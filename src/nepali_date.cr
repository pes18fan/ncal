class NepaliDate
  def initialize(@year : Int32, @month : Int32, @day : Int32)
  end

  def initialize(gregorian : Time)
    date = from_gregorian(gregorian)

    @year = date[:year]
    @month = date[:month]
    @day = date[:day]
  end

  def initialize
    date = from_gregorian(Time.utc)

    @year = date[:year]
    @month = date[:month]
    @day = date[:day]
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
    # Baisakh is set as 1, not 0
    nep_month = 1
    nep_day = 0

    # English date that falls on first day of the nep_year
    first_day_of_nep_year = Globals.first_day[nep_year]

    # Difference in days between the input date and first_day_of_nep_year
    # This must always be positive.
    gregorian_day_gap = (gregorian - first_day_of_nep_year).days

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

    {year: nep_year, month: nep_month, day: nep_day.to_i32}
  end

  def to_s
    "#{Globals.month_name[@month - 1]} #{@day}, #{@year}"
  end
end
