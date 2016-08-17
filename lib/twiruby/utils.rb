class Hash
  def to_q
    if !self.nil?
      str = ""
      self.each do |key, value|
        str << "#{key}=#{url_encode(value)}&"
      end

      str[0..str.length - 2]
    end
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
