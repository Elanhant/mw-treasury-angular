module.exports = (grunt)->
	# Project configuration
	grunt.initConfig
		pkg: grunt.file.readJSON('package.json')
		coffee: 
			compile:
				expand: true
				cwd: 'app/coffee'
				src: ['**/*.coffee']
				dest: 'app/js'
				ext: '.js'
				options:
					bare: true
					preserve_dirs: true

	# Load plugins
	grunt.loadNpmTasks 'grunt-contrib-coffee'

	# Tasks
	grunt.registerTask 'default', ['coffee']