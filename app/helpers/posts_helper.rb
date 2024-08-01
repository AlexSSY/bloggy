module PostsHelper
  include Pagy::Frontend

  def search_highlight(content)
    query = params[:query]
    if query
      content.gsub /#{query}/i, '<span class="bg-warning">\0</span>'
    else
      content 
    end
  end
end
