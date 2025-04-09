class Pokemon < ApplicationRecord
  belongs_to :team
  has_one :external_detail, dependent: :destroy
end
