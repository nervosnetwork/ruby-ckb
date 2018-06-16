module CKB
  # Manages the block DAG
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
          logger.info "main fork -> new head #{@head}"
        else # new block on some other forks
          # TODO: add block and apply fork choice rules
        end
      else # there's gap between new blk and our heads
        # TODO: fetch blocks. should just raise exceptions here
      end

      self
    end

    def find(id)
        case id
        when Integer # find in main fork
            find_in_main(id)
        when String # find in DAG
            id = SHA3.new(id) # validate sha3 hash
            @db[id]
        else
            raise ArgumentError, "id must be block number or block hash"
        end
    end

    def find_in_main(id)
        case id
        when Integer
            get_main_index[id]
        else
            raise NotImplementedError
        end
    end

    private

    def logger
      @logger ||= CKB.get_logger(self.class.name)
    end

    def init_db
      @db = {} # mapping: hash => block
      @db[@head.hash] = @head
    end

    def init_indexer
      @indexer = {} # mapping: head_hash => block_index(number => hash)
      index = [@head]
      @indexer[@head.hash] = index
    end

    def get_main_index
        @indexer[@head.hash]
    end

    def update_index_head(index_key, blk)
      index = @indexer[index_key]
      raise ArgumentError, "invalid new head: new number=#{blk.number}, current number=#{index.last.number}" if blk.number != index.last.number + 1

      index.push blk
      @indexer[blk.hash] = index
      @indexer.delete(index_key)
    end

  end
end
