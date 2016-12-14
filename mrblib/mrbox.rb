def __main__(argv)

  if argv.length <= 1
    Mrbox.help
    return
  end
  begin
    opt = Mrbox::Opt.new.run argv
  rescue NameError => e
    puts "opt error"
    puts "NameError"
    return
  rescue => e
    puts "opt error"
    return 
  end

  begin
    Mrbox::Program.new.run(opt)
  rescue => e
    puts "top level"
    puts "error: #{e.class}"
    puts "notice: #{e}"
  end
end
