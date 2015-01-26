controllers = angular.module('mwTreasuryControllers')
controllers.controller 'PluginsController', ['$scope', '$routeParams', 'Category', 'Plugin',
  ($scope, $routeParams, Category, Plugin)->
    $scope.categories_checked = {}
    $scope.categories = Category.query((cats)-> 
        $scope.categories_checked[cat.id] = false for cat in cats
    )
    $scope.orderProps = [
      {name: 'name', label: 'Name'},
      {name: 'updated_at', label: 'Updated'},
      {name: 'author', label: 'Author'},
    ]
    $scope.orderProp = 'name'
    if $routeParams.keyword
      Plugin.search(name: $routeParams.keyword, (data)-> $scope.plugins = data)
      $scope.$parent.header = 'Search'
      $scope.searchParams = {}
      $scope.$parent.keyword = $routeParams.keyword
    else
      $scope.plugins = Plugin.query()
      $scope.$parent.header = 'Plugins'

    $scope.byCategories = (plugin, index)-> !hasCheckedCats() or $scope.categories_checked[plugin.category_id]

    hasCheckedCats = ->     
      for name of $scope.categories_checked
        return true if $scope.categories_checked.hasOwnProperty(name) and $scope.categories_checked[name] 
      false
]