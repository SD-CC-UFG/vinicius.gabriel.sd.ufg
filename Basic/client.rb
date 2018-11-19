require 'socket'

s = TCPSocket.new 'localhost', 5555

line = s.gets
puts line

while input = gets
    s.puts input    
end

s.close    