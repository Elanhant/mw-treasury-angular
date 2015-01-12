controllers = angular.module('mwTreasuryControllers')
controllers.controller 'PluginController', ['$scope', '$routeParams', '$location', 'Plugin', 'Category',
	($scope, $routeParams, $location, Plugin, Category)->
		$scope.plugin = Plugin.get(pluginId: $routeParams.pluginId, (plugin)-> 
			$scope.mainImageUrl = plugin.images[0]
			$scope.relatedPlugins = Plugin.query(category: plugin.category, (plugins)-> $scope.relatedPlugins = plugins)
			$scope.$parent.header = plugin.name
		)

		$scope.categories = Category.query()
		$scope.setImage = (imageUrl)-> $scope.mainImageUrl = imageUrl

		$scope.save = ->
			if $scope.plugin.id
				$scope.plugin.$save -> $location.path "/plugins/#{$scope.plugin.id}"
			else
				Plugin.create $scope.plugin, 
				(newPlugin)-> $location.path "/plugins/#{newPlugin.id}",
				(httpResponse)-> $scope.errors = httpResponse.data
]