print "出力したい上限の数を入力してください >"
limit_number = gets.to_i

for num in 1..limit_number
  if num % 3 == 0
    puts "Fizz"
  elsif num % 5 == 0
    puts "Buzz"
  elsif num % 15 == 0
    puts "FizzBuzz"
  else
    puts num
  end
end