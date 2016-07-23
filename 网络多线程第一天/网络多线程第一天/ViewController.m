//
//  ViewController.m
//  网络多线程第一天
//
//  Created by apple on 16/7/12.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "ViewController.h"

#import "UIImageView+WebCache.h"

#import "TwoController.h"
@interface ViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *MyWebView;
  
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    //设置代理
    
    self.MyWebView.delegate  = self;
    
    NSURL *str = [NSURL  URLWithString:@"http://m.dianping.com/tuan/deal/5501525"];
    
    [self.MyWebView   loadRequest:[NSURLRequest  requestWithURL:str]];
    
    
    
}

//输出网页展示时不需要的内容

-(void)webViewDidFinishLoad:(UIWebView *)webView  {


  //拼接js代码
    
    NSMutableString  *strM  = [NSMutableString  string];
    
    // 删除导航 跟前端程序猿要的h5代码
    [strM appendString:@"var headerTag = document.getElementsByTagName('header')[0];headerTag.parentNode.removeChild(headerTag);"];
    // 删除底部悬停按钮
    [strM appendString:@"var footerBtnTag = document.getElementsByClassName('footer-btn-fix')[0]; footerBtnTag.parentNode.removeChild(footerBtnTag);"];
    // 删除底部布局
    [strM appendString:@"var footerTag = document.getElementsByClassName('footer')[0]; footerTag.parentNode.removeChild(footerTag);"];
    // 给标签添加点击事件
    [strM appendString:@"var figureTag = document.getElementsByTagName('figure')[0].children[0]; figureTag.onclick = function(){window.location.href = 'hm://?src='+this.src};"];
    
    
    //oc调用js代码   重重之重
    
    [self.MyWebView   stringByEvaluatingJavaScriptFromString:strM];
    

}


-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType  {

 //拿到网页的请求地址
    
    NSString *str  = request.URL.absoluteString;
    
    //判断网页的请求地址协议是否是我们自定义的那个
    
    NSRange   range  = [str  rangeOfString:@"hm://?src="];
    
    if(range.length  > 0)  {
    
        TwoController  *top  = [TwoController  new];
        
        [self.navigationController  pushViewController:top animated:YES];
        
    
    }
  
    return YES;
}


@end
