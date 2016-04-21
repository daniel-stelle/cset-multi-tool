require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase
  def setup
    @relationship = Relationship.new(worker_id: 1, supervisor_id: 2)
  end

  test 'should be valid' do
    assert @relationship.valid?
  end

  test 'should require a worker_id' do
    @relationship.worker_id = nil
    assert_not @relationship.valid?
  end

  test 'should require supervisor_id' do
    @relationship.supervisor_id = nil
    assert_not @relationship.valid?
  end
end
