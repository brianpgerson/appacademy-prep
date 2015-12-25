require "byebug"
class XmlDocument

	attr_reader :indent, :indent_depth

	def initialize(indent = false)
		@indent = indent
		@indent_depth = 0
	end

	def method_missing(method_name, *args, &block)
		args = args[0] || {}
		name = method_name.to_s
		make_tags(name, args, &block)
	end

	def indent_plus
		@indent_depth += 1 if indent
	end

	def indent_minus
		@indent_depth -= 1 if indent
	end

	def indentation
		indent == true ? "  " * indent_depth : ""
	end

	def new_line
		indent == true ? "\n" : ""
	end

	def make_tags(name, args, &block)
		doc = ""
		attributes = attributes(args)
		if !block_given?
			doc << single_tag(name, attributes)
		else
			doc << open_tag(name, attributes)
			indent_plus
			doc << yield
			indent_minus
			doc << close_tag(name)
		end
		doc
	end

	def single_tag(name, attributes)
		"#{indentation}<#{name}#{attributes}/>#{new_line}"
	end

	def open_tag(name, attributes)
		"#{indentation}<#{name}#{attributes}>#{new_line}"
	end

	def close_tag(name)
		"#{indentation}</#{name}>#{new_line}"
	end

	def attributes(args)
		if !args.empty?
			attributes = args.map { |key, val| "#{key.to_s}=\"#{val}\"" }
			" #{attributes.join(" ")}"
		else
			""
		end
	end

	

end
