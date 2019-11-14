require 'byebug'
require 'json'

def get_method_stats(domain)
    file_path = "/home/kin/t2-integradora/#{domain}/res.txt"
    file = File.open(file_path, 'r')
    raw = file.read
    file.close

    raw = raw.split("\n")
    goals = raw[0].split("-")[1].to_f
    landmarks = raw[1].split("-")[1].to_f
    obs = raw[2].split("-")[1].to_f
    spread = raw[3].split("-")[1].to_f
    correct = raw[4].split("-")[1] == "TRUE" ? 1 : 0
    time = raw[5].split("-")[1].to_f

    results = {}
    results[:observations] = obs
    results[:goals] = goals
    results[:landmarks] = landmarks
    results[:correct] = correct
    results[:time] = time
    results[:spread] = spread

    results
end

def all_results(domain, type)
    dataset_path = "/home/kin/dataset-copy"
    res_path = "/home/kin/t2-integradora/#{domain}/res.txt"
    run_path = "/home/kin/t2-integradora/problem_analyser.rb"
    thresholds = %w(0 10 20 30).freeze
    percentages = type == "noisy" ? %w(25 50 75 100).freeze : %w(10 30 50 70 100).freeze
    run_types = %w(--exhaust --hm --rhw --zg).freeze
    algorithms = %w(exhaust hm rhw zg).freeze
    result = {}
    goals = 0
    landmarks = {}
    alg_counter = {}
    algorithms.each do |alg|
        landmarks[alg] = 0
        alg_counter[alg] = 0
    end
    observations = {}
    spread = {}
    seconds = {}   
    accuracy = {}
    counter = {}
    percentages.each do |p|
        observations[p] = 0
        seconds[p] = {}
        accuracy[p] = {}
        counter[p] = {}
        spread[p] = {}
        counter[p]["all"] = 0
        seconds[p]["exhaust"] = {}
        spread[p]["exhaust"] = {}
        spread[p]["hm"] = {}
        spread[p]["rhw"] = {}
        spread[p]["zg"] = {}
        accuracy[p]["exhaust"] = {}
        seconds[p]["hm"] = {}
        accuracy[p]["hm"] = {}
        seconds[p]["rhw"] = {}
        accuracy[p]["rhw"] = {}
        seconds[p]["zg"] = {}
        accuracy[p]["zg"] = {}
        thresholds.each do |t|
            counter[p][t] = 0

            spread[p]["exhaust"][t] = 0
            spread[p]["hm"][t] = 0
            spread[p]["rhw"][t] = 0
            spread[p]["zg"][t] = 0

            seconds[p]["exhaust"][t] = 0
            accuracy[p]["exhaust"][t] = 0
            seconds[p]["hm"][t] = 0
            accuracy[p]["hm"][t] = 0
            seconds[p]["rhw"][t] = 0
            accuracy[p]["rhw"][t] = 0
            seconds[p]["zg"][t] = 0
            accuracy[p]["zg"][t] = 0
        end
    end
    
    puts domain
    symbol_domain = domain.gsub("-", "_").to_sym
    result[symbol_domain] = {}
    problem_counter = 0
    goals = 0
    percentages.each do |p|
        observations[p] = 0
        counter[p]["all"] = 0
        thresholds.each do |t|
            counter[p][t] = 0
            spread[p]["exhaust"][t] = 0
            spread[p]["hm"][t] = 0
            spread[p]["rhw"][t] = 0
            spread[p]["zg"][t] = 0
            seconds[p]["exhaust"][t] = 0
            accuracy[p]["exhaust"][t] = 0
            seconds[p]["hm"][t] = 0
            accuracy[p]["hm"][t] = 0
            seconds[p]["rhw"][t] = 0
            accuracy[p]["rhw"][t] = 0
            seconds[p]["zg"][t] = 0
            accuracy[p]["zg"][t] = 0
        end
    end
    Dir.foreach("#{dataset_path}/#{domain}") do |percent|
        if percentages.include?(percent)
            Dir.foreach("#{dataset_path}/#{domain}/#{percent}") do |tar|
                if tar == "." || tar == ".." || tar == "README.md" || tar == ".gitignore" || tar.include?("FILTERED")
                    next
                end
                puts tar

                begin
                    tar_path = "#{dataset_path}/#{domain}/#{percent}/#{tar}"

                    problem_counter = problem_counter + 1

                    percentual_observed = percent

                    #EXTRACT STATS COMMON TO ALL PERCENTAGES AND THRESHOLDS
                    run_type = "--exhaust"
                    cmd = "ruby #{run_path} #{domain} #{tar_path} 10 --exhaust > #{res_path}"
                    system(cmd)
                    single_result_f = get_method_stats(domain)
                    goals += single_result_f[:goals]
                    observations[percentual_observed.to_s] += single_result_f[:observations]
                    counter[percentual_observed.to_s]["all"] += 1
                    
                    thresholds.each do |tr|
                        counter[percentual_observed.to_s][tr] += 1
                        run_types.each do |run_type|
                            extraction_method = run_type.split("--")[1]
                            cmd = "ruby #{run_path} #{domain} #{tar_path} #{tr} #{run_type} > #{res_path}"
                            system(cmd)
                            single_result_ex = get_method_stats(domain)
                            if single_result_ex[:correct] == 0
                                puts "FAILED - Domain: #{domain} - Problem: #{tar} - Threshold: #{tr} - Algorithm: #{run_type}"
                                file_path = "/home/kin/t2-integradora/#{domain}/res.txt"
                                file = File.open(file_path, 'r')
                                raw = file.read
                                file.close
                                puts raw
                            end
                            alg_counter[extraction_method] += 1
                            landmarks[extraction_method] += single_result_ex[:landmarks]
                            spread[percentual_observed.to_s][extraction_method][tr] += single_result_ex[:spread]
                            seconds[percentual_observed.to_s][extraction_method][tr] += single_result_ex[:time]
                            accuracy[percentual_observed.to_s][extraction_method][tr] += single_result_ex[:correct]
                        end
                    end
                rescue StandardError => e
                    puts e.backtrace
                end
            end
        end
    end
    begin
        if problem_counter == 0
            problem_counter = 1
        end
        result[symbol_domain][:problems] = problem_counter
        result[symbol_domain][:goals_avg] = goals.to_f/problem_counter
        result[symbol_domain][:observations] = {}
        result[symbol_domain][:landmarks_avg] = {}
        result[symbol_domain][:spread] = {}
        algorithms.each do |alg|
            result[symbol_domain][:landmarks_avg][alg] = landmarks[alg].to_f/alg_counter[alg].to_f
        end
        percentages.each do |p|
	    result[symbol_domain][:spread][p] = {}
            result[symbol_domain][:spread][p]["exhaust"] = {}
            result[symbol_domain][:spread][p]["hm"] = {}
            result[symbol_domain][:spread][p]["rhw"] = {}
            result[symbol_domain][:spread][p]["zg"] = {}
            result[symbol_domain][:observations][p] = {}
            result[symbol_domain][:observations][p]["exhaust"] = {}
            result[symbol_domain][:observations][p]["hm"] = {}
            result[symbol_domain][:observations][p]["rhw"] = {}
            result[symbol_domain][:observations][p]["zg"] = {}
            thresholds.each do |t|
                result[symbol_domain][:observations][p]["exhaust"][:time] = {}
                result[symbol_domain][:observations][p]["exhaust"][:accuracy] = {}
                result[symbol_domain][:observations][p]["hm"][:time] = {}
                result[symbol_domain][:observations][p]["hm"][:accuracy] = {}
                result[symbol_domain][:observations][p]["rhw"][:time] = {}
                result[symbol_domain][:observations][p]["rhw"][:accuracy] = {}
                result[symbol_domain][:observations][p]["zg"][:time] = {}
                result[symbol_domain][:observations][p]["zg"][:accuracy] = {}
            end
        end

        percentages.each do |p|
            result[symbol_domain][:observations][p][:observations_avg] = (observations[p].to_f/counter[p]["all"])
            thresholds.each do |t|
                if counter[p][t] == 0
                    counter[p][t] = 1
                end
                result[symbol_domain][:spread][p]["exhaust"][t] = (spread[p]["exhaust"][t].to_f)/(counter[p][t].to_f)
                result[symbol_domain][:spread][p]["hm"][t] = (spread[p]["hm"][t].to_f)/(counter[p][t].to_f)
                result[symbol_domain][:spread][p]["rhw"][t] = (spread[p]["rhw"][t].to_f)/(counter[p][t].to_f)
                result[symbol_domain][:spread][p]["zg"][t] = (spread[p]["zg"][t].to_f)/(counter[p][t].to_f)

                result[symbol_domain][:observations][p]["exhaust"][:time][t] = ((((seconds[p]["exhaust"][t].to_f/counter[p][t])*1000).floor)/1000.0)
                result[symbol_domain][:observations][p]["exhaust"][:accuracy][t] = ((accuracy[p]["exhaust"][t].to_f/counter[p][t]) * 100.0)
                result[symbol_domain][:observations][p]["hm"][:time][t] = ((((seconds[p]["hm"][t].to_f/counter[p][t])*1000).floor)/1000.0)
                result[symbol_domain][:observations][p]["hm"][:accuracy][t] = ((accuracy[p]["hm"][t].to_f/counter[p][t]) * 100.0)
                result[symbol_domain][:observations][p]["rhw"][:time][t] = ((((seconds[p]["rhw"][t].to_f/counter[p][t])*1000).floor)/1000.0)
                result[symbol_domain][:observations][p]["rhw"][:accuracy][t] = ((accuracy[p]["rhw"][t].to_f/counter[p][t]) * 100.0)
                result[symbol_domain][:observations][p]["zg"][:time][t] = ((((seconds[p]["zg"][t].to_f/counter[p][t])*1000).floor)/1000.0)
                result[symbol_domain][:observations][p]["zg"][:accuracy][t] = ((accuracy[p]["zg"][t].to_f/counter[p][t]) * 100.0)
            end
        end
    rescue StandardError => e
        puts e.backtrace
    end

    result
end

def analyse(domain, type)
    results = all_results(domain, type)
    output_path = "/home/kin/t2-integradora/#{domain}/results.json"
    File.write(output_path, JSON.pretty_generate(results))
end

domain = ARGV[0]
type = ARGV[1]
analyse(domain, type)
