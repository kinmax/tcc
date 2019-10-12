require 'json'
require 'byebug'

file_path = ARGV[0]
file = File.open(file_path, 'r')
raw = file.read
file.close

raw.gsub!("[", '["')
raw.gsub!("]", '"]')
raw.gsub!(", ", '", "')

result = JSON.parse(raw)
File.write(file_path, JSON.pretty_generate(result))

