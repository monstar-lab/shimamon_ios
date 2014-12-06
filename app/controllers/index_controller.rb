class IndexController < UIViewController
  def viewDidLoad
    super

    self.title = "しまもん・記事一覧"

    menu_button = BW::UIBarButtonItem.styled(:plain, '⚙') { show_menu }
    menu_button.setTitleTextAttributes({
      UITextAttributeFont => UIFont.fontWithName('Helvetica', size:24),
      UITextAttributeTextShadowColor => UIColor.colorWithWhite(0.0, alpha:0.4),
      UITextAttributeTextColor => UIColor.grayColor
    }, forState:UIControlStateNormal)
    self.navigationItem.RightBarButtonItem = menu_button;

    @table = UITableView.alloc.initWithFrame(self.view.bounds)
    @table.rowHeight = 80
    @table.autoresizingMask = UIViewAutoresizingFlexibleHeight
    self.view.addSubview(@table)

    @table.dataSource = self
    @table.delegate = self

    Motion::Layout.new do |layout|
      layout.view self.view
      layout.subviews table: @table
      layout.vertical "|[table]|"
      layout.horizontal "|[table]|"
    end

    @next_page = 1
    @posts = []
    @indicator = UIActivityIndicatorView.alloc.initWithActivityIndicatorStyle(UIActivityIndicatorViewStyleGray)
    @indicator.stopAnimating

    load_more
  end

  def show_menu
    menu_controller = MenuController.alloc.initWithNibName(nil, bundle:nil)
    self.presentViewController(
      UINavigationController.alloc.initWithRootViewController(menu_controller),
      animated:true,
      completion: lambda {})
  end

  def load_more
    Post.index(page: @next_page) do |post|
      @posts << post
      @table.reloadData
    end
    @next_page += 1
    end_indicator
  end

  # UITableView に必須のメソッド
  def tableView(tableView, numberOfRowsInSection: section)
    @posts.count
  end

  # UITableView に必須のメソッド
  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier)
    cell ||= UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier:@reuseIdentifier)

    cell.textLabel.text = @posts[indexPath.row].title
    cell.detailTextLabel.text = @posts[indexPath.row].posted_at + ' by ' + @posts[indexPath.row].author_name
    cell.detailTextLabel.textColor = UIColor.grayColor

    # ↓を有効にすると、ページ読み込みごとに全cellのりレンダリングが走る感じで苦しい
    #   無効にすると、下から出てくるcellにループ対面のデータが入っているのが一瞬みえてから更新されて苦しい……
    # cell.imageView.image = nil

    Dispatch::Queue.concurrent.async{
      # 重い処理を別スレッドでやる
      imageURL = NSURL.URLWithString(@posts[indexPath.row].cover_photo_url)
      nsData = NSData.dataWithContentsOfURL(imageURL)
      image = UIImage.imageWithData(nsData)
      Dispatch::Queue.main.async{
        # UI更新はメインスレッドから叩く
        cell.imageView.image = image
        cell.layoutSubviews
      }
    }

    cell
  end

 def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)

    PostController.new.tap do |post_controller|
      post_controller.title = @posts[indexPath.row].title
      post_controller.url_key = @posts[indexPath.row].url_key
      post_controller.author_url_key = @posts[indexPath.row].author_url_key
      self.navigationController.pushViewController(post_controller, animated:true)
    end
  end

  def scrollViewDidScroll(scrollView)
    if @table.contentOffset.y >= @table.contentSize.height - @table.bounds.size.height
      return if @indicator.isAnimating
      start_indicator
      self.performSelector('load_more', withObject: nil, afterDelay: 1.0)
    end
  end

  def start_indicator
    @indicator.startAnimating
    @indicator.frame = [[0, 0], [self.view.frame.size.width / 2, self.view.frame.size.height / 8]]  # このへんは適当に
    @table.setTableFooterView @indicator
  end

  def end_indicator
    @indicator.stopAnimating
  end

end