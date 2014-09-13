# Test program for ABCLogger a ruby logfile class
require 'ABCLogger'

logger = ABCLogger.new
logger.set_level(:warn)
logger.log(:debug, nil, 'Test message' )
logger.log(:error, nil, 'Test message' )


