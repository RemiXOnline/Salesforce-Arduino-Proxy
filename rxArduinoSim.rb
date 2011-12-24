require 'socket'               # Get sockets from stdlib
require 'rxUtil.rb'


######################
# Local Server
######################
LOCAL_SIM_PORT=3333
server = TCPServer.open(LOCAL_SIM_PORT)   
Debug.log "Started on port #{LOCAL_SIM_PORT}"
loop {
Thread.start(server.accept) do |client|
  Debug.log "New Connexion"
  readFromArduino=client.readline
  Debug.log "Cmd from Proxy #{readFromArduino}"
  client.puts "OK"
  client.close                # Disconnect from the client
end

}
