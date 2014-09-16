# ABCSharedLogger
require 'ABCLogger'
require 'singleton'

# Singleton version of ABCLogger
class ABCSharedLogger < ABCLogger

  include Singleton

  # Instance method for ABCSharedLogger
  # @return [ABCSharedLogger] instance
  def self.instance

    if DEBUG_LOG
      puts '***ABCSharedLogger::instance'
    end

    @@instance ||= new

  end

  private

  def initialize

    if DEBUG_LOG
      puts '***ABCSharedLogger::initialize'
    end

    super

  end

end