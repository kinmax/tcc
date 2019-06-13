file = File.open("/home/kin/t2-integradora/domains.txt", "r")
raw = file.read
file.close
domains = raw.split("\n")
domains.each do |domain|
    system("mkdir #{domain}")
end