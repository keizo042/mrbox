module Mrbox
  module Env
    def check
      confroot="~/.mrbox"
      unless File.directory?(confroot)
        Kernel.system(("mkdir " + confroot))
      end
      unless File.directory?(confroot + "/default")
        Kernel.system("mkdir " + confroot + "/default")
      end
      unless File.directory?(confroot + "/default/mruby")
        Kernel.system(("git clone https://github.com/mruby/mruby.git " + confroot + "/default/mruby"))
      end
      unless File.directory?(confroot + "/projects")
      end
    end
  end
end
