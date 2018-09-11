struct Report
	text::Any
	values::Dict
	table::Any
end


function Report(; text="Nothing to report", values=Dict(), table=Dict())
    Report(text, values, table)
end




function Base.show(io::IO, report::Report)
	println(io, report.text)
end




function table(report::Report)
	return report.table
end




function Base.values(report::Report)
	return report.values
end





function format_text!(text)
	replace!(text,
		" -0.0 " => " 0.0 ",
		" 0.0 " => " 0 ",
		" 0.0 " => " 0 ",
		" 0.0 " => " 0 ")

end
