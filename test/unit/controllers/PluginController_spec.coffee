describe "PluginController", ->
	scope = null
	ctrl = null
	routeParams = null
	httpBackend = null
	testPlugin = 
		id: 'julan'
		name: 'Julan the Ashlander Companion'
		category: 'quests'
		description: 'Meet the marvelous Julan Kaushibael!'
		images: ['img/plugins/julan-1.jpg']
	categories = [
		id: "quests"
		name: "Quests",
		id: "gameplay",
		name: "Gameplay"
	]
	relatedPlugins = [
		id: 'sixth-house'
		name: 'Sixth House'
	]

	setupController = -> inject(
		($routeParams, $rootScope, $controller, $httpBackend)->
			scope = $rootScope.$new()
			scope.header = 'MW Treasury'
			$routeParams.pluginId = 'julan'
			routeParams = $routeParams
			httpBackend = $httpBackend

			httpBackend.expectGET('plugins/julan.json').respond(testPlugin)
			httpBackend.expectGET('categories/categories.json').respond(categories)
			httpBackend.expectGET('plugins/plugins.json?category=quests').respond(relatedPlugins)

			ctrl = $controller 'PluginController', $scope: scope
	)

	beforeEach(module("mwTreasuryApp"))
	beforeEach(module('mwTreasuryServices'))
	beforeEach ->
		this.addMatchers
			toEqualData: (expected)-> return angular.equals(this.actual, expected)	

	describe 'controller initialization', ->
		beforeEach(setupController())

		it 'defaults to no plugin', ->
			expect(scope.plugin).toEqualData {}

		it 'fetches categories', ->
			httpBackend.flush()
			expect(scope.categories).toEqualData categories

		describe 'fetching the plugin', ->
			beforeEach -> 
				httpBackend.flush()

			it 'contains data', ->
				expect(scope.plugin).toEqualData testPlugin

			it 'has related plugins', ->
				expect(scope.relatedPlugins).toEqualData relatedPlugins

			it 'sets parent\'s header to plugin name', ->
				expect(scope.$parent.header).toBe testPlugin.name

			it 'defaults main image URL to first image', ->
				expect(scope.mainImageUrl).toBe testPlugin.images[0]

			it 'changes main image URL', ->
				new_url = 'img/plugins/julan-123.jpg'
				scope.setImage(new_url)
				expect(scope.mainImageUrl).toBe new_url