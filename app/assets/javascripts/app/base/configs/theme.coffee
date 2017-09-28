#= require ./../module

defaultTheme =
  primary: "light-blue"
  accent: "pink"
  warn: "red"
  background: "grey"

themeConfig = ($mdThemingProvider) ->

  $mdThemingProvider.theme("default")
    .primaryPalette defaultTheme.primary,
      'default': '700'
      'hue-1': '800'
      'hue-2': '200'
      'hue-3': 'A100'
    .accentPalette defaultTheme.accent,
      'default': 'A700'
      'hue-1': 'A400'
      'hue-2': 'A200'
      'hue-3': 'A100'
    .warnPalette defaultTheme.warn,
      'default': 'A700'
      'hue-1': '900'
      'hue-2': '700'
      'hue-3': '800'
    .backgroundPalette(defaultTheme.background)
  $mdThemingProvider.alwaysWatchTheme(true)

themeConfig.$inject = ["$mdThemingProvider"]

angular
  .module "CommonApp"
  .config themeConfig
