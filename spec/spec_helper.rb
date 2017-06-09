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

# https://circleci.com/docs/docker#docker-exec
if ENV['CIRCLECI']
  module Docker
    class Container
      def exec(command, opts = {}, &block)
        command[2] = command[2].inspect
        cmd = %Q{sudo lxc-attach -n #{self.id} -- #{command.join(' ')}}
        stdin, stdout, stderr, wait_thread = Open3.popen3 cmd
        [stdout.read, [stderr.read], wait_thread.value.exitstatus]
      end

      def remove(options={})
        # do not delete container
      end
      alias_method :delete, :remove
      alias_method :kill, :remove
    end
  end
end