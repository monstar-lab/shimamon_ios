class MenuController < UIViewController
  def viewDidLoad
    super

    self.title = "その他"
    self.view.backgroundColor = UIColor.whiteColor

    staff_button = UIButton.buttonWithType(UIButtonTypeSystem)
    staff_button.setTitle("しまもんスタッフ", forState:UIControlStateNormal)
    staff_button.addTarget(self, action:"show_staff", forControlEvents:UIControlEventTouchUpInside)
    staff_button.frame = [[100, 100], [150, 32]]
    staff_button.center = [self.view.frame.size.width / 2, self.view.frame.size.height / 2 - 170]
    self.view.addSubview(staff_button)

    about_button = UIButton.buttonWithType(UIButtonTypeSystem)
    about_button.setTitle("島根開発拠点について", forState:UIControlStateNormal)
    about_button.addTarget(self, action:"show_contact", forControlEvents:UIControlEventTouchUpInside)
    about_button.frame = [[100, 100], [150, 32]]
    about_button.center = [self.view.frame.size.width / 2, self.view.frame.size.height / 2 - 100]
    self.view.addSubview(about_button)

    close_button = UIButton.buttonWithType(UIButtonTypeSystem)
    close_button.setTitle("閉じる", forState:UIControlStateNormal)
    close_button.addTarget(self, action:"close", forControlEvents:UIControlEventTouchUpInside)
    close_button.frame = [[100, 100], [150, 32]]
    close_button.center = [self.view.frame.size.width / 2, self.view.frame.size.height / 2 - 30]
    self.view.addSubview(close_button)

    label = UILabel.alloc.initWithFrame([[0, 0], [0, 0]])
    label.textColor = UIColor.grayColor
    label.text = '本アプリは、RubyでネイティブiOSアプリ開発をするための仕組み「RubyMotion」を利用して制作されました'
    label.sizeToFit
    label.lineBreakMode = NSLineBreakByWordWrapping
    label.numberOfLines = 0
    label.setFrame([[0, 0], [self.view.frame.size.width - 100, label.frame.size.height]])
    label.sizeToFit
    label.center = [self.view.frame.size.width / 2, self.view.frame.size.height / 2 + 100]
    self.view.addSubview(label)

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