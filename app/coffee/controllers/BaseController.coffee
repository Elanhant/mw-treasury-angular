controllers = angular.module('mwTreasuryControllers')
controllers.controller 'BaseController', ['$scope', '$location', 'Category', 'Plugin'
  ($scope, $location, Category, Plugin)->
    $scope.header = 'MW Treasury'
    $scope.mainSearch = (keyword)-> $location.path "/plugins/search/#{keyword}"
]