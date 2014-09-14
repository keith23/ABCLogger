require 'ABCLogger/version'
#require 'singleton'
require 'date'


# ABCLogger logs messages to stdout, stderr, or a file
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
  def set_level(level)
    @level = level
  end

  # Turn logging on and off
  # @param [boolean] flag
  def set_enabled(flag)
    @enabled = flag
  end

  # Set log message location
  # @param [string] name
  def set_location(name)
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
  def log(level = :debug, loc = nil, msg)
    write_msg(@outfile, level, loc, msg)
  end

  # Log formatted message - single arg or array of args
  # @param level [int] log level
  # @param loc [string] message location
  # @param msg [string] message format string
  # @param args [arg or array of args]
  def log_formatted(level, loc, msg, args)
    formatted = sprintf(msg, *args)
    log(level, loc, formatted)
  end

  # Log formatted message - variable number of args
  # @param level [int] log level
  # @param loc [string] message location
  # @param msg [string] message format string
  # @param args [variable number of args]
  def log_formatted_vars(level, loc, msg, *args)
    formatted = sprintf(msg, *args)
    log(level, loc, formatted)
  end

  # Log exception to logfile
  # @param level [int] log level
  # @param loc [string] message location
  # @param exc [exception] exception to log
  def log_exception(level, loc, exc)
    log(level, loc, exc.message)
  end

  # Initialize ABCLogger
  def initialize
    @levels = {:debug => 0, :info => 1, :warning => 2,
               :error => 3, :fatal => 4, :unknown => 5}
    @lnames = %w(DEBUG INFO WARNING ERROR FATAL UNKNOWN)
    @level = :debug
    @enabled = true
    @location = 'Main'
    @outfile_open = false
    @outfile = STDOUT
  end

  private

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
    #puts "level_name(#{sym})"
    case sym
      when Integer
        #puts 'INTEGER'
        return @lnames[sym]
      when Symbol
        #puts 'SYMBOL'
      when String
        #puts 'STRING'
      else
        #puts 'NOT SURE'
    end
    #if sym == nil
    #  sym = 0
    #end
    lvl = @levels[sym]
    @lnames[lvl]
  end


  #def test_func(sym)
  #  lvl = @levels[sym]
  #  puts "#{lvl}|#{@lnames[lvl]}"
  #end

end

#module ABCLogger
# Your code goes here...
#end