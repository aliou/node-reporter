# node-reporter

`node-reporter` is a node.js module to retrieve and manipulate report files from the [Reporter Application](http://www.reporter-app.com).

## Installation

```sh
$ npm install node-reporter
```
## Examples

```javascript
var Reporter = require('node-reporter');

var reporter = new Reporter({ directory: '/reports' });
var reports = reporter.list({ connection: 'cellular' })

console.log(reports);

// OR with a callback:

reporter.list({ connection: 'wifi' }, function(err, reports) {
  console.log(reports.length);
})
```

## Methods

### Reporter

The constructor optionally can take an object with the directory of the reports. By default, it will use `~/Dropbox/Apps/Reporter-App/`.

### Reporter#list(options)

List all the entries filtered by `options`. `options` is an object containing either the [type (how the report was triggered)](https://gist.github.com/dbreunig/9315705#reportimpetus), the [network connection](https://gist.github.com/dbreunig/9315705#connection) when the report was made and/or the date of the report. Can either return the reports or pass them to a callback with the signature `function(err, reports)`.

The `type` field can take the following values:
* `'button'`
* `'buttonAsleep'`
* `'notification'`
* `'sleep'`
* `'wake'`

The `connection` field can take the following values:
* `'cellular'`
* `'wifi'`
* `'none'`

The `date` field is a Date object.

## Contributing

Pull requests are welcome! Fork the repo on [GitHub](http://github.com/aliou/node-reporter/fork)

## License
MIT.
