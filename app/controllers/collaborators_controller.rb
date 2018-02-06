class CollaboratorsController < ApplicationController
  def new
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.new
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.new
    @collaborator.wiki_id = params[:wiki_id]
    @collaborator.user_id = params[:collaborator][:user_id]

    if @collaborator.save
      flash[:notice] = 'Collaborator was saved.'
      redirect_to wiki_path(@wiki)
    else
      flash.now[:alert] = 'There was an error saving the Collaborator. Please try again.'
      render :new
    end
  end

  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.find(params[:id])
    if @collaborator.destroy
      flash[:notice] = 'Collaborator removed'
      redirect_to wiki_path(@wiki)
    else
      flash.now[:alert] = 'Error'
      render :show
    end
  end
end
