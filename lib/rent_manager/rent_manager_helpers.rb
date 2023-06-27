module RentManager
  module RentManagerHelpers
    def arrayitize(array_or_string)
      array_or_string.is_a?(Array) ? array_or_string : [array_or_string]
    end

    def camelize_string(str)
      str.to_s.split('_').collect(&:capitalize).join
    end
  end
end
