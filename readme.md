# node-reporter

`node-reporter` is a node.js module to retrieve and manipulate report files from the [Reporter Application](http://www.reporter-app.com).

## Installation

```sh
$ npm install node-reporter
```

## Methods

### Reporter

The constructor optionally can take an object with the directory of the reports. By default, it will use `~/Dropbox/Apps/Reporter-App/`.

### Reporter#list(options)

List all the entries filtered by `options`. `options` is an object containing either the [type (how the report was triggered)](https://gist.github.com/dbreunig/9315705#reportimpetus) or the [network connection](https://gist.github.com/dbreunig/9315705#connection) when the report was made.

The `type` field can take the following values:
* `'button'`
* `'buttonAsleep'`
* `'notification'`
* `'sleep'`
* `'wake'`

The `connection` field can take the following values:
* `'cellular'`
* `'wifi'`
* `'wake'`

## Examples

```javascript
var Reporter = require('node-reporter');

var reporter = new Reporter({ directory: '/reports' });
var reports = reporter.list({ connection: 'cellular' })

console.log(reports);
```

## Contributing

**DO NOT directly modify the `lib` files.** These files are automatically built from CoffeeScript sources located under the `src` directory.

To do build run:

```sh
$ cake build
```

## License
MIT.
