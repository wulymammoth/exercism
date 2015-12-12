require IEx

defmodule Roman do
  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t
  def numerals(number) do
    { number, 0 }
    # |> thousands
    # |> five_hunds
    # |> centrums
    # |> fifties
    # |> tens
    # |> fives
    |> ones
    |> elem(1)
  end

  def roman_concat(char, multiplier, str \\ "") do
    Enum.reduce 1..multiplier, str, fn(_count, acc) ->
      acc <> char
    end
  end

  def remainder(num_tup, divisor) do
    { num, div } = num_tup
    multiples    = multiplier(num_tup, divisor)

    num - (divisor * multiples)
  end

  def multiplier(num_tup, divisor) do
    { num, _str } = num_tup

    num / divisor |> Float.floor |> round
  end

  # 800 => DCCC
  # 900 => CM vs DCCCC

  # 8 => VIII vs IIX
  # 9 => VIIII vs IX

  def thousands(num_tup) do
    { remainder(num_tup, 1000), roman_concat("M", multiplier(num_tup, 1000)) }
  end

  def five_hunds(num_tup) do
    { remainder(num_tup, 500), roman_concat("D", multiplier(num_tup, 500)) }
  end

  def centrums(num_tup) do
    { remainder(num_tup, 100), roman_concat("C", multiplier(num_tup, 100)) }
  end

  def fifties(num_tup) do
    { remainder(num_tup, 50), roman_concat("L", multiplier(num_tup, 50)) }
  end

  def tens(num_tup) do
    { remainder(num_tup, 10), roman_concat("X", multiplier(num_tup, 10)) }
  end

  def fives(num_tup) do
    { remainder(num_tup, 5), roman_concat("V", multiplier(num_tup, 5)) }
  end

  def ones(num_tup) do
    { remainder(num_tup, 1), roman_concat("I", multiplier(num_tup, 1)) }
  end

  # cond do
  #   number < 4 ->
  #     Enum.reduce 1..number, "", fn num, acc -> acc <> "I" end
  #   number < 5 ->
  #     numerals(5 - number) <> "V"
  #   number == 5 ->
  #     "V"
  #   number > 5 and number < 10 ->
  #     "V" <> numerals(number - 5)
  # end
end