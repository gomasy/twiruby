class Hash
  def to_q
    str = ""
    self.each do |k, v|
      v = v.join(",") if v.kind_of?(Array)
      str << "#{k}=#{url_encode(v)}&"
    end

    str[0..str.length - 2]
  end

  def symbolize_keys
    self.each_with_object({}) do |(k, v), h|
      h[k.to_s.to_sym] = v
    end
  end

  def deep_symbolize_keys
    self.each_with_object({}) do |(k, v), h|
      h[k.to_s.to_sym] = (v.is_a?(Hash) ? v.deep_symbolize_keys : v)
    end
  end
end

class NilClass
  def to_q
  end
end
