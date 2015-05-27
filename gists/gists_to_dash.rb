#!/usr/bin/env ruby

# usage: ./gists_to_dash.rb embayer gists.dash ""

if ARGV[0].nil? || ARGV[0].match(/-h/)
  puts "Usage : #{$0} github_username dash_sqlite_db char_appended_to_keyword [no_comments]"
  exit
end

require 'net/http'
require 'open-uri'
#require 'awesome_print'
require 'uri'
require 'json'
require 'sqlite3'
require 'openssl'

#############
# Variables
#############

url =  "https://api.github.com/users/#{ARGV[0]}/gists"
tag_regex = /#\w+/

############
# Functions
############

def getHttpsContent(url)
  uri = URI.parse(url)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  request = Net::HTTP::Get.new(uri.request_uri)
  http.request(request).body
end

#############
# We get all the public gists
#############

puts "\nFetching #{url}...\n"
gists = JSON.parse getHttpsContent(url)
#ap gists

#############
# We list the gists and detect those we'll update
#############

gists_to_update = []
puts "Gists are :\n"
gists.each do |gist|
  puts "\t#{gist['description']}\n"
    unless (shortcut = gist['description']).empty?

    #gist['files'].each {|f| ap f}
    files = []
    gist['files'].each {|f| files << {:filename => f[0], :url => f[1]['raw_url']}}

    gists_to_update << {
      :shortcut => shortcut[0..-1],
      :files => files
    }
  end
end

puts "\n\nThose Dash snippets will be updated :\n"
gists_to_update.each {|x| puts "\t#{x[:shortcut]}#{ARGV[2]}"}
# gists_to_update.each {|x| puts "\t#{x[:shortcut]}#{ARGV[2]}"}

#############
# We update the database
#############

db = SQLite3::Database.new(ARGV[1])
#db.execute2 'SELECT * FROM snippets;' do |row|
#  ap row
#end

gists_to_update.each do |gist|
  content = ""
  gist[:files].each do |f|
    content << "\n\n### #{f[:filename]}\n\n" if ARGV[3].nil?
    open(f[:url]) {|c|
      c.each_line {|line| content << line}
    }
  end

  snippet_id = db.get_first_row( "SELECT sid FROM snippets WHERE title = ?","#{gist[:shortcut]}#{ARGV[2]}")
  if snippet_id.nil?
    db.execute( "INSERT INTO snippets VALUES (null, ?, ?, 'Standard', 0)",
  	"#{gist[:shortcut]}#{ARGV[2]}",
		content )
  else
    db.execute( "UPDATE snippets SET body = ? WHERE sid = ?",
		content,
		snippet_id )
  end
  puts "\n#{gist[:shortcut]}#{ARGV[2]} has been updated"
end
