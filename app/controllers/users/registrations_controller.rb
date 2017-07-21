class Users::RegistrationsController < Devise::RegistrationsController
  # Extend default devise gem behavior
  # User signing up with pro acc plan id 2
  # save with special stripe subscription
  # otherwise devise signs up user as usual
  def create
    super do |resource|
      if params[:plan]
        resource.plan_id = params[:plan]
        if resource.plan_id == 2
          resource.save_with_subscription
        else
          resource.save
        end
      end
    end
  end
end