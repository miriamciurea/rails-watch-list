# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require "json"
require "open-uri"

url = "http://tmdb.lewagon.com/movie/top_rated?"
user_serialized = URI.open(url).read
user = JSON.parse(user_serialized)
user["results"].each do |hash|
  Movie.create(
    title: hash["original_title"],
    overview: hash["overview"],
    poster_url: "https://image.tmdb.org/t/p/w500#{hash['poster_path']}",
    rating: hash["vote_average"]
  )
end

# t.string "title"
# t.string "overview"
# t.string "poster_url"
# t.float "rating"
