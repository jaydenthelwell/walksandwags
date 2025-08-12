class PagesController < ApplicationController
  def home
    @posts = ContentfulClient.entries(content_type: "blogPost", include: 1)

    if params[:category].present? && params[:category] != "all"
      @posts = @posts.select do |post|
        category = post.fields[:category]
        category.present? && category.downcase == params[:category].downcase
      end
    end
  end

  def contact
  end
  def services
  end
end
