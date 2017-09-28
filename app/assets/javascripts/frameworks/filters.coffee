#= require ./module

trustedHtml = ($sce) ->
  (html) ->
    $sce.trustAsHtml(html)
trustedHtml.$inject = ["$sce"]

valPresent = ->
  (val) ->
    return false unless angular.isDefined(val) or val?
    return val.length > 0 if val? and angular.isDefined(val.length)
    val?

groupInto = ->
  (array, count = 1) ->
    return unless angular.isArray(array)

    length = array.length
    return array unless length >= 1

    count = length if count > length
    group_by = parseInt(length / parseInt(count))
    old_array = angular.extend([], array)
    new_array = []

    while old_array.length > 0
      if (old_array.length - group_by) >= 0
        extract_count = group_by
      else
        extract_count = old_array.length
      new_array.push old_array.splice(0, extract_count)
    new_array

forLoop = ->
  return (input, start, end) ->
    input = new Array(end - start)
    i = 0
    while start < end
      input[i] = start
      start++
      i++
    return input

dateOrYear = ($filter) ->
  return (input, format) ->
    if input.doc_date?
      $filter('date')(input.doc_date, format)
    else
      return input.doc_year
dateOrYear.$inject = ["$filter"]

dateSuffix = ($filter) ->
  suffixes = ['th', 'st', 'nd', 'rd']
  (input, format) ->
    dtfilter = $filter('date')(input, format)
    day = parseInt(dtfilter.slice(-2))
    relevantDigits = if day < 30 then day % 20 else day % 30
    suffix = if relevantDigits <= 3 then suffixes[relevantDigits] else suffixes[0]
    dtfilter + suffix
dateSuffix.$inject = ["$filter"]

angular
  .module "App"
  .filter "trustedHtml", trustedHtml
  .filter "valPresent", valPresent
  .filter "groupInto", groupInto
  .filter "forLoop", forLoop
  .filter "dateOrYear", dateOrYear
  .filter "dateSuffix", dateSuffix
