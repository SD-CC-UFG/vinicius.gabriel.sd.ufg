require 'bunny'

wrn1 = "You can pass the logs now or when executing pass it as parameters. :)"

connection = Bunny.new
connection.start

argvMessage = ARGV.join(' ')

channel = connection.create_channel
exchange = channel.fanout('logs')

argvMessage.empty? ? puts(wrn1) : print("\n")

message = argvMessage.empty? ? (argvMessage = gets) : argvMessage

exchange.publish(message)

puts " [x] Sent #{message}"

while !(message.include? "exit")

  message = gets

  exchange.publish(message)

  puts " [x] Sent #{message}"

end

connection.close
