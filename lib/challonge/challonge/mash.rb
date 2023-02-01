module Challonge
  class Mash < Hashie::Mash
    include Hashie::Extensions::Mash::SymbolizeKeys
  end
end
