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

output_path = noise == "noisy" ? "/home/kingusmao/tcc/bar_graph_noisy.txt" : "/home/kingusmao/tcc/bar_graph.txt"

percentages = noise == "noisy" ? %w(25 50 75 100) : %w(10 30 50 70 100)
threshold = "0"
thresholds = %w(0 10)
algs = %w(exhaust hm rhw zg hoffmann)

values = {}
algs.each do |alg|
    values[alg] = {}
    values[alg]["landmarks_avg"] = 0
    percentages.each do |p|
        values[alg][p] = {}
        thresholds.each do |th|
            values[alg][p][th] = {}
            values[alg][p][th]["accuracy"] = 0
            values[alg][p][th]["time"] = 0
            values[alg][p][th]["spread"] = 0
        end
    end
end

results.each do |key, value|
    algs.each do |alg|
        values[alg]["landmarks_avg"] += value["landmarks_avg"][alg]/14.to_f
        percentages.each do |p|
            thresholds.each do |th|
                values[alg][p][th]["accuracy"] += value["observations"][p][alg]["accuracy"][th]/14.to_f
                values[alg][p][th]["time"] += value["observations"][p][alg]["time"][th]/14.to_f
                values[alg][p][th]["spread"] += value["spread"][p][alg][th].to_f/14.to_f
            end
        end
    end
end



myvalues = {}
myvalues = values

# filename = "results_uniqueness"
# filename += noise == "noisy" ? "_noisy.json" : ".json"

# file_path = File.join(File.dirname(__FILE__), filename)
# file = File.open(file_path, 'r')
# raw = file.read
# file.close
# results = JSON.parse(raw)

# values = {}
# algs.each do |alg|
#     values[alg] = {}
#     values[alg]["landmarks_avg"] = 0
#     percentages.each do |p|
#         values[alg][p] = {}
#         thresholds.each do |th|
#             values[alg][p][th] = {}
#             values[alg][p][th]["accuracy"] = 0
#             values[alg][p][th]["time"] = 0
#             values[alg][p][th]["spread"] = 0
#         end
#     end
# end

# results.each do |key, value|
#     algs.each do |alg|
#         values[alg]["landmarks_avg"] += value["landmarks_avg"][alg]/15.to_f
#         percentages.each do |p|
#             thresholds.each do |th|
#                 values[alg][p][th]["accuracy"] += value["observations"][p][alg]["accuracy"][th]/15.to_f
#                 values[alg][p][th]["time"] += value["observations"][p][alg]["time"][th]/15.to_f
#                 values[alg][p][th]["spread"] += value["spread"][p][alg][th].to_f/15.to_f
#             end
#         end
#     end
# end


info = "#percent #exhaust #hm #rhw #zg #hoffmann\n"

percentages.each do |p|
    # byebug
    info += "#{p} #{myvalues["exhaust"][p][threshold]["accuracy"].to_f/myvalues["exhaust"][p][threshold]["spread"].to_f} #{myvalues["hm"][p][threshold]["accuracy"].to_f/myvalues["hm"][p][threshold]["spread"].to_f} #{myvalues["rhw"][p][threshold]["accuracy"].to_f/myvalues["rhw"][p][threshold]["spread"].to_f} #{myvalues["zg"][p][threshold]["accuracy"].to_f/myvalues["zg"][p][threshold]["spread"].to_f} #{myvalues["hoffmann"][p][threshold]["accuracy"].to_f/myvalues["hoffmann"][p][threshold]["spread"].to_f}\n"
end

file = File.open(output_path, "w")
file.write(info)
file.close