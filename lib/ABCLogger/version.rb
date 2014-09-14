# ABCLogger logs messages to stdout, stderr, or a file
class ABCLogger

  VERSION = "0.0.1"

  LEVELS = {:debug => 0, :info => 1, :warn => 2,
             :error => 3, :fatal => 4, :unknown => 5}

  #LEVELS = [:debug, :info, :warning, :error, :fatal, :unknown]

  #OUTPUT = [:stdout, :stderr, :file]

  #LNAMES = [ 'DEBUG', 'INFO', 'WARNING', 'ERROR', 'FATAL', 'UNKNOWN']

  #$debug = 0
  #$info = 1
  #$warning = 2
  #$error = 3
  #$fatal = 4
  #$unknown = 5

end


##module ABCLogMod
##  VERSION = "0.0.1"
##end