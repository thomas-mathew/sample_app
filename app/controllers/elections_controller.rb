class ElectionsController < ApplicationController
	include SessionsHelper
	before_filter :admin_user, :only => :new
	before_filter :find_vote, :only => [:show, :cast_vote]

  	def show
    	@election = Election.find(params[:id])
    	@participants = @election.users
  	end

	def new
		@election = Election.new
	end

	def create
		@election = Election.new(params[:election])
		if @election.save
			@election.owner_id = current_user.id
			@election.save
			flash[:success] = "You have created the election #{params[:election][:name]} with the owner_id #{@election.owner_id}"
			redirect_to current_user
		else
			render 'new'
		end 
	end

	def edit
		@election = Election.find(params[:id])
	end

	def index
    	@elections_owned = Election.where(owner_id: current_user.id)
	end

	def vote
		user = User.find_by_email(params[:invite_email].downcase)
		if user
			@vote = Vote.new
			@vote.user_id = user.id
			@vote.election_id = params[:election_id]
			if @vote.save
				flash[:success] = "You have invited #{user.name}!"
				redirect_to Election.find(params[:election_id])
			else 
				flash[:failure] = "#{user.name} has been already invited."
				redirect_to Election.find(params[:election_id])
			end
		else
			flash[:failure] = "We could not find #{params[:invite_email]} in our database."
			redirect_to elections_path
		end
	end

	def cast_vote
		@vote.quantity = params[:quantity]
		@vote.direction = params[:direction]
		@vote.save
		redirect_to Election.find(params[:election_id])
	end

	private
		def find_vote
			@vote = Vote.where(user_id: current_user.id, election_id: params[:election_id]).first
		end
end