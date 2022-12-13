# frozen_string_literal: true

# This class - controller for work with pages input and show
class RootController < ApplicationController
  before_action :set_params, only: [:show]
  def input; end

  def show
    if @out.nil?
      @arr = Answer.create(input: params[:query]).decode_output
      flash[:notice] = 'Data download on DB'
    else
      @arr = @out.decode_output
      flash[:notice] = 'Data download of DB'
    end
  end

  private

  def set_params
    @out = Answer.find_by(input: params[:query])
  end
end
