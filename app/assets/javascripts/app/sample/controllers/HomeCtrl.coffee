#= require ./../module

class HomeCtrl
  constructor: ($scope)->

HomeCtrl.$inject = ["$scope"]

angular
  .module "SampleApp"
  .controller "HomeCtrl", HomeCtrl
