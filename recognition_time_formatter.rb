require 'json'
require 'byebug'

heuristic = ARGV[0]
noise = ARGV[1]

filename = "new_results_#{heuristic}"
filename += noise == "noisy" ? "_noisy.json" : ".json"

file_path = File.join(File.dirname(__FILE__), filename)
file = File.open(file_path, 'r')
raw = file.read
file.close
results = JSON.parse(raw)

output_path = noise == "noisy" ? "/home/kingusmao/tcc/recognition_time_noisy.txt" : "/home/kingusmao/tcc/recognition_time.txt"

percentages = noise == "noisy" ? %w(25 50 75 100) : %w(10 30 50 70 100)
thresholds = %w(0 10)
algs = %w(exhaust hm rhw zg hoffmann)

values = {}
values = {}
algs.each do |alg|
    values[alg] = {}
end
results.each do |key, value|
    algs.each do |alg|
        percentages.each do |p|
            values[alg] = values[alg].merge(value["observations"][p]["observations_avg"] => (value["observations"][p][alg]["time"].values.inject(0) {|a,b|a+b})/thresholds.length.to_f)
        rescue Exception => e
            byebug
        end
    end
end

# filename = "results_uniqueness"
# filename += noise == "noisy" ? "_noisy.json" : ".json"

# file_path = File.join(File.dirname(__FILE__), filename)
# file = File.open(file_path, 'r')
# raw = file.read
# file.close
# results = JSON.parse(raw)

# results.each do |key, value|
#     algs.each do |alg|
#         percentages.each do |p|
#             values[alg] = values[alg].merge(value["observations"][p]["observations_avg"] => (value["observations"][p][alg]["time"].values.inject(0) {|a,b|a+b})/4)
#         rescue Exception => e
#             byebug
#         end
#     end
# end

rtime = ""

rtime += "#|O| #exhaust #hm #rhw #zg #hoffmann"
values["hm"].keys.sort.each do |key|
    rtime += "#{key} #{values["exhaust"][key]} #{values["hm"][key]} #{values["rhw"][key]} #{values["zg"][key]} #{values["hoffmann"][key]}\n"
end

file = File.open(output_path, "w")
file.write(rtime)
file.close
