class GalleriesController < ApplicationController
  def index
    @images = Gallery.all
  end
  def new
    @image = Gallery.new
  end
  def create
    return redirect_to new_gallery_path, alert: "Please select any image" if params[:gallery].blank?

    @image = Gallery.new(img_params)
    if @image.save
      redirect_to galleries_path, notice: "Image has been uploaded successfully"
    else
      render :new
    end
  end

  private

  def img_params
    params.require(:gallery).permit(:picture)
  end
end
