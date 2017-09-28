#= require ./../module

class OAuth
  constructor: ($scope)->

OAuth.$inject = ["$scope"]

angular
  .module "SessionApp"
  .controller "OAuthCtrl", OAuth
