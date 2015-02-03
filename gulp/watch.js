'use strict';

var gulp = require('gulp');

var paths = gulp.paths;

gulp.task('setWatch', function() {
  global.isWatching = true;
});

gulp.task('watch', ['setWatch', 'markups', 'inject'], function () {
  gulp.watch([
    paths.src + '/*.html',
    paths.src + '/{app,components}/**/*.styl',
    paths.src + '/{app,components}/**/*.js',
    paths.src + '/{app,components}/**/*.coffee',
    'bower.json'
  ], ['inject']);
  gulp.watch(paths.src + '/{app,components}/**/*.jade', ['markups']);
});
