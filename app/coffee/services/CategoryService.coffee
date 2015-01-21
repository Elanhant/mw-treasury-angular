services = angular.module('mwTreasuryServices')
services.factory 'Category', ['$resource', 
  ($resource)->
    $resource 'http://127.0.0.1:3000/categories/:categoryId.json', { categoryId: "@id", format: 'json' }, 
      query: 
        method: 'GET'
        isArray: true
      search:
        method: 'GET'
        url: 'http://127.0.0.1:3000/categories/:categoryId/search.json'
        isArray: true
]