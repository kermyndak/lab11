# frozen_string_literal: true

# This class - controller for work with pages input and show
class RootController < ApplicationController
  before_action :check, only: [:show]
  def input; end

  def show
    if check_answer
      @arr = Answer.find_by(input: @number).output
                   .split(']]')
                   .first.split('[[')[1..]
                   .first.split('], [')
                   .map { |pair| pair.split(', ').map(&:to_i) }
    else
      generate_arr
      Answer.create(input: @number, output: @arr.to_s)
    end
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

  def check
    if params[:query].nil?
      redirect_to root_path, notice: 'Empty parameter'
      return
    end
    redirect_to root_path, notice: 'Bad input...' unless params[:query].match?(/^[1-9]\d*$/)
    @arr = []
    @number = params[:query].to_i
  end

  def check_answer
    return false if Answer.find_by(input: @number).nil?

    true
  end

  def generate_arr
    @arr = (1..@number).map { |i| [i, find(i).sum] }
                       .select { |val, sum| sum <= @number && val != sum && val == find(sum).sum }
                       .uniq(&:min)
  end
end
