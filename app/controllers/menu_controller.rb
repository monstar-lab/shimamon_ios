class MenuController < UIViewController
  def viewDidLoad
    super

    self.title = "その他"
    self.view.backgroundColor = UIColor.whiteColor

    @staff = UIButton.buttonWithType(UIButtonTypeSystem)
    @staff.setTitle("しまもんスタッフ", forState:UIControlStateNormal)
    @staff.addTarget(self, action:"show_staff", forControlEvents:UIControlEventTouchUpInside)
    self.view.addSubview(@staff)

    @contact = UIButton.buttonWithType(UIButtonTypeSystem)
    @contact.setTitle("島根開発拠点について", forState:UIControlStateNormal)
    @contact.addTarget(self, action:"show_contact", forControlEvents:UIControlEventTouchUpInside)
    self.view.addSubview(@contact)

    @close = UIButton.buttonWithType(UIButtonTypeSystem)
    @close.setTitle("閉じる", forState:UIControlStateNormal)
    @close.addTarget(self, action:"close", forControlEvents:UIControlEventTouchUpInside)
    self.view.addSubview(@close)

    @label = UILabel.new
    @label.textColor = UIColor.grayColor
    @label.text = '本アプリは、RubyでネイティブiOSアプリを開発できる「RubyMotion」を利用して制作されました'
    @label.sizeToFit
    @label.lineBreakMode = NSLineBreakByWordWrapping
    @label.numberOfLines = 0
    @label.setFrame([[0, 0], [self.view.frame.size.width - 100, @label.frame.size.height]])
    @label.sizeToFit
    self.view.addSubview(@label)

    margin = Device.orientation.to_s.match(/\Alandscape/) ? 25 : 50
    top = Device.orientation.to_s.match(/\Alandscape/) ? 70 : 150
    margin_h = Device.orientation.to_s.match(/\Alandscape/) ? 200 : 100

    Motion::Layout.new do |layout|
      layout.view self.view
      layout.metrics width: 150, height: 32, margin: margin, top: top, margin_h: margin_h
      layout.subviews staff: @staff, contact: @contact, close: @close, label: @label
      layout.vertical "|-top-[staff(height)]-margin-[contact(height)]-margin-[close(height)]-100-[label(100)]-20-|"
      layout.horizontal "|-margin_h-[staff]-margin_h-|"
      layout.horizontal "|-margin_h-[contact]-margin_h-|"
      layout.horizontal "|-margin_h-[close]-margin_h-|"
      layout.horizontal "|-40-[label]-40-|"
    end

  end

  def close
    self.dismissViewControllerAnimated(true, completion: nil)
  end

  def show_contact
    PostController.new.tap do |post_controller|
      post_controller.title = '島根開発拠点について'
      post_controller.url_key = 'contact'
      post_controller.author_url_key = ''
      self.navigationController.pushViewController(post_controller, animated:true)
    end
  end

  def show_staff
    PostController.new.tap do |post_controller|
      post_controller.title = 'しまもんスタッフ'
      post_controller.url_key = 'staff'
      post_controller.author_url_key = ''
      self.navigationController.pushViewController(post_controller, animated:true)
    end
  end

end