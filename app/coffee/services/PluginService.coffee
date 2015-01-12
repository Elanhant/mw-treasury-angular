services = angular.module('mwTreasuryServices')
services.factory 'Plugin', ['$resource', 
	($resource)->
		$resource 'http://127.0.0.1:3000/plugins/:pluginId', { pluginId: "@id", format: 'json' }, 
			query: 
				method: 'GET'
				isArray: true
			create:
				method: 'POST'
]