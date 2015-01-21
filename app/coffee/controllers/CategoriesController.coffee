controllers = angular.module('mwTreasuryControllers')
controllers.controller 'CategoriesController', ['$scope', 'Category',
  ($scope, Category)->
    $scope.categories = Category.query()
    $scope.orderProp = 'name'
    $scope.$parent.header = 'Categories'
    $scope.keyword = ''
]