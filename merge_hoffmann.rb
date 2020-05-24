require 'json'
require 'byebug'

heuristic = ARGV[0]
noise = ARGV[1]

path = noise == "noisy" ? "/home/kingusmao/tcc/results_#{heuristic}_noisy.json" : "/home/kingusmao/tcc/results_#{heuristic}.json"
hoffmann_path = noise == "noisy" ? "/home/kingusmao/tcc/results_#{heuristic}_hoffmann_noisy.json" : "/home/kingusmao/tcc/results_#{heuristic}_hoffmann.json"
output_path = "/home/kingusmao/tcc/results_#{heuristic}_full"
output_path += "_noisy" if noise == "noisy"
output_path += ".json"
percentages = noise == "noisy" ? %w(25 50 75 100) : %w(10 30 50 70 100)

other_file = File.open(path, "r")
raw = other_file.read
other_file.close
other_results = JSON.parse(raw)

hoffmann_file = File.open(hoffmann_path, "r")
raw = hoffmann_file.read
hoffmann_file.close
hoffmann_results = JSON.parse(raw)

other_results.keys.each do |key|
    percentages.each do |p|  
        other_results[key]["observations"][p] = other_results[key]["observations"][p].merge(hoffmann_results[key]["observations"][p])
        other_results[key]["spread"][p] = other_results[key]["spread"][p].merge(hoffmann_results[key]["spread"][p])
        other_results[key]["landmarks_avg"] = other_results[key]["landmarks_avg"].merge(hoffmann_results[key]["landmarks_avg"])
    end
end

other_results = JSON.pretty_generate(other_results)
File.write(output_path, other_results)
