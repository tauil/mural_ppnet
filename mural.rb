require 'rubygems'
require 'mechanize'
require 'nokogiri'

a = Mechanize.new
a.get('http://www.pontepreta.net/mural/mural.php') do |page|
  
  # Submit the login form
  my_page = page.form_with(:action => 'mural.php') do |f|
    f.mural_login  = ARGV[0]
    f.mural_senha  = "#{ARGV[1]}!#{ARGV[2]}"
  end.click_button

  my_page.search(".//tr").each do |base|
    puts "__________________________________________________________" unless base.search(".//td[@width='200']/span[@class='Texto']").empty?
    puts base.search(".//td[@width='200']/span[@class='Texto']").text unless base.search(".//td[@width='200']/span[@class='Texto']").empty?
    puts "---" unless base.search(".//td[@width='200']/span[@class='Texto']").empty?
    puts base.search(".//td[@width='550']/span[@class='Texto']").text.strip if base.search(".//td[@width='550']/span[@class='Texto']").text
  end

end
