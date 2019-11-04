require 'json'
require 'byebug'

heuristic = ARGV[0]
noise = ARGV[1]

filename = "results_#{heuristic}"
filename += noise == "noisy" ? "_noisy.json" : ".json"

file_path = File.join(File.dirname(__FILE__), filename)
file = File.open(file_path, 'r')
raw = file.read
results = JSON.parse(raw)
output_path = "/home/kingusmao/t2-integradora/summary_table.txt"

percentages = noise == "noisy" ? %w(25 50 75 100) : %w(10 30 50 70 100)
thresholds = %w(0 10 20 30)
algs = %w(exhaust hm rhw zg)

values = {}
algs.each do |alg|
    values[alg] = {}
end
results.each do |key, value|
    algs.each do |alg|
        percentages.each do |p|
            values[alg] = values[alg].merge(value["observations"][p]["observations_avg"] => (value["observations"][p][alg]["time"].values.inject(0) {|a,b|a+b})/4)
        rescue Exception => e
            byebug
        end
    end
end

puts "#|O| #Exhaust #h^m #RHW #Zhu/Givan"
values["hm"].keys.sort.each do |key|
    puts "#{key} #{values["exhaust"][key]} #{values["hm"][key]} #{values["rhw"][key]} #{values["zg"][key]}"
end
