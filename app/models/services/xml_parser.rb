module Services
  class XmlParser
    def initialize(xml)
      @xml = xml
      create_filer
      create_awards_and_receivers
    end

    def xml_filer
      @xml_filer ||= XML_Filer.new(@xml)
    end

    def awards
      @awards ||= @xml.search('return').search('returndata').search('irs990schedulei').search('recipienttable')
    end

    def create_filer
      @filer = Filer.find_or_create_by(ein: xml_filer.ein, name: xml_filer.name, address: xml_filer.address, city: xml_filer.city, state: xml_filer.state, zip_code: xml_filer.zip_code)
    end

    def create_awards_and_receivers
      awards.each do |award_data|
        create_award(award_data)
        create_receiver(award_data)
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
      @xml = xml.search('return').search('returnheader').search('filer')
    end

    def ein
      @xml.search('ein').text
    end
  
    def us_address
      @xml.search('usaddress')
    end

    def address
      us_address.children.select { |node| node.name.include? 'addressline' }.first.text
    end
  
    def city
      us_address.children.select { |node| node.name.include? 'city' }.first.text
    end
  
    def state
      us_address.children.select { |node| node.name.include? 'state' }.first.text
    end
  
    def zip_code
      us_address.children.select { |node| node.name.include? 'zip' }.first.text
    end
  
    def name
      @xml.children.select { |node| node.name.include? 'name' }.first.text.strip
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
      @xml.children.select { |node| node.name.include? 'name' }.first.text.strip
    end
  
    def us_address
      @xml.children.select { |node| node.name.include? 'address' }.first
    end
  
    def address
      us_address.children.select { |node| node.name.include? 'addressline1' }.first.text
    end
  
    def city
      us_address.children.select { |node| node.name.include? 'city' }.first.text
    end
  
    def state
      us_address.children.select { |node| node.name.include? 'state' }.first.text
    end
  
    def zip_code
      us_address.children.select { |node| node.name.include? 'zip' }.first.text
    end
  end

  class XML_Award
    def initialize(xml)
      @xml = xml
    end

    def purpose
      @xml.children.select { |node| node.name.include? 'purpose' }.first.text
    end
  
    def cash_amount
      @xml.children.select { |node| (node.name.include?('amt') || node.name.include?('amount')) }.first.text
    end
  end
end