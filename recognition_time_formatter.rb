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

output_path = noise == "noisy" ? "/home/kingusmao/t2-integradora/recognition_time_noisy.txt" : "/home/kingusmao/t2-integradora/recognition_time.txt"

percentages = noise == "noisy" ? %w(25 50 75 100) : %w(10 30 50 70 100)
thresholds = %w(0 10 20 30)
algs = %w(exhaust hm rhw zg)

values = {}
values["goalcompletion"] = {}
values["uniqueness"] = {}
algs.each do |alg|
    values["goalcompletion"][alg] = {}
    values["uniqueness"][alg] = {}
end
results.each do |key, value|
    algs.each do |alg|
        percentages.each do |p|
            values["goalcompletion"][alg] = values["goalcompletion"][alg].merge(value["observations"][p]["observations_avg"] => (value["observations"][p][alg]["time"].values.inject(0) {|a,b|a+b})/4)
        rescue Exception => e
            byebug
        end
    end
end

filename = "results_uniqueness"
filename += noise == "noisy" ? "_noisy.json" : ".json"

file_path = File.join(File.dirname(__FILE__), filename)
file = File.open(file_path, 'r')
raw = file.read
file.close
results = JSON.parse(raw)

results.each do |key, value|
    algs.each do |alg|
        percentages.each do |p|
            values["uniqueness"][alg] = values["uniqueness"][alg].merge(value["observations"][p]["observations_avg"] => (value["observations"][p][alg]["time"].values.inject(0) {|a,b|a+b})/4)
        rescue Exception => e
            byebug
        end
    end
end

rtime = ""

rtime += "#|O| #exhaust_gc #hm_gc #rhw_gc #zg_gc #exhaust_uniq #hm_uniq #rhw_uniq #zg_uniq"
values["goalcompletion"]["hm"].keys.sort.each do |key|
    rtime += "#{key} #{values["goalcompletion"]["exhaust"][key]} #{values["goalcompletion"]["hm"][key]} #{values["goalcompletion"]["rhw"][key]} #{values["goalcompletion"]["zg"][key]} #{values["uniqueness"]["exhaust"][key]} #{values["uniqueness"]["hm"][key]} #{values["uniqueness"]["rhw"][key]} #{values["uniqueness"]["zg"][key]}\n"
end

file = File.open(output_path, "w")
file.write(rtime)
file.close
