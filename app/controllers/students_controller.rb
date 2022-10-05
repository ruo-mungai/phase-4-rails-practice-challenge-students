class StudentsController < ApplicationController


 rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
 rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        render json: Student.all, status: :ok
    end

    def show
        student= find_params
        render json: student, status: :ok
    end

    def create
        student = Student.create!(student_params)
        render json: student, status: :created
    end

    def destroy
    student = find_params
    student.destroy
    head :no_content
    end

    def update
    student = find_params
    student.update!(student_params)
    render json: student
    end

    private

    def find_params
    Student.find(params[:id])
    end

    def student_params
    params.permit(:name, :major, :age)
    end

    def render_not_found
    render json: { error: "student not found" }, status: :not_found
    end

    def render_unprocessable_entity_response(invalid)
          render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
     end
end
