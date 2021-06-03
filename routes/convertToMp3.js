const amqp = require('amqplib/callback_api')

  //Creatinf connection
  amqp.connect('ampq://localhost',(connError, connection)=>{
    if(connError){
      throw connError;
    }
    //Creating channel
    connection.createChannel((channelError,channel)=>{
      if(channelError){
        throw channelError;
      }

      //Assert Queue
      const QUEUE = ''
      channel.assertQueue(QUEUE);
      //Send message to queue
      channel.consume(QUEUE,(message)=>{
          console.log('Inside convertQueue')
      })



      //   produce it to another quesue
    }); 
  }) 