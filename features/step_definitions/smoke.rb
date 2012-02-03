require 'net/http'
require 'net/https'

class SmokeTest
  attr_accessor :response_code, :url
  
  def get_url
    uri = URI.parse(@url)
    
    # Do some dancing around so that we can handle both http and https URLs here
    http = Net::HTTP.new(uri.host, uri.port)
    if uri.scheme == 'https'
      http.use_ssl = true
    else
      http.use_ssl = false
    end
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)    
    response = http.request(request)
    @response_code = response.code
  end
end

Given /^the site url "([^"]*)"$/ do |url|
  @ping_test = SmokeTest.new
  @ping_test.url = url
end

When /^requesting that url$/ do
  @ping_test.get_url
end

Then /^the HTTP response code should be "([^"]*)"$/ do |code|
  @ping_test.response_code.should == code
end
