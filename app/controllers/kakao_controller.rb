require 'parse' #만든 모듈 parse.rb 파일 사용하기

class KakaoController < ApplicationController
  def keyboard
    @keyboard = {
        :type => "buttons",
        :buttons => ["메뉴", "로또", "고양이", "선물줘", "프로야구"]
    }
    
    render json: @keyboard
    
  end
  
  def message
    puts "message!"
    @user_msg = params[:content]
    puts "1"
    # puts @user_msg
    @text = "기본응답"
    
    if @user_msg == "메뉴"
      puts "menu"
      @text = ["짬뽕", "볶음밥","짜장면"].sample
    elsif @user_msg == "로또"
      puts "lotto"
      @text = (1..45).to_a.sample(6).sort.to_s
    elsif @user_msg =="고양이"
      puts "고양이123"
      # @url = "http://thecatapi.com/api/images/get?format=xml&type=jpg"
      # @cat_xml = RestClient.get(@url)
      # @cat_doc = Nokogiri::XML(@cat_xml)
      # @cat_url = @cat_doc.xpath("//url").text
      # @text = @cat_url
      @cat_url = Parse::Animal.cat
    elsif @user_msg == "선물줘"
      puts "선물줘"
      @url = "http://thecatapi.com/api/images/get?format=xml&type=jpg"
      @cat_xml = RestClient.get(@url)
      @cat_doc = Nokogiri::XML(@cat_xml)
      @cat_url = @cat_doc.xpath("//url").text
      @text = @cat_url
    elsif @user_msg == "프로야구"
      puts "프로야구22"
      @url = "https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=1&ie=utf8&query=%ED%94%84%EB%A1%9C%EC%95%BC%EA%B5%AC"
      @baceball_xml = RestClient.get(@url)
      @baceball_doc = Nokogiri::HTML(@baceball_xml)
      puts "url"
      @baceball_url = @baceball_doc.css("td.team")
      
      # @result = []
      # @baceball_url.each do |team| 
      #   @result << team.text.strip
      # end
      # puts @baceball_url
      # @text = @result.to_s
      
      @result = ""
      @baceball_url.each_with_index do |team, i| 
        @result << "#{i+1}. " + team.text.strip + "\n"
      end
      puts @baceball_url
      @text = @result
      
    end
    
    
    @return_msg = {
      :text => @text
    }
    
    @return_msg_photo = {
      :text  => "나만 고양이 없어 :(",
      :photo => {
                  :url => @cat_url,
                  :width => 720, 
                  :height => 630 
        
      }
    }
    
    @return_bt_test = {
      :text => "되거라",
      :message_button =>  {
        :label =>  "쿠폰확인하기",
        :url => "http://www.naver.com"
      }
    }
    
    
    
    @return_keyboard = {  
      :type => "buttons",
      :buttons => ["메뉴", "로또", "고양이", "선물줘", "프로야구"]
    }
    
    
    
    
    if @user_msg == "고양이"
      @result = {
        :message => @return_msg_photo,
        :keyboard => @return_keyboard 
      } 
    elsif  @user_msg == "선물줘"
        @result = {
        :message => @return_bt_test,
        :keyboard => @return_keyboard 
      } 
    else
      puts "here????"
      @result = {
        :message => @return_msg,
        :keyboard => @return_keyboard 
      }
    end
    
    
    
    render json: @result
    
  end
  
  def friend_add
    User.create(user_key: params[:user_key], chat_room: 0)
    render nothing: true
  end
  
  def friend_delete
    User.find_by(user_key: params[:user_key]).destroy
    render nothing: true
  end
  
  def chat_room
    user = User.find_by(user_key: params[:user_key])
    user.plus
    user.save
    render nothing: true
  end
  
  
  
end
