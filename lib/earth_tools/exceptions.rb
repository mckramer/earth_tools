module EarthTools

  class Error < StandardError
  end

  class ConfigurationError < Error
  end

  class OverQueryLimitError < Error
  end
  
  class InvalidInputError < Error
  end
  
  class UnsupportedOperationError < Error
  end
  
end