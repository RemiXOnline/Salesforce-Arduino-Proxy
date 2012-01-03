#####################################
# CONSTANTS
#####################################
ARDUINO =  {:IP=>'172.16.27.100',:PORT =>'80'} 
LOCAL_PORT = 2000
$songs=['Ringtone.mp3', 'Fake.mp3'] # Default Playlist

module Debug
  def Debug.log(x)
     formattedDateTime=Time.now.strftime("%Y-%m-%d %H:%M:%S")
    puts "** #{$0} [#{formattedDateTime}] ** #{x}"	
  end
end


