class Api::V1::FoodsController < ApplicationController
	before_action :set_food, only: [:show]

	def index
		if params[:q].present?
			@foods = Food.with_rich_text_description.search(params[:q]).limit(50)
		else
			@foods = Food.with_rich_text_description.limit(50)
		end

		render json: @foods.to_json(methods: :rich_text_description)
	end

	def show
		render json: @food.to_json(methods: :rich_text_description)
	end

	private
		def set_food
			@food = Food.find_by(id: params[:id])
		end

		def food_params
			params.require(:food).permit(:name)
		end
end
