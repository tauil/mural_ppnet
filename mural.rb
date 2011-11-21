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

  my_page.search(".//span[@class='Texto']").each do |base|
    puts base.search(".//font[@color='#FFFF66']").text
    puts base.search(".//p[@align='justify']").text
    puts "\n ---------------------------------------------- \n"
  end

end
