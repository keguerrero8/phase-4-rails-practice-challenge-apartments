class TenantsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

    def index
        render json: Tenant.all
    end

    def show
        tenant = Tenant.find(params[:id])
        render json: tenant
    end

    def create
        tenant = Tenant.create!(tenant_params)
        render json: tenant, status: :created
    end

    def update
        tenant = Tenant.find(params[:id])
        tenant.update!(tenant_params)
        render json: tenant, status: :ok
    end

    def destroy
        tenant = Tenant.find(params[:id])
        tenant.destroy
        head :no_content
    end

    private

    def tenant_params
        params.permit(:name, :age)
    end

    def record_not_found
        render json: {error: "tenant not found"}, status: :not_found
    end
    
    def record_invalid(invalid)
        render json: {error: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
end
