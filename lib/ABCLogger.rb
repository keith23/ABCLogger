require "ABCLogger/version"
#require 'singleton'
require 'date'

#module ABCLogger
  # Your code goes here...
#end

# GunnyLog logs messages to stdout
class ABCLogger

  #include Singleton

  private

  # Output file open flag
  attr_reader :outfile_open
  # Output file
  attr_reader :outfile

  public

  # Log levels
  attr_reader :levels
  # Log level names
  attr_reader :lnames

  # Logging level
  attr_reader :level
  # Logging enabled
  attr_reader :enabled
  # Logging location
  attr_reader :location

  # Set logging level
  # @param [int] level
  def set_level level
    @level = level
  end

  # Turn logging on and off
  # @param [boolean] flag
  def set_enabled flag
    @enabled = flag
  end

  # Set log message location
  # @param [string] name
  def set_location name
    @location = name
  end

  # open the logfile
  # @param [string] filename
  def open(filename = 'ABCLogger.log')
    @outfile = File.open(filename, 'a+')
    @outfile_open = true
  end

  # close the logfile
  def close
    @outfile.close
    @outfile = STDOUT
    @outfile_open = false
  end

  # Log message with level
  # @param level [string] logging level
  # @param loc   [string] location string
  # @param msg   [string] message string
  def log(level = debug, loc = nil, msg)
    write_msg(@outfile, level, loc, msg)
  end

  # Log formatted message - single arg or array of args
  # @param [string] loc - message location
  # @param [string] msg - message format string
  # @param [arg or array of args]
  def log_formatted(level, loc, msg, args)
    formatted = sprintf(msg, *args)
    log(level, loc, formatted)
  end

  # write formatted message - variable number of args
  # @param [string] loc - message location
  # @param [string] msg - message format string
  # @param [variable number of args]
  def log_formatted_vars(level, loc, msg, *args)
    formatted = sprintf(msg, *args)
    log(level, loc, formatted)
  end

  private

  # Initialize ABCLogger
  def initialize
    @levels = {:debug => 0, :info => 1, :warn => 2,
               :error => 3, :fatal => 4, :unknown => 5}
    @lnames = [ 'DEBUG', 'INFO', 'WARNING', 'ERROR', 'FATAL', 'UNKNOWN']
    @level = :debug
    @enabled = true
    @location = 'MainMethod'
    @outfile_open = false
    @outfile = STDOUT
  end

  def write_msg(output, level = :debug, loc, msg)
    if loc == nil
      loc = @location
    end
    if @enabled
      output.puts "#{date_str}|#{level_name(level)}|#{loc}|#{msg}"
    end
  end

  def date_str
    d = DateTime.now
    d.strftime('%m/%d/%Y|%I:%M:%S%p')
  end

  def level_name(sym)
    lvl = @levels[sym]
    return @lnames[lvl]

  #def test_func(sym)
  #  lvl = @levels[sym]
  #  puts "#{lvl}|#{@lnames[lvl]}"
  #end

  end

end