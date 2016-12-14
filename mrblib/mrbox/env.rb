module Mrbox
  class Env
    attr_reader :mrbox, :projects

    def initialize( mrbox = "~/.mrbox", repo = "https://github.com/mruby/mruby.git" )
      @mrbox = File.expand_path(mrbox)
      @projects = "#{@mrbox}/projects"
      @default = "#{@projects}/default"
      @repo = repo
    end

    def setup
      Dir.mkdir(@mrbox) unless File.directory?(@mrbox)

      Dir.mkdir(@projects) unless File.directory?(@projects)
      Dir.mkdir(@default) unless File.directory?(@default)

      mruby = File.join(@default, "mruby")
      Mrbox.git("clone #{@repo} #{mruby}") unless File.directory?(mruby)
    end
  end
end
