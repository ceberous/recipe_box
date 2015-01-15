class RecipesController < ApplicationController
before_action :authenticate_user! , except: [:index , :show]
before_action :find_recipe , only: [:show , :edit , :update , :destroy]

def index
	@recipe = Recipe.all.order("created_at DESC")
end

def show

end

def new
	@recipe = current_user.recipes.build
	@recipe.ingredients.build
	@recipe.directions.build
end

def create
	@recipe = current_user.recipes.build(recipe_params)

	if @recipe.save
		redirect_to @recipe , notice: "Successfully Created New Recipe"
	else
		render 'new'
	end
end

def edit

end

def update
	if @recipe.update(recipe_params)
		flash[:notice] = "Recipe Updated!"
		redirect_to @recipe
	else
		render 'edit'
	end
end

def destroy
	@recipe.destroy
	redirect_to root_path , notice: "Deleted Recipe"
end

def image_remote_url=(url_value)
	self.image = URI.parse(url_value) unless url_value.blank?
	super
end

private

def find_recipe
	@recipe = Recipe.find(params[:id])
end

def recipe_params
	params.require(:recipe).permit(:title , :description , :image , :image_remote_url , ingredients_attributes: [:id , :name , :_destroy] , directions_attributes: [:id , :step , :_destroy] )
end

end
