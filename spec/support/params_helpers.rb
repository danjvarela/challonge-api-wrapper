module ParamsHelpers
  def random_name
    ("a".."z").to_a.sample(8).join
  end

  # really long string
  # useful to be used as tournament id to test response for non-existent tournaments
  def long_id
    "jaksllaksdjalksdjalskdjalskdjaslkdjaslkjslkjfsldkfjslkdjfslkdfjsldkfjskdvsldkjvslkdjflskdjflwkdjf"
  end
end
