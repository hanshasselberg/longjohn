trap 'INT' do
  start_fresh "Done running tests."
  exit! 0
end

def run_spec(file)
  puts file
  return unless file.include?(" ") || File.exist?(file)
  start_fresh "Running specs..."
  system("time rspec -f nested -c #{file}")
end

def start_fresh(text=nil)
  print `clear`
  puts text if text
end

watch('^lib/(.*)\.rb') {|md| run_spec("spec/lib/#{md[1]}_spec.rb") }
watch('^app/models/(.*)\.rb') {|md| run_spec("spec/models/#{md[1]}_spec.rb") }
watch('^app/mailers/(.*)\.rb') {|md| run_spec("spec/mailers/#{md[1]}_spec.rb") }
watch('^app/controllers/(.*)\.rb') {|md| run_spec("spec/controllers/#{md[1]}_spec.rb") }
watch('^app/helpers/(.*)\.rb') {|md| run_spec("spec/helpers/#{md[1]}_spec.rb") }
watch('^app/views/(.*)\.[erb|haml]') {|md| run_spec("spec/integration/**/*_spec.rb") }
watch('^config/initializers/(.*)\.rb') {|md| run_spec("spec/initializers/#{md[1]}_spec.rb") }

watch('^spec/.*_spec\.rb')  {|md| run_spec(md[0]) }

