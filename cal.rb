#!/usr/bin/ruby

require "#{Directory}/cal_sintrom.rb"
require "#{Directory}/cal_birth.rb"
require "#{Directory}/cal_shifts.rb"

class Cal
	def initialize(filename)
		@filename = filename
		@filetmp = "#{filename}.tmp"
	end
	def load_array
		@dataarr = Array.new
		rownr = 0
		File.foreach(@filename) do |line|
			words = line.split(',')
			@dataarr[rownr] = Hash.new
			@dataarr[rownr][:day] = words[0]
			@dataarr[rownr][:note] = words[1]
			rownr += 1
		end
		@dataarr_rows = rownr
	end
	def sort
		load_array
		# sort the data by the last_name field
		@dataarr.sort! { |a,b| 
			a[:day].downcase <=> b[:day].downcase 
		}
		# write the sorted data to the same file
		File.open(@filename, "w") do |f|
			for i in 0..(@dataarr_rows - 1) do
				f.print @dataarr[i][:day],",",@dataarr[i][:note]
			end
		end
	end
	def test_doubled_values
		# Tests that there are no duplicate records for Sintrom, Shift and Blood Level
		# also, it tests that every recorded day has one Sintrom Amount recorded
		load_array
		i = 0
		prevday = 0
		already_sintrom_amount = 0
		already_blood_level = 0
		already_shift = 0
		for i in 0..(@dataarr_rows - 1) do
			notetype = @dataarr[i][:note].split(/:/)[0].gsub( /\A"/m, "" ).gsub( /"\Z/m, "" )
			if @dataarr[i][:day] == prevday
				if notetype == "Sintrom Amount"
					if already_sintrom_amount == 1
						print("ERROR: More than one Sintrom Amount records for ",@dataarr[i][:day],"\n")
						print("Please repair file: ",@filename,"\n")
					else
						already_sintrom_amount = 1
					end
				elsif notetype == "Blood Level"
					if already_blood_level == 1
						print("ERROR: More than one Blood Level records for ",@dataarr[i][:day],"\n")
						print("Please repair file: ",@filename,"\n")
					else
						already_blood_level = 1
					end
				elsif notetype == "Shift"
					if already_shift == 1
						print("ERROR: More than one Shift records for ",@dataarr[i][:day],"\n")
						print("Please repair file: ",@filename,"\n")
					else
						already_shift = 1
					end
				end
			else
				if notetype == "Sintrom Amount"
					already_sintrom_amount = 1
					already_blood_level = 0
					already_shift = 0
				elsif notetype == "Blood Level"
					already_sintrom_amount = 0
					already_blood_level = 1
					already_shift = 0
				elsif notetype == "Shift"
					already_sintrom_amount = 0
					already_blood_level = 0
					already_shift = 1
				else
					already_sintrom_amount = 0
					already_blood_level = 0
					already_shift = 0
				end
			end	
			prevday = @dataarr[i][:day]
		end
	end
	def test_update
		load_array
		return @dataarr[@dataarr_rows - 1][:day]
	end
	def insert(day,notetype,note)
		if (notetype == "sintrom")
			note = "Sintrom Amount: " + note
		elsif (notetype == "shift")
			note = "Shift: "+ note
		elsif (notetype == "birthday")
			note = "Birthdays: " + note
		else
			puts "ERROR: No valid note:" + notetype
		end
		load_array
		new_value = Hash.new
		new_value[:day] = day
		new_value[:note] = note 
		@dataarr.push(new_value)
		@dataarr_rows = @dataarr.count

	end
end
