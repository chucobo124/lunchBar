class Reservation < ApplicationRecord
  enum classification: [:pixnet]
end
