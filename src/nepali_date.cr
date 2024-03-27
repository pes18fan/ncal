# Object that represents a date in Bikram Sambat.
class NepaliDate
  property year : Int32
  property month : Int32
  property day : Int32
  property day_of_week : Time::DayOfWeek

  def initialize(@year : Int32, @month : Int32, @day : Int32, @day_of_week : Time::DayOfWeek)
  end

  def initialize(gregorian : Time)
    date = from_gregorian(gregorian)

    @year = date[:year]
    @month = date[:month]
    @day = date[:day]
    @day_of_week = gregorian.day_of_week
  end

  def initialize
    date = from_gregorian(Time.utc)

    @year = date[:year]
    @month = date[:month]
    @day = date[:day]
    @day_of_week = Time.utc.day_of_week
  end

  private def from_gregorian(gregorian : Time) : NamedTuple(year: Int32, month: Int32, day: Int32)
    year = gregorian.year
    month = gregorian.month
    day = gregorian.day

    nep_year = if gregorian < Globals.first_day[gregorian.year + 57]
                 year + 56
               else
                 year + 57
               end

    # Initial values
    # Do note that Baisakh is set as 1, the value 0 here is just a placeholder
    nep_month = 0
    nep_day = 0

    # English date that falls on first day of the nep_year
    first_day_of_nep_year = Globals.first_day[nep_year]

    # Difference in days between the input date and first_day_of_nep_year
    # This must always be positive.
    gregorian_day_gap = (gregorian - first_day_of_nep_year).days.to_i32

    # The value above is used to calculate the exact Nepali day by subtracting
    # the number of days of each month from it till it is less than the number
    # of days of the current month.
    Globals.month_length[nep_year].each_with_index do |days, i|
      if gregorian_day_gap < days
        nep_month = i + 1
        nep_day = gregorian_day_gap + 1
        break
      end

      gregorian_day_gap -= days
    end

    # nep_day is converted to Int32 as it may be either Int32 or Int64.
    {year: nep_year, month: nep_month, day: nep_day}
  end

  def to_s
    "#{Globals.month_name[@month - 1]} #{@day}, #{@year}"
  end
end
