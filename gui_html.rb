#!/usr/bin/ruby

require 'cgi'

class MainSite
	def create_main(sintrom_today,next_test,next_update)
		create_main_head
		create_main_tail(sintrom_today,next_test,next_update)
	end
	def create_main_head
		@sitesfolder = "/home/aaf/e-yo/tempfiles"
		@startsite = "#{@sitesfolder}/index.html"
		File.open(@startsite, "w") do |f|
			f.write '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'
			f.write '<html xmlns="http://www.w3.org/1999/xhtml">'
			f.write '<head>'
			f.write '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />'
			f.write '<title>e-Yo Personal Assistant</title>'
			f.write '<link rel="stylesheet" type="text/css" href="../deco/style.css" />'
			f.write '</head>'
			# body will be closed afterwards
			f.write '<body>'
		end
	end
	def create_main_tail(sintrom_today,next_test,next_update)
		File.open(@startsite, "a") do |f|
			f.write '<div class="title_block">'
			f.write '  <div class="logo"><a href="index.html"><img src="../deco/logo.png" alt="" title="" border="0" /></a></div>'
			f.write '  <div class="titlediv">Relax...</div>'
			f.write '</div>'
			f.write '<div class="wrap">'
			f.write '  <div class="main_block">'
			f.write "    <h1>You need #{sintrom_today}mg. of Sintrom today.</h1>"
			f.write "    <h1>Next blood test needs to be taken on #{next_test}</h1>"
			f.write "    <h1>The Sintrom File needs to be updated before #{next_update}</h1>"
			f.write '  </div>'
			f.write '</div>'
			f.write '<div class="footer_block"> Press Alt - F4 to Exit </div>'
			f.write '</body>'
			f.write '</html'
		end
	end
	def launch_browser(win_width, win_height)
		# http://wiki.xfce.org/midori/faq
		command="midori -e Fullscreen -a #{@startsite}"
		exec command
	end
	def destroy_browser
		kill_command="kill `ps aux | grep midori | grep e-yo | awk '{print $2}'`"
		exec kill_command
	end
end
