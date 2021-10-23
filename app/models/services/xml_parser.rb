module Services
  class XmlParser
    def initialize(xml)
      @xml = xml
      create_filer
      create_receivers
    end

    def xml_filer
      @xml_filer ||= XML_Filer.new(@xml)
    end

    def receivers
      @receivers ||= @xml.search('returndata').search('recipienttable')
    end

    def create_filer
      @filer = Filer.find_or_create_by(ein: xml_filer.ein, name: xml_filer.name, address: xml_filer.address, city: xml_filer.city, state: xml_filer.state, zip_code: xml_filer.zip_code)
    end

    def create_receivers
      receivers.each do |receiver_data|
        receiver = XML_Receiver.new(receiver_data)
        xml_award = XML_Award.new(receiver_data)
        receiver = Receiver.find_or_create_by(ein: receiver.ein, name: receiver.name, address: receiver.address, city: receiver.city, state: receiver.state, zip_code: receiver.zip_code)
        receiver.awards.find_or_create_by(filer: @filer, purpose: xml_award.purpose, cash_amount: xml_award.cash_amount)
      end
    end
  end

  class XML_Filer
    def initialize(xml)
      @filer = xml.search('filer')
    end

    def ein
      @filer.search('ein').text
    end
  
    def address
      @filer.search('usaddress').search('addressline1').text
    end
  
    def city
      @filer.search('city').text
    end
  
    def state
      @filer.search('state').text
    end
  
    def zip_code
      @filer.search('zipcode').text
    end
  
    def name
      @filer.search('name').text.strip
    end
  end

  class XML_Receiver
    def initialize(xml)
      @xml = xml
    end

    def ein
      @xml.search('einofrecipient').text
    end
  
    def name
      @xml.search('recipientnamebusiness').search('businessnameline1').text
    end
  
    def address_us
      @address_us ||= @xml.search('addressus')
    end
  
    def address
      address_us.search('addressline1').text
    end
  
    def city
      address_us.search('city').text
    end
  
    def state
      address_us.search('state').text
    end
  
    def zip_code
      address_us.search('zipcode').text
    end
  end

  class XML_Award
    def initialize(xml_data)
      @xml_data = xml_data
    end

    def purpose
      @xml_data.search('purposeofgrant').text
    end
  
    def cash_amount
      @xml_data.search('amountofcashgrant').text
    end
  end
end