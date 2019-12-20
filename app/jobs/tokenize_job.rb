class TokenizeJob < ApplicationJob
  queue_as :default

  def perform(id)

    position = 0
    
    # Do something later
    puts "Starting tokenization of text"

    ## grab full text, split on paragraph and remove blank spaces and strip leading/trailing whitespace
    full_text_arr = ImportedText.find(id).content.split(/\r\n+/).reject { |s| s.empty? }.map { |s| s.strip }

    while full_text_arr do
      # grab twenty paragraphs, join to a string, remove punctuation characters and send to API 
      batch = full_text_arr.shift(500).join('')
      puts full_text_arr
      payload = {'sentence': batch, 'mode': 'normal'}
      response = RestClient.post 'https://my-kagome.herokuapp.com/a', payload.to_json, :content_type => :json

      json = JSON.parse(response.body)

      json["tokens"].each do |token|
        
        unless (token["features"][6].match?(/\p{Hiragana}/) && token["features"][6].length == 1) || (token["features"][6].match?(/[\u3000-\u303F]/)) 
          word_to_save = ''
          word_to_look_up = token["features"][6]
          word_to_save = JWord.find_by('entry = ? OR reading = ?', word_to_look_up, word_to_look_up)  
          unless word_to_save.nil?
            TextEntry.create(imported_text_id: id, j_word_id: word_to_save.id, start_position: token['start'], end_position: token['end'])
          else
            p_noun_to_save = PNoun.find_by('entry = ? OR reading = ?', word_to_look_up, word_to_look_up)
            if !p_noun_to_save.nil?
              TextEntry.create(imported_text_id: id, p_noun_id: p_noun_to_save.id,  start_position: token['start'], end_position: token['end'])

            # skip adding Japanese punctuation single characters to missing words
            elsif !word_to_look_up.match?(/^[uFF00-\uFFEF]{1}$/)
              imported_text = ImportedText.find(id)
              missing_words = imported_text.missing_words
              missing_words << word_to_look_up
              imported_text.missing_words = missing_words
              imported_text.save!
            end
          end
        end
      end
    end
  end
end