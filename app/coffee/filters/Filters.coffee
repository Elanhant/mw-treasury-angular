filters = angular.module('mwTreasuryFilters')
filters.filter 'checkmark', ->
	(input)-> input ? '\u2713' : '\u2718'

filters.filter 'truncate', ->
	(text, length, end)->
		if not text
			return ''
		if isNaN(length)
			length = 20
		if end == undefined
			end = '...'
		if text.length <= length || text.length - end.length <= length
			return text
		else
			return String(text).substring(0, length - end.length) + end

filters.filter 'modulo', ->
	(arr, div, val)->
		if not arr
			return []
		arr.filter (item, index)-> index % div == (val || 0)