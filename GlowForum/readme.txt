主题列表页面：ForumView
主题详情页面：TopicView
1，JSON解析到jsonArray, 然后把array的每一个元素解析到jsonDict;
2，通过全局变量AppDelegate中的select传递点击的tableView行,topicTableView根据点击的不同加载不同的话题；
3，为NSString增加了一个函数-(NSString *) calculateUpLoadTime;用来计算创建的时间与现在时间的差值；
4，为UIImage增加一个函数- (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;用来把图片缩放到合适的尺寸；
5，TopicView的评论是按时间排序的，越晚的评论越靠前；
6，在构建可以自适应高度的tableViewCell过程中，我参考了一部分 https://github.com/henrytkirk/HTKDynamicResizingCell (作者：Henry T Kirk)的代码，特此声明和致谢。
7,在完成规定内容的基础上，ForumView增加了一个下拉刷新。