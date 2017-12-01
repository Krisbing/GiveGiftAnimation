
##直播室礼物的连击动画
<img src="http://images2017.cnblogs.com/blog/471463/201712/471463-20171201101452242-1594171085.gif" alt="">

###思路：

1、需要一个描边的label，并设置这个label的放大缩小动画。
2、封装channelView，定义GiftEntity，编写channelView的弹出动画，延迟3秒悬浮，并开始结束动画，在此期间如果有同一giftEntity加入，需要执行numLabel的弹动动画，并取消上次延迟的3秒后会开始的结束动画，重新开始新的延迟。

        添加一个给外界来设置缓存num的方法，引入状态机制。

3、在ContainView里面，持有若干个channelView，并放入数组里面；持有一个当前需要执行动画的giftEntity数组

        当一个channelView结束动画的时候，有几个问题需要注意下：
            需要判断待执行的giftEntity数组是否有entity，如果有，取出来赋值给channelView的模型之后，还得把giftEntity数组里面所有的与该entity相同的giftEntity都取出来，添加到channelView的cacheNum中。
            
        对于一个新加入的entity，首先判断是否存在与它一样的正在展示的channelView
        其次判断是否有闲置的channelView
        最后才是放到缓存中准备被展示
        

4、遇到的bug

        由于channelView中执行动画是有其持续时间的，这个地方的状态控制需要做好处理。
        
