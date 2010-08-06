Factory.define :candidate do |f|
  f.name  { Factory.next :name }
  f.email { Factory.next :email }
end
