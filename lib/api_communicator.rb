require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

  def films(character_hash, character)
    character_hash["results"].each do |character_array|
      if character_array["name"].downcase == character
        return character_array["films"]
      end
    end
  end

  def info(character_hash, character)
    films(character_hash, character).collect do |film_url|
      film = RestClient.get(film_url)
      film_info = JSON.parse(film)
      film_info
    end
  end

  films_hash = info(character_hash, character)

  films_hash
end


  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.


def parse_character_movies(films_hash)
  films_hash.each_with_index do |film_hash, index|
     puts "#{index +1} #{film_hash["title"]}"
  end
  # some iteration magic and puts out the movies in a nice list
end


def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# def get_character_movies_from_api(character)
#   #make the web request
#   # all_characters = RestClient.get('http://www.swapi.co/api/people/')
#   character_hash = JSON.parse(RestClient.get('http://www.swapi.co/api/people/'))
#
#   films = []
#   films = character_hash["results"].each do |character_array|
#     if character_array["name"].downcase == character
#       films = character_array["films"]
#     end
#   end
#
#   films.collect do |film_url|
#     film = RestClient.get(film_url)
#     film_info = JSON.parse(film)
#     film_info
#   end
# end

# def parse_character_movies(films_hash)
#   films_hash.each do |film_hash|
#     puts film_hash["title"]
#   end
# end
#
#
# def show_character_movies(character)
#   films_hash = info(character)
#   parse_character_movies(films_hash)
# end
