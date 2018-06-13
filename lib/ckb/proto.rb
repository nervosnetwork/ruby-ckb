module CKB
    module Proto
    end
end

protobuf_gen_path = File.expand_path('../core_pb.rb', __FILE__)
CKB::Proto.module_eval(File.read(protobuf_gen_path))