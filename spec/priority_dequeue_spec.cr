require "./spec_helper"

record S, size : UInt32

describe PriorityDequeue do
  it "push and pop min" do
    q = PriorityDequeue(Int32).new

    q.push(54)
    q.push(12)
    q.push(7)
    q.push(23)
    q.push(25)
    q.push(13)

    q.size.should eq 6

    q.pop_min.should eq 7
    q.pop_min.should eq 12
    q.pop_min.should eq 13
    q.pop_min.should eq 23
    q.pop_min.should eq 25
    q.pop_min.should eq 54
  end

  it "push and pop min structs" do
    q = PriorityDequeue(S).new(compare_fn: ->(a : S, b : S) { a.size <=> b.size })

    q.push(S.new(size: 54))
    q.push(S.new(size: 12))
    q.push(S.new(size: 7))
    q.push(S.new(size: 23))
    q.push(S.new(size: 25))
    q.push(S.new(size: 13))

    q.size.should eq 6

    q.pop_min.not_nil!.size.should eq 7
    q.pop_min.not_nil!.size.should eq 12
    q.pop_min.not_nil!.size.should eq 13
    q.pop_min.not_nil!.size.should eq 23
    q.pop_min.not_nil!.size.should eq 25
    q.pop_min.not_nil!.size.should eq 54
  end

  it "push and pop max" do
    q = PriorityDequeue(Int32).new

    q.push(54)
    q.push(12)
    q.push(7)
    q.push(23)
    q.push(25)
    q.push(13)

    q.pop_max.should eq 54
    q.pop_max.should eq 25
    q.pop_max.should eq 23
    q.pop_max.should eq 13
    q.pop_max.should eq 12
    q.pop_max.should eq 7
  end

  it "push and pop same min" do
    q = PriorityDequeue(Int32).new

    q.push(1)
    q.push(1)
    q.push(2)
    q.push(2)
    q.push(1)
    q.push(1)

    q.pop_min.should eq 1
    q.pop_min.should eq 1
    q.pop_min.should eq 1
    q.pop_min.should eq 1
    q.pop_min.should eq 2
    q.pop_min.should eq 2
  end

  it "push and pop same max" do
    q = PriorityDequeue(Int32).new

    q.push(1)
    q.push(1)
    q.push(2)
    q.push(2)
    q.push(1)
    q.push(1)

    q.pop_max.should eq 2
    q.pop_max.should eq 2
    q.pop_max.should eq 1
    q.pop_max.should eq 1
    q.pop_max.should eq 1
    q.pop_max.should eq 1
  end

  it "pop empty" do
    q = PriorityDequeue(Int32).new

    q.pop_min.should be_nil
    q.pop_min.should be_nil
  end

  it "edge case 3 elements" do
    q = PriorityDequeue(Int32).new

    q.push(9)
    q.push(3)
    q.push(2)

    q.pop_min.should eq 2
    q.pop_min.should eq 3
    q.pop_min.should eq 9
  end

  it "edge case 3 elements max" do
    q = PriorityDequeue(Int32).new

    q.push(9)
    q.push(3)
    q.push(2)

    q.pop_max.should eq 9
    q.pop_max.should eq 3
    q.pop_max.should eq 2
  end

  it "peekMin" do
    q = PriorityDequeue(Int32).new

    q.peek_min.should be_nil

    q.push(9)
    q.push(3)
    q.push(2)

    q.peek_min.should eq 2
    q.peek_min.should eq 2
  end

  it "peekMax" do
    q = PriorityDequeue(Int32).new

    q.peek_max.should be_nil

    q.push(9)
    q.push(3)
    q.push(2)

    q.peek_max.should eq 9
    q.peek_max.should eq 9
  end

  it "sift up with odd indices, popMin" do
    q = PriorityDequeue(Int32).new

    items = Int32.static_array(15, 7, 21, 14, 13, 22, 12, 6, 7, 25, 5, 24, 11, 16, 15, 24, 2, 1)
    (items).each do |e|
      q.push(e)
    end

    sorted_items = Int32.static_array(1, 2, 5, 6, 7, 7, 11, 12, 13, 14, 15, 15, 16, 21, 22, 24, 24, 25)
    (sorted_items).each do |e|
      q.pop_min.should eq e
    end
  end

  it "sift up with odd indices, popMax" do
    q = PriorityDequeue(Int32).new

    items = Int32.static_array(15, 7, 21, 14, 13, 22, 12, 6, 7, 25, 5, 24, 11, 16, 15, 24, 2, 1)
    (items).each do |e|
      q.push(e)
    end

    sorted_items = Int32.static_array(25, 24, 24, 22, 21, 16, 15, 15, 14, 13, 12, 11, 7, 7, 6, 5, 2, 1)
    (sorted_items).each do |e|
      q.pop_max.should eq e
    end
  end

  it "update min queue" do
    q = PriorityDequeue(Int32).new

    q.push(55)
    q.push(44)
    q.push(11)
    q.update(55, 5)
    q.update(44, 4)
    q.update(11, 1)
    q.pop_min.should eq 1
    q.pop_min.should eq 4
    q.pop_min.should eq 5
  end

  it "update same min queue" do
    q = PriorityDequeue(Int32).new

    q.push(1)
    q.push(1)
    q.push(2)
    q.push(2)
    q.update(1, 5)
    q.update(2, 4)
    q.pop_min.should eq 1
    q.pop_min.should eq 2
    q.pop_min.should eq 4
    q.pop_min.should eq 5
  end

  it "update max queue" do
    q = PriorityDequeue(Int32).new

    q.push(55)
    q.push(44)
    q.push(11)
    q.update(55, 5)
    q.update(44, 4)
    q.update(11, 1)
    q.pop_max.should eq 5
    q.pop_max.should eq 4
    q.pop_max.should eq 1
  end

  it "update same max queue" do
    q = PriorityDequeue(Int32).new

    q.push(1)
    q.push(1)
    q.push(2)
    q.push(2)
    q.update(1, 5)
    q.update(2, 4)
    q.pop_max.should eq 5
    q.pop_max.should eq 4
    q.pop_max.should eq 2
    q.pop_max.should eq 1
  end

  it "update after pop" do
    q = PriorityDequeue(Int32).new

    q.push(1)
    q.pop_min.should eq 1

    expect_raises(Enumerable::NotFoundError) do
      q.update(1, 1)
    end
  end

  it "dump" do
    q = PriorityDequeue(Int32).new

    q.push(1)
    q.push(1)
    q.push(2)
    q.push(2)

    puts ""
    q.dump(STDOUT)
  end

  it "remove at index" do
    q = PriorityDequeue(Int32).new

    q.add(3)
    q.add(2)
    q.add(1)

    two_idx : UInt32? = nil
    q.each.each_with_index do |elem, index|
      if elem == 2
        two_idx = index.to_u32
        break
      end
    end

    q.del_at(two_idx.not_nil!).should eq 2
    q.pop_min.should eq 1
    q.pop_min.should eq 3
    q.pop_min.should be_nil
  end

  it "iterator while empty" do
    q = PriorityDequeue(Int32).new

    it = q.each
    it.next.should eq Iterator.stop
  end
end
