module FreelancersHelper
	def gravatar_for(freelancer)
    gravatar_id = Digest::MD5::hexdigest(freelancer.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: freelancer.name, class: "gravatar")
  end
end
