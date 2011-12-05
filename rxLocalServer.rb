require 'socket'               # Get sockets from stdlib
require 'rxUtil.rb'

def localServer()
  localPort=2000
  server = TCPServer.open(localPort)   # Socket to listen on port 2000
  Debug.log "Started on port #{localPort}"
  loop {                          # Servers run forever
    Thread.start(server.accept) do |client|
    Debug.log "New Connexion"
    client.puts("[#{$0}] >> Connected to Local Server")
    readFromArduino=client.readline
    Debug.log "Response from Arduino #{readFromArduino}"
    
    client.puts "Closing the connection. Bye!"
    client.close                # Disconnect from the client
    
    # Reply to Chatter
    Debug.log "Reply to text #{$global_feed.text__c}"
    dbcom=RXdbcom.new($global_request.sessionId, $global_request.enterpriseUrl);
    if (dbcom.client)
      dbcom.likeToChatter($global_feed.feedId__c)
    end
  end
 } 
end
