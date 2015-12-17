class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @index_controller = IndexController.alloc.initWithNibName(nil, bundle:nil)
    @window.rootViewController = UINavigationController.alloc.initWithRootViewController(@index_controller)
    @window.makeKeyAndVisible
    # ユーザエージェントにshimamonを書くと、サーバがアプリ用のビューを返す
    NSUserDefaults.standardUserDefaults.registerDefaults({UserAgent: "shimamon"})
    true
  end
end
