Dir[File.dirname(__FILE__) + '/mediawiki/*.rb'].each { |f| require f }

module MediaWiki
  class MediaWiki
    def initialize(options={})
      options = {
        :protocol => 'http',
        :domain => 'en.wikipedia.org',
        :path => 'w/api.php',
        :action => 'query',
        :properties => 'content'
      }.merge(options)
      @client = Client.new(options)
    end

    def find(page)
      @client.find(page)
    end
  end

  def self.new(options={})
    MediaWiki.new(options)
  end
end
