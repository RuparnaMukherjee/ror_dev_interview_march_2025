class UpdatePokemonJob < ApplicationJob
  queue_as :default

  def perform
    Pokemon.find_each do |pokemon|
      service=EntityApiService.get_service(pokemon.external_detail.external_service[:name])
      updated_data = PokemonApiService.fetch_pokemon(pokemon.id)
      if pokemon.update(name: updated_data[:name])
        pokemon.external_detail.update!(e_id:updated_data[:id])
      end
    end
  end
end
