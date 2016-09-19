require "readline"

def run(code)
  Readline.readline

  code.each_line do |line|
    line = line.strip
    next if line.empty?

    puts "> #{line}"
    sleep 5
    eval(line)
    puts ""
    sleep 5
  end

  Readline.readline
end
