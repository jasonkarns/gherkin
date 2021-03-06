module Gherkin
  module Formatter
    class StepPrinter
      def write_step(io, text_format, arg_format, step_name, arguments)
        unpacked_step_name = step_name.unpack("U*")
        
        text_start = 0
        arguments.each do |arg|
          if(arg.offset != 0 && !arg.offset.nil?)
            io.write(text_format.text(unpacked_step_name[text_start..arg.offset-1].pack("U*")))
          end
          if(!arg.val.nil?)
            io.write(arg_format.text(arg.val))
            text_start = arg.offset + arg.val.unpack("U*").length
          end
        end
        io.write(text_format.text(unpacked_step_name[text_start..-1].pack("U*"))) unless text_start == unpacked_step_name.length
      end
    end
  end
end
