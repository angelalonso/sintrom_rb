#!/usr/bin/ruby

require 'gtk2'
class MainApp < Gtk::Window
	def initialize
		super
		       
		set_title "e-Yo"
		signal_connect "destroy" do 
			Gtk.main_quit 
		end

	end
	def main_base(win_x,win_y)
		@size_x = win_x
		@size_y = win_y

		set_tooltip_text "Welcome to e-Yo, what can I do for you?"
		set_default_size @size_x, @size_y
		set_window_position Gtk::Window::POS_CENTER

	end
	def layer_a(height)
		@fixed = Gtk::Fixed.new
		add @fixed
		@layerA1 = Gtk::Fixed.new
		@layerA2 = Gtk::Fixed.new
		@fixed.put @layerA1, 0, 0
		@fixed.put @layerA2, 0, height

		layer_a1
		layer_a2

		show_all
	end
	def layer_a1
		layer_A1_text = "Today:"
		aux = "Mamon"
		titleaux = Gtk::Label.new aux
		title = Gtk::Label.new layer_A1_text
		title.set_size_request @size_x, 40
		@layer_A1_table = Gtk::Table.new(2, 2, true)
		@layer_A1_table.attach_defaults(title, 0, 2, 0, 1)
		@layer_A1_table.attach_defaults(titleaux, 1, 2, 1, 2)
#		@layer_A1_table.attach_defaults(title, 0, 2, 1, 2)
		@layerA1.put @layer_A1_table, 0, 0
	end
	def layer_a2
		buttonsize_x = 80
		buttonsize_y = 40
		@quit_button = Gtk::Button.new "Quit"
		@quit_button.signal_connect("clicked") do
			    Gtk.main_quit
		end 
		@quit_button.set_size_request buttonsize_x, buttonsize_y
		@quit_button.set_tooltip_text "Quit the program"

		@layerA2.put @quit_button, @size_x - buttonsize_x, 0

	end

end

