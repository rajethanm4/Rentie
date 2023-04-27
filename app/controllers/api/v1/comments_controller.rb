class Api::V1::CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_comment, only: [:show, :update, :destroy]

  def index
    @comments = Comment.all
    render json: @comments
  end

  def show
    if @comment
      render json: @comment
    else
      render json: { error: 'Comment not found' }, status: :not_found
    end
  end

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      render json: @comment, status: :created
    else
      render json: { error: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @comment
      if @comment.update(comment_params)
        render json: @comment
      else
        render json: { error: @comment.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Comment not found' }, status: :not_found
    end
  end

  def destroy
    if @comment
      @comment.destroy
      head :no_content
    else
      render json: { error: 'Comment not found' }, status: :not_found
    end
  end

  private

  def set_comment
    @comment = Comment.find_by(id: params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content, :user_id, :commentable_id, :commentable_type)
  end
end
