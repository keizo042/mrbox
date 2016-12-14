module Mrbox
  class Program
    def run(opt)
      if opt.options[:help] 
        return
      end
      if opt.mrbox.length < 1
        puts "invaild arguments.."
        Mrbox.help
        return
      end
      sym = opt.mrbox.shift.to_sym
      Mrbox::Commands.send(sym, opt.mrbox, opt.mruby, opt.options)
    end
  end
end
