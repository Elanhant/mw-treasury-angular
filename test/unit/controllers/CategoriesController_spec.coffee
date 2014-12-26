describe "CategoriesController", ->
	scope = null
	ctrl = null
	routeParams = null
	httpBackend = null

	setupController = ->
		inject(($routeParams, $rootScope, $controller, $httpBackend)->
			scope = $rootScope.$new()
			scope.header = 'MW Treasury'
			routeParams = $routeParams
			httpBackend = $httpBackend

			httpBackend.expectGET('categories/categories.json').respond([
				id: 'quests'
				name: 'Quests', 
				id: 'gameplay'
				name: 'Gameplay'
			])

			ctrl = $controller 'CategoriesController', $scope: scope
		)

	beforeEach(module("mwTreasuryApp"))
	beforeEach(module('mwTreasuryServices'))
	beforeEach ->
		this.addMatchers
			toEqualData: (expected)-> return angular.equals(this.actual, expected)

	describe 'controller initialization', ->
		beforeEach(setupController())

		it 'sets parent\'s header to "Categories"', ->
			expect(scope.$parent.header).toBe 'Categories'

		it 'gets categories', ->
			expect(scope.categories).toEqualData []
			httpBackend.flush()
			expect(scope.categories).toEqualData [
				id: 'quests'
				name: 'Quests', 
				id: 'gameplay'
				name: 'Gameplay'
			]

		it 'orders categories by name', ->
			expect(scope.orderProp).toBe 'name'