# frozen_string_literal: true

require 'elasticsearch/model'
# ArticleModel
class Article < ApplicationRecord
  self.per_page = 10
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  validates :title, uniqueness: true, presence: true
  validates :text, presence: true, length: { in: 3..1000, message: 'mínimo 3 máximo 1000 caracteres'}

  def self.search(query)
    __elasticsearch__.search(
      {
        query: {
          multi_match: {
            query: query,
            fields: ['title', 'text']
          }
        },
        highlight: {
          pre_tags: ['<em>'],
          post_tags: ['</em>'],
          fields: {
            title: {},
            text: {}
          }
        }
      }
    )
  end
end
