module Debug
  def Debug.log(x)
     formattedDateTime=Time.now.strftime("%Y-%m-%d %H:%M:%S")
    puts "** #{$0} [#{formattedDateTime}] ** #{x}"	
  end
end


