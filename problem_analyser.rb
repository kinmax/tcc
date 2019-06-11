require 'json'
require 'byebug'
byebug
tar_path = ARGV[0]
system("tar -xjf #{tar_path}")

real_goal_file = File.open("real_hyp.dat", 'r')
real_goal = real_goal_file.read
real_goal_file.close
real_goal = real_goal.downcase

hyps_file = File.open("hyps.dat", "r")
hyps = hyps_file.read
hyps_file.close
hyps = hyps.downcase

obs_file = File.open("obs.dat", "r")
obs = obs_file.read
obs_file.close
obs = obs.downcase

problem_file = File.open("template.pddl", "r")
problem = problem_file.read
problem_file.close
problem = problem.downcase

domain_file = File.open("domain.pddl", "r")
domain = domain_file.read
domain_file.close
domain = domain.downcase

cmd_exhaust = "python3 /home/kingusmao/fd/fast-downward.py domain.pddl template.pddl --landmarks \"lm=lm_exhaust(reasonable_orders=false, only_causal_landmarks=false, disjunctive_landmarks=false, conjunctive_landmarks=true, no_orders=false)\" --heuristic \"hlm=lmcount(lm)\" --search \"astar(lmcut())\" > output.txt"
cmd_hm = "python3 /home/kingusmao/fd/fast-downward.py domain.pddl template.pddl --landmarks \"lm=lm_hm(reasonable_orders=false, only_causal_landmarks=false, disjunctive_landmarks=false, conjunctive_landmarks=true, no_orders=true)\" --heuristic \"hlm=lmcount(lm)\" --search \"astar(lmcut())\" > output.txt"
cmd_rhw = "python3 /home/kingusmao/fd/fast-downward.py domain.pddl template.pddl --landmarks \"lm=lm_rhw(reasonable_orders=false, only_causal_landmarks=false, disjunctive_landmarks=false, conjunctive_landmarks=true, no_orders=true)\" --heuristic \"hlm=lmcount(lm)\" --search \"astar(lmcut())\" > output.txt"
cmd_zg = "python3 /home/kingusmao/fd/fast-downward.py domain.pddl template.pddl --landmarks \"lm=lm_zg(reasonable_orders=false, only_causal_landmarks=false, disjunctive_landmarks=false, conjunctive_landmarks=true, no_orders=true)\" --heuristic \"hlm=lmcount(lm)\" --search \"astar(lmcut())\" > output.txt"


system("java -jar planning-utils-json_actions1.0.jar domain.pddl template.pddl landmarks.json")
system("ruby json_formatter.rb landmarks.json")
actions_file = File.open("landmarks.json", "r")
actions = actions_file.read
actions_file.close
actions = actions.downcase
acts = JSON.parse(actions)
achieved_lmarks = []
acts.keys.each do |key|
    if obs.include?(key)
        achieved_lmarks.push(acts[key]["preconditions"])
        achieved_lmarks.push(acts[key]["delete-effects"])
        achieved_lmarks.push(acts[key]["add-effects"])
        achieved_lmarks = achieved_lmarks.flatten
    end
end

pgrm = system(cmd_exhaust)
if !pgrm
    puts "[ERROR] Error while running: #{cmd_exhaust}"
end
lm_output_file = File.open("output.txt")
landmarks = lm_output_file.read
lm_output_file.close



