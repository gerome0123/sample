#= require ./../module

moduleKeywords = ['extended', 'included']

class Module
  @extend: (obj) ->
    for key, value of obj when key not in moduleKeywords
      @[key] = value
    obj.extended?.apply(@)
    @

  @include: (obj) ->
    for key, value of obj when key not in moduleKeywords
      @::[key] = value
    obj.included?.apply(@)
    @

  constructor: (@me, @opts) ->

  getTarget: ->
    $(@me)

  getDefaults: ->
    @constructor.DEFAULTS

  getOptions: (opts = {}) ->
    $.extend {}, @getDefaults(), @getTarget().data(), opts

window.ClassModule = Module