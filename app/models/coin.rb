class Coin < ApplicationRecord
  belongs_to :mining_type, optinal: true
end
