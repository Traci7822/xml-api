class ApplicationController < ActionController::API
  include Response

  def fallback_index_html
    render file: 'public/index.html'
  end
end
