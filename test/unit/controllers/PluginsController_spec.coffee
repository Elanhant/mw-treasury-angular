describe "PluginsController", ->
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

			$httpBackend.expectGET('plugins/plugins.json').respond([name: 'Ashlander Tent', name: 'Redesigned Vivec'])

			ctrl = $controller 'PluginsController', $scope: scope
		)

	beforeEach(module("mwTreasuryApp"))
	beforeEach(module('mwTreasuryServices'))
	beforeEach ->
		this.addMatchers
			toEqualData: (expected)-> return angular.equals(this.actual, expected)

	describe 'controller initialization', ->
		beforeEach(setupController())

		it 'sets parent\'s header to "Plugins"', ->
			expect(scope.$parent.header).toBe 'Plugins'

		it 'gets plugins', ->
			expect(scope.plugins).toEqualData []
			httpBackend.flush()
			expect(scope.plugins).toEqualData [name: 'Ashlander Tent', name: 'Redesigned Vivec']

		it 'orders plugins by name', ->
			expect(scope.orderProp).toBe 'name'