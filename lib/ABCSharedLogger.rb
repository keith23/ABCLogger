require 'ABCLogger'
require 'singleton'

class ABCSharedLogger < ABCLogger

  include Singleton

  #def self.instance
  #  @@instance ||= new
  #end

  #private

  #def initialize
  #  super.initialize
  #end

end