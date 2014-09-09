require "ABCLogger/version"
require 'singleton'
require 'date'

#module ABCLogger
  # Your code goes here...
#end

# GunnyLog logs messages to stdout
class ABCLogger

  include Singleton

  # Turn logging on and off
  # @param [bool] switch
  def set_switch(switch)
    @onoffswitch = switch
  end

  # Set log message location
  # @param [string] name
  def set_location(name)
    @location = name
  end

  # write message to stdout or logfile
  # @param [string] loc - message location, optional
  # @param [string] msg - message string
  def message(loc = nil, msg)
    if @_is_file_open
      write_msg(@outfile, loc, msg)
    else
      write_msg(STDOUT, loc, msg)
    end
  end

  # write formatted message - single arg or array of args
  # @param [string] loc - message location, optional
  # @param [string] msg - message format string
  # @param [arg or array of args]
  def formatted_message(loc = nil, msg, args)
    formatted = sprintf(msg, *args)
    message(loc, formatted)
  end

  # write formatted message - variable number of args
  # @param [string] loc - message location
  # @param [string] msg - message format string
  # @param [variable number of args]
  def formatted_message_vars(loc, msg, *args)
    formatted = sprintf(msg, *args)
    message(loc, formatted)
  end

  # open the logfile
  # @param [string] filename
  def openlog(filename = 'logger')
    @outfile = File.open(filename  + '.log', 'a+')
    @_is_file_open = true
  end

  # close the logfile
  def closelog
    @outfile.close
    @_is_file_open = false
  end


  private

  class << self;
    attr_accessor :onoffswitch
  end
  @onoffswitch = true

  class << self;
    attr_accessor :location
  end
  @location = 'MainMethod'

  class << self;
    attr_accessor :_is_file_open
  end
  @_is_file_open = false

  def write_msg(output, loc, msg)
    if loc == nil
      loc = @location
    end
    if @onoffswitch
      output.puts "#{date_str}|#{loc}|#{msg}"
    end
  end

  def date_str
    d = DateTime.now
    d.strftime('%m/%d/%Y|%I:%M:%S%p')
  end

end