require 'pry'

class TokenizeJob < ApplicationJob
  queue_as :default

  def check_for_potential_forms(token)
    # see if token is a potential form
    if token["features"][6].match?(/.+[けせえれて]る/)
      # check it's actually a verb we're dealing with
      if token["features"][0].include?("動詞")
        if token["features"][6].match?(/.+[け]る/)
          return token["features"][6].gsub('ける', 'く')
        elsif token["features"][6].match?(/.+[え]る/)
          return token["features"][6].gsub('える', 'う')
        elsif token["features"][6].match?(/.+[げ]る/)
          return token["features"][6].gsub('げれ', 'ぐ')
        elsif token["features"][6].match?(/.+[せ]る/)
          return token["features"][6].gsub('せる', 'す')
        elsif token["features"][6].match?(/.+[て]る/)
          return token["features"][6].gsub('てる', 'つ')
        elsif token["features"][6].match?(/.+[ね]る/)
          return token["features"][6].gsub('ねる', 'ぬ')
        elsif token["features"][6].match?(/.+[べ]る/)
          return token["features"][6].gsub('べる', 'ぶ')
        elsif token["features"][6].match?(/.+[め]る/)
          return token["features"][6].gsub('める', 'む')
        elsif token["features"][6].match?(/.+[れ]る/)
          return token["features"][6].gsub('れる', 'る')
        end
      end
    end
    return nil
  end

  def check_for_adverbs(token)
    if token["features"][6].match?(/.+と{1}\z/)
      return token["features"][6].gsub('と', '')
    end
    return nil
  end

  def check_for_honorific_prefix(token)
    if token["features"][6].match?(/お{1}\p{Han}+/)
      return token["features"][6].sub('お', '')
    end
    return nil
  end

  def add_missing_words(id, word_to_add)
    imported_text = ImportedText.find(id)
    missing_words = imported_text.missing_words
    missing_words << word_to_add
    imported_text.missing_words = missing_words
    imported_text.save!
  end

  def perform(id)

    position = 0
    
    # Do something later
    puts "Starting tokenization of text"

    ## grab full text, split on paragraph and remove blank spaces and strip leading/trailing whitespace
    full_text_arr = ImportedText.find(id).content.split(/\r\n+/).reject { |s| s.empty? }.map { |s| s.strip }

    # grab twenty paragraphs, join to a string, remove punctuation characters and send to API 
    batch = full_text_arr.shift(50000000).join('')
    payload = {'sentence': batch, 'mode': 'normal'}
    response = RestClient.post 'https://my-kagome.herokuapp.com/a', payload.to_json, :content_type => :json
    json = JSON.parse(response.body)

    batch_length = batch.length

    json["tokens"].each_with_index do |token, index|
      word_to_look_up = token["features"][6]
      puts "Processing token starting at #{token["start"]} / #{batch.length}"
      # tests to pass before considering whether to search dicts and add text entry - token must get true from each conditional
      if (!word_to_look_up.match?(/[\u3000-\u303F]/) && !word_to_look_up.match?(/[*！？＊…。]/) && !word_to_look_up.match?(/^[uFF00-\uFFEF]{1}$/) && !(word_to_look_up.match?(/\p{Hiragana}/) && word_to_look_up.length == 1))
        word_to_save = ''
        word_to_save = JWord.find_by('entry = ? OR reading = ?', word_to_look_up, word_to_look_up) || PNoun.find_by('entry = ? OR reading = ?', word_to_look_up, word_to_look_up)
        if !word_to_save.nil?
          # check for furigana first, if it is kana that is the same meaning as the kanji before it then skip
          if word_to_look_up.match?(/\p{Hiragana}/)
            preceding_kanji_token = json["tokens"][index - 1]
            if preceding_kanji_token["features"][6].match?(/\p{Han}/)
              word_to_check_reading_of = JWord.find_by(entry: preceding_kanji_token["features"][6]) || PNoun.find_by(entry: preceding_kanji_token["features"][6])
              unless word_to_check_reading_of.nil?
                if word_to_check_reading_of.reading == word_to_look_up
                  next
                end
              end
            end
          end
          # it's not furigana then look it up and save the entry to text_entry
          if word_to_save.class == JWord
            text_entry_to_save = TextEntry.new(imported_text_id: id, j_word_id: word_to_save.id, start_position: token['start'], end_position: token['end'])
          else
            text_entry_to_save = TextEntry.new(imported_text_id: id, p_noun_id: word_to_save.id, start_position: token['start'], end_position: token['end'])
          end
          # add info about whether the token is a kanji or kana to the textentry and save it
          word_is_kanji = word_to_look_up.match?(/\p{Han}/)
          word_is_kanji ? text_entry_to_save.found_by_kanji = true : text_entry_to_save.found_by_kanji = false
          text_entry_to_save.save
        else
          # see the token is a potential form or an adverb form. If one returns a string then save the base form as a text entry.
          result = check_for_potential_forms(token) || check_for_adverbs(token) || check_for_honorific_prefix(token)
          unless result.nil?
            word_to_save = JWord.find_by('entry = ? OR reading = ?', result, result)
            if word_to_save.nil?
              add_missing_words(id, word_to_look_up)
              next
            end
            text_entry_to_save = TextEntry.new(imported_text_id: id, j_word_id: word_to_save.id, start_position: token['start'], end_position: token['end'])
            word_is_kanji = word_to_look_up.match?(/\p{Han}/)
            word_is_kanji ? text_entry_to_save.found_by_kanji = true : text_entry_to_save.found_by_kanji = false
            text_entry_to_save.save
          else
            # add the missing words to the imported_text
            add_missing_words(id, word_to_look_up)
          end
        end
      end
    end
  end
end
