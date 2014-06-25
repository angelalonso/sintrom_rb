#!/usr/bin/ruby


class Cal

	# Sintrom-related functions
	def sintrom_next_update
		load_array
		i = @dataarr_rows - 1
		while (i >= 0) do
			notetype = @dataarr[i][:note].split(/: /)[0].gsub( /\A"/m, "" ).gsub( /"\Z/m, "" )
			if notetype == "Sintrom Amount"
				return @dataarr[i][:day]
			end
			i -= 1
		end
	end
	def sintrom_amount(day)
		load_array
		for i in 0..(@dataarr_rows - 1) do
			if (@dataarr[i][:day] == day)
			       notetype = @dataarr[i][:note].split(/: /)[0].gsub( /\A"/m, "" ).gsub( /"\Z/m, "" )
		       	       if notetype == "Sintrom Amount"
					return @dataarr[i][:note].split(/: /)[1].gsub( /\A"/m, "" ).gsub( /"\Z/m, "" )
			       end
			end
		end
	end
	def next_sintrom_test(day)
		load_array
		i = 0
		test_found = 0
		while (test_found == 0 and i < @dataarr_rows) do
			if (@dataarr[i][:day] > day)
				notetype = @dataarr[i][:note].split(/:/)[0].gsub( /\A"/m, "" ).gsub( /"\Z/m, "" )
		       		if notetype == "Blood Level"
			       		return @dataarr[i][:day]
					test_found = 1
				end
			end
			i += 1
		end
	end
end

end
