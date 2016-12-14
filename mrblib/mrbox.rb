def __main__(argv)

  begin
    opt = Mrbox::Opt.new.run argv
  rescue NameError => e
    p e
    return
  rescue => e
    puts e.class
    puts e
  end

  begin
  Mrbox::Program.new.run(opt)
  rescue => e
    puts "error: #{e.class}"
    puts "notice: #{e}"
  end
end
