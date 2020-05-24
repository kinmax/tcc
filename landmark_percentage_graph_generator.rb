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

output_path = noise == "noisy" ? "/home/kingusmao/tcc/landmark_pecentage_noisy.txt" : "/home/kingusmao/tcc/landmark_percentage.txt"

percentages = noise == "noisy" ? %w(25 50 75 100) : %w(10 30 50 70 100)
threshold = "10"
thresholds = %w(0 10 20 30)
algs = %w(exhaust hm rhw zg)

values = {}
values["gc"] = {}
values["uniq"] = {}

means = {}
algs.each do |alg|
    means[alg] = {}
    means[alg]["landmarks_avg"] = 0
    percentages.each do |p|
        means[alg][p] = {}
        thresholds.each do |th|
            means[alg][p][th] = {}
            means[alg][p][th]["accuracy"] = 0
            means[alg][p][th]["time"] = 0
            means[alg][p][th]["spread"] = 0
        end
    end
end

results.each do |key, value|
    algs.each do |alg|
        means[alg]["landmarks_avg"] += value["landmarks_avg"][alg]/15.to_f
        percentages.each do |p|
            thresholds.each do |th|
                means[alg][p][th]["accuracy"] += value["observations"][p][alg]["accuracy"][th]/15.to_f
                means[alg][p][th]["time"] += value["observations"][p][alg]["time"][th]/15.to_f
                means[alg][p][th]["spread"] += value["spread"][p][alg][th].to_f/15.to_f
            end
        end
    end
end

counter = {}
algs.each do |alg|
    mean = 0
    percentages.each do |perc|
        mean += means[alg][perc][threshold]["accuracy"].to_f/means[alg][perc][threshold]["spread"].to_f
    end
    mean = mean.to_f/percentages.count.to_f
    lm_perc = means[alg]["landmarks_avg"].to_f/means["exhaust"]["landmarks_avg"].to_f
    if values["gc"].keys.include?(lm_perc)
        counter[lm_perc] += 1
        values["gc"][lm_perc] += mean
    else
        counter[lm_perc] = 1
        hash_to_merge = {lm_perc => mean}
        values["gc"] = values["gc"].merge(hash_to_merge)
    end
    values["gc"].each do |key, value|
        # byebug
        values["gc"][key] = values["gc"][key].to_f/counter[key].to_f
    end
end

filename = "results_uniqueness"
filename += noise == "noisy" ? "_noisy.json" : ".json"

file_path = File.join(File.dirname(__FILE__), filename)
file = File.open(file_path, 'r')
raw = file.read
file.close
results = JSON.parse(raw)

means = {}
algs.each do |alg|
    means[alg] = {}
    means[alg]["landmarks_avg"] = 0
    percentages.each do |p|
        means[alg][p] = {}
        thresholds.each do |th|
            means[alg][p][th] = {}
            means[alg][p][th]["accuracy"] = 0
            means[alg][p][th]["time"] = 0
            means[alg][p][th]["spread"] = 0
        end
    end
end

results.each do |key, value|
    algs.each do |alg|
        means[alg]["landmarks_avg"] += value["landmarks_avg"][alg]/15.to_f
        percentages.each do |p|
            thresholds.each do |th|
                means[alg][p][th]["accuracy"] += value["observations"][p][alg]["accuracy"][th]/15.to_f
                means[alg][p][th]["time"] += value["observations"][p][alg]["time"][th]/15.to_f
                means[alg][p][th]["spread"] += value["spread"][p][alg][th].to_f/15.to_f
            end
        end
    end
end

algs.each do |alg|
    mean = 0
    percentages.each do |perc|
        mean += means[alg][perc][threshold]["accuracy"].to_f/means[alg][perc][threshold]["spread"].to_f
    end
    mean = mean.to_f/percentages.count.to_f
    lm_perc = means[alg]["landmarks_avg"].to_f/means["exhaust"]["landmarks_avg"].to_f
    if values["uniq"].keys.include?(lm_perc)
        values["uniq"][lm_perc] = (values["uniq"][lm_perc] + mean).to_f/2.to_f
    else
        hash_to_merge = {lm_perc => mean}
        values["uniq"] = values["uniq"].merge(hash_to_merge)
    end
end

info = "|L| GC UNIQ\n"

values["gc"].keys.sort.each do |key|
    info += "#{key} #{values["gc"][key]} #{values["uniq"][key]}\n"
end

file = File.open(output_path, "w")
file.write(info)
file.close
