require 'sinatra'
require 'sinatra/reloader'
require 'nokogiri'
require 'open-uri'

get '/currency' do
  doc = Nokogiri::XML(open("https://apiservice.mol.gov.tw/OdService/download/A17030000J-000049-H6s"))
  data_row = doc.xpath("//row")

  info = []
  data_row.size.times do |i|
    info << (data_row[i].element_children.map{ |n| {(n.name).to_sym => n.text }}).reduce({}, :merge)
  end
  info.reverse
  
  erb :index, locals: {info: info}
end