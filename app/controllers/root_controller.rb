# frozen_string_literal: true

# This class - controller for work with pages input and show
class RootController < ApplicationController
  before_action :set_params, only: [:show]
  def input; end

  def show
    return unless check
    if @out.nil?
      @arr.save!
      @arr = @arr.decode_output
      @msg = 'Data download on DB'
    else
      @arr = @out.decode_output
      @msg = 'Data download from DB'
    end
  end

  private

  def set_params
    @out = Answer.find_by(input: params[:query])
    @msg = ''
    @arr = Answer.new(input: params[:query])
  end

  def check
    unless @arr.valid?
      redirect_to root_path, notice: @arr.errors.objects.map(&:message).first
      return false
    end
    true
  end
end
