services = angular.module('mwTreasuryServices')
services.factory 'Category', ['$resource', 
	($resource)->
		$resource 'categories/:categoryId.json', {}, query: 
			method: 'GET'
			params: 
				categoryId: 'categories'
			isArray: true
]