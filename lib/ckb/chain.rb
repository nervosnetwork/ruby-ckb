module CKB
  class Chain
    attr_reader :head, :genesis

    def initialize
      @head = @genesis = Core::Block.genesis

      init_db
      init_indexer
    end

    def add_block(blk)
      # TODO: validate blk

      if @db.include?(blk.parent_hash)
        @db[blk.hash] = blk

        if blk.parent_hash == head.hash # new block on main fork
          update_index_head(@head.hash, blk)
          @head = blk
        else # new block on some other forks
          # TODO: add block and apply fork choice rules
        end
      else # there's gap between new blk and our heads
        # TODO: fetch blocks. should just raise exceptions here
      end
    end

    private

    def init_db
      @db = {} # mapping: hash => block
      @db[@head.hash] = @head
    end

    def init_indexer
      @indexer = {} # mapping: head_hash => block_index(height => hash)
      index = [@head]
      @indexer[@head.hash] = index
    end

    def update_index_head(index_key, blk)
      index = @indexer[index_key]
      raise ArgumentError, "invalid new head: new height=#{blk.height}, current height=#{index.last.height}" if blk.height != index.last.height + 1

      index.push blk
      @indexer[blk.hash] = index
      @indexer.delete(index_key)
    end
  end
end
