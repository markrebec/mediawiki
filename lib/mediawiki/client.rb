module MediaWiki
  class Client
    attr_accessor :follow_redirects, :options
    
    def initialize(options={})
      self.options = {:follow_redirects => true}.merge(options)
      self.follow_redirects = self.options[:follow_redirects]
    end
    
    def find(page)
      page.is_a?(Integer) ? find_by_page_id(page) : find_by_title(page)
    end

    def find_by_title(title)
      page = Page.new(url_for(title, {:query => "titles"}).read)
      while follow_redirects and page.redirect?
        page = Page.new(url_for(page.redirect_title, {:query => "titles"}).read)
      end
      page
    end

    def find_by_page_id(page_id)
      Page.new(url_for(page_id, {:query => "pageids"}).read)
    end
    
    protected 
      
    def url_for(page, opts={})
      opts = {:query => "titles"}.merge(opts)
      URI.parse("#{self.options[:protocol]}://#{self.options[:domain]}/#{self.options[:path]}?action=#{self.options[:action]}&prop=#{URI.encode("info|revisions|images|imageinfo")}&#{opts[:query]}=#{URI.encode(page.to_s)}&rvprop=#{URI.encode([self.options[:properties]].flatten.join("|"))}&format=json")
    end
  end
end
