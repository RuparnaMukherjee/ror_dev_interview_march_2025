class PokemonApiService
  BASE_URL = ENV["POKEMON_API_BASE_URL"]

  def fetch_pokemon(id)
    response = HTTParty.get("#{BASE_URL}/pokemon/#{id}")
    {
      id: response["id"],
      name: response["name"],
    }
  end
end