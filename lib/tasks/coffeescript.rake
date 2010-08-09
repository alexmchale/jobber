task :coffee do
  sh "coffee -w app/coffeescripts/*.coffee -o public/javascripts/"
end
