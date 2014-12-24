class PostController < UIViewController
  PROPERTIES = [:author_url_key, :url_key, :title]
  attr_accessor *PROPERTIES

  def viewDidLoad
    super

    self.navigationItem.title = self.title

    @webview = UIWebView.new.tap do |v|
      v.frame = self.view.bounds
      v.scalesPageToFit = true
      v.loadRequest(NSURLRequest.requestWithURL(NSURL.URLWithString("http://shimane.monstar-lab.com/#{@author_url_key}/#{@url_key}")))
      v.delegate = self
      view.addSubview(v)
    end

    Motion::Layout.new do |layout|
      layout.view self.view
      layout.subviews webview: @webview
      layout.vertical "|[webview]|"
      layout.horizontal "|[webview]|"
    end

  end

  def title
    @title
  end

end