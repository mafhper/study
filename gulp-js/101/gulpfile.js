const gulp = require('gulp');
const sass = require('gulp-sass')(require('sass'));
const browserSync = require('browser-sync').create();

// Compile Sass & Inject Into Browser
function style() {

// 1. Where is my scss file
    return gulp.src('./scss/**/*.scss')

// 2. Pass that file through sass compiler
    .pipe(sass().on('error', sass.logError))

// 3. Where do I save the compiled CSS?
    .pipe(gulp.dest('./css'))

// 4. stream changes to all browser
    .pipe(browserSync.stream());
}

exports.style = style;


function watch() {
    browserSync.init({
        server: {
            baseDir: './'
        }
    });
    gulp.watch('./scss/**/*.scss', style);
    gulp.watch('./*.html').on('change', browserSync.reload);
    gulp.watch('./js/**/*.js').on('change', browserSync.reload);
    gulp.watch('./css/**/*.css').on('change', browserSync.reload);
    gulp.watch('./img/**/*.**').on('change', browserSync.reload);
}

exports.watch = watch;
