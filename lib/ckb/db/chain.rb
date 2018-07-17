module CKB
  module DB
    class Chain
      include Base

      def initialize(db)
        @db = db
      end

      def put(v)
        send "put_#{v.class.name.downcase.gsub("::", "_")}", v
      end

      def put_ckb_core_block(blk)
        @db.put key(blk.header), blk.header.serialize!
        @db.put key(blk), blk.serialize!

        blk.transactions.each do |tx|
          @db.put key(tx),tx.serialize!
        end

        update_p1cs blk
      end

      def put_ckb_core_header(hdr)
        @db.put key(hdr), hdr.serialize!
      end

      def get(k)
        clz(k).decode @db.get(k)
      end

      def get_block(h)
        get blk_key(h)
      rescue
        nil
      end

      def get_header(h)
        get hdr_key(h)
      rescue
        nil
      end

      def get_transaction(h)
        get tx_key(h)
      rescue
        nil
      end

      def get_p1cs(h)
        root_hash = h == SHA3::NULL ?
          ADT::MerklePatriciaTrie::BLANK_ROOT :
          @db.get(p1cs_key(h))
        ADT::MerklePatriciaTrie.new(@db, root_hash)
      rescue
        nil
      end

      def delete(k)
        @db.delete k
      end

      def commit
        @db.commit
      end

      def has_key?(k)
        @db.has_key? k
      end

      def has_value?(v)
        @db.has_key? key(v)
      end

      def has_header?(hdr)
        if hdr.is_a?(String) # header hash
          has_key? "hdr:#{hdr}"
        else
          has_value?(hdr)
        end
      end

      def has_block?(blk)
        if blk.is_a?(String) # block hash
          has_key? "blk:#{blk}"
        else
          has_value?(blk)
        end
      end

      def ==(other)
        other.instance_of?(self.class) && db == other.db
      end

      private

      def update_p1cs(blk)
        p1cs = get_p1cs blk.parent_hash
        txs = blk.transactions.to_a

        add_p1_cells p1cs, txs.shift # cellbase
        txs.each do |tx|
          remove_p1_cells p1cs, tx
          add_p1_cells p1cs, tx
        end

        @db.put p1cs_key(blk.hash), p1cs.root_hash
      end

      def remove_p1_cells(p1cs, tx)
        tx.inputs.each do |input|
          p1cs.delete input.previous_output.to_key
        end
      end

      def add_p1_cells(p1cs, tx)
        txid = tx.hash
        tx.outputs.each_with_index do |_, i|
          op = Core::OutPoint.new(txid: txid, index: i)
          p1cs[op.to_key] = "\x01"
        end
      end

      def p1cs_key(s)
        "p1cs:#{s}"
      end

      def hdr_key(s)
        "hdr:#{s}"
      end

      def blk_key(s)
        "blk:#{s}"
      end

      def tx_key(s)
        "tx:#{s}"
      end

      def key(v)
        case v
        when Core::Header
          hdr_key(v.hash)
        when Core::Block
          blk_key(v.hash)
        when Core::Transaction
          tx_key(v.hash)
        else
          raise ArgumentError, "un-keyable object!"
        end
      end

      def clz(k)
        case k
        when /^hdr:/
          Core::Header
        when /^blk:/
          Core::Block
        when /^tx:/
          Core::Transaction
        else
          raise ArgumentError, "ill-formated key: #{k}"
        end
      end

    end
  end
end
