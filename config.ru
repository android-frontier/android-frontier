# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)

schema = YAML.load_file("schema.yml")
unless schema
  raise "Empty schema!"
end

use Rack::JsonSchema::Docs, schema: schema
use Rack::JsonSchema::SchemaProvider, schema: schema
use Rack::JsonSchema::ErrorHandler
use Rack::JsonSchema::RequestValidation, schema: schema
use Rack::JsonSchema::ResponseValidation, schema: schema if ENV["RACK_ENV"] != "production"
use Rack::JsonSchema::Mock, schema: schema if ENV["RACK_ENV"] == "mock"

run Rails.application
