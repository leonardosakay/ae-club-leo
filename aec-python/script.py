x = 2
print(x)

mylist = [1, "apple", 3 ,"banana", 4.5]

print(mylist)
print(mylist[0])


cal_lookup = {'apple': 95, 'banana': 105, 'orange': 45}
print(cal_lookup['apple'])

for f in mylist:
    print(f)


def sq_int(x):
  y = x**2
  return y

print(sq_int(3))


y = 5
x = 4
def describe_evenness(x):
  if is_even(x):
    print("It’s even!")
  elif is_odd(x):
    print("It’s odd!")
  else:
    print("It’s neither even nor odd!")

describe_evenness(x)
describe_evenness(y)