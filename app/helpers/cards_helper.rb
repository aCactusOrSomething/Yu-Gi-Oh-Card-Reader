module CardsHelper

  # TODO: 2-word keywords do not work as currently implemented.
  # TODO: move this to a seperate file.
  KEYWORDS = {
    "monster"=> "https://yugipedia.com/wiki/Monster_Card",
    "spell"=> "https://yugipedia.com/wiki/Spell_Card",
    "trap"=> "https://yugipedia.com/wiki/Trap_Card",
    "dark"=> "https://yugipedia.com/wiki/DARK",
    "divine"=> "https://yugipedia.com/wiki/DIVINE",
    "earth"=> "https://yugipedia.com/wiki/EARTH",
    "fire"=> "https://yugipedia.com/wiki/FIRE",
    "light"=> "https://yugipedia.com/wiki/LIGHT",
    "water"=> "https://yugipedia.com/wiki/WATER",
    "wind"=> "https://yugipedia.com/wiki/WIND",
    "pendulum"=> "https://yugipedia.com/wiki/Pendulum",
    "normal"=> "https://yugipedia.com/wiki/Normal",
    "effect"=> "https://yugipedia.com/wiki/Effect",
    "ritual"=> "https://yugipedia.com/wiki/Ritual_Monster",
    "fusion"=> "https://yugipedia.com/wiki/Fusion_Monster",
    "synchro"=> "https://yugipedia.com/wiki/Synchro_Monster",
    "xyz"=> "https://yugipedia.com/wiki/Xyz_Monster",
    "link"=> "https://yugipedia.com/wiki/Link_Monster",
    "special"=> "https://yugipedia.com/wiki/Special_Summon",
    "tuner"=> "https://yugipedia.com/wiki/Tuner_monster",
    "flip"=> "https://yugipedia.com/wiki/Flip_monster",
    "toon"=> "https://yugipedia.com/wiki/Toon_monster",
    "spirit"=> "https://yugipedia.com/wiki/Spirit_monster",
    "union"=> "https://yugipedia.com/wiki/Union_monster",
    "gemini"=> "https://yugipedia.com/wiki/Gemini_monster",
    "excavate"=> "https://yugipedia.com/wiki/Excavate",
    "counter"=> "https://yugipedia.com/wiki/Counter",
    "counters"=> "https://yugipedia.com/wiki/Counter",
    "aqua"=> "https://yugipedia.com/wiki/Aqua",
    "beast"=> "https://yugipedia.com/wiki/Beast",
    "beast-warrior"=> "https://yugipedia.com/wiki/Beast-Warrior",
    "cyberse"=> "https://yugipedia.com/wiki/Cyberse",
    "dinosaur"=> "https://yugipedia.com/wiki/Dinosaur",
    "divine-beast"=> "https://yugipedia.com/wiki/Divine-Beast",
    "dragon"=> "https://yugipedia.com/wiki/Dragon",
    "fairy"=> "https://yugipedia.com/wiki/Fairy",
    "fiend"=> "https://yugipedia.com/wiki/Fiend",
    "fish"=> "https://yugipedia.com/wiki/Fish",
    "illusion"=> "https://yugipedia.com/wiki/Illusion",
    "insect"=> "https://yugipedia.com/wiki/Insect",
    "machine"=> "https://yugipedia.com/wiki/Machine",
    "plant"=> "https://yugipedia.com/wiki/Plant",
    "psychic"=> "https://yugipedia.com/wiki/Psychic",
    "pyro"=> "https://yugipedia.com/wiki/Pyro",
    "reptile"=> "https://yugipedia.com/wiki/Reptile",
    "rock"=> "https://yugipedia.com/wiki/Rock",
    "sea serpent"=> "https://yugipedia.com/wiki/Sea_Serpent", #NOT VALID
    "spellcaster"=> "https://yugipedia.com/wiki/Spellcaster",
    "thunder"=> "https://yugipedia.com/wiki/Thunder",
    "warrior"=> "https://yugipedia.com/wiki/Warrior",
    "winged beast"=> "https://yugipedia.com/wiki/Winged_Beast", #NOT VALID
    "wyrm"=> "https://yugipedia.com/wiki/Wyrm",
    "zombie"=> "https://yugipedia.com/wiki/Zombie",
    "level"=> "https://yugipedia.com/wiki/Level",
    "rank"=> "https://yugipedia.com/wiki/Rank",
    "link rating"=> "https://yugipedia.com/wiki/Link_Rating", #NOT VALID
    "pendulum scale"=> "https://yugipedia.com/wiki/Pendulum_Scale", #NOT VALID
    "atk"=> "https://yugipedia.com/wiki/ATK",
    "def"=> "https://yugipedia.com/wiki/DEF",
    "continuous"=> "https://yugipedia.com/wiki/Continuous_Effect",
    "equip"=> "https://yugipedia.com/wiki/Equip_Spell_Card",
    "field"=> "https://yugipedia.com/wiki/Field_Spell_Card",
    "quick-play"=> "https://yugipedia.com/wiki/Quick-Play_Spell_Card",
    "ritual"=> "https://yugipedia.com/wiki/Ritual_Spell_Card",
    "token"=> "https://yugipedia.com/wiki/Monster_Token",
    "lp"=> "https://yugipedia.com/wiki/LP",
    "damage"=> "https://yugipedia.com/wiki/Damage",
    "face-down"=> "https://yugipedia.com/wiki/Face-down",
    "face-up"=> "https://yugipedia.com/wiki/Face-up",
    "control"=> "https://yugipedia.com/wiki/Control",
    "controls"=> "https://yugipedia.com/wiki/Control",
    "owner"=> "https://yugipedia.com/wiki/Owner",
  }

  ABBREVIATIONS = {
    "atk"=> "attack",
    "def"=> "defense",
    "lp"=> "life points",
    "gy"=> "graveyard",
    # because of the way i'm reading strings,
    # "ATK/DEF" cannot easily be read as a keyword
    # this is a duct tape solution but it works fine enough
    "atkdef"=> "attack and defense" 
  }

  # splits a string into an array of strings, based on specified delimiters.
  # ignores when those delimiters are within double quotation marks("").
  # str: the input string
  # start_delims: delimiters that will cause a split BEFORE the character
  # end_delims: delimiters that will cause a split AFTER the character
  def splitOnCharsQuotesafe str, start_delims: [], end_delims: []

    ret = []
    quoted = false
    current = ''

    str.each_char do |c|
      if c == "\""
        quoted = !quoted
      end

      if (start_delims.include? c) && (!quoted)
        ret.push current
        current = ''
      end

      current = current + c

      if (end_delims.include? c) && (!quoted)
        ret.push current
        current = ''
      end
    end
    ret.push current
    ret
  end

  # the following functions break the card text into smaller chunks:
  # text --> sentences --> clauses --> words
  def getSentences text
    splitOnCharsQuotesafe(text.strip, start_delims: ["●"], end_delims: [".", "\n"])
  end

  def getClauses sentence
    splitOnCharsQuotesafe(sentence.strip, start_delims: [], end_delims: [":", ";"])
  end

  def getWords clause
    clause.strip.split(/\s/)
  end

  def wordsToClause words
    ret = ""
    for w in words
      ret += w + " "
    end
    ret
  end

  # search an array of Words for matching Targets in a hash, and applies a Transform function to them.
  # if transformFirst is specified, then that function will be applied instead of Transform on
  # the first instance of a match, and Transform will apply to all subsequent matches.
  # words: list of words that may contain individual words to be transformed.
  # targets: a hash. keys represent targeted words to be transformed, and values represent additional data necessary for the transform functions.
  # transform: a function that takes a value associated with the targets hash and returns something that will replace the targeted word.
  # transformFirst: the same as transform, but only applies to the first appearance of a specific word.
  # visited: a list of transformations that have already been applied - meant to help with transformFirst.
  def applyTransformations words, targets, transform, transformFirst: nil, visited: []
    puts "visited: #{visited}"
    ret = []
    for word in words
      sanitized_word = word.strip.downcase.gsub(/[.,\/\#!$%\^&\*;:{}=\_`~()]/, "")
      if (targets.key? sanitized_word)
        if (transformFirst == nil) || (visited.include? sanitized_word)
          word = transform.call(word, targets[sanitized_word])
        else
          visited.append(sanitized_word)
          word = transformFirst.call(word, targets[sanitized_word])
        end
      end
      ret.append(word)
    end
    [ret, visited]
  end

  def applyKeyWords words
    # transform in this case shouldn't actually transform the word anymore! ain't that weird.
    @keyWordList = []
    def transform word, keyword
      @keyWordList.append "<li><a href=\"#{keyword}\">#{word}</a></li>"
      word
    end
    [applyTransformations(words, KEYWORDS, method(:transform))[0], @keyWordList]
  end

  def applyAbbreviations words, visitedAbbreviations: []
    def transform abbr, fullWord
      "<abbr title=\"#{fullWord}\">#{abbr}</abbr>"
    end

    def transformFirst abbr, fullWord
      "#{transform(abbr, fullWord)} <i>(#{fullWord})</i>"
    end
    applyTransformations(words, ABBREVIATIONS, method(:transform), transformFirst: method(:transformFirst), visited: visitedAbbreviations)
  end

  # analyzes the card, applies some formatting and detects some information,
  # and returns a nested collection of text segments to be used when rendering.
  def analyzeCardDesc desc
    sentences = getSentences(desc)
    segments = []
    visitedAbbreviations = []
    sentences.each do |sentence|
      clauses = getClauses(sentence)
      newClauses = []
      clauses.each do |clause|
        words = getWords(clause)
        words, visitedAbbreviations = applyAbbreviations(words, visitedAbbreviations: visitedAbbreviations)
        words, keyWordList = applyKeyWords(words)

        newClauses.append wordsToClause(words)
      end
      segments.append newClauses
    end
    segments
  end
end
