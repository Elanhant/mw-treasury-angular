controllers = angular.module('mwTreasuryControllers')
controllers.controller 'CategoryController', ['$scope', '$routeParams', 'Category', 'Plugin',
  ($scope, $routeParams, Category, Plugin)->
    $scope.searchParams = {}

    $scope.category = Category.get(categoryId: $routeParams.categoryId, (category)-> 
      $scope.$parent.header = category.name
    )

    $scope.loadPage = (pageNumber)->
      Category.search(
        angular.extend(page: pageNumber, $scope.searchParams, categoryId: $routeParams.categoryId),
        (data, headers)->
          $scope.category.plugins = data
          $scope.currentPage = parseInt headers('x-current-page')
          $scope.totalPages = parseInt headers('x-total-pages')
      )

    $scope.searchPlugins = (params)->
      $scope.searchParams = params
      $scope.loadPage(1)
]