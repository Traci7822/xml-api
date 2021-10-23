class Filer < ApplicationRecord
  has_many :awards
  serialize :awards
end
