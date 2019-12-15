namespace :import do
  require 'pry'

  desc "add rank to JWords from tsv file"
  task add_rank: :environment do 
    filename = File.join Rails.root, "BCCWJ_frequencylist_suw_ver1_0.tsv"
    CSV.foreach(filename, col_sep: "\t", quote_char: nil, headers: :first_row) do |row|
      jword = JWord.find_by(entry: row['lemma'])
      if jword
        puts "adding rank for #{jword.entry}"
        jword.cwj_rank = row['rank']
        jword.save
        puts "#{row['rank']} rank added!"
      end
    end
  end

  desc "add rank to missing words"
  task add_rank_where_missing: :environment do 
    JWord.all.each do |word|
      if word.cwj_rank.nil?
        # see if there is a row with same entry, but with frequency frank
        word_with_rank = JWord.where(entry: word.entry).where.not(cwj_rank: nil)
        # if above is not a blank array, see if there are other rows with same entry
        unless word_with_rank.empty?
          words_without_rank = JWord.where(entry: word.entry).where(cwj_rank: nil)
          unless words_without_rank.empty?
            words_without_rank.each do |unranked_word|
              unranked_word.cwj_rank = word_with_rank[0].cwj_rank
              puts "added rank to #{unranked_word.entry}- ID: #{unranked_word.id}"
              unranked_word.save
            end
          end
        end
      end
    end
  end
end