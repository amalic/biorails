# Be sure to restart your web server when you modify this file.

# Uncomment below to force Rails into production mode when
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
#
# Should work under 2.0 or 1.2 rails unlocked as testing with 2.0 at present
#
#RAILS_GEM_VERSION = '2.0.2'
# remove as caused oracle performance problems ENV['NLS_COMP']='linguistic'

#
# Moved all external libraries requirements to environment
# (helps to fail earily if dependent library missing)
#
require 'rubygems'
require 'openssl'
require 'base64'
require 'csv'
require 'zlib'
require 'stringio'
require 'digest/md5'
require 'digest/sha1'
require 'mime/types'
require 'pathname'
require 'htmldoc'
require 'rubygems/package'
require 'matrix'
require 'archive/tar/minitar'
require 'zip/zipfilesystem'
require 'chronic'

# gem install ruby-net-ldap
#require 'mini_magick'
# now added as plugin require 'liquid'

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')
#
# Rails Engines
#
## Native linked
require "faster_csv"
require 'ntp'

require File.join(File.dirname(__FILE__), '../vendor/plugins/engines/boot')
Engines.disable_code_mixing == true

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence those specified here

  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.
  # See Rails::Configuration for more options.

  # Skip frameworks you're not going to use (only works if using vendor/rails).
  # To use Rails without a database, you must remove the Active Record framework
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Add additional load paths for your own custom dirs
  #
  # Path to custom handlers 
  #  app/cachers page and partial caching code
  #  app/observer active record model change logggers
  #  app/drops custom liquid template data formaters
  #
  config.load_paths += %W( #{RAILS_ROOT}/app/cachers #{RAILS_ROOT}/app/observers #{RAILS_ROOT}/app/drops )

  #
  # Add Controller namespaces to path to found in unit tests
  # 
  #
  config.load_paths += %W( #{RAILS_ROOT}/app/controllers/project #{RAILS_ROOT}/app/controllers/organize #{RAILS_ROOT}/app/controllers/execute #{RAILS_ROOT}/app/controllers/inventory #{RAILS_ROOT}/app/controllers/admin)

  ##
  # Use the database for sessions instead of the cookie-based default,
  # which shouldn't be used to store highly confidential information
  # (create the session table with 'rake db:sessions:create')
  #config.action_controller.session_store = :active_record_store

  # Make Active Record use UTC-base instead of local time
  config.active_record.default_timezone = :utc

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper,
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql
  config.active_record.schema_format = :ruby

  # Only load the plugins named here, in the order given. By default, all plugins
  # in vendor/plugins are loaded in alphabetical order.
  # :all can be used as a placeholder for all plugins not explicitly named
  #
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Your secret key for verifying cookie session data integrity.
  # If you change this key, all old sessions will become invalid!
  # Make sure the secret is at least 30 characters and all random,
  # no regular words or you'll be exposed to dictionary attacks.

  config.action_controller.session = {
    :session_key => '_biorails3',
    :secret      =>'0a3cae420e2e43d216f641e7c84958c357aac44493bee85cb3f9a46bb9fc7f8ebe52d9f8ac5d3d429a678ce91f46336fb04e91a4f9054c164f8f258932763e59'
  }
  
  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector

end


#SYSTEM_SETTINGS="#{RAILS_ROOT}/config/system_settings.yml"

#
# Add functions from /lib/models.rb to the Active Record
#
ActiveRecord::Base.send(:include, ModelExtras)

#
# Nil classes are regarded as a empty?e
#
class NilClass
  def empty?
    true
  end
end

