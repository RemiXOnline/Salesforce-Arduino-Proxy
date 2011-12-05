require 'rubygems'
require 'databasedotcom'
require 'rxUtil.rb'

class Net::HTTP
  alias_method :old_initialize, :initialize
  def initialize(*args)
    old_initialize(*args)
    @ssl_context = OpenSSL::SSL::SSLContext.new
    @ssl_context.verify_mode = OpenSSL::SSL::VERIFY_NONE
  end
end

class RXdbcom

  attr_accessor :client

  # Constructor
  def initialize(token,url)
    Debug.log "Initializing connection to SFDC"
    @client=Databasedotcom::Client.new
    @client.authenticate :token =>token, :instance_url =>url 
    @client.version='23.0'
    Debug.log "Connected on Org #{@client.org_id}"
    rescue
      @client=nil
      Debug.log "Error : Can not log to database.com url=#{url} sessionId=#{token}"
  end
 
  # Reply to Chatter
  # - origin = initial feed id
  # - reply = string to send
  def replyToChatter(origin,reply)
    Debug.log "Reply to chatter #{reply} (#{origin})"
    f=Databasedotcom::Chatter::FeedItem.find(@client,origin);
    f.comment(reply)
  end
  # Like to Chatter
  def likeToChatter(origin)
    Debug.log "Like to chatter (#{origin})"
    f=Databasedotcom::Chatter::FeedItem.find(@client,origin);
    f.like
  end
end
