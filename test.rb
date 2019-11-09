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
end

i = 0
std_array = []
stats_array = []
studio_array = []

#create array of hashes from the csv file
csv.each do |x|
  csv[i] = Movies.new(csv[i][0..-1])
  std_array << csv[i].hash()
  i += 1
end




# array mit allen Studionamen
std_array.each do |x|
  if studio_array.include?(x.fetch("Lead Studio")) == false
    studio_array.push(x.fetch("Lead Studio"))
  end
end

studio_array.each do |x|
  prof = Calc_stats.new(std_array, x)
  stats_array << prof.return_stats()
end


#array von allen Filmen
puts std_array
#array der stats pro Studio, um Durchschnitt >> stats/movie_count
puts stats_array
#array der Studios
puts studio_array
