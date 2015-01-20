controllers = angular.module('mwTreasuryControllers')
controllers.controller 'PluginController', ['$scope', '$routeParams', '$location', 'Plugin', 'Category',
	($scope, $routeParams, $location, Plugin, Category)->
		if $routeParams.pluginId
			$scope.plugin = Plugin.get(pluginId: $routeParams.pluginId, (plugin)-> 
				$scope.mainImageUrl = plugin.images[0]['url'] if plugin.images[0]
				$scope.relatedPlugins = Plugin.query(category: plugin.category, (plugins)-> $scope.relatedPlugins = plugins)
				$scope.pluginFlowInit = {}
				if plugin.category
					$scope.$parent.header = text: plugin.category.name, url: "#/categories/#{plugin.category.id}"
				else
					$scope.$parent.header = 'No category'
			)
		else
			$scope.plugin = {}
			if $routeParams.categoryId
				$scope.plugin.category_id = $routeParams.categoryId

		$scope.categories = Category.query()
		$scope.setImage = (imageUrl)-> $scope.mainImageUrl = imageUrl

		$scope.save = ->
			if $scope.plugin.id
				$scope.plugin.$save -> $location.path "/plugins/#{$scope.plugin.id}"
			else
				Plugin.create $scope.plugin, 
				(newPlugin)-> $location.path "/plugins/#{newPlugin.id}",
				(httpResponse)-> $scope.errors = httpResponse.data

		getFileReader = ($scope)->
			fileReader = new FileReader()
			fileReader.onloadend = -> $scope.img = fileReader.result
			return fileReader

		$scope.saveImage = (flow)->
			if flow  
				abc = !!{png:1,gif:1,jpg:1,jpeg:1}[flow.files[0].getExtension()]
				if abc
						fileReader = getFileReader $scope
						file = flow.files[0]

						fileReader.readAsDataURL file.file
						flow.upload()
				else
					flow.cancel()

		$scope.pluginFlowSuccess = (file, message, chunk)->
			if typeof $scope.plugin.new_images == 'undefined'
				$scope.plugin.new_images = []
			$scope.plugin.new_images.push(url: file.name, uid: file.uniqueIdentifier)

		$scope.removeUploaded = (file)->
			file.cancel()
			$scope.plugin.new_images = $scope.plugin.new_images.filter (item, index)-> item.uid != file.uniqueIdentifier

		$scope.removeImage = (imageId)->
			if typeof $scope.plugin.removed_images == 'undefined'
				$scope.plugin.removed_images = []
			$scope.plugin.removed_images.push(imageId)

		$scope.restoreImage = (imageId)->
			if typeof $scope.plugin.removed_images == 'undefined'
				$scope.plugin.removed_images = []
			$scope.plugin.removed_images = $scope.plugin.removed_images.filter (item, index)-> item != imageId

		$scope.isRemoved = (imageId)->
			typeof $scope.plugin.removed_images != 'undefined' && $scope.plugin.removed_images.indexOf(imageId) > -1
]