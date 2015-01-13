controllers = angular.module('mwTreasuryControllers')
controllers.controller 'PluginImageController', ['$scope', 'PluginImage',
	($scope, PluginImage)->		
		PluginImage = $resource('http://127.0.0.1:3000/plugin_images/')
]