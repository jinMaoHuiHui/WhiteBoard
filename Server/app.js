var express = require('express');
var http = require('http');
var config = require('./config/config.js');
var logs = require(config.logs);
var socketEvent = require(config.socketEvent);
var fs = require('fs');

var app = express();
var sslOptions = {
    key: fs.readFileSync(config.sslKeyPath),
    cert: fs.readFileSync(config.sslCertPath),
};
/*
var server = https.createServer(sslOptions, app).listen(8008, function() {
    logs.happy("Server started at port 8008");
}); 
*/
var server = http.Server(app).listen(8008, function() {
    logs.happy("Server started at port 8008");
});

var io = require('socket.io')(server);


process.env.NODE_ENV = config.env;
process.env.config = config.filename;

app.get('/', function(req, res) {
    res.sendFile(__dirname + '/index.html');
});

logs.happy('Happy is rainbow, aha!');
logs.focus('Focus is very Important !');
logs.debug('Debug log is blue, enjoy it !');
logs.error('Error log is red, I don`t like it at all!');
logs.warn('Warn log is yellow, too shining to blind my eyes...');

io.on('connection', function(socket) {
    socket.join('roomName', function(err) {
    });
    socket.emit('news', { hello: 'world' });
    socket.on(socketEvent.addMarkToPrevious, function(data) {
        logs.debug(socket.id);
        socket.broadcast.emit(socketEvent.addMarkToPrevious, data);
    });
    socket.on(socketEvent.addMarkToParent, function(data) {
        logs.debug(socket.id);
        socket.broadcast.emit(socketEvent.addMarkToPrevious, data);
    });
    

});

