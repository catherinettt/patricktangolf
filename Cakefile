{print} = require 'util'
{spawn} = require 'child_process'

task 'build', 'Build public/javascripts/ from app/', ->
	coffee = spawn 'coffee', ['-j', 'public/javascripts/app.js', '-c', 'app']		
	coffee.stderr.on 'data', (data) ->
    message = data.toString()
    if message.search('is now called') < 0
      process.stderr.write message
	coffee.stdout.on 'data', (data) ->
		print data.toString()
	coffee.on 'exit', (code) ->
		callback?() if code is 0

task 'watch', 'Watch app/ for changes', ->
	coffee = spawn 'coffee', ['-w', '-j', 'public/javascripts/app.js', '-c', 'app']		
	coffee.stderr.on 'data', (data) ->
		process.stderr.write data.toString()
	coffee.stdout.on 'data', (data) ->
		print data.toString()