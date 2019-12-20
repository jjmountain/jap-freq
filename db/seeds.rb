# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# require 'pry'

# tags = JSON.parse(File.read('./db/tag_bank_1.json'));

# pos_hash = {}
# other_tags_hash = {}

# tags.each do |tag|
#   if tag[1] == 'partOfSpeech'
#     pos_hash[tag[0]] = tag[3]
#   else
#     other_tags_hash[tag[0]] = tag[3]
#   end
# end


# # puts "Destroying JWords"
# # JWord.destroy_all

# # puts "Destroying Meta Tags"
# # MetaTag.destroy_all

# puts "Creating Meta Tags"

# pos_hash.each do |entry|
#   MetaTag.create(
#     tag: entry[0],
#     meaning: entry[1],
#     part_of_speech: true
#   )
# end

# other_tags_hash.each do |entry|
#   MetaTag.create(
#     tag: entry[0],
#     meaning: entry[1]
#   )
# end


def create_entries(json_entries)
  json_entries.each do |word|
    new_entry = JWord.new(
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
        EntryTag.create(
          j_word_id: new_entry.id,
          meta_tag_id: meta_tag[0].id
        )
      end
    end
    unless word[7].empty?
      tags = word[7].split(' ')
      tags.each do |tag|
        # find associated MetaTag object for each meta tag
        meta_tag = MetaTag.where(tag: tag)
        EntryTag.create(
          j_word_id: new_entry.id,
          meta_tag_id: meta_tag[0].id
        )
      end
    end
  end
end

# puts "Creating JWords and Entries for 29 Json files and over 280,000 entries. This could take a while!"

# (1..29).to_a.each do |index|
#   file_path = "./db/term_bank_#{index}.json"
#   file_json = JSON.parse(File.read(file_path))
#   puts "Creating Entries and Entry Tags for file #{index}" 
#   create_entries(file_json)
#   puts "Successfully Created Entries and Entry Tags for file #{index}"
# end






# p file_1

# for each word, create a j_word with entry and english
# 