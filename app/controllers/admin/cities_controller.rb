class Admin::CitiesController < Admin::BaseController
    before_action :authenticate_user!
    before_action :authenticate_admin!
    before_action :find_city, except:[:index, :new, :create]
    
      def new
        @city = City.new
      end
    
      def index
        @cities = City.all
      end
    
      def show
        @city = City.find(params[:id])
      end
    
      def create
        @city = City.new(city_params)
    
        if @city.save
          redirect_to admin_city_path(@city)
        else
          render "new", flash: { error: "Validation error" }
        end
      end
    
      def update
        if @city.update_attributes(city_params)
          redirect_to city_path(@city)
        else
          render "edit", flash: { error: "Validation error" }
        end
      end
    
      def edit
      end
    
      def destroy
        @city.destroy
        redirect_to(action: "index")
      end
    
      private
    
      def city_params
        params.require(:city).permit(:name)
      end
    
      def find_city
        @city = City.find(params[:id])
      end
end
    