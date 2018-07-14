# -*- encoding : ascii-8bit -*-

module CKB
  module ADT

    # Bitcoin style double-hashing merkle tree
    # https://en.bitcoin.it/wiki/Protocol_documentation#Merkle_Trees
    class MerkleTree
      EMPTY_ROOT = SHA3.double('').to_s.freeze

      attr :values

      def initialize(values)
        raise ArgumentError, "values must be enumerable" unless values.respond_to?(:each)
        @values = values.to_a
      end

      def root
        @root ||= hash_row(@values.map {|v|
          SHA3.double(v.respond_to?(:to_proto) ? v.to_proto : v)
        })
      end

      private

      def hash_row(hashes)
        return EMPTY_ROOT if hashes.empty?
        return hashes[0].to_s if hashes.size == 1

        hashes.push(hashes.last) if hashes.size.odd?
        parent_row = []
        loop do
          pair = hashes.shift(2)
          break if pair.empty?
          parent_row.push SHA3.double(pair.join)
        end

        hash_row(parent_row)
      end

    end

  end
end
