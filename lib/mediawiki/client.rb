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
      page = Page.new(query(title, {:key => "titles"}))
      while follow_redirects and page.redirect?
        page = Page.new(query(page.redirect_title, {:key => "titles"}))
      end
      page
    end

    def find_by_page_id(page_id)
      Page.new(query(page_id, {:key => "pageids"}))
    end
    
    protected

    def query(page, opts={})
      page_url(page, opts).read
    end
      
    def page_url(page, opts={})
      opts = {:query => "titles"}.merge(opts)
      URI.parse("#{self.options[:protocol]}://#{self.options[:domain]}:#{self.options[:port]}/#{self.options[:path]}?format=json&action=query&prop=#{URI.encode("info|revisions|images|imageinfo")}&#{opts[:query]}=#{URI.encode(page.to_s)}&rvprop=content")
    end
  end
end
