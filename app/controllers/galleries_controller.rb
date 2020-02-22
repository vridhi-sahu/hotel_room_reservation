class GalleriesController < ApplicationController
  def index
    @images = Gallery.all
  end
  def new
    @image = Gallery.new
  end
  def create
    @image = Gallery.new(img_params)
    
    if @image.save 
      redirect_to(galleries_path, flash: { notice: "Image has been uploaded successfully" })
    else
      render "new"
    end
  end
  
  private 
  
  def img_params
    params.fetch(:gallery).permit(:picture)
  end
end
