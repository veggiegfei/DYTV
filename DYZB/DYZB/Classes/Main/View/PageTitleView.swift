//
//  PageTitleView.swift
//  DYZB
//封装首页的tileView  View-->scrollorView-->label
//1》自定义构造函数
//titleView是需要外界传入的东西才可以进行显示，用自定义构造函数，在创建对象的时候就把需要显示内容传进来  在swift中如果重写了initWithframe或者自定义了某个构造函数的话，必须重写initWithCode方法


import UIKit

//MARK:定义协议
protocol PageTitleViewDelegate : class {//表示协议只能被类遵守
    func pageTitleView(_ titleView: PageTitleView, selectedIndex index: Int)
}

//MARK:定义常量
private let kScrollLineH : CGFloat = 2
private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

//MARK-定义PageTitleView类
class PageTitleView: UIView {
    
    
    //MARK:定义属性
    fileprivate var currentIndex : Int = 0
    fileprivate var titles : [String]
    //定义代理属性要用weak
    weak var delegate : PageTitleViewDelegate?
    
    
    
    //MARK:懒加载属性
    fileprivate lazy var titleLabels: [UILabel] = [UILabel]()
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.scrollsToTop = false
        return scrollView
    }()//用闭包创建scrollView
    
    fileprivate lazy var scrollLine :UIView = {
        
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
   //MARK:自定义构造函数
    init(frame: CGRect, titles: [String]){
        
        self.titles = titles
        super.init(frame: frame)
        
        //设置UI界面
        self.setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK:设置UI界面
extension PageTitleView{
    fileprivate func setupUI(){
        //1.添加ScorllView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        //2.添加title对应的Label
          setupTitleLabels()
        
        //3.添加scrollLine
        setupBottomLineAndScrollLine()
    }


fileprivate func setupTitleLabels() {

    //0.确定label的一些frame值
    let labelW : CGFloat = frame.width / CGFloat(titles.count)
    let labelH : CGFloat = frame.height - kScrollLineH
    let labelY : CGFloat = 0
    
    
    for(index, title) in titles.enumerated() { //这种遍历方式既可以遍历出下标，又可以遍历出内容

        //1.创建UILabel
        let label  = UILabel()
        
        //2.设置label的属性
        label.text = title
        label.tag = index
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textAlignment = .center
        label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
      
        //3.设置label的frame
        let labelX : CGFloat = labelW * CGFloat(index)
        label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
        
        //4.将label添加到scrollView
        scrollView.addSubview(label)
        titleLabels.append(label)
        
        //5.给Label添加手势
        label.isUserInteractionEnabled = true
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(PageTitleView.titleLabelClick(_:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    
    
    fileprivate func setupBottomLineAndScrollLine() {
        
        //1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        //2.添加scrollLine
        //2.1 获取第一个Label  guard不符合条件判断时往下执行
        guard let firstLabe = titleLabels.first else {return} //可选类型校验
        firstLabe.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        
        //2.2 设置scrollLine的属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabe.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabe.frame.width, height: kScrollLineH)
        
    }
}

//MARK: - 监听label的点击
extension PageTitleView {
    //如果是事件监听的话前面要加@objc
    @objc fileprivate func titleLabelClick(_ tapGes : UITapGestureRecognizer) {
        
        //1.获取当前的label
        guard let currentlabel = tapGes.view as? UILabel else { return }
        
        //2.获取之前的label
        let oldLabel = titleLabels[currentIndex]
    
        //3.切换文字的颜色
        currentlabel.textColor = UIColor(r:  kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        //4.保存最新label的下标
        currentIndex = currentlabel.tag
        
        //5.滚动条位置发生改变
        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15, animations: {
            self.scrollLine.frame.origin.x = scrollLineX
        }) 
        
        //6.通知代理
        delegate?.pageTitleView(self, selectedIndex: currentIndex)
    
    }
}

//MARK:- 对外暴露的方法
extension PageTitleView {
    
    func setTitleWithProgress(_ progress: CGFloat, sourceIndex: Int, targetIndex: Int){
        
        //1.取出sourceLabel/targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        //2.处理滑块的逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        
        //3.颜色的渐变(复杂)
        //3.1 取出变化的范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        
        //3.2 变化sourceLabel
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        
        //3.3 变化targetLabel
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        //4.记录最新的index
        currentIndex = targetIndex
    }
}


















































