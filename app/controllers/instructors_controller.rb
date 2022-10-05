class InstructorsController < ApplicationController

 rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
 rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        render json: Instructor.all, status: :ok
    end

    def show
        instructor= find_params
        render json: instructor, status: :ok
    end

    def create
        instructor = Instructor.create!(instructor_params)
        render json: instructor, status: :created
    end

    def destroy
    instructor = find_params
    instructor.destroy
    head :no_content
    end

    def update
    instructor = find_params
    instructor.update!(instructor_params)
    render json: instructor
    end

    private

    def find_params
    Instructor.find(params[:id])
    end

    def instructor_params
    params.permit(:name)
    end

    def render_not_found
    render json: { error: "instructor not found" }, status: :not_found
    end

    def render_unprocessable_entity_response(invalid)
          render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
     end

end
