const Pool = require("pg").Pool;
const pool = new Pool({
  user: "postgres",
  host: "localhost",
  database: "SMSGroupBOT",
  password: "postgres",
  port: 5432
});

const saveMeetingDetails = (meeting)=>{ 
    
    const date = new Date().toDateString();
    const dbQuery =  `insert into meetings ("MeetingId", "Topic", "Agenda", "StartedOn") VALUES('${meeting.MeetingId}','${meeting.Topic}','${meeting.Agenda}', '${date}')`;
   
      pool.query(dbQuery, (error, results) => {
        if (error) {
          throw error;
        }   
        console.log("\tMeeting data inserted")
      });
}

const saveParticipant = (participant)=>{
    const dbQuery = `insert into participants ("MeetingId","ParticipantEmail","ParticipantName")
                     values('${participant.MeetingId}', '${participant.ParticipantEmail}','${participant.ParticipantName}')`

    pool.query(dbQuery,(error, results)=>{
        if(error){
            throw error
        }
    })
}

const saveRecordingFile = (file)=>{ 
    const dbQuery = `insert into recording_files values('${file.MeetingId}', '${file.FileType}', '${file.RecordingType}', '${file.SrcObject}', '${file.FilePath}')`
    pool.query(dbQuery,(error, result)=>{
        if(error){
            throw error
        }
    })
}



module.exports = saveMeetingDetails;
module.exports = saveParticipant;
module.exports = saveRecordingFile