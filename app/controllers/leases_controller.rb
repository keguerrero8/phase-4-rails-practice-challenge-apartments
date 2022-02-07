class LeasesController < ApplicationController
    def index
        render json: Lease.all
    end

    def create
        lease = Lease.create!(params_leases)
        render json: lease, status: :created
    end

    def destroy
        lease = Lease.find(params[:id])
        lease.destroy
        head :no_content
    end

    private

    def params_leases
        params.permit(:rent, :apartment_id, :tenant_id)
    end
end
