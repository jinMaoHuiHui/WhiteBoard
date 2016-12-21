var app_path = __dirname + '/..';
module.exports = {
    configPath: __filename,
    socketEvent: app_path + "/config/socketevent.js",
    env: 'DEVELOP',
    logs: app_path + "/lib/logs.js",
    sslKeyPath: app_path + "/ssl/server.key",
    sslCertPath: app_path + "/ssl/server.crt",

};
