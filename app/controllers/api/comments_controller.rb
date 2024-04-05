module Api
  class CommentsController < ApplicationController
    before_action :find_feature
    skip_before_action :verify_authenticity_token # Puedes omitir la verificación de autenticidad si es necesario

    def index
      # Aquí puedes implementar la lógica para obtener todos los comentarios asociados con un feature específico.
      @comments = @feature.comments
      render json: @comments
    end

    def create
      @comment = @feature.comments.build(comment_params)
      if @comment.save
        render json: @comment, status: :created
      else
        render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def find_feature
      @feature = Feature.find(params[:feature_id])
    end

    def comment_params
      params.require(:comment).permit(:body)
    end
  end
end
