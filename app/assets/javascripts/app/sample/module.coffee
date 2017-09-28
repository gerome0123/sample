#= require ./../base

#= require angular-file-model
#= require angular-file-upload
#= require frameworks/lib/contextMenu

angular
  .module "SampleApp", ["CommonApp", "file-model", "angularFileUpload", "ui.bootstrap.contextMenu"]
