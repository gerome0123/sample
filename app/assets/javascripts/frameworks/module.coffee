#= require angular-animate
#= require angular-aria
#= require angular-messages
#= require angular-route
#= require angular-sanitize
#= require angular-cookies
#= require angular-filter

#= require angular-material

#= require moment
#= require angular-moment

#= require ng-rails-csrf
#= require angularjs-viewhead

#= require ./lib/ngDraggable

#= require md-data-table
#= require angular-material-icons
#= require ./lib/angular-drag-and-drop-lists


angular
  .module "App", ["ngAnimate", "ngAria", "ngMessages", "ngRoute", "ngSanitize", "ngCookies", "angular.filter",
                  "ngMaterial", "angularMoment", "ng-rails-csrf", "viewhead", "ngDraggable", "mdDataTable", "ngMdIcons", "dndLists"]
