# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: lib/ckb/core/core.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "CKB.Core.Recipient" do
    optional :module, :uint32, 1
    optional :lock, :bytes, 2
  end
  add_message "CKB.Core.OutPoint" do
    optional :txid, :bytes, 1
    optional :index, :uint32, 2
  end
  add_message "CKB.Core.CellInput" do
    optional :previous_output, :message, 1, "CKB.Core.OutPoint"
    optional :unlock, :bytes, 2
  end
  add_message "CKB.Core.CellOutput" do
    optional :capacity, :uint32, 1
    optional :data, :bytes, 2
    optional :lockhash, :bytes, 3
  end
  add_message "CKB.Core.OperationGrouping" do
    optional :transform_count, :uint32, 1
    optional :destroy_count, :uint32, 2
    optional :create_count, :uint32, 3
  end
  add_message "CKB.Core.Transaction" do
    optional :version, :uint32, 1
    repeated :deps, :message, 2, "CKB.Core.OutPoint"
    repeated :inputs, :message, 3, "CKB.Core.CellInput"
    repeated :outputs, :message, 4, "CKB.Core.CellOutput"
  end
  add_message "CKB.Core.Header" do
    optional :version, :uint32, 1
    optional :parent_hash, :bytes, 2
    optional :timestamp, :uint64, 3
    optional :number, :uint64, 4
    optional :txroot, :bytes, 5
    optional :difficulty, :bytes, 6
    optional :nonce, :uint64, 7
    optional :mix_hash, :bytes, 8
  end
  add_message "CKB.Core.Block" do
    optional :header, :message, 1, "CKB.Core.Header"
    repeated :transactions, :message, 2, "CKB.Core.Transaction"
  end
end

module CKB
  module Core
    Recipient = Google::Protobuf::DescriptorPool.generated_pool.lookup("CKB.Core.Recipient").msgclass
    OutPoint = Google::Protobuf::DescriptorPool.generated_pool.lookup("CKB.Core.OutPoint").msgclass
    CellInput = Google::Protobuf::DescriptorPool.generated_pool.lookup("CKB.Core.CellInput").msgclass
    CellOutput = Google::Protobuf::DescriptorPool.generated_pool.lookup("CKB.Core.CellOutput").msgclass
    OperationGrouping = Google::Protobuf::DescriptorPool.generated_pool.lookup("CKB.Core.OperationGrouping").msgclass
    Transaction = Google::Protobuf::DescriptorPool.generated_pool.lookup("CKB.Core.Transaction").msgclass
    Header = Google::Protobuf::DescriptorPool.generated_pool.lookup("CKB.Core.Header").msgclass
    Block = Google::Protobuf::DescriptorPool.generated_pool.lookup("CKB.Core.Block").msgclass
  end
end
