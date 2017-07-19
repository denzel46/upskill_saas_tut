class ContactsController < ApplicationController
    
    # GET requests to /contact-us
    # Show new contact form
    def new
        @contact = Contact.new
    end
    
    # POST request /contacts
    def create
        # Mass assignmet of form fields into Contact object
        @contact = Contact.new(contact_params)
        # Save the COntact object to the db
        if @contact.save
            # Store form fields via parameters, into vars
            name = params[:contact][:name]
            email = params[:contact][:email]
            body = params[:contact][:comments]
            # Plug Vars into Contact Mailer and send Mail
            ContactMailer.contact_email(name, email, body).deliver
            # Store success msg in flash hash
            flash[:success] = "Message sent."
            #redirect to new action
            redirect_to new_contact_path
        else
            #Store errors msg in flash hash
            flash[:danger] = @contact.errors.full_messages.join(", ")
            #redirect anyway
            redirect_to new_contact_path
        end
    end
    private
        # To collect data from form, we need to use
        # strong parameters and whitelist form fields
        def contact_params
            params.require(:contact).permit(:name, :email, :comments)
        end
    
end
