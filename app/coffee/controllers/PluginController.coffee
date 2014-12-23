controllers = angular.module('mwTreasuryControllers')
controllers.controller 'PluginController', ['$scope', '$routeParams', 'Plugin',
	($scope, $routeParams, Plugin)->
		$scope.plugin = Plugin.get(pluginId: $routeParams.pluginId, (plugin)-> 
			$scope.mainImageUrl = plugin.images[0]
			$scope.relatedPlugins = Plugin.query(category: plugin.category, (plugins)-> $scope.relatedPlugins = plugins)
		)


		$scope.setImage = (imageUrl)-> $scope.mainImageUrl = imageUrl
]