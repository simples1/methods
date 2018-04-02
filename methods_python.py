import re

class TrickyCalculator:
  mapping_correct_keys = {}


  @classmethod
  def mapping_correct_keys_meth(cls):
    eureka = {}
    for k, v in cls.mapping_correct_keys.items():
      if str(k) != str(v):
        print(str(k), " equals " , str(v))
        eureka[str(k)] = str(v)

    return eureka

  @classmethod
  def find_missing(cls, exp):
    exp = exp.replace(" ", "").split("=")
    result = exp[1]
    exp = exp[0]

    exp = list(exp)
    keys = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, "+", "-", "/", "*"]

    for idx, val in enumerate(exp):
      new_exp = exp[:]

      for key in keys:
        invalid_epx = ""
        new_exp[idx] = key

        if(idx == 0 or idx == len(exp) - 1):
          if(key in ["/", "*"]):
            continue

        if(idx == len(exp) - 1):
          if(key in [ "+", "-","/", "*"]):
            continue
        
        test_result = ''.join(map(str,new_exp))
        for error_pair in ["+/", "+-", "+*", "-/", "-+", "-*", "*/", "/*"]:

          if(error_pair in test_result):
            invalid_epx = "true"


        if(invalid_epx != "true" ):
          #ignore leading zeros
          test_result = re.sub(r'^0+', "", test_result)
          test_result = re.sub(r'\+0+', "", test_result)
          test_result = re.sub(r'\*0+', "", test_result)
          test_result = re.sub(r'\-0+', "", test_result)
          test_result = re.sub(r'\/0+', "", test_result)

          #insert leading zero for leading operators
          if test_result[0] in [ "+", "-","/", "*"]:
            test_result = "0" + test_result 

          #skip trailing operators
          if(test_result[len(test_result)-1] in [ "+", "-","/", "*"]):
            continue

          test_result = eval(test_result)

          if (int(test_result) == int(result)):
            cls.mapping_correct_keys[val] = key
            break
    

TrickyCalculator.find_missing("123    = 3")
TrickyCalculator.find_missing("8423   = 252")
TrickyCalculator.find_missing("4+4    = 8")
TrickyCalculator.find_missing("4*7-10 = 417")
TrickyCalculator.find_missing("9/3    = 3")
TrickyCalculator.find_missing("42-9   = -36")

print("These 2 keys have been switched around  ",TrickyCalculator.mapping_correct_keys_meth())