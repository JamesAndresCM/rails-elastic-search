# frozen_string_literal: true

# SearchController
class SearchController < ApplicationController
  def search
    @articles = search_params[:term].nil? ? [] : Article.search(search_params[:term])
  end

  private

  def search_params
    params.permit(:term)
  end
end
