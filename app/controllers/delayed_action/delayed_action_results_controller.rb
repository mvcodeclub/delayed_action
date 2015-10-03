require_dependency "delayed_action/application_controller"

module DelayedAction
  class DelayedActionResultsController < ApplicationController
    before_action :set_delayed_action_result, only: [:show, :edit, :update, :destroy]

    # GET /delayed_action_results
    def index
      @delayed_action_results = DelayedActionResult.all
    end

    # GET /delayed_action_results/1
    def show
    end

    # GET /delayed_action_results/new
    def new
      @delayed_action_result = DelayedActionResult.new
    end

    # GET /delayed_action_results/1/edit
    def edit
    end

    # POST /delayed_action_results
    def create
      @delayed_action_result = DelayedActionResult.new(delayed_action_result_params)

      if @delayed_action_result.save
        redirect_to @delayed_action_result, notice: 'Delayed action result was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /delayed_action_results/1
    def update
      if @delayed_action_result.update(delayed_action_result_params)
        redirect_to @delayed_action_result, notice: 'Delayed action result was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /delayed_action_results/1
    def destroy
      @delayed_action_result.destroy
      redirect_to delayed_action_results_url, notice: 'Delayed action result was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_delayed_action_result
        @delayed_action_result = DelayedActionResult.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def delayed_action_result_params
        params.require(:delayed_action_result).permit(:result, :request_env, :uuid, :content_type)
      end
  end
end
