var casper = require('casper').create({
    verbose: true,
    logLevel: 'debug'
});

var url = casper.cli.get(0);


var date = new Date(),
    day = date.getDate(),
    month = date.getMonth() + 1,
    year = date.getFullYear(),
    hour = date.getHours(),
    minute = date.getMinutes();

var timestamp = year + '-' + month + '-' + day + '-' + hour + '_' + minute;

var casper = require('casper').create();
// macOS Chrome
casper.userAgent('Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36');

// open product page
casper.start(url);
console.log('visiting ', url);

casper.then(function() {
    var image = timestamp + '.png';
    this.capture(image);
    console.log(image);
});

casper.run();
