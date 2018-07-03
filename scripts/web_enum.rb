# Hi this is a script for web enumeration.
require 'mechanize'
class WebEnum
	
	def initialize(ip, port, dir)
		@ip = ip
		@port = port
		@dir = dir
	end

#not configured to crawl
#starting the script

	def start()
		hostname = @ip.split(".")[1]
		puts hostname
		crawl = Mechanize.new {|agent| agent.user_agent_alias = 'Windows Chrome'}
		url = "http://#{@ip}:#{@port}/#{@dir}"
		puts url
		@page = crawl.get(url)
		begin
		@page.links.each do |link| 
			if link.href.include? hostname then
			puts "#{link.href}"
			end
		end
		rescue NoMethodError => e 
			puts "No Links"
		end	
		begin
			puts("\n"*3)
			puts "*"*10+"Displaying robots.txt information"+"*"*10
			@robots = crawl.get(url+"/robots.txt")
			puts @robots.body
		end	
	end

#if the links are not found enable this

	def grep_href()
		puts("\n"*3)
		puts("*"*10+"Displaying Input forms"+"*"*10)
		@page.body.split(">").each do |href|
			if href.include? "href=" then 
				links =  href.gsub('"',"").split("href=")[-1]
				if links.include? "/" then
					puts links
				end
			end
		end
	end

#getting response headers

	def get_headers()
		 puts("\n"*3)
		 puts "*"*10+"Displaying Header information"+"*"*10
		 @page.header.to_s.split(',').each do |header|
		 	puts header
		 end
	end

#getting all the input tags from the html page

	def get_input_tags
		puts("\n"*3)
		puts("*"*10+"Displaying Input forms"+"*"*10)
		@page.body.split(">").each do |body|
			if body.include? "input" then 
				puts body
			end
		end
	end

# getting Forms.

	def get_form_data()
		begin
		puts("\n"*3)
		puts("*"*10+"Displaying Form Information"+"*"*10)
		forms = @page.form
		forms.each do |form|
			puts form
		end
		rescue NoMethodError => e
			puts "NO Form data"
		end
	end
end

a = WebEnum.new("www.google.com",80,'')
a.start	
a.get_headers
a.get_input_tags
a.get_form_data
puts "tags not displayed? y | n "
choice = gets.chomp.downcase
if choice == 'y' then
	a.grep_href
end