require "./calendar"
require "./globals"
require "./nepali_date"
require "clim"
require "colorize"
require "json"

class Cli < Clim
  main do
    help_template do |desc, usage, options, arguments, sub_commands|
      options_help_lines = options.map do |option|
        "\t#{option[:names].join(", ").colorize(:green)}\t#{option[:desc]}"
      end

      arguments_help_lines = arguments.map do |argument|
        "\t#{argument[:display_name].colorize(:green)}\t#{argument[:desc]}"
      end

      sub_commands_help_lines = sub_commands.map do |sub_command|
        "\t#{sub_command[:names].join(", ").colorize(:green)}\t#{sub_command[:desc]}"
      end

      base = <<-BASE_HELP
      #{desc}

      #{"USAGE:".colorize(:yellow)}
      #{usage}

      #{"FLAGS:".colorize(:yellow)}
      #{options_help_lines.join("\n")}

      BASE_HELP

      args = <<-ARGS_HELP

      #{"ARGUMENTS:".colorize(:yellow)}
      #{arguments_help_lines.join("\n")}

      ARGS_HELP

      sub = <<-SUB_HELP

      #{"SUBCOMMANDS:".colorize(:yellow)}
      #{sub_commands_help_lines.join("\n")}

      SUB_HELP

      if arguments.empty? && sub_commands.empty?
        base
      elsif arguments.empty? && !sub_commands.empty?
        base + sub
      elsif sub_commands.empty? && !arguments.empty?
        base + args
      else
        base + sub + args
      end
    end

    desc <<-DESC
    #{"ncal".colorize(:green)} #{Globals.version}
    A command line utility to see the current Nepali date.
    DESC

    usage <<-USAGE
    \tncal [flags]
    \tncal [subcommand] [flags] [args]
    USAGE

    help short: "-h"
    version "#{"ncal".colorize(:green)} version #{Globals.version}\nwritten with <3 by pes18fan", short: "-v"

    sub "of" do
      desc "Choose the type of calendar to show"
      usage "ncal of [type]"
      help short: "-h"

      argument "type",
        desc: "Type of calendar, must be either 'month' or 'year'",
        type: String

      run do |opts, args|
        if args.all_args.empty?
          puts opts.help_string
        elsif args.type.as(String).chomp.to_s == "month"
          puts Calendar.new(:MONTH).render
        elsif args.type.as(String).chomp.to_s == "year"
          puts Calendar.new(:YEAR).render
        else
          puts "#{"ERROR:".colorize(:red)} Invalid type, it must be either 'month' or 'year'."
        end
      end
    end

    sub "json" do
      desc "Get today's date in json"
      usage "ncal json"
      help short: "-h"

      run do |opts, args|
        if !args.all_args.empty?
          puts opts.help_string
        else
          date = NepaliDate.new

          puts({"year" => date.year, "month" => date.month, "day" => date.day}.to_json)
        end
      end
    end

    run do |opts, args|
      # puts "Today is #{NepaliDate.new.to_s}."
      puts Calendar.new(:MONTH).render
    end
  end
end
