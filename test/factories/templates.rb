Factory.define :template do |f|
  f.name { Factory.next :document_name }
  f.content ""
end
