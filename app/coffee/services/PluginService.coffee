services = angular.module('mwTreasuryServices', ['ngResource'])
services.factory 'Plugin', ['$resource', 
	($resource)->
		$resource 'plugins/:pluginId.json', {}, query: 
			method: 'GET'
			params: 
				pluginId: 'plugins'
			isArray: true
]