#!/usr/bin/ruby


class Calendar

	# Birthdays-related functions
	def birthdays_update(day,day_holded)
		load_array
		i = 0
		data_tested = 0
		while (i < @dataarr_rows and data_tested < day.to_i) do
			notetype = @dataarr[i][:note].split(/:/)[0].gsub( /\A"/m, "" ).gsub( /"\Z/m, "" )
			data_tested = @dataarr[i][:day].to_i
			if notetype == "Birthdays"
				puts @dataarr[i][:note]
			end
			i += 1
		end
	end
	def next_birthdays(day,number)
		load_array
		birtharr = Array.new
		i = 0
		test_found = 0
		while (test_found < number and i < @dataarr_rows) do
			if (@dataarr[i][:day] >= day)
				notetype = @dataarr[i][:note].split(/:/)[0].gsub( /\A"/m, "" ).gsub( /"\Z/m, "" )
				if notetype == "Birthdays"
					birtharr[test_found] = @dataarr[i][:note].split(/: /)[1].gsub( /\A"/m, "" ).gsub( /"\Z/m, "" )
					test_found += 1
				end
			end
			i += 1
		end
		return birtharr
	end
	def birthdays_next(day)

	end
end
