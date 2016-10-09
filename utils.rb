def get_nested_hash_value(obj, key)
  if obj.respond_to?(:key?) && obj.key?(key)
    return obj[key]
  elsif obj.respond_to?(:each)
    r = nil
    obj.find{ |*a| r=get_nested_hash_value(a.last, key) }
    r
  end
end
