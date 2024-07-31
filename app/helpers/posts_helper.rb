module PostsHelper
  include Pagy::Frontend

  def search_highlight(content)
    query = params[:query]
    if query
      content.gsub query, '<span class="bg-warning">' + (query) + '</span>'
    else
      content
    end
  end
end
