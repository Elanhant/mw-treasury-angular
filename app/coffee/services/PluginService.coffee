services = angular.module('mwTreasuryServices')
services.factory 'Plugin', ['$resource', 
	($resource)->
		$resource 'http://127.0.0.1:3000/:pluginId.json', { pluginId: "@id", format: 'json' }, query: 
			method: 'GET'
			params: 
				pluginId: 'plugins'
			isArray: true
]