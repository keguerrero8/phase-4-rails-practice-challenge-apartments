class ApartmentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

    def index
        render json: Apartment.all
    end

    def create
        apartment = Apartment.create!(apartment_params)
        render json: apartment, status: :created
    end

    def update
        apartment = Apartment.find(params[:id])
        apartment.update!(apartment_params)
        render json: apartment, status: :ok
    end

    def destroy
        apartment = Apartment.find(params[:id])
        apartment.destroy
        head :no_content
    end

    private

    def apartment_params
        params.permit(:number)
    end

    def record_not_found
        render json: {error: "apartment not found"}, status: :not_found
    end
    
    def record_invalid(invalid)
        render json: {error: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

end
