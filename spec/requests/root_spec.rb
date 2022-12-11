require 'rails_helper'

RSpec.describe "Roots", type: :request do
  describe "GET /" do
    it "returns http success" do
      get root_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get root_show_path, params: { query: 350 }
      expect(response).to have_http_status(:success)
    end

    context 'returns http code 302' do
      it "empty parameter" do
        get root_show_path, params: {}
        expect(response).to have_http_status(302)
      end

      it "Bad input" do
        get root_show_path, params: { query: 'qwerty' }
        expect(response).to have_http_status(302)
      end
    end

    context 'controller tests' do
      it 'test @arr' do
        get root_show_path, params: { query: 350 }
        expect(assigns(:arr)).to eq([[220, 284]])
      end

      it 'test @number' do
        get root_show_path, params: { query: 350 }
        expect(assigns(:number)).to eq(350)
      end
    end

    context 'redirect to input' do
      it 'redirect with bad input' do
        get root_show_path, params: { query: 'qwerty' }
        expect(response).to redirect_to(root_path)
      end

      it 'redirect with empty input' do
        get root_show_path, params: {}
        expect(response).to redirect_to(root_path)
      end
    end

    context "parse answer" do
      it 'parameter 1220' do
        get root_show_path, params: { query: 1220 }
        html = Nokogiri::HTML(response.body)
        answer = [[220, 284], [1184, 1210]]
        td = html.search('td')
        answer.each_with_index do |pair, index|
          exp = [td[2 * index].text.to_i, td[1 + 2 * index].text.to_i]
          expect(exp).to eq(pair)
        end
      end
    end
  end
end
