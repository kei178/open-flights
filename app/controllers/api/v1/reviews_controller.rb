module Api
  module V1
    class ReviewsController < ApplicationController
      def create
        review = Review.new(review_params)
        if review.save
          render json: ReviewSerializer.new(review)
        else
          render json: { error: review.errors.full_messages }, status: 422
        end
      end

      def destroy
        review = Review.find(params[:id])
        if review.destroy
          head :no_content
        else
          render json: { error: review.errors.full_messages }, status: 422
        end
      end

      private

      def review_params
        params.require(:review).permit(%i[title description score airline_id])
      end
    end
  end
end