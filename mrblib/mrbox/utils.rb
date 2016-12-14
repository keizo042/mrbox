module Mrbox
  class << self
    def git(*argv)
      Kernel.system("git #{argv.join(" ")}")
    end

    def rm(opt , dist)
      Kernel.system("rm #{opt} #{dist}")
    end
  end
end
