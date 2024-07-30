require 'faker'

module Faker
  class Katakana
    KATAKANA_CHARACTERS = 'アイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨラリルレロワヲン'

    def self.random(length = 1)
      Array.new(length) { KATAKANA_CHARACTERS[rand(KATAKANA_CHARACTERS.size)] }.join
    end
  end
end