require 'json'
require 'byebug'

heuristic = ARGV[0]
noise = ARGV[1]

filename = "results_#{heuristic}_full"
filename += noise == "noisy" ? "_noisy.json" : ".json"

file_path = File.join(File.dirname(__FILE__), filename)
file = File.open(file_path, 'r')
raw = file.read
results = JSON.parse(raw)
output_path = "/home/kingusmao/t2-integradora/summary_table.txt"

percentages = noise == "noisy" ? %w(25 50 75 100) : %w(10 30 50 70 100)
thresholds = %w(0 10 20 30)
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
        values[alg]["landmarks_avg"] += value["landmarks_avg"][alg]/15.to_f
        percentages.each do |p|
            thresholds.each do |th|
                values[alg][p][th]["accuracy"] += value["observations"][p][alg]["accuracy"][th]/15.to_f
                values[alg][p][th]["time"] += value["observations"][p][alg]["time"][th]/15.to_f
                values[alg][p][th]["spread"] += value["spread"][p][alg][th].to_f/15.to_f
            end
        end
    end
end

table = "\\begin{table}[h]
\\centering
\\resizebox{\\textwidth}{!}{%
    \\begin{tabular}{|c|c|c|c|c|c|c|c|c|c|c|c|c|c|c|c|c|}
      \\hline
      \\multicolumn{2}{|c|}{}&\\multicolumn{3}{|c|}{\\textit{10\\%}}&\\multicolumn{3}{|c|}{\\textit{30\\%}}&\\multicolumn{3}{|c|}{\\textit{50\\%}}&\\multicolumn{3}{|c|}{\\textit{70\\%}}&\\multicolumn{3}{|c|}{\\textit{100\\%}}\\\\
      \\hline
      \\textbf{Approach}&$|\\mathcal{L}|$&\\textbf{Time (s)}&\\textbf{Accuracy (\\%)}&\\textbf{Spread}&\\textbf{Time (s)}&\\textbf{Accuracy (\\%)}&\\textbf{Spread}&\\textbf{Time (s)}&\\textbf{Accuracy (\\%)}&\\textbf{Spread}&\\textbf{Time (s)}&\\textbf{Accuracy (\\%)}&\\textbf{Spread}&\\textbf{Time (s)}&\\textbf{Accuracy (\\%)}&\\textbf{Spread}\\\\
      \\hline
      "

table = "\\begin{table}[h]
\\centering
\\resizebox{\\textwidth}{!}{%
    \\begin{tabular}{|c|c|c|c|c|c|c|c|c|c|c|c|c|c|c|c|c|}
      \\hline
      \\multicolumn{2}{|c|}{}&\\multicolumn{3}{|c|}{\\textit{25\\%}}&\\multicolumn{3}{|c|}{\\textit{50\\%}}&\\multicolumn{3}{|c|}{\\textit{75\\%}}&\\multicolumn{3}{|c|}{\\textit{100\\%}}\\\\
      \\hline
      \\textbf{Approach}&$|\\mathcal{L}|$&\\textbf{Time(s)}&\\textbf{Accuracy(\\%)}&\\textbf{Spread}&\\textbf{Time(s)}&\\textbf{Accuracy(\\%)}&\\textbf{Spread}&\\textbf{Time(s)}&\\textbf{Accuracy(\\%)}&\\textbf{Spread}&\\textbf{Time(s)}&\\textbf{Accuracy(\\%)}&\\textbf{Spread}\\\\
      \\hline
      " if noise == "noisy"

algs.each do |alg|
    algorithm = case alg
    when "exhaust"
        "Exhaust"
    when "hm"
        "h^m"
    when "rhw"
        "RHW"
    when "zg"
        "Zhu/Givan"
    when "hoffmann"
        "Hoffmann"
    end
    thresholds.each do |th|
        table += "\\makecell{#{algorithm} ($\\theta = #{th}$)} & #{'%.1f' % values[alg]["landmarks_avg"]}"
        percentages.each do |p|
            table += "& #{'%.3f' % values[alg][p][th]["time"]} & #{'%.1f' % values[alg][p][th]["accuracy"]} & #{'%.3f' % values[alg][p][th]["spread"]}"
        end
        table += " \\Bstrut \\\\ \\hline "
    end
end

# values = {}
# algs.each do |alg|
#     values[alg] = {}
#     values[alg]["landmarks_avg"] = 0
#     percentages.each do |p|
#         values[alg][p] = {}
#         thresholds.each do |th|
#             values[alg][p][th] = {}
#             values[alg][p][th]["accuracy"] = 0
#             values[alg][p][th]["time"] = 0
#             values[alg][p][th]["spread"] = 0
#         end
#     end
# end

# filename = "results_uniqueness_full"
# filename += noise == "noisy" ? "_noisy.json" : ".json"

# file_path = File.join(File.dirname(__FILE__), filename)
# file = File.open(file_path, 'r')
# raw = file.read
# results = JSON.parse(raw)

# results.each do |key, value|
#     algs.each do |alg|
#         values[alg]["landmarks_avg"] += value["landmarks_avg"][alg]/15.to_f
#         percentages.each do |p|
#             thresholds.each do |th|
#                 values[alg][p][th]["accuracy"] += value["observations"][p][alg]["accuracy"][th]/15.to_f
#                 values[alg][p][th]["time"] += value["observations"][p][alg]["time"][th]/15.to_f
#                 values[alg][p][th]["spread"] += value["spread"][p][alg][th].to_f/15.to_f
#             end
#         end
#     end
# end

# algs.each do |alg|
#     algorithm = case alg
#     when "exhaust"
#         "Exhaust"
#     when "hm"
#         "h^m"
#     when "rhw"
#         "RHW"
#     when "zg"
#         "Zhu/Givan"
#     when "hoffmann"
#         "Hoffmann"
#     end
#     thresholds.each do |th|
#         table += "\\makecell{h_{uniq} + #{algorithm} ($\\theta = #{th}$)} & #{'%.1f' % values[alg]["landmarks_avg"]}"
#         percentages.each do |p|
#             table += "& #{'%.3f' % values[alg][p][th]["time"]} & #{'%.1f' % values[alg][p][th]["accuracy"]} & #{'%.3f' % values[alg][p][th]["spread"]}"
#         end
#         table += " \\Bstrut \\\\ \\hline "
#     end
# end

caption = "Resultados"
caption += " Noisy" if noise == "noisy"
table += " \\end{tabular}}
\\caption{#{caption}}
\\label{table:resultados}
\\end{table}"

File.write(output_path, table)