class AddIndexToPokemon < ActiveRecord::Migration[8.0]
  def change
    add_index :pokemons, :name
  end
end
