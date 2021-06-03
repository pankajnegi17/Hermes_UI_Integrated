var express = require("express");
var router = express.Router();
const jwt = require("jsonwebtoken");
const rp = require("request-promise");
const crypto = require("crypto");
const nodemailer = require("nodemailer");

const publishToQueue = require("../rabbitMq/rabbitMq");
const saveMeetingDetails = require("../services/meetingService");
const saveParticipant = require("../services/meetingService");
const saveRecordingFile = require("../services/meetingService");

var meetings = {};

const amqp = require("amqplib/callback_api");
const CONN_URL = "amqp://localhost";

/* GET home page. */
router.get("/", function (req, res, next) {
  console.log(
    "#################################################3\n/get: \n : "
  );
  res.render("index", { title: "Zoom Integration Demo" });
});

router.post("/init_meeting", function (req, res, next) {
  console.log(
    "#################################################3\ninit_meeting: \n  rre: " +
      req
  );

  const topic = req.body.topic,
    agenda = req.body.agenda;
  let participants = req.body["participants[]"];

  participants = Array.isArray(participants) ? participants : [participants];

  createNewMeeting(topic, agenda, participants, function (meetingId) {
    //Save meeting data
    //  saveMeetingDetails({MeetingId:meetingId,Topic:topic,Agenda:agenda,})

    const host_join_url = `/join_meeting/${meetingId}?participant=host`;

    res.send(host_join_url);
  });
});


router.get("/zoom_join/:meetingId",function(req, res, next){
  res.render("index_join", { title: "Welcome to Hermees Video Meeting", meetingId: req.params.meetingId});
})

router.get("/join_meeting/:meetingId", function (req, res, next) {
  console.log("\tJOIN_MEETING CALLED\t")
  console.log(
    "#################################################3\njoin_meeting/:meetingId: \n req: " +
      req
  );

  const meeting = meetings[req.params.meetingId];

  const isHost = req.query["participant"] === "host";

  let name = isHost ? process.env.MEETING_HOST_NAME : req.query["participant"];
  let email = isHost
    ? process.env.MEETING_HOST_EMAIL
    : req.query["participant"];
  let role = isHost ? 1 : 0; //1 = HOST, 0 = PARTICIPANT

  //saveParticipant({MeetingId:req.params.meetingId,ParticipantEmail:email,ParticipantName:name})

  res.render("join_meeting", {
    title: "Meeting Started",
    signature: createSignature(meeting.id, role),
    meetingNumber: meeting.id,
    userName: name,
    apiKey: process.env.ZOOM_API_KEY,
    userEmail: email,
    password: meeting.password,
  });
});

router.get("/end_meeting", function (req, res, next) {
  console.log(
    "#################################################3\nend_meeting: \n"
  );

  res.render("end_meeting", { title: "Meeting Ended" });
});

router.post("/recording_completed", async function (req, res, next) {
  await publishToQueue("download_file_queue", req);
  res.statusCode = 200;
  res.data = { File_to_download: "hghghg" };
  res.status(res.statusCode || 200).send({ status: true, response: res.data });
});

function createNewMeeting(topic, agenda, participants, callback) {
  console.log(
    "#################################################\nCreateNewMeeting Called \n"
  );
  const token = createJwtToken();

  var options = {
    //You can use a different uri if you're making an API call to a different Zoom endpoint.
    uri: `${process.env.ZOOM_BASE_URL}/users/${process.env.ZOOM_USER_ID}/meetings`,
    method: "POST",
    auth: {
      bearer: token,
    },
    headers: { "content-type": "application/json" },
    body: {
      topic,
      agenda,
      type: 1,
      timezone: "Asia/Calcutta",
      settings: {
        host_video: true,
        participant_video: true,
        cn_meeting: false, //Disable using chinese servers!
        in_meeting: true, //Try and use servers from India
        audio: "voip", //Only VOIP option can be used. Enabling telephone gives US numbers which can only be dialled into via ISD
      },
    },
    json: true,
  };

  rp(options).then(function (meeting) {
    console.log("\n\n\n rp called \n\n\n");
    meetings[meeting.id] = meeting;

    const url = `${process.env.ZOOM_BASE_URL}/meetings/${meeting.id}/registrants`;

    participants.map((p) => {
      options.body = {
        email: p,
        first_name: p,
        last_name: " ",
      };

      rp(options);
    });

    sendEmailInvites(meeting, participants);

    callback(meeting.id);
  });
}

function createJwtToken() {
  console.log(
    "#################################################\ncreateJwtToken:"
  );
  const payload = {
    iss: process.env.ZOOM_API_KEY,
    exp: new Date().getTime() + 5000,
  };

  const token = jwt.sign(payload, process.env.ZOOM_API_SECRET);

  console.log("createJwtToken Returns:" + token);
  return token;
}

function createSignature(meetingNumber, role) {
  console.log(
    "#################################################3\nCreateSignature: \n MeetingNumber: " +
      meetingNumber +
      " \n role" +
      role
  );
  // Signature Generation code from https://github.com/zoom/websdk-sample-signature-node.js/blob/master/index.js
  const timestamp = new Date().getTime() - 30000;
  console.log("TimeStamp");
  console.log(timestamp);
  const msg = Buffer.from(
    process.env.ZOOM_API_KEY + meetingNumber + timestamp + role
  ).toString("base64");
  const hash = crypto
    .createHmac("sha256", process.env.ZOOM_API_SECRET)
    .update(msg)
    .digest("base64");
  const signature = Buffer.from(
    `${process.env.ZOOM_API_KEY}.${meetingNumber}.${timestamp}.${role}.${hash}`
  ).toString("base64");
  console.log("Signature \n");
  console.log(signature);

  return signature;
}

function sendEmailInvites(meeting, participants) {
  console.log(
    "sendEmailInvites: \n meeting: " +
      meeting +
      " \n participants: " +
      participants
  );
  var transporter = nodemailer.createTransport({
    service: "Gmail",
    host : "smtp.gmail.com",
    port : 587,
    auth: {
      user: "dev.pankajnegi@gmail.com",
      pass: "Integra@123$%^",
      // user: "sonaliv@botaiml.com",
      // pass: "Integra@123",
    },
  });

  for (var p of participants) {
    var joinUrl = `${process.env.SITE_URL}/zoom_join/${meeting.id}?participant=${p}`;

    var mailOptions = {
      from: process.env.GMAIL_USER_ID,
      to: p,
      subject: `${process.env.MEETING_HOST_NAME} is inviting you to a meeting`,
      text: `
To join the Meeting enter this URL in your browser: ${joinUrl}. If possible, please use Google Chrome for best experience.

Meeting ID: ${meeting.id}
Password: ${meeting.password}

Thanks & Regards,
${process.env.MEETING_HOST_NAME}`,
      html: `
      <p>Join the Meeting:<br />
      <a href=${joinUrl}>${joinUrl}</a>
      <p>
      <p>
      Meeting ID: ${meeting.id}<br />
      Password: ${meeting.password}<br />
      </p>
      <p>
      Thanks &amp; Regards,
      ${process.env.MEETING_HOST_NAME}`,
    };

    transporter.sendMail(mailOptions, function (error, info) {
      if (error) {
        console.log(error);
      } else {
        console.log("Email sent: " + info.response);
      }
    });
  }
}

module.exports = router;
