
class User < ActiveRecord::Base
  rolify
  has_one :student
  has_many :courses, class_name: "Course", :foreign_key => :instructor
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
    end
  end
  
  def github_emails
    uri = URI.parse("https://api.github.com/user/emails")
    http = Net::HTTP.new(uri.host,uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(uri.request_uri)
    request["Authorization"] = "token " + self.github_token.to_s

    response = http.request(request)
    case response.code.to_i
    when 200 || 201
      JSON.parse(response.body)
    else
      nil
    end
  end

  def student_record
    emails = self.github_emails
    student = nil
    unless emails.nil?
      emails.each do |email|
        begin
          student = Student.find_by! email: email["email"]
          student.user = self
        rescue ActiveRecord::RecordNotFound => e
        end
      end
    end
    return student
  end

  def is_admin
    self.has_role? :admin
  end
end
