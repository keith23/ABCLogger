# ABCLogger

ABCLogger logs messages to stdout, stderr, or a file.<br>
ABCSharedLogger is the singleton implementaion.<br>

## Installation

Add this line to your application's Gemfile:

```
gem 'ABCLogger'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ABCLogger

## Usage

### ABCLogger Examples 
require 'ABCLogger'

#### Example of STDOUT logging 

##### Sample code
``` 
logger = ABCLogger.new
logger.set_level(:debug)

logger.log(:debug, 'init', 'Test message')
logger.log(:error, 'Test message')
logger.log('post init', 'Next message') 
logger.log('Msg only ARG Test message')
 
age = 42
logger.log_formatted(:warning, 'init','Value was: %d', age)
logger.log_formatted(:info, 'Value was: %d', age)
logger.log_formatted('not_init','Value was: %d', age)
logger.log_formatted('Value was: %d', age)

name = 'Gunny'
job = 'Developer'
logger.log_formatted_vars(:debug, 'next','name: %s, age: %d, job: %s', name, age, job)
```  
  
##### Sample output

STDOUT<br> 

```
09/15/2014|02:36:00PM|ABCTester.rb|DEBUG|init|Test message
09/15/2014|02:36:00PM|ABCTester.rb|ERROR|init|Test message
09/15/2014|02:36:00PM|ABCTester.rb|ERROR|post init|Next message
09/15/2014|02:36:00PM|ABCTester.rb|ERROR|post init|Msg only ARG Test message
09/15/2014|02:36:00PM|ABCTester.rb|WARNING|init|Value was: 42
09/15/2014|02:36:00PM|ABCTester.rb|INFO|init|Value was: 42
09/15/2014|02:36:00PM|ABCTester.rb|INFO|not_init|Value was: 42
09/15/2014|02:36:00PM|ABCTester.rb|INFO|not_init|Value was: 42
09/15/2014|02:36:00PM|ABCTester.rb|DEBUG|next|name: Gunny, age: 42, job: Developer
```

#### Example of file logging 

##### Sample code #open
```
logger = ABCLogger.new
logger.set_level(:debug)

logger.open('ABCTester.log')
logger.log(:warning, 'file', 'Test message')
logger.log(:fatal, 'Test message')
logger.log('Msg only ARGS Test message')
logger.log_exception(:unknown, Exception.new('File exception'))
logger.close
```

##### Sample output

File: ABCTester.log<br>

```
09/15/2014|06:45:00PM|ABCTester.rb|WARNING|file|Test message
09/15/2014|06:45:00PM|ABCTester.rb|FATAL|file|Test message
09/15/2014|06:45:00PM|ABCTester.rb|FATAL|file|Msg only ARGS Test message
09/15/2014|06:45:00PM|ABCTester.rb|UNKNOWN|file|File exception
```

##### Sample code #open_with_date
```
logger = ABCLogger.new
logger.set_level(:debug)

logger.open_with_date
logger.log(:warning, 'file', 'Test message' )
logger.log(:fatal, 'Test message' )
logger.log('Msg only ARGS Test message' )
logger.log_exception(:unknown, Exception.new('File exception'))
logger.close
```

##### Sample output

File: ABCLogger_20140916.log<br>

```
09/16/2014|02:57:35PM|ABCTester.rb|WARNING|file|Test message
09/16/2014|02:57:35PM|ABCTester.rb|FATAL|file|Test message
09/16/2014|02:57:35PM|ABCTester.rb|FATAL|file|Msg only ARGS Test message
09/16/2014|02:57:35PM|ABCTester.rb|UNKNOWN|file|File exception
```

#### Example of custom output

##### Sample code
```
logger = ABCLogger.new
logger.set_level(:debug)

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
```

##### Sample output

STDERR<br> 

```
09/16/2014|02:57:35PM|ABCTester.rb|DEBUG|next|Testing to STDERR
09/16/2014|02:57:35PM|ABCTester.rb|INFO|next|Testing to STDERR
```

STDOUT<br>
 
```
09/16/2014|02:57:35PM|ABCTester.rb|INFO|next|Testing to STDOUT
09/16/2014|02:57:35PM|ABCTester.rb|WARNING|next|Testing to STDOUT
```

File: testing.log<br>

```
09/16/2014|02:57:35PM|ABCTester.rb|WARNING|next|Testing to file
09/16/2014|02:57:35PM|ABCTester.rb|WARNING|next|Testing to file
```

### ABCSharedLogger Examples 
require 'ABCSharedLogger'

#### Example of STDOUT logging 

##### Sample code
``` 
ABCSharedLogger.instance.set_program('ABCTester')
ABCSharedLogger.instance.set_level(:warning)
ABCSharedLogger.instance.log(:error, 'Testing singleton')
ABCSharedLogger.instance.log('Testing singleton again')

log = ABCSharedLogger.instance
log.log(:warning,'ReadData','New test 1')
log.log('New test 2')
log.log_formatted_vars(:fatal, 'ErrorHandler', 'RC = %d', errno)
```  
  
##### Sample output

STDOUT<br> 

```
09/16/2014|03:59:27PM|ABCTester|ERROR|Main|Testing singleton
09/16/2014|03:59:27PM|ABCTester|ERROR|Main|Testing singleton again
09/16/2014|03:59:27PM|ABCTester|WARNING|ReadData|New test 1
09/16/2014|03:59:27PM|ABCTester|WARNING|ReadData|New test 2
09/16/2014|03:59:27PM|ABCTester|FATAL|ErrorHandler|RC = 7

```

#### Example of file logging 

##### Sample code #open
```
flog = ABCSharedLogger.instance
flog.set_level(:debug)

flog.open('testing.log')
flog.log(:warning, 'Testing again.......')
flog.log('Again.....')
flog.log_exception(Exception.new ('Test exception'))
flog.log(:fatal, 'This is weird')
flog.close
```

##### Sample output

File: ABCTester.log<br>

```
09/16/2014|04:05:50PM|ABCTester|WARNING|ErrorHandler|Testing again.......
09/16/2014|04:05:50PM|ABCTester|WARNING|ErrorHandler|Again.....
09/16/2014|04:05:50PM|ABCTester|WARNING|ErrorHandler|Test exception
09/16/2014|04:05:50PM|ABCTester|FATAL|ErrorHandler|This is weird
```

##### Sample code #open_with_date
```
dlog = ABCSharedLogger.instance
dlog.set_program('AppZ')

dlog.open_with_date(nil, 'ABCTst', 'log')
dlog.log :info, 'Testing again.......'
dlog.log 'Again.....'
dlog.log_exception ( Exception.new ('Test exception'))
dlog.log(:fatal, 'This is weird')
dlog.close
```

##### Sample output

File: ABCTst_20140916.log<br>

```
09/16/2014|04:07:10PM|AppZ|INFO|ErrorHandler|Testing again.......
09/16/2014|04:07:10PM|AppZ|INFO|ErrorHandler|Again.....
09/16/2014|04:07:10PM|AppZ|INFO|ErrorHandler|Test exception
09/16/2014|04:07:10PM|AppZ|FATAL|ErrorHandler|This is weird
```

#### Example of custom output

##### Sample code
```
logger = ABCSharedLogger.instance
logger.set_level(:debug)

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
```

##### Sample output

STDERR<br> 

```
09/16/2014|02:57:35PM|ABCTester.rb|DEBUG|next|Testing to STDERR
09/16/2014|02:57:35PM|ABCTester.rb|INFO|next|Testing to STDERR
```

STDOUT<br>
 
```
09/16/2014|02:57:35PM|ABCTester.rb|INFO|next|Testing to STDOUT
09/16/2014|02:57:35PM|ABCTester.rb|WARNING|next|Testing to STDOUT
```

File: testing.log<br>

```
09/16/2014|02:57:35PM|ABCTester.rb|WARNING|next|Testing to file
09/16/2014|02:57:35PM|ABCTester.rb|WARNING|next|Testing to file
```


## Contributing

1. Fork it ( https://github.com/keith23/ABCLogger/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
