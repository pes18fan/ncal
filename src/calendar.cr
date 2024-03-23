require "./nepali_date"
require "colorize"

# Used to figure out whether the calendar should show just the month or the
# entire year.
enum CalendarType
  MONTH
  YEAR
end

# Object that represents a calendar.
class Calendar
  def initialize(@type : CalendarType)
  end

  # Return a string representation of the calendar.
  def render
    date = NepaliDate.new

    if @type == CalendarType::MONTH
      # Get the number of days in said month.
      days_in_month = Globals.month_length[date.year][date.month - 1]

      # Number of weeks, necessary to print out just the right number of rows
      num_weeks = (days_in_month / 7.0).ceil.to_i32

      # Placeholder for the current day while rendering.
      day = 1

      # Find out what the weekday was for the first day of the month.
      weekday_of_first_day_of_month = Globals.get_offset_weekday(
        date.day_of_week, -(date.day - 1)
      )

      str = String.build do |str|
        # Spacing between days in well... number of spaces.
        element_spacing = 4

        weekdays_str = String.build do |weekdays|
          weekdays << "Su"
          weekdays << " " * element_spacing
          weekdays << "Mo"
          weekdays << " " * element_spacing
          weekdays << "Tu"
          weekdays << " " * element_spacing
          weekdays << "We"
          weekdays << " " * element_spacing
          weekdays << "Th"
          weekdays << " " * element_spacing
          weekdays << "Fr"
          weekdays << " " * element_spacing
          weekdays << "Sa".colorize(:red)
        end
        month_year_str = "#{Globals.month_name[date.month - 1]} #{date.year}"

        # For some unknown reason Crystal thinks the weekdays_str is 9 characters
        # longer than what it actually is, necessitating this workaround.
        str << month_year_str.center(weekdays_str.size - 9).colorize(:yellow)
        str << "\n"
        str << weekdays_str
        str << "\n"

        num_weeks.times do |i|
          7.times do |j|
            # This gigantic condition is present because of the need to convert
            # the western weekday order (Mon-Sun) to the one used here (Sun-Sat)
            if i == 0 && j + 1 < (weekday_of_first_day_of_month.value % 7) + 1
              str << " "
              str << " " * (element_spacing + 1)
              next
            end

            if day == date.day
              # Color the current day green
              str << day.to_s.colorize(:green)
            elsif (j + 1) % 7 == 0
              # Make Saturdays red
              str << day.to_s.colorize(:red)
            else
              str << day
            end

            # Add appropriate spacing between days, based on the size of the
            # day number as a string. If it is a single-digit, an extra space
            # must be added in the spacing.
            if day < 10
              str << " " * (element_spacing + 1)
            else
              str << " " * element_spacing
            end

            day += 1

            # End the loop after reaching over the last day.
            if day > days_in_month
              break
            end
          end
          str << "\n"
        end
      end

      str
    elsif @type == CalendarType::YEAR
      raise "todo"
    end
  end
end
