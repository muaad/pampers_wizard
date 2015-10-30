require "whatsapp"
class HomeController < ApplicationController
	before_action :set_mother, only: [:wizard]
	before_action :set_account, only: [:wizard]
	def wizard
    if params[:notification_type] == "MessageReceived"
    	@account = Account.find_by(phone_number: params[:account])
    	if is_command(params[:text])
    		cmd = command(params[:text])
    		if !cmd.nil?
	    		if cmd.name == "help"
	    			msg = "Use the following commands:\n\n"
	    			msg += "/menu - Get a list of tips and choose one of them\n\n"
	    			msg += "/diet - This will let you get some dietary tips\n\n"
	    			msg += "/shower - This will give you some instructions on the baby shower\n\n"
	    			msg += "/chat - You can chat with fellow mums anonymously and exchange ideas with them.\n\n"

	    			Whatsapp.send_message(msg, params[:phone_number], @account)
	    		elsif cmd.name == "shower"
	    				images = [
	    									"http://newbabywallpapers.com/download/baby-shower-images-and-wallpaper/baby-shower-images-and-wallpaper-17.jpg",
	    									"http://www.brightstarcare.com/chicago-/files/2013/04/baby-shower-4.jpg"
	    				]
	    				Whatsapp.send_image(@account, params[:phone_number], images[0])
	    				Whatsapp.send_image(@account, params[:phone_number], images[1])
	    		elsif cmd.name == "chat"
	    			if @mother.username.nil?
	    				step = Step.find_by(name: "Username")
	    				progress = Progress.create! mother: @mother, step: step
	    				question = step.questions.first
	    				msg = question.to_result(@mother)[:text]
	    			else
	    				msg = "Find a random person to chat with by sending /spin. You can then start a conversation with your random friend like this:\n\n@username: hi. \n\nOnce you have started the chat, you don't have to include the username again. Just send the message the way you normally do. But, if you want to chat with someone else, you will have to start with the username or your message will go to the wrong person. If you want to be very careful, you can always add the username to your message but most of the times, that is not neccessary."
	    			end
	    			Whatsapp.send_message(msg, params[:phone_number], @account)
	    		elsif cmd.name == "spin"
	    				msg = Command.spin(@mother)
	    				Whatsapp.send_message(msg, params[:phone_number], @account)
	    		else
	    			if !cmd.step.nil?
	    				progress = Progress.create! mother: @mother, step: cmd.step
	    				question = cmd.step.questions.first
	    				q = question.to_result(@mother)[:text]
	    				Whatsapp.send_message(q, @mother.phone_number, @account)
	    			end
	    		end
	    	else
	    		Whatsapp.send_message("We don't recognize this command: #{params[:text]}. Please send /help.", @mother.phone_number, @account)
	    	end
    		render json: { success: true }
    	elsif @mother.in_chat? || params[:text].start_with?("@")
    		message = params[:text]
    		# Chat.process @mother, message, @account, username

    		if message.start_with?("@")
    			msg = Chat.message_details(message)[:message]
    			username = Chat.message_details(message)[:username]
    			recipient = Mother.where("username ilike ?", username).first
    			sender = @mother
    			if recipient != sender
    				if !msg.blank?
    					Chat.process sender, username, msg
    				else
    					Whatsapp.send_message "A chat has been initiated with @#{recipient.username} but you haven't included a message. Send your message now.", sender.phone_number, @account
    				end
    			else
    				Whatsapp.send_message "Looks like you are trying to chat with yourself. :) Send /spin to find someone to chat with or /chat to get help on how the chat feature works.", params[:phone_number], @account
    			end
    		else
    			sender = @mother
    			Chat.process sender, message
    		end
    		render json: { success: true }
      else
      	# Check progress first in case an answer of one of the steps is a start of another wizard?
	      @current = Progress.where(mother_id: @mother.id).order(id: :desc).first
	      text = params[:text]

	      wizards = Wizard.get_reset_wizards(text)
	      if !wizards.empty?
	        wizard = wizards.first
	        number = @mother.phone_number
	        Progress.where(mother_id: @mother.id).destroy_all
	        @mother.delete
	        wizard.reset(@mother)
	        render json: { success: true }
	      else
	        if @current.nil?
	          # check to see if there is any wizard matching that keyword
	          # wizard = Wizard

	          wizards = Wizard.get_starting_wizards(text)
	          if !wizards.empty?
	            
	            # only ever deal with the first wizard
	            wizard = wizards.first
	            response = wizard.start(@mother)
	            first_step = wizard.first_step
	            question = first_step.questions.first
	            Whatsapp.send_message(question.to_result(@mother)[:text], @mother.phone_number, @mother.account)
	            render json: { success: true }

	          else
	            render json: { ignore: true }
	          end
	        else
	          wizard = @current.step.wizard
	          response = remove_nil(progress_step(@current, params[:text]))
	          # current = Progress.where(mother_id: @mother.id).order(id: :desc).first
	          # WizardWorker.perform_in((wizard.restart_in * 60), current.id)
	          Whatsapp.send_message(response[:text], @mother.phone_number, @mother.account)
	          render :json => { response: response }
	        end
	      end
      end
    else
      render :json => { success: true }
    end
  end

  def progress_step progress, text
  	step = progress.step
  	mother = progress.mother
  	if step.step_type == "free-text"
	    next_step = Step.find(step.next_step_id)
	  	if !next_step.nil?
	  	  question = next_step.questions.first
	  	  Progress.create! step_id: next_step.id, mother_id: mother.id, account_id: next_step.account.id
	  	  q = question.to_result(@mother)[:text]
	  	  return {type: "Response", text: q}
	  	else
	  	  @contact.update(bot_complete: true)
	  	  return {type: "Response", text: "Thanks #{@mother.name} for engaging with us."}
	  	end
	  elsif step.step_type == "profile"
	  	if step.name.downcase == "name"
	  		mother.update(name: text)
	  	elsif step.name.downcase == "weeks"
	  		if is_number?(text)
	  			mother.update(weeks_since_conception: text)
	  			tips = Tip.where('week >= ?', mother.weeks_since_conception)
	  			tips.each do |tip|
	  				ReminderWorker.perform_in(((tip.week.to_i - mother.weeks_since_conception.to_i) * 60), mother.id, tip.id)
	  			end
	  		else
	  			return {type: "Response", text: "You have sent #{text} which is not a number. Please send a number i.e 4. Thanks."}
	  		end
	  	elsif step.name.downcase == "username"
  			error = Mother.check_format(params[:text])
  			if error.blank?
  				@mother.update(username: params[:text].downcase)
  				msg = "Your username has been setup. Now, you can chat with fellow mums.\n\nFind a random person to chat with by sending /spin. You can then start a conversation with your random friend like this:\n\n@username: hi. \n\nOnce you have started the chat, you don't have to include the username again. Just send the message the way you normally do. But, if you want to chat with someone else, you will have to start with the username or your message will go to the wrong person. If you want to be very careful, you can always add the username to your message but most of the times, that is not neccessary."
  			else
  				msg = error
  			end
  			return {type: "Response", text: msg}
	  	end
	  	next_step = Step.find(step.next_step_id)
	  	if !next_step.nil?
	  	  question = next_step.questions.first
	  	  Progress.create! step_id: next_step.id, mother_id: mother.id, account_id: next_step.account.id
	  	  q = question.to_result(@mother)[:text]
	  	  return {type: "Response", text: q}
	  	else
	  	  @contact.update(bot_complete: true)
	  	  return {type: "Response", text: "Thanks #{@mother.name} for engaging with us. We will be sending you more helpful information periodically. Send /help to find out what else you can do through this number."}
	  	end
	  elsif step.step_type.downcase == "menu"
	  	question = step.questions.first
	  	if !Option.is_valid?(question, text)
	  	  response = { type: "Response", text: "Oops! Wrong option there.", phone_number: mother.phone_number }

	  	  return response
	  	else
	  		if step.name.downcase == "expectant"
	  			if text == "2"
	  				mother.update(expectant: false)
	  			end
	  		end
	  		option = Option.get_valid_option question, text
	  		next_step = nil
	  	  next_step = Step.find(option.next_step_id) if !option.next_step_id.blank?
	  	  next_step = Step.find(step.next_step_id) if next_step.nil?

	  	  if !next_step.nil?
	  	    question = next_step.questions.first
	  	    Progress.create! step_id: next_step.id, mother_id: mother.id, account_id: next_step.account.id
	  	    q = question.to_result(@mother)[:text]
	  	    return {type: "Response", text: q}
	  	  else
	  	    @contact.update(bot_complete: true)
	  	    return {type: "Response", text: "Thanks #{@mother.name} for engaging with us."}
	  	  end
	  	end
	  else

	  end	
  end

  def command message
  	if is_command message
  		return Command.find_by(name: message.split("/")[1].downcase.strip)
  	end
  end

  def is_command message
  	message.start_with?("/")
  end

  def remove_nil responses
    responses.reject! { |r| r.nil? }
    responses
  end

  def set_mother
    @mother = Mother.find_by_phone_number(params[:phone_number])
    if @mother.nil? && params[:notification_type] == "MessageReceived"
      @mother = Mother.create! phone_number: params[:phone_number], name: params[:name], account: Account.find_by(phone_number: params[:account])
    end
    @mother
  end

  def set_account
  	@account = Account.find_by(phone_number: params[:account]) if params[:notification_type] == "MessageReceived"
  end
end
