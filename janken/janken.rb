def janken(game_of_round)
  win_count = 0
  lose_count = 0
  # 勝負回数が0回になるまでループ
  while game_of_round > 0
    # ジャンケンのだし手
    janken_skill = ["g", "c", "p"]
    # 「」回戦開始のコール
    round_call = win_count + lose_count + 1
    puts "#{round_call}本目"
    puts "じゃんけん…(press g or c or p)"
    # プレイヤーの出し手選択
    player_hand = gets.chomp
    # コンピュータの出し手
    cpu_hand = rand(3)
    cpu_hand = janken_skill[cpu_hand]

    case cpu_hand
    when "g"
      puts "CPU...グー"
    when "c"
      puts "CPU...チョキ"
    when "p"
      puts "CPU...パー"
    end

    case player_hand
    when "g"
      puts "あなた...グー"
    when "c"
      puts "あなた...チョキ"
    when "p"
      puts "あなた...パー"
    end
    # 対戦組み合わせの条件分岐
    if player_hand == "g" && cpu_hand == "c"
      puts "勝ち！"
      win_count += 1
      game_of_round -= 1
      next
    elsif player_hand == "g" && cpu_hand == "p"
      puts "負け！"
      lose_count += 1
      game_of_round -= 1
      next
    elsif player_hand == "c" && cpu_hand == "p"
      puts "勝ち！"
      win_count += 1
      game_of_round -= 1
      next
    elsif player_hand == "c" && cpu_hand == "g"
      puts "負け！"
      lose_count += 1
      game_of_round -= 1
      next
    elsif player_hand == "p" && cpu_hand == "g"
      puts "勝ち！"
      win_count += 1
      game_of_round -= 1
      next
    elsif player_hand == "p" && cpu_hand == "c"
      puts "負け！"
      lose_count += 1
      game_of_round -= 1
      next
    elsif player_hand == cpu_hand
      puts "あいこ！"
      next
    end
    puts "#{win_count}勝#{lose_count}敗)"
  end
  if win_count > lose_count
    puts "#{win_count}勝#{lose_count}敗であなたの勝ち"
  else
    puts "#{win_count}勝#{lose_count}敗であなたの負け"
  end
end
