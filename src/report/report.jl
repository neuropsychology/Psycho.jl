struct Report
	text::Any
	values::Dict
end


function Report(; text="Nothing to report", values=Dict())
    Report(text, values)
end


function Base.show(io::IO, report::Report)
	println(report.text)
end
