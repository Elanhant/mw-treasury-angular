controllers = angular.module('mwTreasuryControllers')
controllers.controller 'BaseController', ['$scope', 'Category',
	($scope, Category)->
		$scope.header = 'MW Treasury'
]