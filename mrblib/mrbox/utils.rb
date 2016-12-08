module Mrbox
  class << self
    def git(cmd, args)
      e = ["git", cmd, args]
      Kernel.system(e.join(" "))
    end
  end
end
