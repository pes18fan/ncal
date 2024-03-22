class Globals
  # Version of the program.
  @@version : String = {{ `shards version #{__DIR__}`.chomp.stringify }}

  # Length of each BS month from 2000 BS to 2090 BS.
  # Taken from https://github.com/kanchudeep/BikramSambat.
  @@month_length : Hash(Int32, Array(Int32)) = {
      2000 => [30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31], 2001 => [31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30], 2002 => [31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30], 2003 => [31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31], 2004 => [30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31], 2005 => [31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30], 2006 => [31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30], 2007 => [31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31], 2008 => [31, 31, 31, 32, 31, 31, 29, 30, 30, 29, 29, 31], 2009 => [31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
 			2010 => [31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30], 2011 => [31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31], 2012 => [31, 31, 31, 32, 31, 31, 29, 30, 30, 29, 30, 30], 2013 => [31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30], 2014 => [31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30], 2015 => [31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31], 2016 => [31, 31, 31, 32, 31, 31, 29, 30, 30, 29, 30, 30], 2017 => [31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30], 2018 => [31, 32, 31, 32, 31, 30, 30, 29, 30, 29, 30, 30], 2019 => [31, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31],
 			2020 => [31, 31, 31, 32, 31, 31, 30, 29, 30, 29, 30, 30], 2021 => [31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30], 2022 => [31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 30], 2023 => [31, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31], 2024 => [31, 31, 31, 32, 31, 31, 30, 29, 30, 29, 30, 30], 2025 => [31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30], 2026 => [31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31], 2027 => [30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31], 2028 => [31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30], 2029 => [31, 31, 32, 31, 32, 30, 30, 29, 30, 29, 30, 30],
 			2030 => [31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31], 2031 => [30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31], 2032 => [31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30], 2033 => [31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30], 2034 => [31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31], 2035 => [30, 32, 31, 32, 31, 31, 29, 30, 30, 29, 29, 31], 2036 => [31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30], 2037 => [31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30], 2038 => [31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31], 2039 => [31, 31, 31, 32, 31, 31, 29, 30, 30, 29, 30, 30],
 			2040 => [31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30], 2041 => [31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30], 2042 => [31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31], 2043 => [31, 31, 31, 32, 31, 31, 29, 30, 30, 29, 30, 30], 2044 => [31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30], 2045 => [31, 32, 31, 32, 31, 30, 30, 29, 30, 29, 30, 30], 2046 => [31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31], 2047 => [31, 31, 31, 32, 31, 31, 30, 29, 30, 29, 30, 30], 2048 => [31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30], 2049 => [31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 30],
 			2050 => [31, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31], 2051 => [31, 31, 31, 32, 31, 31, 30, 29, 30, 29, 30, 30], 2052 => [31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30], 2053 => [31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 30], 2054 => [31, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31], 2055 => [31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30], 2056 => [31, 31, 32, 31, 32, 30, 30, 29, 30, 29, 30, 30], 2057 => [31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31], 2058 => [30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31], 2059 => [31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
 			2060 => [31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30], 2061 => [31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31], 2062 => [30, 32, 31, 32, 31, 31, 29, 30, 29, 30, 29, 31], 2063 => [31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30], 2064 => [31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30], 2065 => [31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31], 2066 => [31, 31, 31, 32, 31, 31, 29, 30, 30, 29, 29, 31], 2067 => [31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30], 2068 => [31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30], 2069 => [31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
 			2070 => [31, 31, 31, 32, 31, 31, 29, 30, 30, 29, 30, 30], 2071 => [31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30], 2072 => [31, 32, 31, 32, 31, 30, 30, 29, 30, 29, 30, 30], 2073 => [31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31], 2074 => [31, 31, 31, 32, 31, 31, 30, 29, 30, 29, 30, 30], 2075 => [31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30], 2076 => [31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 30], 2077 => [31, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31], 2078 => [31, 31, 31, 32, 31, 31, 30, 29, 30, 29, 30, 30], 2079 => [31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
 			2080 => [31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 30], 2081 => [31, 31, 32, 32, 31, 30, 30, 30, 29, 30, 30, 30], 2082 => [30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 30, 30], 2083 => [31, 31, 32, 31, 31, 30, 30, 30, 29, 30, 30, 30], 2084 => [31, 31, 32, 31, 31, 30, 30, 30, 29, 30, 30, 30], 2085 => [31, 32, 31, 32, 30, 31, 30, 30, 29, 30, 30, 30], 2086 => [30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 30, 30], 2087 => [31, 31, 32, 31, 31, 31, 30, 30, 29, 30, 30, 30], 2088 => [30, 31, 32, 32, 30, 31, 30, 30, 29, 30, 30, 30], 2089 => [30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 30, 30],
 			2090 => [30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 30, 30]
  }

  # Mapping of first day of every BS year from 2000 to 2090 (Baisakh 1) to its English date.
  @@first_day : Hash(Int32, Time) = {
     2000 => Time.utc(1943, 4, 13),
     2001 => Time.utc(1944, 4, 13),
     2002 => Time.utc(1945, 4, 13),
     2003 => Time.utc(1946, 4, 13),
     2004 => Time.utc(1947, 4, 14),
     2005 => Time.utc(1948, 4, 13),
     2006 => Time.utc(1949, 4, 13),
     2007 => Time.utc(1950, 4, 13),
     2008 => Time.utc(1951, 4, 14),
     2009 => Time.utc(1952, 4, 13),
     2010 => Time.utc(1953, 4, 13),
     2011 => Time.utc(1954, 4, 13),
     2012 => Time.utc(1955, 4, 14),
     2013 => Time.utc(1956, 4, 13),
     2014 => Time.utc(1957, 4, 13),
     2015 => Time.utc(1958, 4, 13),
     2016 => Time.utc(1959, 4, 14),
     2017 => Time.utc(1960, 4, 13),
     2018 => Time.utc(1961, 4, 13),
     2019 => Time.utc(1962, 4, 13),
     2020 => Time.utc(1963, 4, 14),
     2021 => Time.utc(1964, 4, 13),
     2022 => Time.utc(1965, 4, 13),
     2023 => Time.utc(1966, 4, 13),
     2024 => Time.utc(1967, 4, 14),
     2025 => Time.utc(1968, 4, 13),
     2026 => Time.utc(1969, 4, 13),
     2027 => Time.utc(1970, 4, 14),
     2028 => Time.utc(1971, 4, 14),
     2029 => Time.utc(1972, 4, 13),
     2030 => Time.utc(1973, 4, 13),
     2031 => Time.utc(1974, 4, 14),
     2032 => Time.utc(1975, 4, 14),
     2033 => Time.utc(1976, 4, 13),
     2034 => Time.utc(1977, 4, 13),
     2035 => Time.utc(1978, 4, 14),
     2036 => Time.utc(1979, 4, 14),
     2037 => Time.utc(1980, 4, 13),
     2038 => Time.utc(1981, 4, 13),
     2039 => Time.utc(1982, 4, 14),
     2040 => Time.utc(1983, 4, 14),
     2041 => Time.utc(1984, 4, 13),
     2042 => Time.utc(1985, 4, 13),
     2043 => Time.utc(1986, 4, 14),
     2044 => Time.utc(1987, 4, 14),
     2045 => Time.utc(1988, 4, 13),
     2046 => Time.utc(1989, 4, 13),
     2047 => Time.utc(1990, 4, 14),
     2048 => Time.utc(1991, 4, 14),
     2049 => Time.utc(1992, 4, 13),
     2050 => Time.utc(1993, 4, 13),
     2051 => Time.utc(1994, 4, 14),
     2052 => Time.utc(1995, 4, 14),
     2053 => Time.utc(1996, 4, 13),
     2054 => Time.utc(1997, 4, 13),
     2055 => Time.utc(1998, 4, 14),
     2056 => Time.utc(1999, 4, 14),
     2057 => Time.utc(2000, 4, 13),
     2058 => Time.utc(2001, 4, 14),
     2059 => Time.utc(2002, 4, 14),
     2060 => Time.utc(2003, 4, 14),
     2061 => Time.utc(2004, 4, 13),
     2062 => Time.utc(2005, 4, 14),
     2063 => Time.utc(2006, 4, 14),
     2064 => Time.utc(2007, 4, 14),
     2065 => Time.utc(2008, 4, 13),
     2066 => Time.utc(2009, 4, 14),
     2067 => Time.utc(2010, 4, 14),
     2068 => Time.utc(2011, 4, 14),
     2069 => Time.utc(2012, 4, 13),
     2070 => Time.utc(2013, 4, 14),
     2071 => Time.utc(2014, 4, 14),
     2072 => Time.utc(2015, 4, 14),
     2073 => Time.utc(2016, 4, 13),
     2074 => Time.utc(2017, 4, 14),
     2075 => Time.utc(2018, 4, 14),
     2076 => Time.utc(2019, 4, 14),
     2077 => Time.utc(2020, 4, 13),
     2078 => Time.utc(2021, 4, 14),
     2079 => Time.utc(2022, 4, 14),
     2080 => Time.utc(2023, 4, 14),
     2081 => Time.utc(2024, 4, 13),
     2082 => Time.utc(2025, 4, 14),
     2083 => Time.utc(2026, 4, 14),
     2084 => Time.utc(2027, 4, 14),
     2085 => Time.utc(2028, 4, 13),
     2086 => Time.utc(2029, 4, 14),
     2087 => Time.utc(2030, 4, 14),
     2088 => Time.utc(2031, 4, 15),
     2089 => Time.utc(2032, 4, 14),
     2090 => Time.utc(2033, 4, 14),
  }

  # Name of each BS month.
  @@month_name : Array(String) = [
    "Baisakh",
    "Jestha",
    "Asaar",
    "Shrawan",
    "Bhadra",
    "Ashoj",
    "Kartik",
    "Mangsir",
    "Poush",
    "Magh",
    "Falgun",
    "Chaitra",
  ]

  def self.version
    @@version
  end

  def self.month_length
    @@month_length
  end

  def self.first_day
    @@first_day
  end

  def self.month_name
    @@month_name
  end
end