task :coffee do
  sh "coffee -c -w -o public/javascripts/ app/coffeescripts/*.coffee"
end
