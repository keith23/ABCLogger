require 'ABCLogger/version'
require 'ABCLogger/exceptions'
#require 'singleton'
require 'date'


# ABCLogger logs messages to stdout, stderr, or a file
class ABCLogger

  #include Singleton

  private
  DEBUG_LOG = false

  # Output file open flag
  attr_reader :outfile_open
  # Output file
  attr_reader :outfile

  #public

  # Log levels
  attr_reader :levels
  # Log level names
  attr_reader :lnames

  public

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
    begin
      @outfile = File.open(filename, 'a+')
      @outfile_open = true
    rescue SystemCallError => exc
      handle_exception(exc)
    end
  end

  # close the logfile
  def close
    begin
      @outfile.close
      @outfile = STDOUT
      @outfile_open = false
    rescue SystemCallError => exc
      handle_exception(exc)
    end
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

  # Set output to STDOUT, STDERR, or a File
  # @param output [object] output for log
  def set_output(output = STDOUT)
    if @outfile_open
      close
    end
    @outfile = output
  end

  private

  def write_msg(output, level = :debug, loc, msg)
    if loc == nil
      loc = @location
    end

    if DEBUG_LOG
      puts @levels[@level]
      puts @levels[level]
    end

    case level
      when Integer
        if 1 == 2 #ABCLogger::DEBUG_LOG
        #  puts "INTEGER level_name(#{level})"
        end
        lvl_int = level
      when Symbol
        if 1 == 2 #ABCLogger::DEBUG_LOG
        #  puts "SYMBOL level_name(#{level})"
        end
        lvl_int = @levels[level]
      when String
        if 1 == 2 #ABCLogger::DEBUG_LOG
        #  puts "STRING level_name(#{level})"
        end
        lvl_int = 0
      else
        if 1 == 2 #ABCLogger::DEBUG_LOG
        #  puts "NOT SURE level_name(#{level})"
        end
        lvl_int = 0
      end

    if @enabled
      if @levels[@level] <= lvl_int # @levels[level]
        output.puts "#{date_str}|#{level_name(level)}|#{loc}|#{msg}"
      end
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
        #puts "INTEGER level_name(#{sym})"
        return @lnames[sym]
      when Symbol
        #puts "SYMBOL level_name(#{sym})"
      when String
        #puts "STRING level_name(#{sym})"
      else
        #puts "NOT SURE level_name(#{sym})"
    end
    #if sym == nil
    #  sym = 0
    #end
    lvl = @levels[sym]
    @lnames[lvl]
  end

  # log exception and raise
  def handle_exception(exc)
    self.log_exception(:fatal, '***ABCLogger***', exc)
    raise ABCLoggerException.new(exc.message)
  end

  #def test_func(sym)
  #  lvl = @levels[sym]
  #  puts "#{lvl}|#{@lnames[lvl]}"
  #end

end

#module ABCLogger
# Your code goes here...
#end