var reportObj = JSON.parse(report);

var fileName = inputFilePath.indexOf('/') >= 0
  ? inputFilePath.replace(/.*\/([^\/]+)$/i, '$1')
  : inputFilePath.replace(/.*\\([^\\]+)$/i, '$1');

var successEmailSubject = 'Purchase Orders Workflow Result for ' + fileName;
var successEmailMarkup = '<p>A total of <strong>' + reportObj.records.length + '</strong> records from <strong>' + fileName + '</strong> were successfully processed.</p>\n';
var successEmailText = '';

successEmailMarkup += '<p>';
for (var i = 0; i < reportObj.records.length; ++i) {
  successEmailMarkup += '<p>Purchase Order Number: ' + reportObj.records[i].poNumber + '</p>';
  successEmailMarkup += '<ul>';
  successEmailMarkup += '<li>\tInstance UUID: ' + reportObj.records[i].instanceUuid + '</li>';
  successEmailMarkup += '<li>\tInstance HRID: ' + reportObj.records[i].instanceHrid + '</li>';
  successEmailMarkup += '</ul>';
}
successEmailMarkup += '</p>';

successEmailText = successEmailMarkup.replace(/<\/p>/ig, '\n')
  .replace(/<\/li>/ig, '\n')
  .replace(/<\/ul>/ig, '\n')
  .replace(/<\/[^>]+>/ig, '')
  .replace(/<[^>]+>/ig, '');

successEmailMarkup = successEmailMarkup.replace(/\t/ig, '')
  .replace(/\n/ig, '');

if (logLevel === 'INFO' || logLevel === 'DEBUG') {
  print('inputFilePath = ' + inputFilePath);
  print('fileName = ' + fileName);
  print('emailTo = ' + emailTo);
  print('emailFrom = ' + emailFrom);
  print('totalRecords = ' + reportObj.records.length + '\n');

  if (logLevel === 'DEBUG') {
    print('successEmailSubject = ' + successEmailSubject);
    print('successEmailText = ' + successEmailText);
    print('successEmailMarkup = ' + successEmailMarkup);
    print('reportObj = ' + JSON.stringify(reportObj) + '\n');
  }
}

var successEmail = {
  subject: successEmailSubject,
  text: successEmailText,
  markup: successEmailMarkup
};

execution.setVariableLocal('successEmail', S(JSON.stringify(successEmail)));
