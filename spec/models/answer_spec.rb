require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe 'If adding with similar params' do
    before do
      Answer.create!(input: 350) if Answer.find_by(input: 350).nil?
    end

    it 'should be error if input is not unique' do
      expect { Answer.create!(input: 350) }.to raise_error(ActiveRecord::RecordNotUnique)
    end
  end

  describe 'If adding correct params' do
    before do
      Answer.delete_by(input: 350)
    end
    it 'Input: 350' do
      expect(Answer.create(input: 350).output).to eq("[[220,284]]")
    end
  end
end
