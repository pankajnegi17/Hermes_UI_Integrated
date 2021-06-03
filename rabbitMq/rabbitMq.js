const amqp = require('amqplib/callback_api')
const CONN_URL = 'amqp://localhost';

let ch =null;

amqp.connect(CONN_URL,function(err, conn){
    conn.createChannel(function(err, channel){
        ch =channel; 
    });
});

 const publishToQueue = async (queueName, data)=>{
        ch.sendToQueue('download_file_q', Buffer.from(JSON.stringify(data)), {persistent: true});
}

process.on('exit', (code)=>{
    ch.close();
    console.log(`closing rabbitMq channel`)
})


module.exports = publishToQueue