Factory.define :interview do |f|
  f.starts_at Time.now
  f.access_code { Factory.next :sha1 }
  f.association :candidate
end
