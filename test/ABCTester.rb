# Test program for ABCLogger a ruby logfile class
require 'ABCLogger'
require 'ABCSharedLogger'

errno = 7
age = 42
name = 'Gunny'
job = 'Developer'

# ABCLogger STDOUT example
logger = ABCLogger.new
logger.set_level(:debug)

logger.log(:debug, 'init', 'Test message')
logger.log(:error, 'Test message' )
logger.log('post init', 'Next message')
logger.log('Msg only ARG Test message')

logger.log_formatted(:warning, 'init','Value was: %d', age)
logger.log_formatted(:info, 'Value was: %d', age)
logger.log_formatted('not_init','Value was: %d', age)
logger.log_formatted('Value was: %d', age)

logger.log_formatted_vars(:debug, 'next',
                'name: %s, age: %d, job: %s', name, age, job)


# ABCLogger File example
#logger.open('ABCTester.log')
#logger.open_with_date('/home/testing', 'ABCLog', 'log')
logger.open_with_date
logger.log(:warning, 'file', 'Test message' )
logger.log(:fatal, 'Test message' )
logger.log('Msg only ARGS Test message' )
logger.log_exception(:unknown, Exception.new('File exception'))
logger.close

# ABCLogger Custom example
logger.set_output(STDERR)
logger.log('Testing to STDERR')
logger.log(:info, 'Testing to STDERR')

logger.set_output(STDOUT)
logger.log('Testing to STDOUT')
logger.log(:warning, 'Testing to STDOUT')

file = File.open('testing.log', 'a+')
logger.set_output(file)
logger.log('Testing to file')
logger.log(:warning, 'Testing to file')
logger.set_output(STDOUT)
file.close


# ABCSharedLogger example
ABCSharedLogger.instance.set_program('ABCTester')
ABCSharedLogger.instance.set_level(:warning)
ABCSharedLogger.instance.log(:error, 'Testing singleton')
ABCSharedLogger.instance.log('Testing singleton again')

log = ABCSharedLogger.instance
log.log(:warning,'ReadData','New test 1')
log.log('New test 2')
log.log_formatted_vars(:fatal, 'ErrorHandler', 'RC = %d', errno)

# ABCSharedLogger example
flog = ABCSharedLogger.instance
flog.set_level(:debug)

flog.open('testing.log')
flog.log(:warning, 'Testing again.......')
flog.log('Again.....')
flog.log_exception(Exception.new ('Test exception'))
flog.log(:fatal, 'This is weird')
flog.close

# ABCSharedLogger example
dlog = ABCSharedLogger.instance
dlog.set_program('AppZ')

dlog.open_with_date(nil, 'ABCTst', 'log')
dlog.log :info, 'Testing again.......'
dlog.log 'Again.....'
dlog.log_exception ( Exception.new ('Test exception'))
dlog.log(:fatal, 'This is weird')
dlog.close