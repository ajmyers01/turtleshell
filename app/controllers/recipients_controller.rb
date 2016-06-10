class RecipientsController < ApplicationController

  def index
    @recipients = current_user.recipients
  end

  def create
    @recipient = Recipient.new(first_name: params[:first_name],
                               last_name: params[:last_name],
                               email: params[:email],
                               user_id: current_user.id)
    if @recipient.valid?
      if @recipient.save
        respond_to do |format|
          format.json { render json: {success: true} }
        end
      end
    end
  end

  def destroy
    @recipient = Recipient.find(params[:target_recipient_id].to_i)
    @recipient.destroy
    respond_to do |format|
      format.json { render json: {success: true} }
    end
  end
end
