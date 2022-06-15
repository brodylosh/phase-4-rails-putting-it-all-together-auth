class RecipesController < ApplicationController

    def index
        user = User.find_by(id: session[:user_id])
        recipes = Recipe.all
        if user
            render json: recipes, include: :user, status: 201
        else
            render json: { error: "Not authorized" }, status: :unauthorized
        end
    end

    def create
        user = User.find_by(id: session[:user_id])
        recipe = Recipe.create(recipe_params)
        if user && recipe.valid?
            render json: recipe, status: :created
        elsif user && recipe.valid?
            render json: { errors: user.errors.full_messages }, status: 422
        else
            render json: { errors: user.errors.full_messages }, status: 401
        end
    end

    private

    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete, :user_id)
    end
end
