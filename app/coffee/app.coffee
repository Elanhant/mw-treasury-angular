mwTreasuryApp = angular.module 'mwTreasuryApp', [
	'ngRoute',
	'mwTreasuryControllers',
	'mwTreasuryFilters',
	'mwTreasuryServices',
	'mwTreasuryDirectives',
	'flow'
]

mwTreasuryApp.config ['$routeProvider',
	($routeProvider)->
		$routeProvider.
			when('/plugins', templateUrl: 'templates/plugin/index.html', controller: 'PluginsController').
			when('/plugins/new', templateUrl: 'templates/plugin/form.html', controller: 'PluginController').
			when('/plugins/:pluginId', templateUrl: 'templates/plugin/show.html', controller: 'PluginController').
			when('/plugins/:pluginId/edit', templateUrl: 'templates/plugin/form.html', controller: 'PluginController').
			when('/categories', templateUrl: 'templates/category/index.html', controller: 'CategoriesController').
			when('/categories/:categoryId', templateUrl: 'templates/category/show.html', controller: 'CategoryController').
			when('/upload', controller: 'PluginImageController').
			otherwise(redirectTo: '/plugins')
		return true
]

mwTreasuryApp.config ['$resourceProvider',
	($resourceProvider)->
		$resourceProvider.defaults.stripTrailingSlashes = false
]

mwTreasuryApp.config ['flowFactoryProvider', (flowFactoryProvider)->
    flowFactoryProvider.defaults = 
        target: 'http://127.0.0.1:3000/plugin_images/upload'
        testMethod: 'OPTIONS'
        testChunks: false
        permanentErrors:[404, 500, 501]
]

controllers = angular.module('mwTreasuryControllers', [])
filters = angular.module('mwTreasuryFilters', ['ngResource'])
services = angular.module('mwTreasuryServices', [])
directives = angular.module('mwTreasuryDirectives', [])