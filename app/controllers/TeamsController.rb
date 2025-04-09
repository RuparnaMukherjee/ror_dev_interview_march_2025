class TeamsController < ApplicationController
  def create
    team = Team.new(name: params[:name])
    service = EntityApiService.get_service(params[:service] || "pokemon")
    if team.save
      6.times do |slot|
        @pokemon = service.fetch_pokemon(rand(1..100))
        pokeData = team.pokemons.create!(
          name: @pokemon[:name],
          slot: slot + 1
        )
        external_service = ExternalService.find_or_create_by(name: params[:service] || "pokemon")
        external_detail =ExternalDetail.new(e_id: @pokemon[:id])
        external_detail.external_service = external_service
        external_detail.pokemon = pokeData
        external_detail.save
      end  

    render json: {
      message: "Team created successfully!",
      team: {
        id: team.id,
        name: team.name,
        pokemons: team.pokemons.map do |pokemon|
          pokemon.as_json.merge(
            url: "#{pokemon.external_detail.pokemon_url}/#{pokemon.external_detail&.e_id}"
          )
        end
      }
    }, status: :created

    else
      render json: { error: "Team creation failed" }, status: :unprocessable_entity
    end
  end

  def show
    team = Team.includes(:pokemons).find(params[:id]) 
    if team
      render json: {
      team: {
        id: team.id,
        name: team.name,
        pokemons: team.pokemons.map do |pokemon|
          pokemon.as_json.merge(
            url: "#{pokemon.external_detail.pokemon_url}/#{pokemon.external_detail&.e_id}"
          )
        end
      }
    }
    else
      render json: { error: "Team not found" }, status: :not_found
    end
  end

  def update_pokemon
    pokemon = Pokemon.find_by(team_id: params[:id], slot: params[:slot])
  
    if pokemon
      external_detail = pokemon.external_detail
      service = EntityApiService.get_service(external_detail.external_service[:name] || "pokemon")
      new_pokemon = service.fetch_pokemon(rand(1...100))

      if pokemon.update(name: new_pokemon[:name])
        external_detail.update!(e_id: new_pokemon[:id])
      end
      render json: { message: "Pokemon updated successfully", pokemon: pokemon }
    else
      render json: { error: "Pokemon not found" }, status: :not_found
    end
  end

  def delete_pokemon
    pokemon = Pokemon.find_by(team_id: params[:id], slot: params[:slot])
  
    if pokemon&.destroy
      render json: { message: "Pokemon deleted successfully" }
    else
      render json: { error: "Pokemon not found" }, status: :not_found
    end
  end
end