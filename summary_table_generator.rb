require 'json'
require 'byebug'

noise = ARGV[0]

filename = "new_results_goalcompletion"
filename += noise == "noisy" ? "_noisy.json" : ".json"

file_path = File.join(File.dirname(__FILE__), filename)
file = File.open(file_path, 'r')
raw = file.read
results = JSON.parse(raw)
output_path = "/home/kingusmao/tcc/summary_table.txt"

percentages = noise == "noisy" ? %w(25 50 75 100) : %w(10 30 50 70 100)
thresholds = %w(0 10)
algs = %w(exhaust hm rhw zg hoffmann)

values = {}
algs.each do |alg|
    values[alg] = {}
    values[alg]["landmarks_avg"] = 0
    percentages.each do |p|
        values[alg][p] = {}
        thresholds.each do |th|
            values[alg][p][th] = {}
            values[alg][p][th]["accuracy"] = 0
            values[alg][p][th]["time"] = 0
            values[alg][p][th]["spread"] = 0
        end
    end
end

results.each do |key, value|
    algs.each do |alg|
        values[alg]["landmarks_avg"] += value["landmarks_avg"][alg]/14.to_f
        percentages.each do |p|
            thresholds.each do |th|
                values[alg][p][th]["accuracy"] += value["observations"][p][alg]["accuracy"][th]/14.to_f
                values[alg][p][th]["time"] += value["observations"][p][alg]["time"][th]/14.to_f
                values[alg][p][th]["spread"] += value["spread"][p][alg][th].to_f/14.to_f
            end
        end
    end
end

table = "\\begin{table*}[ht]
\\centering
\\fontsize{6.5}{10}\\selectfont
\\setlength\\tabcolsep{3pt}
\\begin{tabular}{rrrrr@{\\hspace*{8mm}}rrr@{\\hspace*{8mm}}rrr@{\\hspace*{8mm}}rrr@{\\hspace*{8mm}}rrl}
\\toprule	
\\hline

&
& \\multicolumn{3}{c}{\\bf 10\\%}                                                             
& \\multicolumn{3}{c}{\\bf 30\\%}                                                             
& \\multicolumn{3}{c}{\\bf 50\\%}                                                             
& \\multicolumn{3}{c}{\\bf 70\\%}                                                             
& \\multicolumn{3}{c}{\\bf 100\\%}                                                          \\\\ \\hline

\\textbf{Approach}
& $|\\mathcal{L}|$
& \\multicolumn{1}{r}{\\bf Time} & \\multicolumn{1}{r}{\\bf Acc \\%} & \\multicolumn{1}{l}{\\bf S in $\\mathcal{G}$} 
& \\multicolumn{1}{r}{\\bf Time} & \\multicolumn{1}{r}{\\bf Acc \\%} & \\multicolumn{1}{l}{\\bf S in $\\mathcal{G}$} 
& \\multicolumn{1}{r}{\\bf Time} & \\multicolumn{1}{r}{\\bf Acc \\%} & \\multicolumn{1}{l}{\\bf S in $\\mathcal{G}$} 
& \\multicolumn{1}{r}{\\bf Time} & \\multicolumn{1}{r}{\\bf Acc \\%} & \\multicolumn{1}{l}{\\bf S in $\\mathcal{G}$} 
& \\multicolumn{1}{r}{\\bf Time} & \\multicolumn{1}{r}{\\bf Acc \\%} & \\multicolumn{1}{r}{\\bf S in $\\mathcal{G}$} \\\\ \\hline
      "

table = "\\begin{table*}[ht]
\\centering
\\fontsize{6.5}{10}\\selectfont
\\setlength\\tabcolsep{3pt}
\\begin{tabular}{rrrrr@{\\hspace*{8mm}}rrr@{\\hspace*{8mm}}rrr@{\\hspace*{8mm}}rrr@{\\hspace*{8mm}}rrl}
\\toprule	
\\hline

&
& \\multicolumn{3}{c}{\\bf 25\\%}                                                             
& \\multicolumn{3}{c}{\\bf 50\\%}                                                             
& \\multicolumn{3}{c}{\\bf 75\\%}                                                             
& \\multicolumn{3}{c}{\\bf 100\\%}                                                             \\\\ \\hline

\\textbf{Approach}
& $|\\mathcal{L}|$
& \\multicolumn{1}{r}{\\bf Time} & \\multicolumn{1}{r}{\\bf Acc \\%} & \\multicolumn{1}{l}{\\bf S in $\\mathcal{G}$} 
& \\multicolumn{1}{r}{\\bf Time} & \\multicolumn{1}{r}{\\bf Acc \\%} & \\multicolumn{1}{l}{\\bf S in $\\mathcal{G}$} 
& \\multicolumn{1}{r}{\\bf Time} & \\multicolumn{1}{r}{\\bf Acc \\%} & \\multicolumn{1}{l}{\\bf S in $\\mathcal{G}$} 
& \\multicolumn{1}{r}{\\bf Time} & \\multicolumn{1}{r}{\\bf Acc \\%} & \\multicolumn{1}{l}{\\bf S in $\\mathcal{G}$} \\\\ \\hline
      " if noise == "noisy"

algs.each do |alg|
    algorithm = case alg
    when "exhaust"
        "Exhaust"
    when "hm"
        "$h^m$"
    when "rhw"
        "RHW"
    when "zg"
        "Zhu \\& Givan"
    when "hoffmann"
        "Hoffmann"
    end
    thresholds.each do |th|
        table += "$\\mathit{h_{gc}}$ (#{algorithm} $\\theta = #{th}$) 
        & #{'%.1f' % values[alg]["landmarks_avg"]}"
        percentages.each do |p|
            table += " & #{'%.3f' % values[alg][p][th]["time"]} & #{'%.1f' % values[alg][p][th]["accuracy"]}\\% & #{'%.3f' % values[alg][p][th]["spread"]}
            "
        end
        table += "\\\\
        "
    end
end

table += "\\hline
"

filename = "new_results_uniqueness"
filename += noise == "noisy" ? "_noisy.json" : ".json"

file_path = File.join(File.dirname(__FILE__), filename)
file = File.open(file_path, 'r')
raw = file.read
results = JSON.parse(raw)

values = {}
algs.each do |alg|
    values[alg] = {}
    values[alg]["landmarks_avg"] = 0
    percentages.each do |p|
        values[alg][p] = {}
        thresholds.each do |th|
            values[alg][p][th] = {}
            values[alg][p][th]["accuracy"] = 0
            values[alg][p][th]["time"] = 0
            values[alg][p][th]["spread"] = 0
        end
    end
end

results.each do |key, value|
    algs.each do |alg|
        values[alg]["landmarks_avg"] += value["landmarks_avg"][alg]/14.to_f
        percentages.each do |p|
            thresholds.each do |th|
                values[alg][p][th]["accuracy"] += value["observations"][p][alg]["accuracy"][th]/14.to_f
                values[alg][p][th]["time"] += value["observations"][p][alg]["time"][th]/14.to_f
                values[alg][p][th]["spread"] += value["spread"][p][alg][th].to_f/14.to_f
            end
        end
    end
end

algs.each do |alg|
    algorithm = case alg
    when "exhaust"
        "Exhaust"
    when "hm"
        "$h^m$"
    when "rhw"
        "RHW"
    when "zg"
        "Zhu \\& Givan"
    when "hoffmann"
        "Hoffmann"
    end
    thresholds.each do |th|
        table += "$\\mathit{h_{uniq}}$ (#{algorithm} $\\theta = #{th}$) 
        & #{'%.1f' % values[alg]["landmarks_avg"]}"
        percentages.each do |p|
            table += " & #{'%.3f' % values[alg][p][th]["time"]} & #{'%.1f' % values[alg][p][th]["accuracy"]}\\% & #{'%.3f' % values[alg][p][th]["spread"]}
            "
        end
        table += "\\\\
        "
    end
end

table += "\\hline
"

caption = noise == "noisy" ? "Experiments and evaluation with missing, noisy and full observations." : "Experiments and evaluation with missing and full observations."
label = noise == "noisy" ? "tab:results_noisy" : "tab:results"
table += "\\bottomrule
\\end{tabular}
\\caption{#{caption}}
\\label{#{label}}	
\\end{table*}
"

File.write(output_path, table)