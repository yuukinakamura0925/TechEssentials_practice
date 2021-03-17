def bubble_sort(nums)
  # 要素数10件
  len_nums = nums.size
  # limitが左にずれていく繰り返し処理
  for i in 0..(len_nums - 1)
    # limitに辿り着くまで隣同士の数値の比較を行う
    for j in 0..(len_nums - 2 - i)
      # 左の数値が大きかったら
      if nums[j] > nums[j + 1]
        # 左の数値を右に、右の数値を左に入れ替える
        nums[j], nums[j + 1] = nums[j + 1], nums[j]
      end
      # endなので次の隣通しの比較を行う
    end
    # endなのでlimitが左にずれる
  end
  return nums
end

# main
nums = [10, 8, 3, 5, 2, 4, 11, 18, 20, 33]
puts bubble_sort(nums)
