require 'rails_helper'

RSpec.describe Article, type: :model do
  it 'has a valid factory' do
    expect(build(:article)).to be_valid
  end

  describe 'Validations' do
    context 'valid title' do
      it 'valid with a title' do
        article = Article.new(title: 'Test', text: 'ruby')
        expect(article).to be_valid
      end
    end

    context 'without title' do
      it 'invalid title' do
        article = Article.new(title: nil, text: 'test')
        expect(article).to_not be_valid
      end
    end

    context 'without text' do
      it 'invalid text' do
        article = Article.new(title: 'hello', text: nil)
        expect(article).to_not be_valid
      end
    end

    context 'minimum text' do
      it 'valid min' do
        article = Article.new(title: 'example', text: 'tes')
        expect(article).to be_valid
      end
    end

    context 'maximum text' do
      it 'valid max' do
        str = 'text' * 75
        article = Article.new(title: 'valid', text: str)
        expect(article).to be_valid
      end
    end

    context 'error size text' do
      it 'invalid max' do
        str = 'text' * 8000
        article = Article.new(title: 'err', text: str)
        expect(article).to_not be_valid
      end
    end

    context 'uniqueness title' do
      let!(:articles) { create_list(:article, 2) }
      it 'valid unique title' do
        article = Article.new(title: Article.first.title, text: 'test')
        expect(article).to_not be_valid
      end
    end
  end
end
