module Services
  class XmlParser
    def initialize(xml)
      @xml = xml
      create_filer
      create_awards_and_receivers
    end

    def xml_filer
      @xml_filer ||= XmlFiler.new(@xml)
    end

    def awards
      @awards ||= @xml.search('return').search('returndata').search('irs990schedulei').search('recipienttable')
    end

    def create_filer
      @filer = Filer.find_or_create_by(
        ein: xml_filer.ein,
        name: xml_filer.name,
        address: xml_filer.address,
        city: xml_filer.city,
        state: xml_filer.state,
        zip_code: xml_filer.zip_code
      )
    end

    def create_awards_and_receivers
      awards.each do |award_data|
        create_award(award_data)
        create_receiver(award_data)
        associate_award
      end
    end

    def create_receiver(xml_data)
      xml_receiver = XmlReceiver.new(xml_data)
      @receiver = Receiver.find_or_create_by(
        ein: xml_receiver.ein,
        name: xml_receiver.name,
        address: xml_receiver.address,
        city: xml_receiver.city,
        state: xml_receiver.state,
        zip_code: xml_receiver.zip_code
      )
    end

    def create_award(xml_data)
      xml_award = XmlAward.new(xml_data)
      @award = Award.find_or_create_by(filer: @filer, purpose: xml_award.purpose, cash_amount: xml_award.cash_amount)
    end

    def associate_award
      @filer.awards << @award
      @receiver.awards << @award
    end
  end

  class XmlFiler
    def initialize(xml)
      @xml = xml.search('return').search('returnheader').search('filer')
    end

    def ein
      @xml.search('ein').text
    end
  
    def us_address
      @xml.search('usaddress')
    end

    def address
      us_address.children.detect { |node| node.name.include? 'addressline' }.text
    end
  
    def city
      us_address.children.detect { |node| node.name.include? 'city' }.text
    end
  
    def state
      us_address.children.detect { |node| node.name.include? 'state' }.text
    end
  
    def zip_code
      us_address.children.detect { |node| node.name.include? 'zip' }.text
    end
  
    def name
      @xml.children.detect { |node| node.name.include? 'name' }.text.strip
    end
  end

  class XmlReceiver
    def initialize(xml)
      @xml = xml
    end

    def ein
      @xml.search('einofrecipient').text
    end
  
    def name
      @xml.children.detect { |node| node.name.include? 'name' }.text.strip
    end
  
    def us_address
      @xml.children.detect { |node| node.name.include? 'address' }
    end
  
    def address
      us_address.children.detect { |node| node.name.include? 'addressline1' }.text
    end
  
    def city
      us_address.children.detect { |node| node.name.include? 'city' }.text
    end
  
    def state
      us_address.children.detect { |node| node.name.include? 'state' }.text
    end
  
    def zip_code
      us_address.children.detect { |node| node.name.include? 'zip' }.text
    end
  end

  class XmlAward
    def initialize(xml)
      @xml = xml
    end

    def purpose
      @xml.children.detect { |node| node.name.include? 'purpose' }.text
    end
  
    def cash_amount
      @xml.children.detect { |node| (node.name.include?('amt') || node.name.include?('amount')) }.text
    end
  end
end