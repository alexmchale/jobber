Factory.define :document do |f|
  f.content ""
  f.name { Factory.next :document_name }
end
