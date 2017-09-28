#= require ./../module

resourceConfig = ($resourceProvider) ->

# Don't strip trailing slashes from calculated URLs
  $resourceProvider.defaults.stripTrailingSlashes = true

  $resourceProvider.defaults.actions.create =
    method: 'POST'
  $resourceProvider.defaults.actions.destroy =
    method: 'DELETE'
  $resourceProvider.defaults.actions.update =
    method: 'PUT'

resourceConfig.$inject = ["$resourceProvider"]

angular.module "CommonApp"
  .config resourceConfig
