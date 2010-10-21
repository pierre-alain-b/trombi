# Load the rails application
require File.expand_path('../application', __FILE__)

# Load site.yml information
require 'yaml'
SITE_CONFIG = YAML.load_file(File.join(File.dirname(__FILE__), 'site.yml'))
HOST_ROOT = SITE_CONFIG['host_root']

# Initialize the rails application
Trombi3::Application.initialize!
