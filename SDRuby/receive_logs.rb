require 'bunny'

comLogs = File.open('logs/com.logs','a')

connection = Bunny.new
connection.start

channel = connection.create_channel

exchange = channel.fanout('logs')
queue = channel.queue('', exclusive: true)

queue.bind(exchange)

puts ' [*] Waiting for logs. To exit press CTRL+C'

begin
  queue.subscribe(block: true) do |_delivery_info, _properties, body|
    puts body
    comLogs << body << "\n"
  end
rescue Interrupt => _
  channel.close
  connection.close
end
