require 'json'
require 'byebug'

start = Process.clock_gettime(Process::CLOCK_MONOTONIC)

domain = ARGV[0]

tar_path = ARGV[1]
system("tar -xjf #{tar_path}")

threshold = ARGV[2].to_f
recognized = []

method = ARGV[3]
case(method)
when "--exhaust"
    cmd = "python3 /home/kin/t2-integradora/#{domain}/fd/fast-downward.py /home/kin/t2-integradora/#{domain}/domain.pddl /home/kin/t2-integradora/#{domain}/problem.pddl --landmarks \"lm=lm_exhaust(reasonable_orders=false, only_causal_landmarks=false, disjunctive_landmarks=false, conjunctive_landmarks=true, no_orders=false)\" --heuristic \"hlm=lmcount(lm)\" --search \"astar(lmcut())\" > /home/kin/t2-integradora/#{domain}/output.txt"
when "--hm"
    cmd = "python3 /home/kin/t2-integradora/#{domain}/fd/fast-downward.py /home/kin/t2-integradora/#{domain}/domain.pddl /home/kin/t2-integradora/#{domain}/problem.pddl --landmarks \"lm=lm_hm(reasonable_orders=false, only_causal_landmarks=false, disjunctive_landmarks=false, conjunctive_landmarks=true, no_orders=true)\" --heuristic \"hlm=lmcount(lm)\" --search \"astar(lmcut())\" > /home/kin/t2-integradora/#{domain}/output.txt"
when "--rhw"
    cmd = "python3 /home/kin/t2-integradora/#{domain}/fd/fast-downward.py /home/kin/t2-integradora/#{domain}/domain.pddl /home/kin/t2-integradora/#{domain}/problem.pddl --landmarks \"lm=lm_rhw(reasonable_orders=false, only_causal_landmarks=false, disjunctive_landmarks=false, conjunctive_landmarks=true, no_orders=true)\" --heuristic \"hlm=lmcount(lm)\" --search \"astar(lmcut())\" > /home/kin/t2-integradora/#{domain}/output.txt"
when "--zg"
    cmd = "python3 /home/kin/t2-integradora/#{domain}/fd/fast-downward.py /home/kin/t2-integradora/#{domain}/domain.pddl /home/kin/t2-integradora/#{domain}/problem.pddl --landmarks \"lm=lm_zg(reasonable_orders=false, only_causal_landmarks=false, disjunctive_landmarks=false, conjunctive_landmarks=true, no_orders=true)\" --heuristic \"hlm=lmcount(lm)\" --search \"astar(lmcut())\" > /home/kin/t2-integradora/#{domain}/output.txt"
else
    cmd = "python3 /home/kin/t2-integradora/#{domain}/fd/fast-downward.py /home/kin/t2-integradora/#{domain}/domain.pddl /home/kin/t2-integradora/#{domain}/problem.pddl --landmarks \"lm=lm_exhaust(reasonable_orders=false, only_causal_landmarks=false, disjunctive_landmarks=false, conjunctive_landmarks=true, no_orders=false)\" --heuristic \"hlm=lmcount(lm)\" --search \"astar(lmcut())\" > /home/kin/t2-integradora/#{domain}/output.txt"
end

real_goal_file = File.open("/home/kin/t2-integradora/#{domain}/real_hyp.dat", 'r')
real_goal = real_goal_file.read
real_goal_file.close
real_goal = real_goal.downcase
real_goal.strip!

visited_facts = []

initial_state_file = File.open("/home/kin/t2-integradora/#{domain}/template.pddl", 'r')
initial_state = initial_state_file.read
initial_state_file.close
initial_state = initial_state.downcase
initial_state = initial_state.split("(:init")[1].split("(:goal")[0].gsub("(", "").gsub(")", "").strip
split_initials = initial_state.split("\n")
split_initials.each do |fact|
    unless fact.strip.empty?
        visited_facts.push(fact)
    end
end

hyps_file = File.open("/home/kin/t2-integradora/#{domain}/hyps.dat", "r")
hyps = hyps_file.read
hyps_file.close
hyps = hyps.downcase
split_hyps = hyps.split("\n")
candidates = []
split_hyps.each do |hyp|
    if hyp.empty?
        next
    end
    hyp.strip!
    candidates.push(hyp)
end

system("ruby problem_formatter.rb /home/kin/t2-integradora/#{domain}/template.pddl /home/kin/t2-integradora/#{domain}/real_hyp.dat /home/kin/t2-integradora/#{domain}/problem.pddl")

obs_file = File.open("/home/kin/t2-integradora/#{domain}/obs.dat", "r")
observs = obs_file.read
obs_file.close
observs = observs.downcase
obs = observs.split("\n")
obs.reject! { |c| c.empty? }
obs.each do |ob|
    ob.gsub!("(", "")
    ob.gsub!(")", "")
    ob.strip!
end

problem_file = File.open("/home/kin/t2-integradora/#{domain}/problem.pddl", "r")
problem = problem_file.read
problem_file.close
problem = problem.downcase

domain_file = File.open("/home/kin/t2-integradora/#{domain}/domain.pddl", "r")
dom = domain_file.read
domain_file.close
dom = dom.downcase

system("java -jar planning-utils-json_actions1.0.jar /home/kin/t2-integradora/#{domain}/domain.pddl /home/kin/t2-integradora/#{domain}/problem.pddl /home/kin/t2-integradora/#{domain}/landmarks.json > /dev/null")
system("ruby /home/kin/t2-integradora/json_formatter.rb /home/kin/t2-integradora/#{domain}/landmarks.json")
actions_file = File.open("/home/kin/t2-integradora/#{domain}/landmarks.json", "r")
actions = actions_file.read
actions_file.close
actions = actions.downcase
acts = JSON.parse(actions)
keys = acts.keys
obs.each do |ob|
    h = acts[ob]
    if h.nil?
        next
    end
    visited_facts.push(h["preconditions"])
    visited_facts.push(h["delete-effects"])
    visited_facts.push(h["add-effects"])
    visited_facts = visited_facts.flatten
end
# acts.keys.each do |key|
#     if obs.include?(key)
#         visited_facts.push(acts[key]["preconditions"])
#         visited_facts.push(acts[key]["delete-effects"])
#         visited_facts.push(acts[key]["add-effects"])
#         visited_facts = visited_facts.flatten
#     end
# end

goals_scores = {}

landmark_avg = 0

landmarks_per_goal = {}

candidates.each do |candidate|

    File.write("/home/kin/t2-integradora/#{domain}/candidate.dat", candidate)
    
    system("ruby problem_formatter.rb /home/kin/t2-integradora/#{domain}/template.pddl /home/kin/t2-integradora/#{domain}/candidate.dat /home/kin/t2-integradora/#{domain}/problem.pddl")

    pgrm = system(cmd)
    if !pgrm
        puts "[ERROR] Error running: #{cmd}"
    end
    lm_output_file = File.open("/home/kin/t2-integradora/#{domain}/output.txt")
    landmarks = lm_output_file.read
    lm_output_file.close

    lms = []

    landmarks = landmarks.split("############################################################################")[1]
    landmarks = landmarks.split("Landmark graph: \n")[1].split("\nLandmark graph end.\n")[0]
    landmarks = landmarks.split("\n")
    landmarks.each do |lm|
        lm.strip!
        if lm.include?("conj") || lm.include?("->_nat") || lm.empty? || lm.include?("<none of those>") || lm == "Landmark graph end."
            next
        end
        negated = lm.include?("Negated")
        lm = lm.split("Atom")[1].split("(var")[0].strip
        lm = lm.gsub(", ", " ").gsub("(", " ").gsub(")", "")
        lm.strip!
        if negated
            lm = "not (#{lm})"
        end
        lms.push(lm)
    end

    landmarks_per_goal[candidate] = lms

    landmark_avg = landmark_avg + lms.length
end

landmarks_uniqueness = {}
landmark_set = []

candidates.each do |candidate|
    landmarks_per_goal[candidate].each do |lm|
        landmark_set.push(lm) unless landmark_set.include?(lm)
        landmarks_uniqueness[lm] = 0
    end
end

landmark_set.each do |lm|
    candidates.each do |candidate|
        if landmarks_per_goal[candidate].include?(lm)
            landmarks_uniqueness[lm] += 1
        end
    end
end

# candidates.each do |candidate|
#     candidates.each do |cd2|
#         landmarks_per_goal[candidate].each do |lm|
#             if landmarks_per_goal[cd2].include?(lm)
#                 landmarks_uniqueness[lm] += 1
#             end
#         end
#     end
# end

landmarks_uniqueness.each do |k,v|
    landmarks_uniqueness[k] = 1.to_f/v.to_f
end

achieved_landmarks_per_goal = {}
candidates.each do |candidate|
    achieved_landmarks_per_goal[candidate] = []
    uniqueness_sum = 0.to_f
    achieved_uniqueness_sum = 0.to_f
    landmarks_per_goal[candidate].each do |lm|
        if visited_facts.include?(lm)
            achieved_landmarks_per_goal[candidate].push(lm)
            achieved_uniqueness_sum = achieved_uniqueness_sum + landmarks_uniqueness[lm]
        end
        uniqueness_sum += landmarks_uniqueness[lm]
    end

    goals_scores[candidate] = landmarks_per_goal[candidate].length > 0 && uniqueness_sum > 0 ? achieved_uniqueness_sum.to_f/uniqueness_sum.to_f : 0.to_f
end

landmark_avg = landmark_avg.to_f/candidates.length.to_f

best = goals_scores.max_by{|k,v| v}
recognized.push(best[0])
goals_scores.keys.each do |goal|
    if goals_scores[goal] >= (best[1] - (best[1]*(threshold/100.0))) && goal != best[0]
        recognized.push(goal)
    end
end

puts "GOALS-#{candidates.length}"
puts "LANDMARKS_AVG-#{landmark_avg}"
puts "OBS-#{obs.length}"
puts "SPREAD-#{recognized.length}"

if recognized.include?(real_goal)
    puts "CORRECT-TRUE"
else
    puts "CORRECT-FALSE"
end

finish = Process.clock_gettime(Process::CLOCK_MONOTONIC)

time = finish - start

puts "TIME-#{time}"

puts "#"*50
recognized.each do |rg|
    puts "Recognized goal: #{rg} - score = #{goals_scores[rg]}\n"
    puts "Landmarks:"
    landmarks_per_goal[rg].each do |l|
        puts l
    end
    puts "\n"
    puts "Achieved Landmarks:"
    achieved_landmarks_per_goal[rg].each do |achieved_landmark|
        puts achieved_landmark
    end
    puts "$"*50
end
puts "Real Goal: #{real_goal} - score = #{goals_scores[real_goal]}\n"
puts "Landmarks:"
landmarks_per_goal[real_goal].each do |l|
    puts l
end
puts "\n"
puts "Achieved Landmarks:"
achieved_landmarks_per_goal[real_goal].each do |al|
    puts al
end
puts "#"*50
