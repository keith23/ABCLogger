# ABCLogger logs messages to stdout, stderr, or a file
class ABCLogger

  VERSION = "0.0.1"

  LEVELS = [:debug, :info, :warning, :error, :fatal, :unknown]

  #LEVELS = {:debug => 0, :info => 1, :warn => 2,
  #           :error => 3, :fatal => 4, :unknown => 5}
  #LNAMES = [ 'DEBUG', 'INFO', 'WARNING', 'ERROR', 'FATAL', 'UNKNOWN']

  #DEBUG = :debug
  #INFO = 1
  #WARNING = 2
  #ERROR = 3
  #FATAL = 4
  #UNKNOWN = 5

  private
  DEBUG_LOG = true

end


##module ABCLogMod
##  VERSION = "0.0.1"
##end