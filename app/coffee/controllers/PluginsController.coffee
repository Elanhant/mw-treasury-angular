controllers = angular.module('mwTreasuryControllers')
controllers.controller 'PluginsController', ['$scope', 'Plugin',
	($scope, Plugin)->
		$scope.plugins = Plugin.query()
		$scope.orderProp = 'name'
		$scope.$parent.header = 'Plugins'
]