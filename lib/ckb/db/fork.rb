module CKB
  module DB
    # Index to forks in chain.
    class Fork
      include Base

      def initialize(db)
        @db = db
      end

      def put(hdr)
        raise ArgumentError, "head #{hdr} already exist!" if get_fork(hdr.hash)

        fork_id = get(hdr.parent_hash)
        delete hdr.parent_hash
        @db.put fork_key(hdr.hash), fork_id
      rescue KeyError
        # hdr's parent is not a fork head, hdr is a new fork
        fork_id = get_next_fork_id
        @db.put fork_key(hdr.hash), fork_id
      end

      # fork:<head_hash> => fork_id
      def get(k)
        @db.get fork_key(k)
      end

      def get_fork(h)
        get(h)
      rescue
        nil
      end

      def get_fork_count
        @db.get "fork:count"
      rescue
        0
      end

      def delete(k)
        @db.delete fork_key(k)
      end

      def commit
        @db.commit
      end

      private

      def fork_key(h)
        "fork:#{h}"
      end

      def get_next_fork_id
        id = get_fork_count
        @db.put "fork:count", id+1
        id
      end

    end
  end
end
