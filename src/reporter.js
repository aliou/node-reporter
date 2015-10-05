const fs     = require('fs');
const helper = require('./helper');
const path   = require('path-extra');

const DEFAULT_FOLDER = path.join(path.homedir(), 'Dropbox/Apps/Reporter-App/');

class Reports {
  constructor(options = { directory: DEFAULT_FOLDER }) {
    this.options = options;
  }

  questions() {
    if (this._questions) {
      return this.questions;
    }

    this._questions = null; // [];
    const files = fs.readdirSync(this.options.directory);

    if (files.length) {
      let file = path.join(this.options.directory, files[0]);
      this._questions = JSON.parse(fs.readFileSync(file)).questions;
    }

    return (this._questions);
  }

  snapshots(options, cb) {
    const combine = (...arrays) => [].concat(...arrays);

    var reports = [];

    if (typeof(options) == 'function') {
      cb = options;
      options = null;
    }

    fs.readdirSync(this.options.directory).forEach(file => {
      if (file.match(/.json$/)) {
        let data = JSON.parse(fs.readFileSync(path.join(
                this.options.directory, file)));

        if (this._questions == null) {
          this._questions = data.questions;
        }
        reports = combine(reports, data.snapshots);
      }
    })

    reports.forEach(report => {
      report.date = helper.formatDate(report.date);
    });
    reports = filterReports(reports, options);

    if (cb) { return cb(null, reports); }
    return reports;
  }
}

function filterReports(reports, options) {
  if (!options) {
    return (reports);
  }

  if (options.type) {
    const impetuses = ['button', 'buttonAsleep', 'notification', 'sleep', 'wake'];
    reports = reports.filter(report => {
      const impetus = report.reportImpetus;
      return (impetus && impetus == impetuses.indexOf(options.type));
    });
  }

  if (options.connection) {
    const connections = ['cellular', 'wifi', 'none'];
    reports = reports.filter(report => {
      return (report.connection == connections.indexOf(options.connection));
    });
  }

  if (options.date) {
    reports = reports.filter(report => {
      const reportDate = new Date(report.date);
      return (reportDate.toDateString() == options.date.toDateString());
    });
  }

  if (options.between && options.between.start && options.between.end) {
    reports = reports.filter(report => {
      const reportDate = new Date(report.date);
      return +reportDate >= +options.between.start && +reportDate <= +options.between.end;
    });
  }

  return (reports);
}

module.exports = Reports;
