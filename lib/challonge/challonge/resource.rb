module Challonge
  class Resource < Hashie::Mash
    include Hashie::Extensions::Mash::SymbolizeKeys
  end
end
