#= require angular-resource
#= require angular-translate
#= require angular-translate-loader-partial
#= require angular-translate-storage-cookie
#= require angular-translate-storage-local

angular
  .module "CommonApp", ["App", "ngResource", "pascalprecht.translate"]
