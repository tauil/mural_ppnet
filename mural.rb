require 'rubygems'
require 'mechanize' # gem install mechanize
require 'nokogiri'
require 'term/ansicolor' # gem install term-ansicolor

include Term::ANSIColor

a = Mechanize.new
a.get('http://www.pontepreta.net/mural/mural.php') do |page|
  
  # Submit the login form
  my_page = page.form_with(:action => 'mural.php') do |f|
    f.mural_login  = ARGV[0]
    f.mural_senha  = "#{ARGV[1]}!#{ARGV[2]}"
  end.click_button

  my_page.search(".//tr").each do |base|
    puts "__________________________________________________________" unless base.search(".//td[@width='200']/span[@class='Texto']").empty?
    puts yellow(base.search(".//td[@width='200']/span[@class='Texto']").text) unless base.search(".//td[@width='200']/span[@class='Texto']").empty?
    puts base.search(".//td[@width='550']/span[@class='Texto']").text if base.search(".//td[@width='550']/span[@class='Texto']").text
  end

end
