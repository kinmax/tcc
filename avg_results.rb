require 'json'

path = "/home/kingusmao/t2-integradora/results.json"
output_path = "/home/kingusmao/t2-integradora/avg_results.json"

percents = %w(10 30 50 70 100)
thresholds = %w(0 10 20 30)
algorithms = %w(exhaust hm rhw zg)

res = {}

a = {}
a["problems"] = 0
a["goals_avg"] = 0.to_f
a["observations"] = {}
a["landmarks_avg"] = {}
a["spread"] = {}
algorithms.each do |alg|
    a["landmarks_avg"][alg] = 0.to_f
end

percents.each do |p|
    a["observations"][p] = {}
    a["observations"][p]["observations_avg"] = 0.to_f
    a["spread"][p] = {}
    algorithms.each do |alg|
        a["spread"][p][alg] = {}
        a["observations"][p][alg] = {}
        a["observations"][p][alg]["time"] = {}
        a["observations"][p][alg]["accuracy"] = {}
        thresholds.each do |t|
            a["spread"][p][alg][t] = 0.to_f
            a["observations"][p][alg]["time"][t] = 0.to_f
            a["observations"][p][alg]["accuracy"][t] = 0.to_f
        end
    end
end

file = File.open(path, "r")
raw = file.read
json = JSON.parse(raw)

json.keys.each do |domain|
    algorithms.each
end

json.keys.each do |domain|
    a["problems"] += json[domain]["problems"]
    a["goals_avg"] += json[domain]["goals_avg"]
    algorithms.each do |alg|
        a["landmarks_avg"][alg] += json[domain]["landmarks_avg"][alg]
    end
    percents.each do |p|
        a["observations"][p]["observations_avg"] += json[domain]["observations"][p]["observations_avg"]
        algorithms.each do |alg|
            thresholds.each do |t|
                a["spread"] += json[domain]["spread"][p][alg][t]
                a["observations"][p][alg]["time"][t] += json[domain]["observations"][p][alg]["time"][t]
                a["observations"][p][alg]["accuracy"][t] += json[domain]["observations"][p][alg]["accuracy"][t]
            end
        end
    end
end

a["goals_avg"] = a["goals_avg"]/15.to_f

algorithms.each do |alg|
    a["landmarks_avg"][alg] = a["landmarks_avg"][alg]/15.to_f
end

percents.each do |p|
    a["observations"][p]["observations_avg"] = a["observations"][p]["observations_avg"]/15.to_f
    algorithms.each do |alg|
        thresholds.each do |t|
            a["observations"][p][alg]["time"][t] = a["observations"][p][alg]["time"][t]/15.to_f
            a["observations"][p][alg]["accuracy"][t] = a["observations"][p][alg]["accuracy"][t]/15.to_f
            a["spread"][p][alg][t] = a["spread"][p][alg][t].to_f/15.to_f
        end
    end
end

res["all"] = a

res = res.sort.to_h
json_res = JSON.pretty_generate(res)
File.write(output_path, json_res)
