require "httparty"
class Whatsapp
	def self.send_message message, phone_number, account
		HTTParty.post("https://app.ongair.im/api/v1/base/send?token=#{account.auth_token}", body: {phone_number: phone_number, text: message, thread: true})
	end

	def self.send_image account, phone_number, image_url
		HTTParty.post("https://app.ongair.im/api/v1/base/send_image", body: { token: account.auth_token,  phone_number: phone_number, image: image_url, thread: true })
	end
end