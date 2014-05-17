# A sample Guardfile
# More info at https://github.com/guard/guard#readme

group :integration do
  guard 'kitchen' do
    watch(%r{test/.+})
    watch(%r{^recipes/(.+)\.rb$})
    watch(%r{^attributes/(.+)\.rb$})
    watch(%r{^files/(.+)})
    watch(%r{^templates/(.+)})
    watch(%r{^providers/(.+)\.rb})
    watch(%r{^resources/(.+)\.rb})
  end
end

group :specs do
  guard :rspec, cmd: 'bundle exec rspec', :all_on_start => false do
    watch(%r{^spec/(.+)_spec\.rb$})
    watch(%r{^(recipes)/(.+)\.rb$})   { |m| "spec/#{m[1]}_spec.rb" }
    watch('spec/spec_helper.rb')      { 'spec' }
  end
end
