#!/usr/bin/ruby


class Cal

	# Shift-related functions
	def shift_for_day(day)
		load_array
		i = 0
		shift_found = 0
		while (shift_found == 0 and i < @dataarr_rows) do
			if (@dataarr[i][:day] = day)
				notetype = @dataarr[i][:note].split(/:/)[0].gsub( /\A"/m, "" ).gsub( /"\Z/m, "" )
		       		if notetype == "Shift"
			       		return @dataarr[i][:note]
					test_found = 1
				end
			end
			i += 1
		end
		if (shift_found == 0)
			return "nothing found"
		end

	end
	def shift_add_day(day,shift)
		insert(day,"shift",shift)
		i = 0
		while ( i < @dataarr_rows) do
			if (@dataarr[i][:day] == day)
				puts(@dataarr[i][:day],@dataarr[i][:note])
			end
			i += 1
		end
	end
	def shift_add_week(day)
		week = day.cweek
		for i in 0..6
			puts week.monday.day
		end
	end
end
