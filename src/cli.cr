require "./globals"
require "./nepali_date"
require "clim"
require "colorize"

class Cli < Clim
  main do
    help_template do |desc, usage, options, arguments, sub_commands|
      base = <<-BASE_HELP
        #{desc}

        #{"USAGE:".colorize(:yellow)} #{usage}
      BASE_HELP

      base
    end

    desc <<-DESC
    #{"ncal".colorize(:green)} #{Globals.version}
    A command line utility to see the current Nepali date.
    DESC

    usage <<-USAGE

    \tncal [flags]
    \tncal [subcommand] [flags] [arguments]
    USAGE

    help short: "-h"
    version "ncal version #{Globals.version}\nwritten with <3 by pes18fan", short: "-v"

    run do |opts, args|
      puts "Today is #{NepaliDate.new.to_s}."
    end
  end
end
