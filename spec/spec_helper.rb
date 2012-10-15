require 'simplecov'
SimpleCov.start if ENV["COVERAGE"]

def temp_name()
  "test_#{SecureRandom.hex 4}"
end
