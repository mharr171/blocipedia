class CollaboratorsController < ApplicationController
  before_action :set_wiki

  def new
    @collaborator = Collaborator.new
  end

  def create
    @collaborator = Collaborator.new
    @collaborator = @wiki.collaborators.build(collaborator_params)

    if @collaborator.save
      flash[:notice] = 'Collaborator was saved.'
      redirect_to wiki_path(@wiki)
    else
      flash.now[:alert] = 'There was an error saving the Collaborator. Please try again.'
      render :new
    end
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])
    if @collaborator.destroy
      flash[:notice] = 'Collaborator removed'
      redirect_to wiki_path(@wiki)
    else
      flash.now[:alert] = 'Error'
      render :show
    end
  end

  private

  def collaborator_params
    params.require(:collaborator).permit(:collaborator, :user_id)
  end

  def set_wiki
    @wiki = Wiki.find(params[:wiki_id])
  end
end
