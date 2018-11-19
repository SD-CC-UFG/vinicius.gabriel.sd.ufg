require 'socket'

server = TCPServer.new 5555

loop do
    
    client = server.accept    # Wait for a client to connect
    client.puts "Hello! Connected to Server, local time -> #{Time.now}, enjoy."
   
    
    while msg = client.gets
        if msg ==  1110
           puts "help"
            client.close
        end
        
        puts msg
        # client.puts msg
    end
    
  end