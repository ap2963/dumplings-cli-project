require 'tty-prompt'

prompt = TTY::Prompt.new





prompt.select("What would you like to do?") do |menu|
    menu.choice 'Navigate', 1
    menu.choice 'Read a short history'
    menu.choice 'View a full list of options'
  end