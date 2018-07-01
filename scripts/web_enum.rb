# Hi this is a script for web enumeration.
require 'mechanize'
class WebCrawler
	
	def initialize(ip, port, dir)
		@ip = ip
		@port = port
		@dir = dir
	end

	def start()
		hostname = @ip.split(".")[1]
		puts hostname
		crawl = Mechanize.new
		url = "http://#{@ip}:#{@port}/#{@dir}"
		puts url
		@page = crawl.get(url)
		@page.links.each do |link| 
			if link.href.include? hostname then
			puts "#{link.href}"
			end
		end	
	end

	def get_headers()
		 puts("\n"*3)
		 puts " ************************Displaying Header information*************************************"
		 @page.header.to_s.split(',').each do |header|
		 	puts header
		 end
	end
end

a = WebCrawler.new("www.theuselessweb.com",80,'')
a.start
a.get_headers
