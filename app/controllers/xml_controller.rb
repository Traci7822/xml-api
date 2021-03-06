require 'open-uri'

class XmlController < ApplicationController
  FILES = [
    'http://s3.amazonaws.com/irs-form-990/201132069349300318_public.xml',
    'http://s3.amazonaws.com/irs-form-990/201612429349300846_public.xml',
    'http://s3.amazonaws.com/irs-form-990/201521819349301247_public.xml',    
    'http://s3.amazonaws.com/irs-form-990/201641949349301259_public.xml',
    'http://s3.amazonaws.com/irs-form-990/201921719349301032_public.xml',
    'http://s3.amazonaws.com/irs-form-990/201831309349303578_public.xml',
    'http://s3.amazonaws.com/irs-form-990/201823309349300127_public.xml',
    'http://s3.amazonaws.com/irs-form-990/201401839349300020_public.xml',
    'http://s3.amazonaws.com/irs-form-990/201522139349100402_public.xml',
    'http://s3.amazonaws.com/irs-form-990/201831359349101003_public.xml'
  ].freeze

  def index
    parse_files
    redirect_to filers_path
  end

  private

  def parse_files
    FILES.each do |url|
      xml = Nokogiri::HTML(URI.open(url))
      Services::XmlParser.new(xml)
    end
  end
end