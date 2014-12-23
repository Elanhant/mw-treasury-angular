module.exports = (grunt)->
	# Project configuration
	grunt.initConfig
		pkg: grunt.file.readJSON('package.json')
		coffee: 
			compile:
				expand: true
				files: 
					'app/js/app.js': 'app/coffee/app.coffee'
					'app/js/controllers.js': ['app/coffee/controllers/*.coffee']
					'app/js/directives.js': ['app/coffee/directives/*.coffee']
					'app/js/services.js': ['app/coffee/services/*.coffee']
					'app/js/filters.js': ['app/coffee/filters/*.coffee']
				options:
					bare: true
					preserve_dirs: true

	# Load plugins
	grunt.loadNpmTasks 'grunt-contrib-coffee'

	# Tasks
	grunt.registerTask 'default', ['coffee']