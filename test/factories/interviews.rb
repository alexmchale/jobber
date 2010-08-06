Factory.define :interview do |f|
  f.starts_at Time.now
  f.association :candidate
end
