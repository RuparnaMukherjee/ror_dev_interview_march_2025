class ExternalService < ApplicationRecord
  has_many :pokemons, dependent: :destroy
end
