class ListImport
  class TaigaXML < ListImport
    validates :input_text, absence: true
    validates_attachment :input_file, content_type: {
      content_type: %w[application/xml]
    }, presence: true

    def count
      xml.css('anime').count
    end

    def each
      xml.css('anime').each do |anime|
        row = Row.new(anime)
        yield row.media, row.data
      end
    end

    private

    def xml
      @xml ||= Nokogiri::XML(open(input_file.url).read)
    end
  end
end