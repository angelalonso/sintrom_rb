#!/usr/bin/ruby

require 'gtk2'
require 'date'
require "#{Directory}/cal.rb"
include Gtk

class Win < Window

# Part 1: Window initialization and quit
#
	def initialize(title)

		#Member variables
		@main_array = Array.new
		@button_array = Array.new

		super
		self.set_title(title)
		self.set_size_request( 800, 800 )
		self.resizable = false
		self.set_window_position( Position::CENTER )
		self.signal_connect( "destroy" ) do
			on_exit
		end

		@layer_general = Layout.new

		main_area_first
		btn_area_first
		
		all_on
	end
	def all_on

		self.add( @layer_general )
		self.show_all
	end
	def on_exit
		# Despite the name "main_quit" this is defined somewhere else and is related to window, not to "our" main area
		main_quit
	end

# Part 2: Managing the main area
# 
	def main_area_off
		if @main_array.length > 0 then
			for i in 0..(@main_array.length - 1) do
				@layer_general.remove( @main_array[i] )
			end
			@main_array.clear
		end
		self.remove( @layer_general )
	end
	def main_area_first

		@msg_main = Label.new
		@msg_sintrom_amount = Label.new
		@msg_sintrom_test = Label.new
		@msg_sintrom_update = Label.new

		@main_array.push(@msg_main)
		@main_array.push(@msg_sintrom_amount)
		@main_array.push(@msg_sintrom_test)
		@main_array.push(@msg_sintrom_update)

		@layer_general.put( @msg_main, 0, 0 )
		@layer_general.put( @msg_sintrom_amount, 0, 80 )
		@layer_general.put( @msg_sintrom_test, 0, 140 )
		@layer_general.put( @msg_sintrom_update, 0, 180 )
	end
	def main_area_first_values(message,sintrom_amount,sintrom_test, sintrom_update)

		@msg_main.set_markup("<span font='44'>#{message}</span>")
		@msg_sintrom_amount.set_markup("<span font='24'>#{sintrom_amount}</span>")
		@msg_sintrom_test.set_markup("<span font='14'>#{sintrom_test}</span>")
		@msg_sintrom_update.set_markup("<span font='14'>#{sintrom_update}</span>")
	end
	def main_area_sintrom
		main_area_off
		
		@msg_main.set_markup("<span font='44'>Sintrom Calendar</span>")
		nr_days_shown = 11
		gap = (nr_days_shown / 2)
		for i in 1..nr_days_shown do
			day_searched = (Date.today - i + gap + 1)
			date_formatted = [day_searched.year,"%02d" % day_searched.month,"%02d" % day_searched.day].join('')
			sintrom_amount = @cal.sintrom_amount(date_formatted)
			test = Label.new
			test.set_markup(day_searched," amount required: ", sintrom_amount)
			@layer_general.put( test, 0, (280 - (14 * i)) )
		end
		btn_layer_gen
		btn_gen("Atrás","Agenda","Cumpleaños","Turnos")
		all_on
	end
# Part 3 : Managing the buttons at the bottom
# 
	def btn_area_first

		@layer_btns = HBox.new( true, 0 )
		@layer_btns.set_size_request( 800 , 40 )

		@btn_sintrom = Button.new("Sintrom")
		@btn_sintrom.set_size_request( 100, 40 )
		@btn_sintrom.signal_connect( "clicked" ) do
			main_area_sintrom
		end
		@btn_agenda = Button.new("Agenda")
		@btn_agenda.set_size_request( 100, 40 )
		@btn_agenda.signal_connect( "clicked" ) do
			on_exit
		end
		@btn_bdays = Button.new("Cumpleaños")
		@btn_bdays.set_size_request( 100, 40 )
		@btn_bdays.signal_connect( "clicked" ) do
			on_exit
		end
		@btn_shifts = Button.new("Turnos")
		@btn_shifts.set_size_request( 100, 40 )
		@btn_shifts.signal_connect( "clicked" ) do
			on_exit
		end
		@btn_exit = Button.new("Exit")
		@btn_exit.set_size_request( 100, 40 )
		@btn_exit.signal_connect( "clicked" ) do
			on_exit
		end

		@layer_btns.add( @btn_sintrom )
		@layer_btns.add( @btn_agenda )
		@layer_btns.add( @btn_bdays )
		@layer_btns.add( @btn_shifts )
		@layer_btns.add( @btn_exit )

		@layer_general.put( @layer_btns,  0, 760 )

	end
	def btn_layer_gen
		@layer_btns = HBox.new( true, 0 ) 
		@layer_btns.set_size_request( 800 , 40 )
	end
	def btn_gen(btn1msg,btn2msg,btn3msg,btn4msg)
		@btn_1 = Button.new("#{btn1msg}")
		@btn_1.set_size_request( 100, 40 )
		@btn_1.signal_connect( "clicked" ) do
			puts "lalala"
		end
		@btn_2 = Button.new("#{btn2msg}")
		@btn_2.set_size_request( 100, 40 )
		@btn_2.signal_connect( "clicked" ) do
			puts "lalala"
		end
		@btn_3 = Button.new("#{btn3msg}")
		@btn_3.set_size_request( 100, 40 )
		@btn_3.signal_connect( "clicked" ) do
			puts "lalala"
		end
		@btn_4 = Button.new("#{btn4msg}")
		@btn_4.set_size_request( 100, 40 )
		@btn_4.signal_connect( "clicked" ) do
			puts "lalala"
		end
		@btn_exit = Button.new("Exit")
		@btn_exit.set_size_request( 100, 40 )
		@btn_exit.signal_connect( "clicked" ) do
			on_exit
		end

		@layer_btns.add( @btn_1 )
		@layer_btns.add( @btn_2 )
		@layer_btns.add( @btn_3 )
		@layer_btns.add( @btn_4 )
		@layer_btns.add( @btn_exit )

		@layer_general.put( @layer_btns,  0, 760 )

	end
end


