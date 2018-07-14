# -*- encoding : ascii-8bit -*-

module CKB
  module ADT

    # Bitcoin style double-hashing merkle tree
    # https://en.bitcoin.it/wiki/Protocol_documentation#Merkle_Trees
    class MerkleTree
      EMPTY_ROOT = SHA3.double('').freeze

      attr :values

      def initialize(values)
        raise ArgumentError, "values must be enumerable" unless values.respond_to?(:each)
        @values = values.to_a
      end

      def root
        @root ||= generate_root
      end

      private

      def generate_root
        return EMPTY_ROOT if @values.empty?

        hashes = @values.map {|v| SHA3.double(v.respond_to?(:to_proto) ? v.to_proto : v) }

        while hashes.size > 1
          hashes.push(hashes.last) if hashes.size.odd?

          parents = []
          loop do
            pair = hashes.shift(2)
            break if pair.empty?
            parents.push SHA3.double(pair.join)
          end

          hashes = parents
        end

        hashes[0].to_s
      end

    end

  end
end
