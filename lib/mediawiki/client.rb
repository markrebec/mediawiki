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
      page = Page.new(request_page(title, {:query => "titles"}))
      while follow_redirects and page.redirect?
        page = Page.new(request_page(page.redirect_title, {:query => "titles"}))
      end
      page
    end

    def find_by_page_id(page_id)
      Page.new(request_page(page_id, {:query => "pageids"}))
    end
    
    def request_page(page, opts={})
      URI.parse(url_for(page, opts)).read
    end
    
    protected 
      
    def url_for(page, opts={})
      opts = {:query => "titles"}.merge(opts)
      "#{self.options[:protocol]}://#{self.options[:domain]}/#{self.options[:path]}?action=#{self.options[:action]}&prop=revisions&#{opts[:query]}=#{URI.encode(page.to_s)}&rvprop=#{[self.options[:properties]].flatten.join("|")}&format=json"
    end
  end
end
