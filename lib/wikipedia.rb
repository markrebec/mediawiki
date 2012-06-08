Wikipedia = MediaWiki.new(
  :protocol => 'http',
  :domain => 'en.wikipedia.org',
  :path => 'w/api.php',
  :action => 'query',
  :properties => 'content'
)
