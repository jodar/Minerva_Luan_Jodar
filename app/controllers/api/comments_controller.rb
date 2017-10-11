class Api::CommentsController < ApplicationController
  before_action :set_post
  before_action :set_post_comment, only: [:show, :update, :destroy]

  def index
    render json: @post.comments
  end

  def show
    render json: @comment
  end

  def create
    @post.comments.create!(comments_params)

    if @post.save
      render json: @post, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comments_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_post_comment
    @comment = @post.comments.find_by!(id: params[:id]) if @post
  end

  def comments_params
    params.require(:data).
      permit(
        attributes:[
          :body
        ]
      )
  end
end
