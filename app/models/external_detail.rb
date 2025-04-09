class ExternalDetail < ApplicationRecord
  belongs_to :pokemon
  belongs_to :external_service

  def pokemon_url
    url = external_service[:name] == "digimon" ? "#{ENV['DIGIMON_API_BASE_URL']}/digimon" : "#{ENV['POKEMON_API_BASE_URL']}/pokemon"
    return url 
  end
end
