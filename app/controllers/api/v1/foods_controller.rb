class Api::V1::FoodsController < ApplicationController
	before_action :set_food, only: [:show]

	def index
		if params[:q].present?
			foods = Food.with_rich_text_description.search(params[:q]).limit(50)
		else
			foods = Food.with_rich_text_description.limit(50)
		end

		@serialized_foods = FoodSerializer.new(foods).serializable_hash
		
		render json: @serialized_foods.to_json
	end

	def show
		render json: FoodSerializer.new(@food).serializable_hash.to_json
	end

	private
		def set_food
			@food = Food.find_by(id: params[:id])
		end

		def food_params
			params.require(:food).permit(:name)
		end
end
