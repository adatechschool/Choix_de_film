require 'csv'

film_csv = "#{File.expand_path File.dirname(__FILE__)}/movies.csv"
csv = CSV.read(film_csv)

class Movies
  attr_reader :i #"privat" Variabeln werden "public" gemacht

  def initialize(i)
    @i = i
  end
  def hash()
    return {:"Film" => i[0],
            :"Genre" => i[1],
            :"Lead Studio" => i[2],
            :"Audience Score" => i[3].to_i,
            :"Profitability" => i[4].to_i,
            :"Rotten Tomatoes" => i[5].to_i,
            :"Worldwide Gross" => i[6].to_i,
            :"Year" => i[7].to_i}
  end
  def calculate_stats()

  end
 end


i = 0
hash = []
csv.each do |x|
  csv[i] = Movies.new(csv[i][0..-1])
  hash << csv[i].hash()
=begin
  if i == 0
    binded = csv[i].get_binded(csv[i][0..2])
  end
=end
  #print "#{csv[i].i[0]}\n"
  i += 1
end

if hash { |h| h[:"Lead Studio"] == 'Disney' }
  puts hash.fetch("Worldwide Gross")
end
