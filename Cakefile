## t.coffee cakefile ##
fs = require 'fs'
{exec} = require 'child_process'
uglify = require 'uglify-js'

option '-s', '--source [DIR]', 'Source coffee directory.'
option '-o', '--output [DIR]', 'Target compiled directory.'

task 'compile', 'Compile Coffeescript to JS', (options) ->
    dir = options.output or './'
    src = options.source or './'
    exec 'coffee --compile --output '+dir+' '+src, (err, stdout, stderr) ->
        throw err if err?
        console.log stdout + stderr

task 'minify', 'Minify compiled JS', (options) ->
    console.log('Minification currently stubbed.')
