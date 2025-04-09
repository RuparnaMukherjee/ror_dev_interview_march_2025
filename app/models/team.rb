class Team < ApplicationRecord
  has_many :pokemons, dependent: :destroy
end
