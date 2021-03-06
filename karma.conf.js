// Karma configuration
// Generated on Thu May 09 2013 23:27:13 GMT-1000 (HST)


// base path, that will be used to resolve files and exclude
basePath = '';


// list of files / patterns to load in the browser
files = [
  MOCHA,
  MOCHA_ADAPTER,
  'vendor/chai-1.6.0.js',
  'vendor/js-fixtures.js',
  // 'vendor/jquery-1.9.1.js',
  // 'vendor/chai-jquery.js',

  'coffee/lib/tdd.coffee',
  'coffee/lib/stub.coffee',
  'coffee/lib/*.coffee',
  'coffee/src/*.coffee',
  'coffee/test/*.coffee'

  // coffee -o js/ -cwbl coffee/
];


// list of files to exclude
exclude = [

];


// test results reporter to use
// possible values: 'dots', 'progress', 'junit'
reporters = ['progress', 'growl'];


// web server port
port = 9876;


// cli runner port
runnerPort = 9100;


// enable / disable colors in the output (reporters and logs)
colors = true;


// level of logging
// possible values: LOG_DISABLE || LOG_ERROR || LOG_WARN || LOG_INFO || LOG_DEBUG
logLevel = LOG_INFO;


// enable / disable watching file and executing tests whenever any file changes
autoWatch = true;


// Start these browsers, currently available:
// - Chrome
// - ChromeCanary
// - Firefox
// - Opera
// - Safari (only Mac)
// - PhantomJS
// - IE (only Windows)
browsers = [
  // 'Firefox',
  'Chrome'
];


// If browser does not capture in given timeout [ms], kill it
captureTimeout = 60000;


// Continuous Integration mode
// if true, it capture browsers, run tests and exit
singleRun = false;
