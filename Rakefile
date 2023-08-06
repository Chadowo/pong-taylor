
require 'fileutils'

task default: :run

def has_docker?
  case RUBY_PLATFORM
  when /windows/
    system('where docker')
  when /darwin/
    system('which docker')
  when /linux/
    system('which docker')
  end
end

desc 'Run the game'
task :run do
  unless File.exist?('taylor') || File.exist?('taylor.exe')
    raise RuntimeError, 'taylor executable not found!'
  end

  sh './taylor'
end

task :build do
  puts 'Checking for Docker...'
  unless has_docker?
    puts 'Docker not found! make sure it is installed properly and on PATH'
    puts 'see: https://www.docker.com/'
    puts

    raise RuntimeError
  end

  puts 'Generating exports...'

  Dir.mkdir('exports') unless Dir.exist?('exports')
  sh './taylor export'  

  puts 'Done!'
end