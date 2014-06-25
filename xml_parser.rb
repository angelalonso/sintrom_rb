#!/usr/bin/ruby

class Config
	def initialize(configfile)
		translation=""
		config = File.open(configfile, "r")
		config.each {|line| 
			if line.strip[0,1] != "#" and line.strip[0,1] != ""
				translation << translate(line.strip)
			end
		}
		puts translation
	end
	def translate(line)
		# Let's separae the XML declaration (maybe useful later)
		if line.split(" ")[0] != "<?xml"
			# Here we basically want to cut down our string
			return line.gsub(/\s+/, "||").gsub(/"/, "||").gsub(/\n/, "||").gsub("><", ">||<") << "||"
		else
			return "||" 
		end
	end
end

