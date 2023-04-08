class ProconBypassManCommand < ApplicationRecord
  validates :name, :first_buttons, presence: true
  validates :repeat_count, numericality: { greater_than_or_equal_to: 1 }
end
