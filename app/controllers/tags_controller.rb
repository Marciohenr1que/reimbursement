class TagsController < CrudController

  def search
    @tags = Tag.where("name LIKE ?", "%#{params[:query]}%")
    render json: @tags
  end
end
