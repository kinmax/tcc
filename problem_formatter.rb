require 'json'

problem_path = File.join(File.dirname(__FILE__), ARGV[0])
goal_path = File.join(File.dirname(__FILE__), ARGV[1])
problem_file = File.open(problem_path, 'r')
goal_file = File.open(goal_path, 'r')
problem = problem_file.read
goal = goal_file.read
problem_file.close
goal_file.close

goal.gsub!(",", " ")
problem.gsub!("<HYPOTHESIS>", goal)

output_path = ARGV[2]
File.write(output_path, problem)

