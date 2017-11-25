var casper = require('casper').create();

var url = casper.cli.get(0);


var casper = require('casper').create();
// macOS Chrome
casper.userAgent('Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36');

// open url
casper.start(url);

casper.then(function() {
    this.echo(this.getHTML());
});

casper.run();
