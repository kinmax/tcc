require 'json'
require 'byebug'

tar_path = ARGV[0]
system("tar cvfj #{tar_path}")

real_goal_file = File.open("real_hyp.dat", 'r')
real_goal = real_goal_file.read
real_goal_file.close
real_goal.downcase

hyps_file = File.open("hyps.dat", "r")
hyps = hyps_file.read
hyps_file.close
hyps.downcase

obs_file = File.open("obs.dat", "r")
obs = obs_file.read
obs_file.close
obs.downcase

problem_file = File.open("template.pddl", "r")
problem = problem_file.read
problem_file.close

domain_file = File.open("domain.pddl", "r")
domain = domain_file.read
domain_file.close

cmd_exhaust = "python3 /home/kingusmao/fd/fast-downward.py ~/dataset-copy/domain.pddl ~/dataset-copy/template.pddl --landmarks \"lm=lm_exhaust(reasonable_orders=false, only_causal_landmarks=false, disjunctive_landmarks=true, conjunctive_landmarks=true, no_orders=false)\" --heuristic \"hlm=lmcount(lm)\" --search \"astar(lmcut())\""

system("java -jar planning-utils-json_actions1.0.jar domain.pddl template.pddl landmarks.json")
lms_file = File.open("landmarks.json", "r")
landmarks = lms_file.read
lms_file.close
landmarks.downcase
lms = JSON.parse(landmarks)
achieved_lmarks = []
lms.keys.each do |key|
    if obs.include?(key)
        achieved_lmarks.push(lms[key]["preconditions"])
        achieved_lmarks.push(lms[key]["delete-effects"])
        achieved_lmarks.push(lms[key]["add-effects"])
        achieved_lmarks = lmarks.flatten
    end
end


