Autotest.add_hook :initialize do |at|
  at.clear_mappings
  at.add_mapping(%r%^lib/(.*)\.rb$%) { |_, m|
    ["spec/#{m[1]}_spec.rb"]
  }
end