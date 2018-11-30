const path = require('path')
const express = require('express');
const app = express();
const swipl = require('swipl');

const exec = require('child_process').exec;
console.log('Initializing...');

// settings
app.set('port', process.env.PORT || 3000);

// static files
app.use(express.static(path.join(__dirname, 'public')));

// start server
const server = app.listen(app.get('port'), () => {
    console.log('Server on port ', app.get('port'))
});

// websockets
const SocketIO = require('socket.io');
const io = SocketIO(server);

swipl.call("working_directory(_, '/home/bernal//Escritorio/prolog/game_2.0')");
swipl.call("consult('my_house.pl')");
swipl.call("save");

io.on('connection', (socket) => {
    socket.on('prolog:command', (data) => {
        child = exec(`swipl -s checkpoint.pl -g "${data.command}, save; save." -t halt.`,
        function (error, stdout, stderr) {
          if (error !== null) {
            io.sockets.emit('prolog:error', stdout || "Some error found");
          } else {
            io.sockets.emit('prolog:command', clearCommand(stdout));
          }
      });
    });
});

const clearCommand = (command) => {
  let divide = command.split("You can go to: </b>");
  let newCommand = divide[0];
  if(divide.length > 1) {
    newCommand += "You can go to: </b>";
    let rooms = divide[1].split('\n');
    for(let i=0; i<rooms.length/2 ; i++) {
      newCommand += rooms[i]+"\n"
    } 
  }
  return newCommand.replace(new RegExp('\n', 'g'), "<br>");
}