Swiper 的使用筆記
2018-01-07 17:03:31

#### 關於Swiper
>  [Swiper](https://github.com/nolimits4web/Swiper) 是一款開源免費、強大的移動端觸摸滑動插件，[中文文檔](http://www.swiper.com.cn/)豐富，不詳述。

  
#### 使用過程中遇到的問題
當使用 DIV 背景替代 IMG 標籤時，無法像 IMG 標籤可通過 data-srcset 設置多張圖片適應不同顯示屏。
  
##### IMG 標籤 data-srcset
當使用 DIV 背景替代 IMG 標籤時，像 IMG 標籤可通過 data-srcset 設置多張圖片？
  
##### 解决方法
  
- 方法一
可以結合 [lazysizes](https://github.com/aFarkas/lazysizes) 的 [bgset plugins](https://github.com/aFarkas/lazysizes/tree/gh-pages/plugins/bgset) 解決;
  
- 方法二
當需要懶加載並且達到滑動到某一張圖片才加載下一張圖片時，方法一不太適宜。
通過 swiper 的 onLazyImageLoad 回調函數解決：

  1. 為 DIV 添加額外的類名和 `data-bg-at1x` 、`data-bg-at2x` 屬性(用於放置@1x/@2x 圖片 URL)；

  2. 在 onLazyImageLoad 回調里獲取該 DIV 的 背景圖片 URL，為該 DIV 設置 background-image：
    - 使用 -webkit-image-set(/path/to/image@1x 1x, /path/to/image@2x 1x) 設置,不支持部分瀏覽器（e.g: firefox)；
    - 通過 JS 判斷瀏覽器 `devicePixelRetio` 直接使用 `url(/path/to/image)`` 設置對應的背景(兼容不支持 -webkit-image-set 的瀏覽器)；
  
#### 效果

<!--EXAMPLE CODE BEGIN -->
<div class="example">
    <!-- Swiper -->
    <div class="exampler__swiper swiper-container">
        <div class="swiper-wrapper">
            <!-- Lazy image -->
            <div class="swiper-slide">
                <img
                        data-src="assets/images/blueberries@1x.jpg"
                        data-srcset="assets/images/blueberries@1x.jpg 1x,
                            assets/images/blueberries@2x.jpg 2x
                        class="swiper-lazy">
                <div class="swiper-lazy-preloader"></div>
            </div>
            <!-- Lazy image with srscet-->
            <div class="swiper-slide">
                <img
                        data-src="assets/images/coffee@1x.jpg"
                        data-srcset="iassets/images/coffee@1x.jpg 1x,
                            assets/images/coffee@2x.jpg 2x
                        class="swiper-lazy">
                <div class="swiper-lazy-preloader"></div>
            </div>
            <!-- Element with lazy background image -->
            <div class="swiper-slide">
                <div
                        class="swiper-lazy"
                        data-background="assets/images/pet@1x.jpg"

                >
                    <div class="swiper-lazy-preloader"></div>
                </div>
            </div>
            <!-- Element with lazy background image -->
            <div class="swiper-slide">
                <div
                        class="swiper-lazy swiper-lazy--retina-bg"
                        data-bg-at1x="assets/images/fruit@1x.jpg"
                        data-bg-at2x="assets/images/fruit@2x.jpg"
                >
                    <div class="swiper-lazy-preloader"></div>
                </div>
            </div>
        </div>
        <!-- Add Pagination -->
        <div class="swiper-pagination"></div>
    </div>
</div>
<script src="assets/scripts/jquery.min.js"></script>
<script src="assets/scripts/swiper.jquery.js"></script>
<link rel="stylesheet" href="assets/styles/notes-of-using-swiper.css">
<script type="text/javascript" src="assets/scripts/notes-of-using-swiper.js">
</script>
<!--END-->

<br/>
以上實例 JS [源代碼](assets/scripts/notes-of-using-swiper.js)