# Test program for ABCLogger a ruby logfile class
require 'ABCLogger'
#require 'ABCLogger/ABCSharedLogger'

logger = ABCLogger.new
logger.set_level(:debug)

logger.log(:debug, nil, 'Test message' )
logger.log(:error, nil, 'Test message' )

#logger.open('testing/z.log')
logger.open
logger.log(:warning, nil, 'Test message' )
logger.log(:fatal, nil, 'Test message' )
logger.close

logger.log(:unknown, nil, 'Test message' )
logger.log(:info, nil, 'Test message' )

logger.log(4, nil, 'Test Message')
logger.log(2, nil, 'Test Message')

logger.log(:info, nil, 'Test Message')

val = 234
logger.log_formatted(:warning, 'init','Value was: %d', val)

#x = :fatal
#puts x.to_sym

logger.log(:error, nil, 'Testing 123....')

#ABCSharedLogger.instance.log(:error, nil, 'Testing singleton')

#logger.log(nil, '2 args ........Test message' )
logger.log(:fatal, 'Other 2 args ........Test message' )
logger.log(:info, 'another message 2 args')
logger.log('Msg only ARGS Test message' )

