#= require ./module

RouteProvider = ($locationProvider, $routeProvider) ->

  $locationProvider.html5Mode
    enabled: true
    requireBase: false

  homeConfig =
    templateUrl: "/templates/home/index"
    controller: "HomeCtrl"
    controllerAs: "ctrl"

  bookConfig =
    templateUrl: "/templates/books/index"
    controller: "BookCtrl"
    controllerAs: "ctrl"

  $routeProvider
    .when "/", homeConfig
    .when "/books", bookConfig
    .otherwise
      redirectTo: "/"

RouteProvider.$inject = ["$locationProvider", "$routeProvider"]

angular
  .module "SampleApp"
  .config RouteProvider
