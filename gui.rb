#!/usr/bin/ruby

require 'gtk2'
require 'date'
#require "#{Directory}/cal.rb"

class Win < Gtk::Window

# Part 1: Window initialization and quit
#
	def initialize(calendarFile)
		#Calendar initialization
		
		@cal = Cal.new(calendarFile)

		# Now we get the Calendar File ready
		@cal.sort
		@cal.test_doubled_values
		
		#Member variables
		@layer_array = Array.new
		@button_array = Array.new

		super
		self.set_title("e-yo")
		self.set_size_request( 800, 800 )
		self.resizable = false
		self.set_window_position( Position::CENTER )
		self.signal_connect( "destroy" ) do
			on_exit
		end

		main_area_first
	end
	def all_on(layer)

		self.add( layer )
		self.show_all
# The following is supposed to be useful for a general-purpose gneration script
#		if @layer_array.length > 0 then
#			for i in 0..(@layer_array.length - 1) do
#				puts @layer_array[i].name
#				self.add( @layer_array[i] )
#			end 
#		end
	end
	def on_exit
		# Despite the name "main_quit" this is defined somewhere else and is related to window, not to "our" main area
		Gtk::main_quit
	end

# Part 2: Managing the main area
# 
	def main_area_off
		self.each do |w|
 			self.remove( w )
		end
	end
	def main_area_first

		# Generate the data shown on the first screen
		today = [Date.today.year,"%02d" % Date.today.month,"%02d" % Date.today.day].join('')
		sintrom_amount = @cal.sintrom_amount(today)
		sintrom_test = @cal.next_sintrom_test(today),"\n" 
		sintrom_update = @cal.sintrom_next_update,"\n" 

		@layer_first = Gtk::Layout.new

		@frame_first_sintrom_title = Gtk::Label.new
		@frame_first_sintrom_title.set_markup("<span font='14'>Sintrom</span>")	
		
		@frame_first_center = Gtk::Frame.new("Sintrom")
		@frame_first_center.set_label_widget(@frame_first_sintrom_title)
		@frame_first_center.set_size_request(300,300)
		@frame_first_center.set_label_align(0.5, 0.5)
		
		@msg_first_sintrom = Gtk::Label.new
		@msg_first_sintrom.set_justify(Gtk::JUSTIFY_CENTER)
		@msg_first_sintrom.set_wrap( true )
		@msg_first_sintrom.set_markup("<span font='12'>Cantidad de Sintrom para hoy: </span>\n<span font='44' color='#6e0328'>#{sintrom_amount}</span>\n\n<span font='11'>El próximo test será el </span>\n<span font='16' color='#03556e'>#{sintrom_test}</span>\n<span font='9'>El archivo deberá ser actualizado antes del </span>\n<span font='16' color='#03556e'>#{sintrom_update}</span>")

		@frame_first_center.add( @msg_first_sintrom )


		@frame_first_shifts_title = Gtk::Label.new
		@frame_first_shifts_title.set_markup("<span font='14'>Turnos</span>")	
		
		@frame_first_upright = Gtk::Frame.new("Turnos")
		@frame_first_upright.set_label_widget(@frame_first_shifts_title)
		@frame_first_upright.set_size_request(275,275)
		@frame_first_upright.set_label_align(0.5, 0.5)
		
		@msg_first_shifts = Gtk::Label.new
		@msg_first_shifts.set_justify(Gtk::JUSTIFY_CENTER)
		@msg_first_shifts.set_wrap( true )
		@msg_first_shifts.set_markup("<span font='12'>Cantidad de Sintrom para hoy: </span>\n<span font='44' color='#6e0328'>#{sintrom_amount}</span>\n\n<span font='11'>El próximo test será el </span>\n<span font='16' color='#03556e'>#{sintrom_test}</span>\n<span font='9'>El archivo deberá ser actualizado antes del </span>\n<span font='16' color='#03556e'>#{sintrom_update}</span>")

		@frame_first_upright.add( @msg_first_shifts )

		@layer_first.put( @frame_first_upright, 525, 0 )
		@layer_first.put( @frame_first_center, 250, 250 )
		btn_area_first
		
		@layer_array.push(@layer_first)
		all_on(@layer_first)
	end
	def main_area_sintrom
		main_area_off
		title = "Sintrom esta Semana"
		@layer_sintrom = Gtk::Layout.new

		@frame_sintrom_title = Gtk::Label.new
		@frame_sintrom_title.set_markup("<span font='14'>#{title}</span>")	
		@frame_sintrom_days = Gtk::Frame.new("#{title}")
		@frame_sintrom_days.set_label_widget(@frame_sintrom_title)
		@frame_sintrom_days.set_size_request(300,700)
		@frame_sintrom_days.set_label_align(0.5, 0.5)

		nr_days_shown = 14
		gap = (nr_days_shown / 2)
		sintrom_list = ""
		for i in 1..nr_days_shown do
			day_searched = (Date.today - gap + i + 1 )
			date_formatted = [day_searched.year,"%02d" % day_searched.month,"%02d" % day_searched.day].join('')
			sintrom_amount = @cal.sintrom_amount(date_formatted)
			today_tag = gap - 1
			if (i < today_tag)
				sintrom_list = ( sintrom_list + "<span font='12' color='#777'>" + day_searched.to_s + "</span><span font='10' color='#777'>, cantidad(en mg.): </span><span font='16' color='#777'>" + sintrom_amount.to_s + "</span>\n" )
			elsif (i == today_tag)
				sintrom_list = ( sintrom_list + "<span font='14' color='#03556e'>" + day_searched.to_s + "</span><span font='12'>, cantidad(en mg.): </span><span font='20' color='#6e0328'>" + sintrom_amount.to_s + "</span>\n" )
			elsif (i > today_tag)
				sintrom_list = ( sintrom_list + "<span font='12' color='#03556e'>" + day_searched.to_s + "</span><span font='10'>, cantidad(en mg.): </span><span font='16' color='#6e0328'>" + sintrom_amount.to_s + "</span>\n" )
			end
		end

		@msg_sintrom_days = Gtk::Label.new
		@msg_sintrom_days.set_justify(Gtk::JUSTIFY_CENTER)
		@msg_sintrom_days.set_wrap( true )
		@msg_sintrom_days.set_markup( sintrom_list )

		@frame_sintrom_days.add( @msg_sintrom_days )
		@layer_sintrom.put( @frame_sintrom_days, 0, 0 )
		
		@layer_array.push(@layer_sintrom)

		btn_gen(@layer_sintrom,"Atrás","btn2msg","btn3msg","btn4msg")

		self.add( @layer_sintrom )
		self.show_all

	end
# Part 3 : Managing the buttons at the bottom
# 
	def btn_area_first

		@layer_btns = Gtk::HBox.new( true, 0 )
		@layer_btns.set_size_request( 800 , 40 )

		@btn_sintrom = Gtk::Button.new("Sintrom")
		@btn_sintrom.set_size_request( 100, 40 )
		@btn_sintrom.signal_connect( "clicked" ) do
			main_area_sintrom
		end
		@btn_agenda = Gtk::Button.new("Agenda")
		@btn_agenda.set_size_request( 100, 40 )
		@btn_agenda.signal_connect( "clicked" ) do
			on_exit
		end
		@btn_bdays = Gtk::Button.new("Cumpleaños")
		@btn_bdays.set_size_request( 100, 40 )
		@btn_bdays.signal_connect( "clicked" ) do
			on_exit
		end
		@btn_shifts = Gtk::Button.new("Turnos")
		@btn_shifts.set_size_request( 100, 40 )
		@btn_shifts.signal_connect( "clicked" ) do
			on_exit
		end
		@btn_exit = Gtk::Button.new("Exit")
		@btn_exit.set_size_request( 100, 40 )
		@btn_exit.signal_connect( "clicked" ) do
			on_exit
		end

		@layer_btns.add( @btn_sintrom )
		@layer_btns.add( @btn_agenda )
		@layer_btns.add( @btn_bdays )
		@layer_btns.add( @btn_shifts )
		@layer_btns.add( @btn_exit )

		@layer_first.put( @layer_btns,  0, 760 )

	end
	def btn_gen(layer,btn1msg,btn2msg,btn3msg,btn4msg)
		@layer_btns = Gtk::HBox.new( true, 0 )
		@layer_btns.set_size_request( 800 , 40 )

		@btn_1 = Gtk::Button.new("#{btn1msg}")
		@btn_1.set_size_request( 100, 40 )
		@btn_1.signal_connect( "clicked" ) do
			main_area_off
			main_area_first
		end
		@btn_2 = Gtk::Button.new("#{btn2msg}")
		@btn_2.set_size_request( 100, 40 )
		@btn_2.signal_connect( "clicked" ) do
			puts "lalala"
		end
		@btn_3 = Gtk::Button.new("#{btn3msg}")
		@btn_3.set_size_request( 100, 40 )
		@btn_3.signal_connect( "clicked" ) do
			puts "lalala"
		end
		@btn_4 = Gtk::Button.new("#{btn4msg}")
		@btn_4.set_size_request( 100, 40 )
		@btn_4.signal_connect( "clicked" ) do
			puts "lalala"
		end
		@btn_exit = Gtk::Button.new("Exit")
		@btn_exit.set_size_request( 100, 40 )
		@btn_exit.signal_connect( "clicked" ) do
			on_exit
		end

		@layer_btns.add( @btn_1 )
		@layer_btns.add( @btn_2 )
		@layer_btns.add( @btn_3 )
		@layer_btns.add( @btn_4 )
		@layer_btns.add( @btn_exit )

		layer.put( @layer_btns,  0, 760 )

	end
end
