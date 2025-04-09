class DigimonApiService
  BASE_URL = ENV["DIGIMON_API_BASE_URL"]

  def fetch_pokemon(id)
    puts id
    response = HTTParty.get("#{BASE_URL}/digimon/#{id}")
    {
      id: response["id"],
      name: response["name"],
    }
  end
end