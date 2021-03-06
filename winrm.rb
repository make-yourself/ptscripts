require 'winrm'
require 'optparse'
require 'ostruct'


options = OpenStruct.new
OptionParser.new do |opt| 
  opt.on('-e', '--endpoint', 'endpoint') { |o| options.endpoint = o }                                                                                                                              
  opt.on('-u', '--username', 'username') { |o| options.username = o }
  opt.on('-p', '--password', 'password') { |o| options.password = o } 
end.parse!


conn = WinRM::Connection.new( 
  endpoint: options.endpoint,
  user: options.username,
  password: options.password,
)

command=""

conn.shell(:powershell) do |shell|
  until command == "exit\n" do
    print "PS > "
    command = gets        
    output = shell.run(command) do |stdout, stderr|
      STDOUT.print stdout
      STDERR.print stderr
    end
  end    
  puts "Exiting with code #{output.exitcode}"
end

options = OpenStruct.new
OptionParser.new do |opt|
  opt.on('-e', '--endpoint', 'endpoint') { |o| options.endpoint = o }
  opt.on('-u', '--username', 'username') { |o| options.username = o }
  opt.on('-p', '--password', 'password') { |o| options.password = o }
end.pare
