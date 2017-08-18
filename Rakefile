require 'pathname'
require_relative 'lib/issue'

rule '.md' do |t|
  issue_number = Pathname.new(t.name).basename('.md')
  issue = Issue.new(issue_number)
  File.open(t.name, 'w+') { |f| f.write(issue.markdown) }
end
