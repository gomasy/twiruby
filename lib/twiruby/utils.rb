module TwiRuby
  module Utils
    def build_query(hash)
      if !hash.nil?
        str = ""
        hash.each do |key, value|
          str << "#{key}=#{url_encode(value)}&"
        end

        str[0..str.length - 2]
      else
        nil
      end
    end
  end
end
