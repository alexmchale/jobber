Factory.sequence :email do |n|
  "user#{n}@example.com"
end

Factory.sequence :name do |n|
  "Joe Test the #{n.ordinalize}"
end
