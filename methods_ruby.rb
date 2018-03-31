class TrickyCalculator 
  @@mapping_correct_keys = {}

  def self.find_missing(exp)
    expression, result = exp.split("=")
    expression_array = expression.strip.split("")

    expression_array.each_with_index do |exp_num, index|
      expression_array2 = expression_array.dup
      [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, "+", "-", "/", "*"].each do |replace_num|
        invalid_epx = ""

        if index == 0 || index == expression_array2.length - 1
          ["/", "*"].include?(replace_num) ? next : ""
        end

        if index == expression_array2.length - 1
          [ "+", "-","/", "*"].include?(replace_num) ? next : " "
        end

        expression_array2[index] = replace_num
        test_result = expression_array2.join("")

        ["+/", "+-", "+*", "-/", "-+", "-*", "*/", "/*"].each do |error_pair|
          test_result.include?(error_pair) ? invalid_epx = true : ""
        end
        
        if invalid_epx != true 
          test_result = eval(test_result) rescue 0

          if (test_result == result.strip.to_i)
            @@mapping_correct_keys[exp_num] = replace_num
            next
          end
        end
      end
    end
  end

  def self.mapping_correct_keys
    @@mapping_correct_keys.select { |key, value| key.to_s != value.to_s }
  end
end


TrickyCalculator.find_missing("123    = 3")
TrickyCalculator.find_missing("8423   = 252")
TrickyCalculator.find_missing("4+4    = 8")
TrickyCalculator.find_missing("4*7-10 = 417")
TrickyCalculator.find_missing("9/3    = 3")
TrickyCalculator.find_missing("42-9   = -36")

puts "These 2 keys have been switched around #{TrickyCalculator.mapping_correct_keys}"


