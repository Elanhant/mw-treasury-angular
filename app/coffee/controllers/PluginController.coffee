controllers = angular.module('mwTreasuryControllers')
controllers.controller 'PluginController', ['$scope', '$routeParams', '$location', 'Plugin', 'Category',
  ($scope, $routeParams, $location, Plugin, Category)->
    $scope.carousel
    $scope.modal

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

    $scope.saveFile = (flow, imageOnly)->
      if flow  
        abc = !imageOnly or !!{png:1,gif:1,jpg:1,jpeg:1}[flow.files[0].getExtension()]
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

    $scope.pluginFlowSuccessFile = (file, message, chunk)->
      if typeof $scope.plugin.new_files == 'undefined'
        $scope.plugin.new_files = []
      $scope.plugin.new_files.push(name: file.name, path: file.name, size: file.size, uid: file.uniqueIdentifier)

    $scope.removeUploaded = (file, isImage)->
      file.cancel()
      attr = if isImage then 'new_images' else 'new_files'
      $scope.plugin[attr] = $scope.plugin[attr].filter (item, index)-> item.uid != file.uniqueIdentifier

    $scope.removeImage = (imageId)-> addTo(imageId, 'removed_images')

    $scope.removeFile = (fileId)-> addTo(fileId, 'removed_files');

    $scope.restoreImage = (imageId)-> removeFrom(imageId, 'removed_images')

    $scope.restoreFile = (fileId)-> removeFrom(fileId, 'removed_files')

    $scope.imageRemoved = (imageId)-> isIn(imageId, 'removed_images')

    $scope.fileRemoved = (fileId)-> isIn(fileId, 'removed_files')

    addTo = (value, arr)->
      if typeof $scope.plugin[arr] == 'undefined'
        $scope.plugin[arr] = []
      $scope.plugin[arr].push(value)

    removeFrom = (value, arr)->
      if typeof $scope.plugin[arr] == 'undefined'
        $scope.plugin[arr] = []
      $scope.plugin[arr] = $scope.plugin[arr].filter (item, index)-> item != value

    isIn = (value, arr)->
      typeof $scope.plugin[arr] != 'undefined' && $scope.plugin[arr].indexOf(value) > -1

    $scope.triggerGallery = (page)->      
      Ink.requireModules ['Ink.Dom.Selector_1', 'Ink.UI.Modal_1', 'Ink.UI.Carousel_1'], (InkSelector, InkModal, InkCarousel)->
        if not $scope.modal
          $scope.modal = new InkModal '#gallery-modal'
        if not $scope.carousel
          $scope.carousel = new InkCarousel '#gallery-carousel', nextLabel: '', previousLabel: ''
        $scope.modal.open()
        $scope.carousel.refit()
        $scope.carousel.setPage page

    $scope.slide = ($event)->
      if $event.keyCode == 37
        $scope.carousel.previousPage(true)
      else if $event.keyCode == 39
        $scope.carousel.nextPage(true)
]