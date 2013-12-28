module EarthTools
  
  ##
  # Common error, extended by more specific errors.
  class Error < StandardError
  end
  
  ##
  # Error thrown when there is an issue setting/getting configuration.
  class ConfigurationError < Error
  end
  
  ##
  # Error thrown when too many requests have been made to EarthTools service in.
  class OverQueryLimitError < Error
  end
  
  ##
  # Error thrown when invalid input is provided to the service when querying.
  class InvalidInputError < Error
  end
  
  ##
  # Error thrown when unsupported operation is attempted on the service.
  class UnsupportedOperationError < Error
  end
  
end