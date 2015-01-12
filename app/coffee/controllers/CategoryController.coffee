controllers = angular.module('mwTreasuryControllers')
controllers.controller 'CategoryController', ['$scope', '$routeParams', 'Category', 'Plugin',
	($scope, $routeParams, Category, Plugin)->
		$scope.category = Category.get(categoryId: $routeParams.categoryId, (category)-> 
			$scope.$parent.header = category.name
		)
]