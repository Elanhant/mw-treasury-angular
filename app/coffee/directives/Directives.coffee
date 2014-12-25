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