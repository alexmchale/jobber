Factory.sequence :email do |n|
  "user#{n}@example.com"
end

Factory.sequence :name do |n|
  "Joe Test the #{n.ordinalize}"
end

Factory.sequence :document_name do |n|
  "Document Style #{n}"
end

Factory.sequence :sha1 do |n|
  Digest::SHA1.hexdigest n.to_s
end
