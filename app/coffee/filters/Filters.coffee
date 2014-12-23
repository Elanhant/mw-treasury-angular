filters = angular.module('mwTreasuryFilters')
filters.filter 'checkmark', ->
	(input)-> input ? '\u2713' : '\u2718'