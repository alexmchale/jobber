Factory.sequence :email do |n|
  "user#{n}@example.com"
end

Factory.sequence :name do |n|
  "Joe Test the #{n.ordinalize}"
end

Factory.sequence :document_name do |n|
  "Document Style #{n}"
end
