module CKB
  # Manages the block DAG
  class Chain
    attr_reader :head, :genesis

    def initialize
      @head = @genesis = Core::Block.genesis

      @store = DB::Chain.new(DB::Memory.new)
      @store.put @head
      @store.commit

      @fork = DB::Fork.new(DB::Memory.new)
      @fork.put @head
      @fork.commit
    end

    def add_block!(blk)
      verify_block!(blk)

      if @store.has_header?(blk.parent_hash)
        @store.put blk

        if blk.parent_hash == head.hash # new block on main fork
          @fork.put blk
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

    def verify_block!(blk)
      #TODO
    end

    def find(id)
        case id
        when Integer # find in main fork
          raise NotImplementedError
        when String # find in DAG
            @store.get_block id
        else
            raise ArgumentError, "id must be block number or block hash"
        end
    end

    private

    def logger
      @logger ||= CKB.get_logger(self.class.name)
    end

  end
end
