require 'nokogiri'
require 'rest-client'

module Parse
    
    
    
    class Animal
        def self.cat #self를하면 new 한것과 같이 instance 화가 됨 
            url = "http://thecatapi.com/api/images/get?format=xml&type=jpg"
            cat_xml = RestClient.get(url)
            cat_doc = Nokogiri::XML(cat_xml)
            cat_url = cat_doc.xpath("//url").text
        end
    end
    
    class Baseball
        def self.Baseball #self를하면 new 한것과 같이 instance 화가 됨 
            url = "http://thecatapi.com/api/images/get?format=xml&type=jpg"
            baseball = RestClient.get(url)
            baseball_doc = Nokogiri::XML(cat_xml)
            baseball_url = baseball_doc.xpath("//url").text
        end
    end
            
    
end