module Debug
  def Debug.log(x)
     formattedDateTime=Time.now.strftime("%Y-%m-%d %H:%M:%S")
    puts "** rxProxy[#{formattedDateTime}] ** #{x}"	
  end
end


