group :default do
  guard 'rails', :daemon => true do
    watch('Gemfile.lock')
    watch(%r{^config/(application\.rb|boot\.rb|database\.yml|environment\.rb|environments|initializers|routes\.rb).*})
    watch(%r{^(lib).*})
  end

  guard 'bundler' do
    watch('Gemfile')
  end
end
