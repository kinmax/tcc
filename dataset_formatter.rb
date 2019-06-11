# frozen_string_literal: true

require 'byebug'

dataset_path = "/home/kingusmao/dataset-copy"
untarcmd = "tar -xjf "
tarcmd = "tar cvfj "
percentages = %w(10 30 50 70 100).freeze


Dir.foreach(dataset_path) do |domain|
    if domain == "." || domain == ".." || domain == "README.md" || domain == ".zenodo.json" || domain == ".git" || domain.include?("noisy") || domain == ".gitignore"
        next
    end

    Dir.foreach("#{dataset_path}/#{domain}") do |percent|
        unless percentages.include?(percent)
            next
        end

        Dir.foreach("#{dataset_path}/#{domain}/#{percent}") do |tar|
            if tar == "." || tar == ".." || tar == "README.md" || tar == ".gitignore" || tar.include?("FILTERED")
                next
            end
            puts tar
            system(untarcmd + "#{dataset_path}/#{domain}/#{percent}/#{tar} > /dev/null" )
            if(domain == "blocks-world")
                domain_file = File.open("domain.pddl", "r")
                dom = domain_file.read
                domain_file.close
                dom.gsub!("-block", "- block")
                File.write("domain.pddl", dom)
            end
            #system("ruby problem_formatter.rb template.pddl real_hyp.dat template.pddl > /dev/null")
            system(tarcmd + "#{dataset_path}/#{domain}/#{percent}/#{tar} *.dat *.pddl > /dev/null")
        end
    end
end

system("rm *.pddl *.dat")