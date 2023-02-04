module ParamsHelpers
  def random_name(length = 8)
    chars = ("a".."z").to_a + ("A".."Z").to_a + (0..9).to_a
    (0...length).map { chars[rand(chars.length)] }.join
  end
end
