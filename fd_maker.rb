file = File.open("/home/kin/tcc/domains.txt", "r")
raw = file.read
file.close
domains = raw.split("\n")
domains.each do |domain|
    system("mkdir /home/kin/tcc/#{domain}/fd")
    system("hg clone http://hg.fast-downward.org /home/kin/tcc/#{domain}/fd")
    lm_fac_file = File.open("/home/kin/tcc/#{domain}/fd/src/search/landmarks/landmark_factory.cc", "r")
    lm_fac = lm_fac_file.read
    lm_fac_file.close
    lm_fac.gsub!("//lm_graph->dump();", "cout << \"############################################################################\" << endl;\nlm_graph->dump(task_proxy.get_variables());\ncout << \"############################################################################\" << endl;\nexit(0);")
    File.write("/home/kin/tcc/#{domain}/fd/src/search/landmarks/landmark_factory.cc", lm_fac)
    system("python3 /home/kin/tcc/#{domain}/fd/build.py")
end
