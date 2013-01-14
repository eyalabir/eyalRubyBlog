class CommentsController < ApplicationController
  respond_to :html, :xml, :json
   
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment])
    if @comment.save
      respond_with do |format|
        format.html do
          if request.xhr?
            render :partial => "comments/comment", :locals => { :comment => @comment }, :layout => false, :status => :created
          else
            redirect_to @comment
          end
        end
      end
    else
      respond_with do |format|
        format.html do
          if request.xhr?
            render :json => @comment.errors, :status => :unprocessable_entity
          else
            render :action => :new, :status => :unprocessable_entity
          end
        end
      end
    end    
  end
  
   def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post)
  end
end
