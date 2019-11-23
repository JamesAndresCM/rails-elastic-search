require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  describe 'Search articles' do
    let!(:articles) { create_list(:article, 20) }
    it 'get search element' do
      get :search, params: { term: Article.first.title }
      expect(response.status).to eq 200
    end

    it 'record not found' do
      get :search, params: { term: nil }
      expect(response.status).to eq 200
    end
  end
end
