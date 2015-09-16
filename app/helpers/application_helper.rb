module ApplicationHelper

  def fix_url(url)
    if url.starts_with?('http://') || url.starts_with?('https://')
    	url
    else
    	url = "http://#{url}"
    end
  end

	def friendly_date(date)
    @tabdate = date.strftime('%b %d %Y at %l:%M%p') #+ "at" + date.strftime
	end
end
