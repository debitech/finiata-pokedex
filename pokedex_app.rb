class PokedexApp < Sinatra::Application
  enable :sessions

  require 'json'
  require 'open-uri'

  get '/' do
    # display_page :index

    id = rand(1..10)

    pokemon_url = "https://pokeapi.co/api/v2/pokemon/#{id}/"
    pokemon_serialized = open(pokemon_url).read
    pokemon = JSON.parse(pokemon_serialized)

    erb :index, locals: {pokemon: pokemon}
  end

  def display_page(location, locals = {})
    options = {
      layout_options: { views: './views/layouts' },
      layout: locals.fetch(:layout) { :default },
      locals: locals
    }

    haml location.to_sym, options
  end

  def display_partial(location, locals = {})
    haml location.to_sym, layout: false, locals: locals
  end
end
