# frozen_string_literal: true

require 'byebug'

dataset_path = "/home/kingusmao/dataset-copy"
untarcmd = "tar -xjf "
tarcmd = "tar cvfj "


Dir.foreach(dataset_path) do |domain|
    if domain == "." || domain == ".." || domain == "README.md" || domain == ".zenodo.json" || domain == ".git" || domain.include?("noisy") || domain == ".gitignore"
        next
    end

    Dir.foreach("#{dataset_path}/#{domain}") do |percent|
        if percent == "." || percent == ".." || percent == "README.md" || percent == ".zenodo.json" || percent == ".git" || percent == ".gitignore"
            next
        end

        Dir.foreach("#{dataset_path}/#{domain}/#{percent}") do |tar|
            if tar == "." || tar == ".." || tar == "README.md" || tar == ".gitignore" || tar.include?("FILTERED")
                next
            end
            system(untarcmd + "#{dataset_path}/#{domain}/#{percent}/#{tar} > /dev/null" )
            system("ruby problem_formatter.rb template.pddl real_hyp.dat template.pddl > /dev/null")
            system(tarcmd + "#{dataset_path}/#{domain}/#{percent}/#{tar} *.dat *.pddl > /dev/null")
        end
    end
end

system("rm *.pddl *.dat")