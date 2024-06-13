class PriorityDequeue(T)
  include Indexable(T)

  VERSION = "0.1.0"

  @items : Pointer(T)

  getter cap : UInt32 = 0

  getter size : UInt32 = 0

  @compare_fn : Proc(T, T, Int32)

  def initialize(@cap : UInt32 = 0, @compare_fn = ->(a : T, b : T) { a <=> b })
    if cap == 0
      @items = Pointer(T).null
    else
      @items = Pointer(T).malloc(cap)
    end
  end

  def unsafe_fetch(index) : T
    @items[index]
  end

  # Add a new element, maintaining priority.
  #
  def <<(elem : T)
    add(elem)
  end

  # :ditto:
  #
  def push(elem : T)
    add(elem)
  end

  # :ditto:
  #
  def add(elem : T)
    ensure_unused_capacity(1)
    add_unchecked(elem)
  end

  private def add_unchecked(elem : T)
    size = @size
    @items[size] = elem

    if size > 0
      start = get_start_for_sift_up(elem, size)
      sift_up(start)
    end

    @size += 1
  end

  # Look at the smallest element in the dequeue. Returns `nil` if empty.
  #
  def peek_min : T?
    if @size > 0
      @items[0]
    end
  end

  # Look at the largest element in the dequeue. Returns `nil` if empty
  #
  def peek_max : T?
    case @size
    when 0
      nil
    when 1
      @items[0]
    when 2
      @items[1]
    else
      best_item_at_indices(1, 2, :gt).item
    end
  end

  # Pop the smallest element from the dequeue. Returns `nil` if empty.
  #
  def pop_min : T?
    if @size > 0
      del_at(0)
    end
  end

  # Pop the largest element from the dequeue. Returns `nil` if empty.
  #
  def pop_max : T?
    if index = max_index
      del_at(index)
    end
  end

  # Delete and return element at index. Indices are in the
  # same order as iterator, which is not necessarily priority order.
  #
  def del_at(index : UInt32) : T
    unless index < @size
      raise ArgumentError.new("Requires index < size, index : #{index}, size : #{@size}")
    end
    del_at_unchecked(index)
  end

  # Ensure that the dequeue can fit at least `new_capacity` items.
  #
  def ensure_total_capacity(new_capacity : UInt32)
    better_cap = cap
    return if better_cap >= new_capacity
    loop do
      better_cap += better_cap // 2 + 8
      break if better_cap >= new_capacity
    end

    @items = @items.realloc(better_cap)
    @cap = better_cap
  end

  # Ensure that the dequeue can fit at least `additional_count` **more** items.
  #
  def ensure_unused_capacity(additional_count : UInt32)
    ensure_total_capacity(@size + additional_count)
  end

  def update(old_elem : T, new_elem : T)
    size = @size
    each_with_index do |elem, index|
      if elem == old_elem
        del_at_unchecked(index.to_u32)
        add_unchecked(new_elem)
        return
      end
    end

    raise Enumerable::NotFoundError.new("#{old_elem} not found")
  end

  def dump(io : IO)
    io << "#{typeof(self)}:"
    io << "\n"

    io << "\titems  : "
    io << @items.to_slice(@size)
    io << "\n"

    io << "\tbuffer : "
    io << @items.to_slice(@cap)
    io << "\n"

    io << "\tsize   : #{@size}"
    io << "\n"

    io << "\tcap    : #{cap}"
    io << "\n"
    io << "\n"
  end

  ###########################################################
  #                                                         #
  #  ██████╗ ██████╗ ██╗██╗   ██╗ █████╗ ████████╗███████╗  #
  #  ██╔══██╗██╔══██╗██║██║   ██║██╔══██╗╚══██╔══╝██╔════╝  #
  #  ██████╔╝██████╔╝██║██║   ██║███████║   ██║   █████╗    #
  #  ██╔═══╝ ██╔══██╗██║╚██╗ ██╔╝██╔══██║   ██║   ██╔══╝    #
  #  ██║     ██║  ██║██║ ╚████╔╝ ██║  ██║   ██║   ███████╗  #
  #  ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═══╝  ╚═╝  ╚═╝   ╚═╝   ╚══════╝  #
  #                                                         #
  ###########################################################

  # :nodoc:
  #
  record StartIndexAndLayer, index : UInt32, min_layer : Bool

  private def get_start_for_sift_up(child : T, child_index : UInt32) : StartIndexAndLayer
    parent_index = parent_index(child_index)
    parent = @items[parent_index]

    min_layer = next_is_min_layer?
    if (min_layer && @compare_fn.call(child, parent) > 0) || (!min_layer && @compare_fn.call(child, parent) < 0)
      # We must swap the item with it's parent if it is on the "wrong" layer
      #
      @items[parent_index], @items[child_index] = child, parent
      return StartIndexAndLayer.new(index: parent_index, min_layer: !min_layer)
    else
      return StartIndexAndLayer.new(index: child_index, min_layer: min_layer)
    end
  end

  private def sift_up(start : StartIndexAndLayer)
    min_layer = start.min_layer
    child_index = start.index
    while child_index > 2
      grandparent_index = grandparent_index(child_index)
      child, grandparent = @items[child_index], @items[grandparent_index]

      # If the grandparent is already better or equal, we have gone as far as we need to
      #
      break if min_layer && @compare_fn.call(child, grandparent) >= 0
      break if !min_layer && @compare_fn.call(child, grandparent) <= 0

      # Otherwise swap the item with it's grandparent
      #
      @items[grandparent_index], @items[child_index] = child, grandparent
      child_index = grandparent_index
    end
  end

  private def max_index : UInt32?
    case @size
    when 0
      nil
    when 1
      0_u32
    when 2
      1_u32
    else
      best_item_at_indices(1, 2, :gt).index
    end
  end

  private def del_at_unchecked(index : UInt32) : T
    item, last = @items[index], @items[@size - 1]

    @items[index] = last
    @size -= 1
    sift_down(index)

    return item
  end

  private def sift_down(index : UInt32)
    order = min_layer?(index) ? :lt : :gt
    half = @size >> 1
    loop do
      first_grandchild_index = first_grandchild_index(index)
      last_grandchild_index = first_grandchild_index + 3

      elem = @items[index]

      if last_grandchild_index < @size
        # All four grandchildren exist
        #
        index2 = first_grandchild_index + 1
        index3 = index2 + 1

        # Find the best grandchild
        #
        best_left = best_item_at_indices(first_grandchild_index, index2, order)
        best_right = best_item_at_indices(index3, last_grandchild_index, order)
        best_grandchild = best_item(best_left, best_right, order)

        # If the item is better than or equal to its best grandchild, we are done
        #
        return if order == :lt && @compare_fn.call(best_grandchild.item, elem) >= 0
        return if order == :gt && @compare_fn.call(best_grandchild.item, elem) <= 0

        # Otherwise, swap them
        #
        @items[best_grandchild.index], @items[index] = elem, best_grandchild.item
        index = best_grandchild.index

        #  We might need to swap the element with it's parent
        #
        swap_if_parent_is_better(elem, index, order)
      else
        # The children or grandchildren are the last layer
        #
        first_child_index = first_child_index(index)
        return if first_child_index >= @size

        best_descendent = best_descendent(first_child_index, first_grandchild_index, order)

        # If the item is better than or equal to its best descendant, we are done
        #
        return if order == :lt && @compare_fn.call(best_descendent.item, elem) >= 0
        return if order == :gt && @compare_fn.call(best_descendent.item, elem) <= 0

        # Otherwise swap them
        #
        @items[best_descendent.index], @items[index] = elem, best_descendent.item
        index = best_descendent.index

        # If we didn't swap a grandchild, we are done
        #
        return if index < first_grandchild_index

        # We might need to swap the element with it's parent
        #
        swap_if_parent_is_better(elem, index, order)
        return
      end
      return if index >= half
    end
  end

  private def swap_if_parent_is_better(child : T, child_index : UInt32, order : Symbol)
    parent_index = parent_index(child_index)
    parent = @items[parent_index]

    if (order == :lt && @compare_fn.call(parent, child) < 0) || (order == :gt && @compare_fn.call(parent, child) > 0)
      @items[parent_index], @items[child_index] = child, parent
    end
  end

  # :nodoc:
  #
  record ItemAndIndex(T), item : T, index : UInt32

  private def get_item(index : UInt32) : ItemAndIndex(T)
    ItemAndIndex(T).new(item: @items[index], index: index)
  end

  private def best_item(item1 : ItemAndIndex, item2 : ItemAndIndex, order : Symbol) : ItemAndIndex
    if (order == :lt && @compare_fn.call(item1.item, item2.item) < 0) || (order == :gt && @compare_fn.call(item1.item, item2.item) > 0)
      item1
    else
      item2
    end
  end

  private def best_item_at_indices(index1 : UInt32, index2 : UInt32, order : Symbol) : ItemAndIndex
    item1, item2 = get_item(index1), get_item(index2)
    best_item(item1, item2, order)
  end

  private def best_descendent(first_child_index : UInt32, first_grandchild_index : UInt32, order : Symbol) : ItemAndIndex
    second_child_index = first_child_index + 1
    if first_grandchild_index >= @size
      # No grandchildren, find the best child (second may not exist)
      #
      if second_child_index >= @size
        return ItemAndIndex(T).new(item: @items[first_child_index], index: first_child_index)
      else
        return best_item_at_indices(first_child_index, second_child_index, order)
      end
    end

    second_grandchild_index = first_grandchild_index + 1
    if second_grandchild_index >= @size
      # One grandchild, so we know there is a second child. Compare first grandchild and second child
      #
      return best_item_at_indices(first_grandchild_index, second_child_index, order)
    end

    best_left_grandchild_index = best_item_at_indices(first_grandchild_index, second_grandchild_index, order).index
    third_grandchild_index = second_grandchild_index + 1
    if third_grandchild_index > @size
      # Two grandchildren, and we know the best. Compare this to second child.
      #
      return best_item_at_indices(best_left_grandchild_index, second_child_index, order)
    else
      # Three grandchildren, compare the min of the first two with the third
      #
      return best_item_at_indices(best_left_grandchild_index, third_grandchild_index, order)
    end
  end

  private def min_layer?(index : UInt32) : Bool
    # In the min-max heap structure:
    # The first element is on a min layer;
    # next two are on a max layer;
    # next four are on a min layer, and so on.
    #
    1 == (index &+ 1).leading_zeros_count & 1
  end

  private def next_is_min_layer? : Bool
    min_layer?(@size)
  end

  private def parent_index(index : UInt32) : UInt32
    (index - 1) >> 1
  end

  private def grandparent_index(index : UInt32) : UInt32
    parent_index(parent_index(index))
  end

  private def first_child_index(index : UInt32) : UInt32
    (index << 1) + 1
  end

  private def first_grandchild_index(index : UInt32) : UInt32
    first_child_index(first_child_index(index))
  end
end
