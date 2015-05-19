require 'puppetserver/acceptance/compat_utils'

test_name 'content file resource'

studio = "/tmp/simmons-studio-#{Process.pid}"
agent = nonmaster_agents().first

teardown do
  cleanup(studio)
end

step "Apply simmons::content_file to agent(s)" do
  apply_simmons_class(agent, master, studio, 'simmons::content_file')
end

step "Validate content-file" do
  contents = on(agent, "cat #{studio}/content-file").stdout.chomp
  assert_equal('Static content defined in manifest', contents)
end
