# frozen_string_literal: true

# This class - controller for work with pages input and show
class RootController < ApplicationController
  def input; end

  def show
    if params[:query].nil?
      redirect_to root_path, notice: 'Empty parameter'
      return
    end
    redirect_to root_path, notice: 'Bad input...' unless params[:query].match?(/^[1-9]\d*$/)
    @arr = []
    @number = params[:query].to_i
    generate_arr
  end

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

  def generate_arr
    @arr = (1..@number).map { |i| [i, find(i).sum] }
                       .select { |val, sum| sum <= @number && val != sum && val == find(sum).sum }
                       .uniq(&:min)
  end
end
