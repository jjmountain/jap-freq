namespace :import do
  require 'pry'
  
  def create_entries_for_p_nouns(json_entries)
    json_entries.each do |word|
      new_entry = PNoun.new(
        entry: word[0],
        english: word[5]
      )
      unless word[1].empty?
        new_entry.reading = word[1] 
      end
      new_entry.save!
      unless word[2].empty?
        tags = word[2].split(' ')
        tags.each do |tag|
          # find associated MetaTag object for each meta tag
          meta_tag = MetaTag.where(tag: tag)
          # binding.pry
          PNounTag.create(
            p_noun_id: new_entry.id,
            meta_tag_id: meta_tag[0].id
          )
        end
      end
      unless word[7].empty?
        tags = word[7].split(' ')
        tags.each do |tag|
          # find associated MetaTag object for each meta tag
          meta_tag = MetaTag.where(tag: tag)
          PNounTag.create(
            p_noun_id: new_entry.id,
            meta_tag_id: meta_tag[0].id
          )
        end
      end
    end
  end

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

  desc "add Name tags to Meta Tags"
  task add_name_tags: :environment do
    tags = JSON.parse(File.read('./db/name-dict/tag_bank_1.json'));
    tags_hash = {}
    tags.each do |tag|
      tags_hash[tag[0]] = tag[3]
    end
    tags_hash.each do |entry|
      MetaTag.create(
        tag: entry[0],
        meaning: entry[1]
      )
      puts "Created Meta Tag for #{entry[0]} #{entry[1]}"
    end
end

  desc "add entires from Names dict"
  task add_proper_nouns: :environment do
    (1..75).to_a.each do |index|
      file_path = "./db/name-dict/term_bank_#{index}.json"
      file_json = JSON.parse(File.read(file_path))
      puts "Creating Entries and Entry Tags for file #{index}" 
      create_entries_for_p_nouns(file_json)
      puts "Successfully Created Entries and Entry Tags for file #{index}"
    end
  end

end