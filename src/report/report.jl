struct Report
	text::Any
	values::Dict
	table::Any
end


function Report(; text="Nothing to report", values=Dict(), table=Dict())
    Report(text, values, table)
end




function Base.show(io::IO, report::Report)
	println(report.text)
end




function table(report::Report)
	return report.table
end




function values(report::Report)
	return report.values
end
