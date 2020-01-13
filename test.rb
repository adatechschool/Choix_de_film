require 'csv'

#csv header: Film,Genre,Lead Studio,Audience score %,Profitability,Rotten Tomatoes %,Worldwide Gross,Year

film_csv = "#{File.expand_path File.dirname(__FILE__)}/movies.csv"
csv = CSV.read(film_csv)

class Movies
  attr_reader :i #"privat" Variabeln werden "public" gemacht

  def initialize(i)
    @i = i
  end
  def hash()
    return {"Film" => i[0],
            "Genre" => i[1],
            "Lead Studio" => i[2],
            "Audience Score" => i[3],
            "Profitability" => i[4],
            "Rotten Tomatoes" => i[5],
            "Worldwide Gross" => i[6][1..],
            "Year" => i[7]}
  end
 end

class Calc_stats
  :studio_counter

  def initialize(hash_array, studio)
    @hash_array = hash_array
    @studio = studio
  end

  def audience_sc()
    counter = 0
    @hash_array.each do |x|
      if x["Lead Studio"] == @studio
        counter += x["Audience Score"].to_i
      end
    end
    return counter
  end

  def profitability()
    counter = 0
    @hash_array.each do |x|
      if x["Lead Studio"] == @studio
        counter += x["Profitability"].to_f
      end
    end
    return counter
  end

  def tomatoes_sc()
    counter = 0
    @hash_array.each do |x|
      if x["Lead Studio"] == @studio
        counter += x["Rotten Tomatoes"].to_i
      end
    end
    return counter
  end

  def tt_ww_gross()
    counter = 0
    @hash_array.each do |x|
      if x["Lead Studio"] == @studio
        counter += x["Worldwide Gross"].to_f
      end
    end
    return counter
  end

  def movie_counter()
    counter = 0
    @hash_array.each do |x|
      if x["Lead Studio"] == @studio
        counter += 1
      end
    end
    return counter
  end

  def return_stats()
    return studio_stats = {"Studio Name" => @studio,
                           "Audience Score" => audience_sc(),
                           "Profitability" => profitability(),
                           "Tomatoes Score" => tomatoes_sc(),
                           "Total Gross" => tt_ww_gross(),
                           "Movie Amount" => movie_counter()}
  end
end

class Sort_stats

  def sort_movies_by_studio(studio, csv, sort_type)
    std_array = []
    studio_array = []
    i = 0

    begin
    csv.each do |x|
      csv[i] = Movies.new(csv[i][0..-1])
      std_array << csv[i].hash()
      i += 1
    end

      std_array.each do |x|
        if x["Lead Studio"] == studio
          studio_array << x
        end
      end

      header = "0--".ljust(5) + "Genre".ljust(15) + "Film".ljust(40) + "Audience Score in %".ljust("Audience Score in %".length + 7) + "Profitability in %".ljust("Profitability in %".length + 5) + "Rotten Tomatoes in %".ljust("Rotten Tomatoes in %".length + 5) + "Worldwide Gross".ljust("Worldwide Gross".length + 5) + "Year\n"
      puts header
      puts "-"*header.length
      counter = 1
      #sort_type char = normal, int = reverse
      studio_array.sort_by!{ |x| x[sort_type]}.reverse!
      studio_array.each do |x|
        if counter < 10
          puts "#{counter}---".ljust(5) + x["Genre"].ljust(15) + x["Film"].ljust(40) + "#{x["Audience Score"].to_i}" + "%".ljust("Audience Score in %".length + 5) + "#{x["Profitability"].to_f.round(3)}%".ljust("Profitability in %".length + 5) + "#{x["Rotten Tomatoes"].to_i}%".ljust("Rotten Tomatoes in %".length + 5) + "$#{x["Worldwide Gross"].to_f.round(3)}M".ljust("Worldwide Gross".length + 5) + x["Year"]
          counter += 1
        elsif counter > 9
          puts "#{counter}--".ljust(5) + x["Genre"].ljust(15) + x["Film"].ljust(40) + "#{x["Audience Score"].to_i}" + "%".ljust("Audience Score in %".length + 5) + "#{x["Profitability"].to_f.round(3)}%".ljust("Profitability in %".length + 5) + "#{x["Rotten Tomatoes"].to_i}%".ljust("Rotten Tomatoes in %".length + 5) + "$#{x["Worldwide Gross"].to_f.round(3)}M".ljust("Worldwide Gross".length + 5) + x["Year"]
          counter += 1
        end
      end
    rescue
      print "An error has occured. Returning to the menu."
      return
    end
  end

  def sort_all(csv, sort_type)
    #Sortierungen die auf alle Studios angewendet werden
    std_array = []
    i = 0

    begin
      csv.each do |x|
        csv[i] = Movies.new(csv[i][0..-1])
        std_array << csv[i].hash()
        i += 1
      end

      header = "0--".ljust(5) + "Genre".ljust(15) + "Film".ljust(40) + "Audience Score in %".ljust("Audience Score in %".length + 7) + "Profitability in %".ljust("Profitability in %".length + 5) + "Rotten Tomatoes in %".ljust("Rotten Tomatoes in %".length + 5) + "Worldwide Gross".ljust("Worldwide Gross".length + 5) + "Year\n"
      puts header
      puts "-"*header.length
      counter = 1
      #sort_type char = normal, int = reverse
      std_array.sort_by!{ |x| x[sort_type]}.reverse!
      std_array.each do |x|
        if counter < 10
          puts "#{counter}---".ljust(5) + x["Genre"].ljust(15) + x["Film"].ljust(40) + "#{x["Audience Score"].to_i}" + "%".ljust("Audience Score in %".length + 5) + "#{x["Profitability"].to_f.round(3)}%".ljust("Profitability in %".length + 5) + "#{x["Rotten Tomatoes"].to_i}%".ljust("Rotten Tomatoes in %".length + 5) + "$#{x["Worldwide Gross"].to_f.round(3)}M".ljust("Worldwide Gross".length + 5) + x["Year"]
          counter += 1
        elsif counter > 9
          puts "#{counter}--".ljust(5) + x["Genre"].ljust(15) + x["Film"].ljust(40) + "#{x["Audience Score"].to_i}" + "%".ljust("Audience Score in %".length + 5) + "#{x["Profitability"].to_f.round(3)}%".ljust("Profitability in %".length + 5) + "#{x["Rotten Tomatoes"].to_i}%".ljust("Rotten Tomatoes in %".length + 5) + "$#{x["Worldwide Gross"].to_f.round(3)}M".ljust("Worldwide Gross".length + 5) + x["Year"]
          counter += 1
        end
      end
    rescue
      print "An error has occured. Returning to the menu."
      return
    end
  end
end

i = 0
studio_name = []
csv.each do |x|
  if studio_name.include?(csv[i][2]) == false
    studio_name << csv[i][2]
  end
  i += 1
end

sorting = Sort_stats.new

while true
  print "Do you want to inspect [1] everything or only a [2] specific studio: "
  scope = gets.chomp.to_i
  if [1, 2].include?(scope)
    case scope
    when 1
      puts "Valid characteristic are: [Genre] [Film] [Audience Score] [Profitability] [Rotten Tomatoes] [Worldwide Gross] [Year]."
      print "Enter the characteristic you want to sort: "
      sort = gets.chomp
      if ["Genre", "Film", "Audience Score", "Profitability", "Rotten Tomatoes", "Worldwide Gross", "Year"].include?(sort)
        sorting.sort_all(csv, sort)
      else
        puts "#{sort} is not a valid characteristic."
        next
      end
    when 2
      print "Valid studio names are: "
      studio_name.each do |x|
        print "[#{x}] "
      end
      print "\n"
      print "Enter the studio you want to inspect: "
      studio = gets.chomp
      if studio_name.include?(studio)
        puts "Valid characteristic are: [Genre] [Film] [Audience Score] [Profitability] [Rotten Tomatoes] [Worldwide Gross] [Year]."
        print "Enter the characteristic you want to sort: "
        sort = gets.chomp
        if ["Genre", "Film", "Audience Score", "Profitability", "Rotten Tomatoes", "Worldwide Gross", "Year"].include?(sort)
          sorting.sort_movies_by_studio(studio, csv, sort)
        else
          puts "#{sort} is not a valid characteristic."
          next
        end
      else
        puts "#{studio} is not a valid studio."
        next
      end
    end
  else
    puts "#{scope} is not a valid decision."
    next
  end
  print "\nIf you want to exit type [x] else press [enter]: "
  exit = gets.chomp
  if exit == "x"
    break
  end
end
