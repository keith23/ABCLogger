# Test program for ABCLogger a ruby logfile class
require 'ABCLogger'

logger = ABCLogger.new
logger.set_level(:warn)

logger.log(:debug, nil, 'Test message' )
logger.log(:error, nil, 'Test message' )

logger.open
logger.log(:warn, nil, 'Test message' )
logger.log(:fatal, nil, 'Test message' )
logger.close

logger.log(:unknown, nil, 'Test message' )
logger.log(:info, nil, 'Test message' )