require 'bunny'

connection = Bunny.new
connection.start

puts "Insert name: "
name = gets.chomp

puts "Insert channel:\n 1 - Games \n 2 - Filmes \n 3 - Series\n"
chn = gets.chomp

comLogs = File.open('logs/com.logs','a')

comLogs << " ----------- Channel -- #{chn} ----------- \n"

argvMessage = ARGV.join(' ')

channel = connection.create_channel
exchange = channel.fanout(chn)
queue = channel.queue('', exclusive: true)

queue.bind(exchange)

Thread.new{
  begin
    queue.subscribe(block: true) do |_delivery_info, _properties, body|
      puts body
      comLogs << body << "\n"
    end
  rescue Interrupt => _
    channel.close
    connection.close
  end
}

message = argvMessage.empty? ? (argvMessage = gets) : argvMessage

newMessage = "[#{name}] #{message}"

exchange.publish(newMessage)

while !(message.include? "exit")

  message = gets.chomp

  newMessage = "[#{name}] #{message}"

  exchange.publish(newMessage)


end

connection.close
