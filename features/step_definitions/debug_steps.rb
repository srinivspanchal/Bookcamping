Then /^what$/ do
  puts "***************************************************************"
  puts page.body.gsub("\n", "\n            ")
  puts "***************************************************************"
end