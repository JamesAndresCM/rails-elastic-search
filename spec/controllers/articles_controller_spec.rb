require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  describe 'Get index action' do
    context 'sucess articles' do
      let!(:articles) { create_list(:article, 5) }
      it 'response ok' do
        get :index
        expect(Article.all).to match_array(articles)
        expect(response.status).to eq(200)
        expect(response).to render_template('index')
      end
    end

    context 'pagination articles' do
      let!(:articles) { create_list(:article, 20) }
      it 'last ten elements' do
        get :index, params: { page: 2 }
        expect(Article.last(10)).to eq articles.last(10)
        expect(response).to render_template('index')
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'Show article' do
    context 'find record' do
      let!(:article) { create(:article) }
      it 'assigns the request article' do
        get :show, params: { id: article.id }
        assigns(:article).should eq(article)
      end

      it 'renders show view' do
        get :show, params: { id: article.id }
        expect(response).to render_template(:show)
      end
    end

    context 'record not found' do
      it 'error' do
        get :show, params: { id: 30 }
        expect(response.status).to eq 302
      end
    end
  end

  describe 'Post create article' do
    context 'valid attributes' do
      it 'expect create new article' do
        article = { article: { title: 'test title ruby', text: 'test text' } }
        post :create, params: article
        expect(response.status).to eq(302)
        expect(Article.count).to eq 1
      end
    end

    context 'with no valid attributes' do
      it 'does not save new article' do
        article = { article: { title: nil, text: 'test text' } }
        post :create, params: article
        expect(response.status).to eq(200)
        expect(Article.count).to eq 0
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'Get new' do
    let!(:article) { build(:article) }
    it 'assigns article' do
      get :new
      expect(response.status).to eq 200
    end
  end

  describe 'put article' do
    context 'valid params' do
      let!(:article) { create(:article) }
      it 'update record' do
        param_article = { title: 'otro', text: 'text example' }
        put :update, params: { id: article.id, article: param_article }
        article.reload
        expect(response.status).to eq 302
        expect(article.title).to eq param_article[:title]
      end
    end

    context 'invalid params' do
      let!(:article) { create(:article) }
      it 'update record' do
        param_article = { title: nil, text: nil }
        put :update, params: { id: article.id, article: param_article }
        article.reload
        expect(response.status).to eq 200
        expect(Article.first).to eq article
      end
    end
  end

  describe 'destroy article' do
    let!(:article) { create(:article) }
    it 'delete record' do
      delete :destroy, params: { id: article.id }
      expect(Article.count).to eq 0
      expect(response.status).to eq 302
      expect(article).to redirect_to(articles_url)
    end
  end
end
