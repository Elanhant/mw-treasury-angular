filters = angular.module('mwTreasuryFilters')
filters.filter 'checkmark', ->
	(input)-> if input then '\u2713' else '\u2718'

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

filters.filter 'round', ->
	(input, precision)-> if input then parseFloat(input).toFixed(precision) else ''

filters.filter 'bytes', ->
	(bytes, precision)->
		if bytes == 0 || isNaN(parseFloat(bytes)) || !isFinite(bytes) 
			return '-'
		if typeof precision == 'undefined'
			precision = 1;
		units = ['bytes', 'kB', 'MB', 'GB', 'TB', 'PB']
		number = Math.floor(Math.log(bytes) / Math.log(1024))
		return (bytes / Math.pow(1024, Math.floor(number))).toFixed(precision) +  ' ' + units[number]