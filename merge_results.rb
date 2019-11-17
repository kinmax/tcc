require 'json'

heuristic = ARGV[0]
noise = ARGV[1]

path = "/home/kin/t2-integradora"
output_path = "/home/kin/t2-integradora/results_#{heuristic}_hoffmann"
output_path += "_noisy" if noise == "noisy"
output_path += ".json"

domains = %w(blocks-world campus depots driverlog dwr easy-ipc-grid ferry intrusion-detection kitchen logistics miconic rovers satellite sokoban zeno-travel).freeze
domains = %w(blocks-world-noisy campus-noisy depots-noisy driverlog-noisy dwr-noisy easy-ipc-grid-noisy ferry-noisy intrusion-detection-noisy kitchen-noisy logistics-noisy miconic-noisy rovers-noisy satellite-noisy sokoban-noisy zeno-travel-noisy).freeze if noise == "noisy"

res = {}

Dir.foreach(path) do |domain|
    unless(domains.include?(domain))
        next
    end
    Dir.foreach("#{path}/#{domain}") do |file_name|
        unless(file_name == "results.json")
            next
        end

        file = File.open("#{path}/#{domain}/#{file_name}", "r")
        raw = file.read
        file.close
        hash = JSON.parse(raw)
        underscore_domain = domain.gsub("-", "_")
        res[domain] = hash[underscore_domain]
    end
end
res = res.sort.to_h
json_res = JSON.pretty_generate(res)
File.write(output_path, json_res)
