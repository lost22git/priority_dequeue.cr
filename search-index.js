crystal_doc_search_index_callback({"repository_name":"priority_dequeue","body":"# priority_dequeue\n\npriority dequeue implementation for Crystal, ported from [Zig.std priority-dequeue](https://ziglang.org/documentation/master/std/#src/std/priority_dequeue.zig)\n\n[API DOC](https://lost22git.github.io/priority_dequeue.cr)\n\n## Installation\n\n1. Add the dependency to your `shard.yml`:\n\n   ```yaml\n   dependencies:\n     priority_dequeue:\n       github: lost22git/priority_dequeue.cr\n   ```\n\n2. Run `shards install`\n\n## Development\n\n### Run tests\n\n```\ncrystal spec --progress\n```\n\n## Contributing\n\n1. Fork it (<https://github.com/lost22git/priority_dequeue/fork>)\n2. Create your feature branch (`git checkout -b my-new-feature`)\n3. Commit your changes (`git commit -am 'Add some feature'`)\n4. Push to the branch (`git push origin my-new-feature`)\n5. Create a new Pull Request\n\n## Contributors\n\n- [lost](https://github.com/lost22git) - creator and maintainer\n","program":{"html_id":"priority_dequeue/toplevel","path":"toplevel.html","kind":"module","full_name":"Top Level Namespace","name":"Top Level Namespace","abstract":false,"locations":[],"repository_name":"priority_dequeue","program":true,"enum":false,"alias":false,"const":false,"types":[{"html_id":"priority_dequeue/PriorityDequeue","path":"PriorityDequeue.html","kind":"class","full_name":"PriorityDequeue(T)","name":"PriorityDequeue","abstract":false,"superclass":{"html_id":"priority_dequeue/Reference","kind":"class","full_name":"Reference","name":"Reference"},"ancestors":[{"html_id":"priority_dequeue/Indexable","kind":"module","full_name":"Indexable","name":"Indexable"},{"html_id":"priority_dequeue/Enumerable","kind":"module","full_name":"Enumerable","name":"Enumerable"},{"html_id":"priority_dequeue/Iterable","kind":"module","full_name":"Iterable","name":"Iterable"},{"html_id":"priority_dequeue/Reference","kind":"class","full_name":"Reference","name":"Reference"},{"html_id":"priority_dequeue/Object","kind":"class","full_name":"Object","name":"Object"}],"locations":[{"filename":"src/priority_dequeue.cr","line_number":1,"url":"https://github.com/lost22git/priority_dequeue.cr/blob/c42b2555ccabcef46f12408a3ed2f78942c1723c/src/priority_dequeue.cr#L1"}],"repository_name":"priority_dequeue","program":false,"enum":false,"alias":false,"const":false,"constants":[{"id":"VERSION","name":"VERSION","value":"\"0.1.0\""}],"included_modules":[{"html_id":"priority_dequeue/Indexable","kind":"module","full_name":"Indexable","name":"Indexable"}],"constructors":[{"html_id":"new(cap:UInt32=0,compare_fn:T,T->Int32=->(a:T,b:T)do\na<=>b\nend)-class-method","name":"new","abstract":false,"args":[{"name":"cap","default_value":"0","external_name":"cap","restriction":"UInt32"},{"name":"compare_fn","default_value":"->(a : T, b : T) do\n  a <=> b\nend","external_name":"compare_fn","restriction":"(T, T -> ::Int32)"}],"args_string":"(cap : UInt32 = 0, compare_fn : T, T -> Int32 = ->(a : T, b : T) do\n  a <=> b\nend)","args_html":"(cap : UInt32 = <span class=\"n\">0</span>, compare_fn : T, T -> Int32 = <span class=\"o\">-&gt;</span>(a : <span class=\"t\">T</span>, b : <span class=\"t\">T</span>) <span class=\"k\">do</span>\n  a <span class=\"o\">&lt;=&gt;</span> b\n<span class=\"k\">end</span>)","location":{"filename":"src/priority_dequeue.cr","line_number":14,"url":"https://github.com/lost22git/priority_dequeue.cr/blob/c42b2555ccabcef46f12408a3ed2f78942c1723c/src/priority_dequeue.cr#L14"},"def":{"name":"new","args":[{"name":"cap","default_value":"0","external_name":"cap","restriction":"UInt32"},{"name":"compare_fn","default_value":"->(a : T, b : T) do\n  a <=> b\nend","external_name":"compare_fn","restriction":"(T, T -> ::Int32)"}],"visibility":"Public","body":"_ = PriorityDequeue(T).allocate\n_.initialize(cap, compare_fn)\nif _.responds_to?(:finalize)\n  ::GC.add_finalizer(_)\nend\n_\n"}}],"instance_methods":[{"html_id":"<<(elem:T)-instance-method","name":"<<","doc":"Add a new element, maintaining priority.\n","summary":"<p>Add a new element, maintaining priority.</p>","abstract":false,"args":[{"name":"elem","external_name":"elem","restriction":"T"}],"args_string":"(elem : T)","args_html":"(elem : T)","location":{"filename":"src/priority_dequeue.cr","line_number":28,"url":"https://github.com/lost22git/priority_dequeue.cr/blob/c42b2555ccabcef46f12408a3ed2f78942c1723c/src/priority_dequeue.cr#L28"},"def":{"name":"<<","args":[{"name":"elem","external_name":"elem","restriction":"T"}],"visibility":"Public","body":"add(elem)"}},{"html_id":"add(elem:T)-instance-method","name":"add","doc":"Add a new element, maintaining priority.\n","summary":"<p>Add a new element, maintaining priority.</p>","abstract":false,"args":[{"name":"elem","external_name":"elem","restriction":"T"}],"args_string":"(elem : T)","args_html":"(elem : T)","location":{"filename":"src/priority_dequeue.cr","line_number":40,"url":"https://github.com/lost22git/priority_dequeue.cr/blob/c42b2555ccabcef46f12408a3ed2f78942c1723c/src/priority_dequeue.cr#L40"},"def":{"name":"add","args":[{"name":"elem","external_name":"elem","restriction":"T"}],"visibility":"Public","body":"ensure_unused_capacity(1)\nadd_unchecked(elem)\n"}},{"html_id":"cap:UInt32-instance-method","name":"cap","abstract":false,"location":{"filename":"src/priority_dequeue.cr","line_number":8,"url":"https://github.com/lost22git/priority_dequeue.cr/blob/c42b2555ccabcef46f12408a3ed2f78942c1723c/src/priority_dequeue.cr#L8"},"def":{"name":"cap","return_type":"UInt32","visibility":"Public","body":"@cap"}},{"html_id":"del_at(index:UInt32):T-instance-method","name":"del_at","doc":"Delete and return element at index. Indices are in the\nsame order as iterator, which is not necessarily priority order.\n","summary":"<p>Delete and return element at index.</p>","abstract":false,"args":[{"name":"index","external_name":"index","restriction":"UInt32"}],"args_string":"(index : UInt32) : T","args_html":"(index : UInt32) : T","location":{"filename":"src/priority_dequeue.cr","line_number":87,"url":"https://github.com/lost22git/priority_dequeue.cr/blob/c42b2555ccabcef46f12408a3ed2f78942c1723c/src/priority_dequeue.cr#L87"},"def":{"name":"del_at","args":[{"name":"index","external_name":"index","restriction":"UInt32"}],"return_type":"T","visibility":"Public","body":"if index < @size\nelse\n  raise(ArgumentError.new(\"Requires index < size, index : #{index}, size : #{@size}\"))\nend\ndel_at_unchecked(index)\n"}},{"html_id":"dump(io:IO)-instance-method","name":"dump","abstract":false,"args":[{"name":"io","external_name":"io","restriction":"IO"}],"args_string":"(io : IO)","args_html":"(io : IO)","location":{"filename":"src/priority_dequeue.cr","line_number":127,"url":"https://github.com/lost22git/priority_dequeue.cr/blob/c42b2555ccabcef46f12408a3ed2f78942c1723c/src/priority_dequeue.cr#L127"},"def":{"name":"dump","args":[{"name":"io","external_name":"io","restriction":"IO"}],"visibility":"Public","body":"io << \"#{typeof(self)}:\"\nio << \"\\n\"\nio << \"\\titems  : \"\nio << (@items.to_slice(@size))\nio << \"\\n\"\nio << \"\\tbuffer : \"\nio << (@items.to_slice(@cap))\nio << \"\\n\"\nio << \"\\tsize   : #{@size}\"\nio << \"\\n\"\nio << \"\\tcap    : #{cap}\"\nio << \"\\n\"\nio << \"\\n\"\n"}},{"html_id":"ensure_total_capacity(new_capacity:UInt32)-instance-method","name":"ensure_total_capacity","doc":"Ensure that the dequeue can fit at least `new_capacity` items.\n","summary":"<p>Ensure that the dequeue can fit at least <code>new_capacity</code> items.</p>","abstract":false,"args":[{"name":"new_capacity","external_name":"new_capacity","restriction":"UInt32"}],"args_string":"(new_capacity : UInt32)","args_html":"(new_capacity : UInt32)","location":{"filename":"src/priority_dequeue.cr","line_number":96,"url":"https://github.com/lost22git/priority_dequeue.cr/blob/c42b2555ccabcef46f12408a3ed2f78942c1723c/src/priority_dequeue.cr#L96"},"def":{"name":"ensure_total_capacity","args":[{"name":"new_capacity","external_name":"new_capacity","restriction":"UInt32"}],"visibility":"Public","body":"better_cap = cap\nif better_cap >= new_capacity\n  return\nend\nloop do\n  better_cap = better_cap + ((better_cap // 2) + 8)\n  if better_cap >= new_capacity\n    break\n  end\nend\n@items = @items.realloc(better_cap)\n@cap = better_cap\n"}},{"html_id":"ensure_unused_capacity(additional_count:UInt32)-instance-method","name":"ensure_unused_capacity","doc":"Ensure that the dequeue can fit at least `additional_count` **more** items.\n","summary":"<p>Ensure that the dequeue can fit at least <code>additional_count</code> <strong>more</strong> items.</p>","abstract":false,"args":[{"name":"additional_count","external_name":"additional_count","restriction":"UInt32"}],"args_string":"(additional_count : UInt32)","args_html":"(additional_count : UInt32)","location":{"filename":"src/priority_dequeue.cr","line_number":110,"url":"https://github.com/lost22git/priority_dequeue.cr/blob/c42b2555ccabcef46f12408a3ed2f78942c1723c/src/priority_dequeue.cr#L110"},"def":{"name":"ensure_unused_capacity","args":[{"name":"additional_count","external_name":"additional_count","restriction":"UInt32"}],"visibility":"Public","body":"ensure_total_capacity(@size + additional_count)"}},{"html_id":"peek_max:T|Nil-instance-method","name":"peek_max","doc":"Look at the largest element in the dequeue. Returns `nil` if empty\n","summary":"<p>Look at the largest element in the dequeue.</p>","abstract":false,"location":{"filename":"src/priority_dequeue.cr","line_number":55,"url":"https://github.com/lost22git/priority_dequeue.cr/blob/c42b2555ccabcef46f12408a3ed2f78942c1723c/src/priority_dequeue.cr#L55"},"def":{"name":"peek_max","return_type":"T | ::Nil","visibility":"Public","body":"case @size\nwhen 0\n  nil\nwhen 1\n  @items[0]\nwhen 2\n  @items[1]\nelse\n  (best_item_at_indices(1, 2, :gt)).item\nend"}},{"html_id":"peek_min:T|Nil-instance-method","name":"peek_min","doc":"Look at the smallest element in the dequeue. Returns `nil` if empty.\n","summary":"<p>Look at the smallest element in the dequeue.</p>","abstract":false,"location":{"filename":"src/priority_dequeue.cr","line_number":47,"url":"https://github.com/lost22git/priority_dequeue.cr/blob/c42b2555ccabcef46f12408a3ed2f78942c1723c/src/priority_dequeue.cr#L47"},"def":{"name":"peek_min","return_type":"T | ::Nil","visibility":"Public","body":"if @size > 0\n  @items[0]\nend"}},{"html_id":"pop_max:T|Nil-instance-method","name":"pop_max","doc":"Pop the largest element from the dequeue. Returns `nil` if empty.\n","summary":"<p>Pop the largest element from the dequeue.</p>","abstract":false,"location":{"filename":"src/priority_dequeue.cr","line_number":78,"url":"https://github.com/lost22git/priority_dequeue.cr/blob/c42b2555ccabcef46f12408a3ed2f78942c1723c/src/priority_dequeue.cr#L78"},"def":{"name":"pop_max","return_type":"T | ::Nil","visibility":"Public","body":"if index = max_index\n  del_at(index)\nend"}},{"html_id":"pop_min:T|Nil-instance-method","name":"pop_min","doc":"Pop the smallest element from the dequeue. Returns `nil` if empty.\n","summary":"<p>Pop the smallest element from the dequeue.</p>","abstract":false,"location":{"filename":"src/priority_dequeue.cr","line_number":70,"url":"https://github.com/lost22git/priority_dequeue.cr/blob/c42b2555ccabcef46f12408a3ed2f78942c1723c/src/priority_dequeue.cr#L70"},"def":{"name":"pop_min","return_type":"T | ::Nil","visibility":"Public","body":"if @size > 0\n  del_at(0)\nend"}},{"html_id":"push(elem:T)-instance-method","name":"push","doc":"Add a new element, maintaining priority.\n","summary":"<p>Add a new element, maintaining priority.</p>","abstract":false,"args":[{"name":"elem","external_name":"elem","restriction":"T"}],"args_string":"(elem : T)","args_html":"(elem : T)","location":{"filename":"src/priority_dequeue.cr","line_number":34,"url":"https://github.com/lost22git/priority_dequeue.cr/blob/c42b2555ccabcef46f12408a3ed2f78942c1723c/src/priority_dequeue.cr#L34"},"def":{"name":"push","args":[{"name":"elem","external_name":"elem","restriction":"T"}],"visibility":"Public","body":"add(elem)"}},{"html_id":"size:UInt32-instance-method","name":"size","doc":"Returns the number of elements in this container.","summary":"<p>Returns the number of elements in this container.</p>","abstract":false,"location":{"filename":"src/priority_dequeue.cr","line_number":10,"url":"https://github.com/lost22git/priority_dequeue.cr/blob/c42b2555ccabcef46f12408a3ed2f78942c1723c/src/priority_dequeue.cr#L10"},"def":{"name":"size","return_type":"UInt32","visibility":"Public","body":"@size"}},{"html_id":"unsafe_fetch(index):T-instance-method","name":"unsafe_fetch","abstract":false,"args":[{"name":"index","external_name":"index","restriction":""}],"args_string":"(index) : T","args_html":"(index) : T","location":{"filename":"src/priority_dequeue.cr","line_number":22,"url":"https://github.com/lost22git/priority_dequeue.cr/blob/c42b2555ccabcef46f12408a3ed2f78942c1723c/src/priority_dequeue.cr#L22"},"def":{"name":"unsafe_fetch","args":[{"name":"index","external_name":"index","restriction":""}],"return_type":"T","visibility":"Public","body":"@items[index]"}},{"html_id":"update(old_elem:T,new_elem:T)-instance-method","name":"update","abstract":false,"args":[{"name":"old_elem","external_name":"old_elem","restriction":"T"},{"name":"new_elem","external_name":"new_elem","restriction":"T"}],"args_string":"(old_elem : T, new_elem : T)","args_html":"(old_elem : T, new_elem : T)","location":{"filename":"src/priority_dequeue.cr","line_number":114,"url":"https://github.com/lost22git/priority_dequeue.cr/blob/c42b2555ccabcef46f12408a3ed2f78942c1723c/src/priority_dequeue.cr#L114"},"def":{"name":"update","args":[{"name":"old_elem","external_name":"old_elem","restriction":"T"},{"name":"new_elem","external_name":"new_elem","restriction":"T"}],"visibility":"Public","body":"size = @size\neach_with_index do |elem, index|\n  if elem == old_elem\n    del_at_unchecked(index.to_u32)\n    add_unchecked(new_elem)\n    return\n  end\nend\nraise(Enumerable::NotFoundError.new(\"#{old_elem} not found\"))\n"}}]}]}})