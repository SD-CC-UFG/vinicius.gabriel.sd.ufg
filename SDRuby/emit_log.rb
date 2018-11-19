require 'bunny'

wrn1 = ":)"

connection = Bunny.new
connection.start

puts "Insert name: "
name = gets.chomp

argvMessage = ARGV.join(' ')

channel = connection.create_channel
exchange = channel.fanout('logs')
queue = channel.queue('', exclusive: true)

queue.bind(exchange)

Thread.new{
  begin
    queue.subscribe(block: true) do |_delivery_info, _properties, body|
      puts body
    end
  rescue Interrupt => _
    channel.close
    connection.close
  end
}

argvMessage.empty? ? puts(wrn1) : puts(wrn1)

message = argvMessage.empty? ? (argvMessage = gets) : argvMessage

newMessage = "[#{name}] #{message}"

exchange.publish(newMessage)

while !(message.include? "exit")

  message = gets.chomp

  newMessage = "[#{name}] #{message}"

  exchange.publish(newMessage)


end

connection.close
