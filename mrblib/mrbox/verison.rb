module Mrbox
    COMMAND = "mrbox"
    VERSION = "0.1.0"
    AUTHOR = "Kouichi Nakanishi(keizo042)"

    CMDS = {
      :build => {desc: "build mruby binary."},
       :clean => {desc: "clean up mruby repo"},
       :help => {desc: "print help and version"},
       :init => {desc: "intialize local mrbox sandbox"},
       :show => {desc: "show your named mruby binaries"},
       :setup => {desc: "setup global mrbox's mruby sandbox"},
       :update => {desc: "update mruby repo"},
       :mruby => {desc: "use mruby"},
       :mirb => {desc: "use mirb"},
       :mrbc => {desc: "use mrbc"},
       :mruby_strip => {desc: "use mruby-strip"},
       :edit => {desc: "edit build_config.rb"},
       :config => {desc: "config mrbox"},
    }

  class << self
    def banner 
      text=<<DOC
Usage: #{COMMAND} [mrbox options] [command] [mrbox options] -- [mruby option]
Author:#{AUTHOR}
mruby binary sandbox manager.

example:
---

$mrbox build --name hello
$mrbox mruby --name hello -- -e 'puts "Hello mrbox World!"'

---

At first, you must execute 'mrbox setup'. 
by default, it use default mruby repository.
if you specifiy option '--name', download mruby repo into local  and manage it as this name.

options
--file (-f)     ---   using specific mruby's build_config.rb
--name (-n)     ---   nameing mruby binary, it use when build,clean,mruby.mirb,mrbc

DOC
      puts text
    end

    def descs(key=nil)
      desc(key,CMDS[key]) if key

      CMDS.keys.each { |key|
        cmd = CMDS[key]
        desc(key, cmd)
      }
    end

    def desc(key,cmd)
      puts "#{key} -- #{cmd[:desc]}"
    end

    def help
      banner
      puts "subcommands:"
      descs
    end
  end
end
