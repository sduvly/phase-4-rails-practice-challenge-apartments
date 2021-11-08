class ApartmentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_error
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessed_error

    def index
        apartments = Apartment.all
        render json:  apartments
    end

    def show
        apartments = Apartment.find(params[:id])
        render json:  apartments
    end

    def create
        apartments = Apartment.create(params)
        render json:  apartments, status: :created
    end

    def update
        apartments = Apartment.find(params[:id])
        apartments.update!(params)
        render json:  apartments, status: :updated
    end

    def destroy
        apartments = Apartment.find(params[:id])
        apartments.destroy
    end

    private 

    def render_not_found_error
        render json: {error: "Apartment not found"}, status: :not_found
    end

    def render_unprocessed_error(invalid)
        render json: {errors: invalid.record.errors}, status: :unprocessed_error
    end

end
