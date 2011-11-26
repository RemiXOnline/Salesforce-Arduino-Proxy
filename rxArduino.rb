require 'socket'
require 'rxUtil.rb'

class RXarduino
  attr_accessor :server
  def initialize(ip,port)
    Debug.log "Connecting to Arduino on  #{ip}:#{port} "     
    @server = TCPSocket.open(ip, port) 
    rescue 
      @server=nil;
      Debug.log "Can't connect to Arduino"
  end
  def sendCmd(cmd)
    Debug.log "Send #{cmd} to Arduino"
    @server.puts cmd
    response=@server.read
    Debug.log "Response = #{response}"
    return response
  end
end
