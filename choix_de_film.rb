require 'csv'

#puts Dir.pwd

#puts File.expand_path File.dirname(__FILE__)

file = "#{File.expand_path File.dirname(__FILE__)}/a_voir.csv"

table = CSV.read(file)
buffer = CSV.read(file)

def movie_to_vu(mvi)
	CSV.open("#{File.expand_path File.dirname(__FILE__)}/vu.csv", "a") do |csv|
		csv << [mvi]
	end
end

def buffer(buffer, y)
	if buffer.length == 0
		return "The list is empty"
	end
	#	film = buffer[y][0
	if buffer[y].length == 0
		buffer.delete_at(y)
	elsif
		name = buffer[y][0]
		buffer[y].delete_at(0)
		return name
	end
end

x = table.length
x -= 1
#movie = table[y][0]

#movie_to_vu(movie)

inp = ""

while true
	y = rand(0..x)
	c = buffer(buffer, y)
	puts c
	if c == "The list is empty"
		break
	end
	print "Do you want to choose another movie? If not type break: "
	gets inp
	if inp == "break"
		break
	end
end


#CSV.open(file, "w")  do |csv|
#  table.each do |item|
#    csv << item
#  end
#end
