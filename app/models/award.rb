class Award < ApplicationRecord
  belongs_to :filer 
  belongs_to :receiver

  attr_accessor :purpose, :cash_amount
end
