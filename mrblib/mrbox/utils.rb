module Mrbox
  class << self
    def git(cmd, args)
      e = ["git", cmd, args]
      Kernel.system(e.join(" "))
    end

    def rm(opt , dist)
      Kernel.system("rm #{opt} #{dist}")
    end
  end
end
