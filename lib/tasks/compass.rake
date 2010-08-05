task :compass do
  sh "compass watch --app rails --sass-dir app/stylesheets/ --css-dir public/stylesheets/ --images-dir public/images/ --javascripts-dir public/javascripts/"
end
