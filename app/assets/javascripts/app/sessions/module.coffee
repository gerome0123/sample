#= require ./../base

i18n = (translatePartialLoaderProvider) ->
  translatePartialLoaderProvider.addPart "sessions"

i18n.$inject = ["$translatePartialLoaderProvider"]

angular
  .module "SessionApp", ["CommonApp"]
  .config i18n
