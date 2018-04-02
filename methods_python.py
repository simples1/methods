import re

class TrickyCalculator:
  mapping_correct_keys = {}

  @classmethod
  def testing(cls, exp):
    exp = exp.replace(" ", "").replace("=","")
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

          test_result = eval(test_result)
          print(test_result)



TrickyCalculator.testing("12+56 = 3")