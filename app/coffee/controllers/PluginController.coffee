controllers = angular.module('mwTreasuryControllers')
controllers.controller 'PluginController', ['$scope', '$routeParams', 'Plugin', 'Category',
	($scope, $routeParams, Plugin, Category)->
		$scope.plugin = Plugin.get(pluginId: $routeParams.pluginId, (plugin)-> 
			$scope.mainImageUrl = plugin.images[0]
			$scope.relatedPlugins = Plugin.query(category: plugin.category, (plugins)-> $scope.relatedPlugins = plugins)
			$scope.$parent.header = plugin.name
		)

		$scope.categories = Category.query()
		$scope.setImage = (imageUrl)-> $scope.mainImageUrl = imageUrl
]