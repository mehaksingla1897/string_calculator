class CalculatorService
 
  def add str
    num_arr = []
    negative_num_arr = []
    last_ch_index = 0
    return 0 if str == ""
    negative_num = []
    positive_num = []
    is_negative_num = false
    str.each_char.with_index do |ch, index|
      unless ("0".."9").include?(ch)
        if positive_num.present?
          val = combine_string_arr_into_num(positive_num)
          num_arr << val if val < 1000
        end
        negative_num_arr << (combine_string_arr_into_num(negative_num) * -1) if negative_num.present?
        negative_num = []
        positive_num = []
        is_negative_num = false
        next
      end
      if str[index - 1] == "-" || is_negative_num 
        negative_num << ch
        is_negative_num = true
        last_ch_index = index
      else
        positive_num << ch
        last_ch_index = index
      end
    end

    raise "Input String Invalid" if last_ch_index != str.length - 1

    if is_negative_num
      negative_num_arr << (combine_string_arr_into_num(negative_num) * -1)
    else
      val = combine_string_arr_into_num(positive_num)
      num_arr << val if val < 1000
    end
    if negative_num_arr.present?
      raise "Negative numbers are not allowed. i.e #{negative_num_arr.inspect}"
    else
      num_arr.sum
    end
      
  end

  def combine_string_arr_into_num str_arr
    number = 0
    str_arr.reverse.each_with_index do |num, index|
      number = number + (num.to_i * (10 ** index))
    end
    number
  end

end