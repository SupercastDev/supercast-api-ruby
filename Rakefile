# frozen_string_literal: true

require 'rubocop/rake_task'

desc 'Update bundled certs'
task :update_certs do
  require 'faraday'

  fetch_file 'https://curl.haxx.se/ca/cacert.pem', ::File.expand_path('../lib/data/ca-certificates.crt', __FILE__)
end

#
# helpers
#

def fetch_file(url, dest)
  ::File.open(dest, 'w') do |file|
    resp = Faraday.get(url)
    abort("bad response when fetching: #{url}\nStatus #{resp.status}: #{resp.body}") unless resp.status == 200
    file.write(resp.body)
    puts "Successfully fetched: #{url}"
  end
end
