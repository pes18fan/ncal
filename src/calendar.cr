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
  def render(date : NepaliDate = NepaliDate.new)
    if @type == CalendarType::MONTH
      render_month(date, true)
    elsif @type == CalendarType::YEAR
      month = date.month - 1

      String.build do |str|
        12.times do |i|
          first_day = Globals.first_day[date.year]
          days_to_add = 0.days

          i.times do |j|
            days_to_add += Globals.month_length[date.year][j].days
          end

          first_day_of_week = (first_day + days_to_add).day_of_week

          date = NepaliDate.new(date.year, i + 1, 1, first_day_of_week)

          if i == month
            str << render_month(date, true)
          else
            str << render_month(date, false)
          end

          str << "\n\n"
        end
      end
    end
  end

  private def render_month(date : NepaliDate, highlight_day : Bool)
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
            if highlight_day
              str << day.to_s.colorize(:green)
            else
              str << day.to_s
            end
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

        # Occasionally, the last few days of the month may not be shown because
        # of the way the number of weeks is calculated. This if statement compensates
        # for that.
        if day < days_in_month && i == num_weeks - 1
          ((days_in_month - day) + 1).times do |i|
            str << day + i
            str << " " * element_spacing
          end
        end
      end
    end

    str
  end
end
