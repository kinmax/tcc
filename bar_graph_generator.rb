require 'json'
require 'byebug'

noise = ARGV[0]

filename = "results_goalcompletion"
filename += noise == "noisy" ? "_noisy.json" : ".json"

file_path = File.join(File.dirname(__FILE__), filename)
file = File.open(file_path, 'r')
raw = file.read
file.close
results = JSON.parse(raw)

output_path = noise == "noisy" ? "/home/kingusmao/t2-integradora/bar_graph_noisy.txt" : "/home/kingusmao/t2-integradora/bar_graph.txt"

percentages = noise == "noisy" ? %w(25 50 75 100) : %w(10 30 50 70 100)
threshold = "10"
thresholds = %w(0 10 20 30)
algs = %w(exhaust hm rhw zg)

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
        values[alg]["landmarks_avg"] += value["landmarks_avg"][alg]/15.to_f
        percentages.each do |p|
            thresholds.each do |th|
                values[alg][p][th]["accuracy"] += value["observations"][p][alg]["accuracy"][th]/15.to_f
                values[alg][p][th]["time"] += value["observations"][p][alg]["time"][th]/15.to_f
                values[alg][p][th]["spread"] += value["spread"][p][alg][th].to_f/15.to_f
            end
        end
    end
end



myvalues = {}
myvalues["gc"] = values

filename = "results_uniqueness"
filename += noise == "noisy" ? "_noisy.json" : ".json"

file_path = File.join(File.dirname(__FILE__), filename)
file = File.open(file_path, 'r')
raw = file.read
file.close
results = JSON.parse(raw)

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
        values[alg]["landmarks_avg"] += value["landmarks_avg"][alg]/15.to_f
        percentages.each do |p|
            thresholds.each do |th|
                values[alg][p][th]["accuracy"] += value["observations"][p][alg]["accuracy"][th]/15.to_f
                values[alg][p][th]["time"] += value["observations"][p][alg]["time"][th]/15.to_f
                values[alg][p][th]["spread"] += value["spread"][p][alg][th].to_f/15.to_f
            end
        end
    end
end

myvalues["uniq"] = values

info = "#percent #gc+exhaust #gc+hm #gc+rhw #gc+zg #uniq+exhaust #uniq+hm #uniq+rhw #uniq+zg\n"

percentages.each do |p|
    # byebug
    info += "#{p} #{myvalues["gc"]["exhaust"][p][threshold]["accuracy"].to_f/myvalues["gc"]["exhaust"][p][threshold]["spread"].to_f} #{myvalues["gc"]["hm"][p][threshold]["accuracy"].to_f/myvalues["gc"]["hm"][p][threshold]["spread"].to_f} #{myvalues["gc"]["rhw"][p][threshold]["accuracy"].to_f/myvalues["gc"]["rhw"][p][threshold]["spread"].to_f} #{myvalues["gc"]["zg"][p][threshold]["accuracy"].to_f/myvalues["gc"]["zg"][p][threshold]["spread"].to_f} #{myvalues["uniq"]["exhaust"][p][threshold]["accuracy"].to_f/myvalues["uniq"]["exhaust"][p][threshold]["spread"].to_f} #{myvalues["uniq"]["hm"][p][threshold]["accuracy"].to_f/myvalues["uniq"]["hm"][p][threshold]["spread"].to_f} #{myvalues["uniq"]["rhw"][p][threshold]["accuracy"].to_f/myvalues["uniq"]["rhw"][p][threshold]["spread"].to_f} #{myvalues["uniq"]["zg"][p][threshold]["accuracy"].to_f/myvalues["uniq"]["zg"][p][threshold]["spread"].to_f}\n"
end

file = File.open(output_path, "w")
file.write(info)
file.close