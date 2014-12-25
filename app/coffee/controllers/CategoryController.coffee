controllers = angular.module('mwTreasuryControllers')
controllers.controller 'CategoryController', ['$scope', '$routeParams', 'Category', 'Plugin',
	($scope, $routeParams, Category, Plugin)->
		$scope.category = Category.get(categoryId: $routeParams.categoryId, (category)-> $scope.$parent.header = category.name)
		$scope.plugins = Plugin.query(category: $routeParams.categoryId, (plugins)->
			for plugin in plugins
				plugin.data = Plugin.get(pluginId: plugin.id)
		)
]