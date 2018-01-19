require 'faker'

module RandomData
  def self.random_paragraphs
    paragraphs = []
    rand(4..6).times do
      paragraphs << random_paragraph
    end

    paragraphs.join("\n\t  ")
  end

  def self.random_paragraph
    sentences = []
    rand(5..8).times do
      sentences << random_sentence
    end

    sentences.join(" ")
  end

  def self.random_sentence
    strings = []
    rand(4..9).times do
      strings << random_word
    end

    sentence = strings.join(" ")
    sentence.capitalize << "."
  end

  def self.random_word
    letters = ('a'..'z').to_a
    letters.shuffle!
    letters[0,rand(3..8)].join
  end

  def self.random_name
    first_name = random_word.capitalize
    last_name = random_word.capitalize
    "#{first_name} #{last_name}"
  end

  def self.random_email
    "#{random_word}@#{random_word}.com"
  end

end
