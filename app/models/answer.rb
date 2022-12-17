# frozen_string_literal: true

# This class for methods and validates model Answer
class Answer < ApplicationRecord
  validates :input, {
    presence: { message: 'Error, empty input value...' },
    numericality: {
      only_integer: true,
      greater_than: 0,
      message: 'Error, bad input, must be natural number'
    }
  }

  before_create :set_params

  def decode_output
    ActiveSupport::JSON.decode(output)
  end

  private

  def find(value)
    arr = [1]
    (2..value**0.5).each do |i|
      if (value % i).zero?
        arr << i
        arr << value / i unless i == value / i
      end
    end
    arr
  end

  def set_params
    @number = input.to_i
    self.output = encode_output
  end

  def encode_output
    ActiveSupport::JSON.encode(generate_arr)
  end

  def generate_arr
    (1..@number).map { |i| [i, find(i).sum] }
                .select { |val, sum| sum <= @number && val != sum && val == find(sum).sum }
                .uniq(&:min)
  end
end
