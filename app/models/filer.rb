class Filer < ApplicationRecord
  has_many :awards

  attr_accessor :ein, :name, :address, :city, :state, :zip_code
end
