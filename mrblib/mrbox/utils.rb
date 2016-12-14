module Mrbox
  class << self
    def git(*argv)
      Kernel.system("git #{argv.join(" ")}")
    end

    def rm(opt , dist)
      puts IO.open("rm #{opt} #{dist}","r+")  do |io|
        io.gets
      end
    end
  end
end
