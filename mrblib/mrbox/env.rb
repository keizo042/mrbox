module Mrbox
  class Env
    class << self
      def check
        confroot="~/.mrbox"
        projects = confroot + "/projects"
        unless File.directory?(File.expand_path(confroot))
          Kernel.system(("mkdir " + confroot))
        end
        unless File.directory?(File.expand_path(projects))
          Kernel.system("mkdir " + File.expand_path(projects))
        end
        unless File.directory?(File.expand_path(projects + "/default"))
          Kernel.system("mkdir " + File.expand_path(projects + "/default"))
        end
        unless File.directory?(File.expand_path(projects + "/default/mruby"))
          Kernel.system(("git clone https://github.com/mruby/mruby.git " + File.expand_path(projects + "/default/mruby")))
        end
      end
    end

    def initialize
    end
    def setup
    end
  end
end
