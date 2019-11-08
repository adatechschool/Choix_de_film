require 'csv'

class Info
	def initialize(table)
		@table = table
		@studio = @table[2]
	end
	def info_studio(opt)
		x = 1
		puts "\nThe movies of \"#{opt}\" are:"
		puts ""
		@table.each do |i|
			if i[2] == opt
				puts "	#{x}-- #{i[0]}"
				x += 1
			end
		end
		puts ""
	end
	def genre()
		x = 1
		print "Which genre of movies do you want to find: "
		genre = gets
		puts "\nThe #{genre.chomp} movies are:"
		puts ""
		@table.each do |i|
			if i[1] == genre.chomp
				puts "	#{x}-- #{i[0]}"
				x += 1
			end
		end
		puts ""
	end
	def profitability(opt)
		studio = Array.new
		@table.each do |i|
			if studio.include?(i[2]) == false
				studio.push(i[2])
			end
		end
		if studio.include?(opt) == false && opt != "all"
			puts "\"#{opt}\" is not a valid answer."
			return
		end
		studio.delete_at(0)
		sorting = Array.new
		if opt == "all"
			puts ""
			studio.each do |i|
				counter = 0
				total_p = 0
				total_g = 0
				@table.each do |row|
					if row[2] == i
						total_p += row[4].to_f
						counter += 1
					end
				end
				@table.each do |row|
					if row[2] == i
						row = row[-2]
						total_g += row[1..].to_f
					end
				end
				profit = (total_p/counter).round(3)
				av_gross = (total_g/counter).round(3)
				to_gross = total_g.round(3)
				sorting.push([i, profit, av_gross, to_gross])
				#puts "#{i} had a profitability of #{profit}%, an average gross of $#{av_gross}M and a total gross of $#{to_gross}M."
			end
			return sorting
		end
		if studio.include?(opt)
			counter = 0
			total_p = 0
			total_g = 0
			@table.each do |row|
				if row[2] == opt
					total_p += row[4].to_f
					counter += 1
				end
			end
			@table.each do |row|
				if row[2] == opt
					row = row[-2]
					total_g += row[1..].to_f
				end
			end
			puts "#{opt} had a profitability of #{(total_p/counter).round(3)}%, an average gross of $#{(total_g/counter).round(3)}M and a total gross of $#{total_g.round(3)}M."
		end
	end
end

class Sort
	def un_sorted(data)
		data.each do |row|
			puts "#{row[0]} had a profitability of #{row[1]}%, an average gross of $#{row[2]}M and a total gross of $#{row[3]}M."
		end
	end
	def name_sorted_up(data)
		len =  data.length
		bytes = data
		x = 0
		while x < len
			bytes[x][-1] = bytes[x][0][0].bytes
			print bytes[x]
			x += 1
		end
	end
end
=begin
class Generator
	def initialize(table, vu)
		@table = table
		@buffer = table
		@vu = vu
	end
	def generator()
		x = @table.length
		x -= 1
		while true
			y = rand(0..x)
			if y == 0
				y = 1
			end
			movie = @buffer[y]
			print "Do you want to watch \"#{movie[0]}\"? y/n: "
			answer = gets.strip!

			if answer == "y"
				puts "Oh yeah!!! ( ͡° ͜ʖ ͡°)".green
				CSV.open(@vu, "a") do |csv|
					csv << movie
				end
				@table.delete_at(y)
				CSV.open(@avoir, "w") do |csv|
					@table.each do |item|
						csv << item
					end
				end
				break
			elsif answer == "n"
				puts "stfu".yellow
				@buffer.delete_at(y)
			end
		end
	end
end
=end
avoir = "#{File.expand_path File.dirname(__FILE__)}/movies.csv"
vu = "#{File.expand_path File.dirname(__FILE__)}/vu.csv"
table = CSV.read(avoir)
print table
#buffer = CSV.read(avoir)

#gen = Generator.new(table, vu)
#gen.generator()

searcher = Info.new(table)
stats = Sort.new

while true
	print "The movies and information from which studio do you want to find?\nType \"all\" if you want to get the information of all studios: "
	studio = gets
	results = searcher.profitability(studio.chomp)
	case studio.chomp
	when "all"
		puts "Do you want to get the results:\n\n"
		puts "	1-- unsorted"
		puts "	2-- sorted names rising"
		puts "	3-- sorted names falling"
		puts "	4-- sorted profitability rising"
		puts "	5-- sorted profitability falling"
		puts "	6-- sorted average gross rising"
		puts "	7-- sorted average gross falling"
		puts "	8-- sorted total gross rising"
		puts "	9-- sorted total gross falling"
		puts ""
		print "Your decision: "
		sort = gets
		puts ""
		sort = sort.chomp
		case sort
		when "1"
			stats.un_sorted(results)
		when "2"
			stats.name_sorted_up(results)
		when "3"
		when "4"
		when "5"
		when "6"
		when "7"
		when "8"
		when "9"
		end
	else
		searcher.info_studio(studio.chomp)
		test = searcher.profitability(studio.chomp)
	end
	puts "\nPress return to continue: "
	exit = gets
	if exit == "\n"
		next
	end
	break
end
