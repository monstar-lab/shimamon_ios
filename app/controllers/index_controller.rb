class IndexController < UIViewController
  def viewDidLoad
    super

    self.title = "記事一覧"

    @table = UITableView.alloc.initWithFrame(self.view.bounds)
    @table.autoresizingMask = UIViewAutoresizingFlexibleHeight
    self.view.addSubview(@table)

    @table.dataSource = self
    @table.delegate = self

    @posts = []#
    Post.index do |post|
      @posts << post
      @table.reloadData
    end
  end

  # UITableView に必須のメソッド
  def tableView(tableView, numberOfRowsInSection: section)
    @posts.count
  end

  # UITableView に必須のメソッド
  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier)
    cell ||= UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)

    cell.textLabel.text = @posts[indexPath.row].title
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

end