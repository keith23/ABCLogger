require 'ABCLogger/version'
require 'ABCLogger/exceptions'
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
  # Saved file name
  attr_reader :file_name
  # Saved log level
  attr_reader :level_save

  # Log levels
  attr_reader :levels
  # Log level names
  attr_reader :lnames

  public
  LEVELS = {:debug => 0, :info => 1, :warning => 2,
            :error => 3, :fatal => 4, :unknown => 5}

  # Logging level
  # @return [symbol] current log level
  attr_reader :level
  # Logging enabled
  # @return [boolean] logging enabled flag
  attr_reader :enabled
  # Logging location
  # @return [string] log message location
  attr_reader :location
  # Program name
  # @return [string] program name
  attr_reader :program

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

  # Set program name
  # @param [string] name
  def set_program(name)
    @program = name
  end

  # open the logfile
  # @param [string] filename
  def open(filename = 'ABCLogger.log')
    begin
      @outfile = File.open(filename, 'a+')
      @file_name = filename
      @outfile_open = true
      if DEBUG_LOG
        puts "***ABCLogger:file: #{@file_name} was opened"
      end
    rescue SystemCallError => exc
      handle_exception(exc)
    end
  end

  # open the logfile
  # @param [string] path
  # @param [string] prefix
  # @param [string] ext
  def open_with_date(path = nil, prefix = 'ABCLogger', ext = 'log')
    begin
      d = DateTime.now
      if path == nil
        @file_name = prefix << '_' << d.strftime('%Y%m%d') << '.' << ext
      else
        @file_name = path << '/' << prefix << '_' << d.strftime('%Y%m%d') << '.' << ext
      end
      @outfile = File.open(@file_name, 'a+')
      @outfile_open = true
      if DEBUG_LOG
        puts "***ABCLogger:file: #{@file_name} was opened"
      end
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
      if DEBUG_LOG
        puts "***ABCLogger:file: #{@file_name} was closed"
      end
      @file_name = nil
    rescue SystemCallError => exc
      handle_exception(exc)
    end
  end

  # Set output to STDOUT, STDERR, or a File
  # @param output [object] output for log
  def set_output(output = STDOUT)
    if @outfile_open
      close
    end
    @outfile = output
    if DEBUG_LOG
      puts "***ABCLogger:ouput was changed to: #{output_name}"
    end
  end

  # Log message with level
  # @param level [string] logging level, optional
  # @param loc   [string] location string, optional
  # @param msg   [string] message string
  def log(level = nil, loc = nil, msg)

    if level == nil
      level = @level_save
    end

    if level.is_a? Symbol
      #puts 'level is symbol'
      @level_save = level
    end

    if level.is_a? String
      #puts 'level is string'
      if loc == nil
        loc = level
        level = @level_save
      end
    end

    write_msg(@outfile, level, loc, msg)

  end

  # Log formatted message - single arg or array of args
  # @param level [int] log level, optional
  # @param loc [string] message location, optional
  # @param msg [string] message format string
  # @param args [arg or array of args]
  def log_formatted(level = nil, loc = nil, msg, args)
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
  # @param level [int] log level, optional
  # @param loc [string] message location, optional
  # @param exc [exception] exception to log
  def log_exception(level = nil, loc = nil, exc)
    log(level, loc, exc.message)
  end

  # Initialize ABCLogger
  # @return [ABCLogger]
  def initialize
    @levels = {:debug => 0, :info => 1, :warning => 2,
               :error => 3, :fatal => 4, :unknown => 5}
    @lnames = %w(DEBUG INFO WARNING ERROR FATAL UNKNOWN)
    @level = :debug
    @enabled = true
    @location = 'Main'
    @outfile_open = false
    @outfile = STDOUT
    @file_name = nil
    @level_save = :debug
    @program = $0
  end

  private

  def write_msg(output, level = :debug, loc = nil, msg)

    if loc == nil
      loc = @location
    else
      @location = loc
    end

    #if DEBUG_LOG and 1 == 2
    #  puts @levels[@level]
    #  puts @levels[level]
    #end

    case level
      when Integer
        #  puts "INTEGER level_name(#{level})"
        lvl_int = level
      when Symbol
        #  puts "SYMBOL level_name(#{level})"
        lvl_int = @levels[level]
      when String
        #  puts "STRING level_name(#{level})"
        lvl_int = 0
      else
        #  puts "NOT SURE level_name(#{level})"
        lvl_int = 0
      end

    @level_save = lvl_int

    if @enabled
      if @levels[@level] <= lvl_int # @levels[level]
        output.puts "#{date_str}|#{@program}|#{level_name(level)}|#{loc}|#{msg}"
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

  # make private
  def output_name
    if @outfile == STDOUT
      return 'STDOUT'
    end
    if @outfile == STDERR
      return 'STDERR'
    end
    @file_name
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