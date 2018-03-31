class TrickyCalculator 
  @@mapping_mixed_keys = {}

  def self.find_missing(exp)
    expression, result = exp.split("=")
    result.strip!
    
    expression_array = expression.strip.split("")

    expression_array.each_with_index do |exp_num, index|
      expression_array2 = expression_array.dup
      [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, "+", "-", "/", "*"].each do |replace_num|
        expression_array2[index] = replace_num

        if index == 0 || index == expression_array2.length - 1
          ["/", "*"].include?(replace_num) ? next : ""
        end

        if index == expression_array2.length - 1
          [ "+", "-","/", "*"].include?(replace_num) ? next : " "
        end

        test_result = expression_array2.join("")

        if test_result.include?("+/") || test_result.include?("+-") || test_result.include?("+*") || 
          test_result.include?("-/") || test_result.include?("-+") || test_result.include?("-*") || 
          test_result.include?("*/") || test_result.include?("*-") || test_result.include?("*+") || 
          test_result.include?("/+") || test_result.include?("/-") || test_result.include?("/*")

          next
        end
        
        test_result = eval(test_result) rescue 0

        if (test_result == result.to_i)
          puts "#{expression_array2.join("")} "
          puts "#{eval(expression_array2.join(""))} "
          @@mapping_mixed_keys[exp_num] = replace_num
          puts @@mapping_mixed_keys.inspect
          puts "**"

          next
        end
      end
    end
  end



end


TrickyCalculator.find_missing("123    = 3")
TrickyCalculator.find_missing("8423   = 252")
TrickyCalculator.find_missing("4+4    = 8")
TrickyCalculator.find_missing("4*7-10 = 417")
TrickyCalculator.find_missing("9/3    = 3")
TrickyCalculator.find_missing("42-9   = -36")
puts "&&&&"
puts TrickyCalculator.mapping_mixed_keys.inspect

# ***********
# Instructions
# Please write two software programs, one in your strongest language and the other in a new language that you have little experience of that solve the following problem.
# Please include instructions on how your solutions should be run, versions of frameworks and copies of the input/output files.


# The problem
# 2 keys on a calculator (1, 2, 3, 4, 5, 6, 7, 8, 9, 0, +, -, /, *) have been switched resulting in the following incorrect arithmetic expressions. The outputs (on the right of the ‘=’) are correct but the inputs (on the left of the ‘=’) are incorrect.
# We need to identify which 2 have been switched.

# 123    = 3
# 8423   = 252
# 4+4    = 8
# 4*7-10 = 417
# 9/3    = 3
# 42-9   = -36

