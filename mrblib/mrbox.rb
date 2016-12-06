def __main__(argv)
  if argv[1] == "version"
    puts "v#{Mrbox::VERSION}"
  else
    puts "Hello World"
  end
end
