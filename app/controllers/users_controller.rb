class UsersController < ApplicationController

    def show
        user = User.find_by(id: session[:user_id])
        if user
            user
        else
            render json: { error: "Not authorized" }, status: 401
        end
    end

    def create
        user = User.create(user_params)
        if user.valid?
            session[:user_id] = user.id
            render json: user, status: :created
        else
            render json: { error: user.errors.full_messages }, status: 422
        end
    end

    private

    # def 

    # end

    def user_params
        params.permit(:username, :password, :image_url, :bio)
    end
end
