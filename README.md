# ZHFScrollView-OC
OC 语言仿网易新闻头部导航
demo使用方法
把ViewController拖入项目后 （如需要，可对控制器名称进行修改）。
然后创建需要此功能的控制器继承ViewController即可使用

如有bug在ViewController的
//标题居中这个方法最后一行加上  _radioBtn = btn; 
如下， Swift同理
-(void)setupTitleCenter:(UIButton *)btn{
    CGPoint offsetPoint = _titleScrollView.contentOffset;
    offsetPoint.x =  btn.center.x -  screen_width / 2 ;
    //左边超出处理
    if (offsetPoint.x<0) offsetPoint.x = 0;
    CGFloat maxX = _titleScrollView.contentSize.width -screen_width;
    //右边超出处理
    if (offsetPoint.x>maxX) offsetPoint.x = maxX;
    [_titleScrollView setContentOffset:offsetPoint animated:YES];
     _radioBtn = btn;
}
