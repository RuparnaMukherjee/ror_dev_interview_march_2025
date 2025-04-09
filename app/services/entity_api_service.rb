class EntityApiService
  def self.get_service(source_type)
    case source_type.downcase
    when "pokemon"
      PokemonApiService.new
    when "digimon"
      DigimonApiService.new
    else
      raise ArgumentError, "Unsupported source type: #{source_type}"
    end
  end
end