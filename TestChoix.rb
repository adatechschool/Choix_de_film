require 'csv'
require 'colorize'

avoir = "#{File.expand_path File.dirname(__FILE__)}/movies.csv"
vu = "#{File.expand_path File.dirname(__FILE__)}/vu.csv"
table = CSV.read(avoir)
buffer = CSV.read(avoir)

x = table.length
x -= 1



while true
	y = rand(0..x)
	if y = 0
		y = 1
	end
	movie = buffer [y]
	print "Vous-voulez voir \"#{movie[0]}\"? y/n: "
	answer = gets.strip!

	if answer == "y"
		puts "Oh yeah!!! ( ͡° ͜ʖ ͡°)".green
		CSV.open(vu, "a") do |csv|
			csv << movie
		end
		table.delete_at(y)
		CSV.open(avoir, "w") do |csv|
			table.each do |item|
				csv << item
			end
		end
		break
	elsif answer == "n"
		puts "Poooouuuurrrqqquuuooooiiiiiiiii !!! (/;o;)/".yellow
		buffer.delete_at(y)
	end
end


=begin
else
puts "(°_o) rage quit => []".red
end
	y = 0
	table.each do |item|
		table[y].each do |x|
			print "#{x} "
		end
		puts " "
		y += 1
	end
=end
