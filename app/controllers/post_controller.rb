class PostController < UIViewController
  PROPERTIES = [:author_url_key, :url_key, :title]
  attr_accessor *PROPERTIES

  def viewDidLoad
    super

    self.navigationItem.title = self.title

    @webview = UIWebView.new.tap do |v|
      v.frame = self.view.bounds
      v.scalesPageToFit = true
      v.loadRequest(NSURLRequest.requestWithURL(NSURL.URLWithString("http://shimane.monstar-lab.com/#{@author_url_key}/#{@url_key}?mode=mobile_app")))
      v.delegate = self
      view.addSubview(v)
    end
  end

  def title
    @title
  end

end