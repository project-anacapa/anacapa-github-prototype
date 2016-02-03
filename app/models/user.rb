require 'net/https'

class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :rememberable, :omniauthable, :trackable, :omniauth_providers => [:github]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.github_token = auth.credentials.token
#      user.password = Devise.friendly_token[0,20]
#      user.name = auth.info.name
#      user.image = auth.info.image
    end
  end
  
  def github_emails
    uri = URI.parse("https://api.github.com/user/emails")
    http = Net::HTTP.new(uri.host,uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(uri.request_uri)
    request["Authorization"] = "token " + self.github_token

    response = http.request(request)
    case response.code.to_i
    when 200 || 201
      response.body
    else
      nil
    end
  end

  def is_admin
    self.has_role? :admin
  end
end
