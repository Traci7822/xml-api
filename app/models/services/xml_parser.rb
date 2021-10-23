module Services
  class XmlParser
    def initialize(xml)
      @xml = xml
      create_filer
      create_receivers_and_awards
    end

    def xml_filer
      @xml_filer ||= XML_Filer.new(@xml)
    end

    def receivers
      if @xml.search('recipienttable').present?
        @receivers = @xml.search('recipienttable')
      else
        @receivers = @xml.search('grantorcontributionpdduryrgrp')
      end
    end

    def create_filer
      @filer = Filer.find_or_create_by(ein: xml_filer.ein, name: xml_filer.name, address: xml_filer.address, city: xml_filer.city, state: xml_filer.state, zip_code: xml_filer.zip_code)
    end

    def create_receivers_and_awards
      receivers.each do |receiver_data|
        create_receiver(receiver_data)
        create_award(receiver_data)
        associate_award
      end
    end

    def create_receiver(xml_data)
      xml_receiver = XML_Receiver.new(xml_data)
      @receiver = Receiver.find_or_create_by(ein: xml_receiver.ein, name: xml_receiver.name, address: xml_receiver.address, city: xml_receiver.city, state: xml_receiver.state, zip_code: xml_receiver.zip_code)
    end

    def create_award(xml_data)
      xml_award = XML_Award.new(xml_data)
      @award = Award.find_or_create_by(filer: @filer, purpose: xml_award.purpose, cash_amount: xml_award.cash_amount)
    end

    def associate_award
      @filer.awards << @award
      @receiver.awards << @award
    end
  end

  class XML_Filer
    def initialize(xml)
      @recipient_table = xml.name == "recipienttable"
      @xml = xml.search('filer')
    end

    def ein
      @xml.search('ein').text
    end
  
    def us_address
      @xml.search('usaddress')
    end

    def address
      @recipient_table ? us_address.search('addressline1').text : us_address.search('addressline1txt').text
    end
  
    def city
      @recipient_table ? us_address.search('city').text : us_address.search('citynm').text
    end
  
    def state
      @recipient_table ? us_address.search('state').text : us_address.search('stateabbreviationcd').text
    end
  
    def zip_code
      @recipient_table ? us_address.search('zipcode').text : us_address.search('zipcd').text
    end
  
    def name
      text = @recipient_table ? @xml.search('name').text : @xml.search('businessname').text
      text.strip
    end
  end

  class XML_Receiver
    def initialize(xml)
      @xml = xml
      @recipient_table = xml.name == "recipienttable"
    end

    def ein
      @xml.search('einofrecipient').text
    end
  
    def name
      xml_name = @recipient_table ? @xml.search('businessnameline1') : @xml.search('businessnameline1txt')
      xml_name.text.strip
    end
  
    def address_us
      @address_us ||= @recipient_table ? @xml.search('addressus') : @xml.search('recipientusaddress')
    end
  
    def address
      @recipient_table ? address_us.search('addressline1').text : address_us.search('addressline1txt').text
    end
  
    def city
      @recipient_table ? address_us.search('city').text : address_us.search('citynm').text
    end
  
    def state
      @recipient_table ? address_us.search('state').text : address_us.search('stateabbreviationcd').text
    end
  
    def zip_code
      @recipient_table ? address_us.search('zipcode').text : address_us.search('zipcd').text
    end
  end

  class XML_Award
    def initialize(xml)
      @xml = xml
      @recipient_table = xml.name == "recipienttable"
    end

    def purpose
      @recipient_table ? @xml.search('purposeofgrant').text : @xml.search('grantorcontributionpurposetxt').text
    end
  
    def cash_amount
      @recipient_table ? @xml.search('amountofcashgrant').text : @xml.search('amt').text
    end
  end
end