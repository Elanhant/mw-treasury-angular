directives = angular.module('mwTreasuryDirectives')
directives.directive 'inkcarousel', ->
	restrict: 'E'
	transclude: true
	templateUrl: 'templates/directive/ink_carousel.html'
	link: (scope, element, attrs)->		
		scope.inkCarElements = scope[attrs['elements']]
		scope.incCarViewPath = attrs['viewPath']
		scope.incCarAttrImage = attrs['attrImage']
		scope.incCarAttrDesc = attrs['attrDesc']		
		carouselId = element.attr 'id'
		jQuery(element).after('<nav id="ink-pager-' + carouselId + '" class="ink-navigation"><ul class="pagination black"></ul></nav>')
		scope.$watch attrs['elements'], (newval, oldval)->
			if newval.length
				Ink.requireModules ['Ink.UI.Carousel_1'], (InkCarousel)-> new InkCarousel('#'+carouselId, {pagination: '#ink-pager-' + carouselId})

directives.directive 'anchored', ->
    restrict: 'A'
    link: (scope, element, attrs)->
      element.bind 'click', ->
        el = document.getElementById(attrs['anchored'])
        el.scrollIntoView()

directives.directive 'incsticky', ->
    restrict: 'A'
    require: '?id'
    link: (scope, element, attrs)->
    	bottomElement = '#' + attrs['bottomElement'] if attrs['bottomElement']
    	topElement = '#' + attrs['topElement'] if attrs['topElement']
	    Ink.requireModules ['Ink.UI.Sticky_1'], (Sticky)-> 
	    	new Sticky '#' + element.attr('id'), bottomElement: bottomElement, topElement: topElement

directives.directive 'mwPluginsStacker', ->
	link: (scope, element, attrs)->
		if scope.$last and scope.$parent.$last		
      Ink.requireModules ['Ink.UI.Stacker_1'], (Stacker)-> 
        cols = large: 4, medium: 3, small: 1
        new Stacker '#stacker-container', largeCols: cols.large, mediumCols: cols.medium

directives.directive 'mwPluginsCarousel', ->
  link: (scope, element, attrs)->
    if scope.$last
      Ink.requireModules ['Ink.UI.Carousel_1'], (InkCarousel)-> 
        new InkCarousel '#plugins-carousel', pagination: '#plugins-pagination', nextLabel: '', previousLabel: '', autoAdvance: 5000