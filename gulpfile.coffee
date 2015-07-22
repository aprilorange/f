config = require './config'
gulp = require 'gulp'
uglify = require 'gulp-uglify'
stylus = require 'gulp-stylus'
swig = require 'gulp-swig'
sourcemaps = require 'gulp-sourcemaps'
concat = require 'gulp-concat'
serve = require 'gulp-serve'
minifyHTML = require 'gulp-minify-html'
coffee = require 'gulp-coffee'

gulp.task 'serve', serve
  root: [ './' ]
  port: 3001

gulp.task 'coffee', ->
  stream = gulp.src([
    './src/coffee/app.coffee'
  ])
    .pipe coffee bare: true
    .pipe gulp.dest './src/js'
  stream

gulp.task 'js', ['coffee'], ->
  stream = gulp.src([
    './src/js/nunjucks.js'
    './src/js/q.js'
    './src/js/app.js'
  ])
    .pipe sourcemaps.init()
    .pipe concat 'vendor.js'
    .pipe uglify()
    .pipe sourcemaps.write '.'
    .pipe gulp.dest './build/js'
  stream

gulp.task 'html', ->
  opts = defaults:
    cache: false
    locals:
      buildTime: (new Date).getTime()
      title: config.title
  stream = gulp.src './src/html/index.html'
    .pipe swig opts
    .pipe minifyHTML()
    .pipe gulp.dest('./')
  stream

gulp.task 'css', ->
  stream = gulp.src './src/styl/main.styl'
    .pipe stylus compress: true
    .pipe gulp.dest './build/css'
  stream

gulp.task 'watch', ->
  gulp.watch './src/html/index.html', [ 'html' ]
  gulp.watch './src/styl/*.styl', [ 'css' ]
  gulp.watch './src/js/*.js', [ 'js' ]

gulp.task 'build', [
  'js'
  'css'
  'html'
]
gulp.task 'default', [
  'build'
  'watch'
  'serve'
]
