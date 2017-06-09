require 'rubygems'
require 'serverspec'
require 'docker'
require 'docker/helpers'

Excon.defaults[:write_timeout] = 1000
Excon.defaults[:read_timeout] = 1000

RSpec.configure do |config|
    config.include Docker::Helpers

    config.color     = true
    config.tty       = true
    config.formatter = :documentation
end