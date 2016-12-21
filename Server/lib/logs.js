var colors = require('colors');

colors.setTheme({
  silly: 'rainbow',
  input: 'grey',
  verbose: 'cyan',
  prompt: 'grey',
  info: 'green',
  data: 'grey',
  help: 'cyan',
  warn: 'yellow',
  debug: 'blue',
  error: 'red'
});



function logs() {
    this.happy = function(str) {
        if (typeof(str) == 'string' ) {
            console.log(str.rainbow.bold);
        } else {
            console.log('Happy: ',str);
        }
    };
    this.focus = function(str) {
        if (typeof(str) == 'string' ) {
            console.log(str.magenta.bold.underline);
        } else {
            console.log('Important: '.magenta.bold.underline, str);
        }

    };
    this.debug = function(str) {
        if (typeof(str) == 'string' ) {
            console.log(str.blue.bold);
        } else {
            console.log('Debug: '.blue.bold, str);
        }
    };
    this.error = function(str) {
        if (typeof(str) == 'string') {
            console.log('Error:'.red.bold.bgBlack + ' '+ str.red.bold);
        } else {
            console.log('Error: '.red.bold.bgBlack,  str);
        }

    };
    this.warn = function(str) {
        if (typeof(str) == 'string') {
            console.log('Warning:'.yellow.bold.bgBlack + ' ' + str.toString().bold.yellow);
        } else {
            console.log('Warning: '.yellow.bold.bgBlack,  str);
        }
    }
}

module.exports = new logs();

