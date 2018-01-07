window.getDevicePixelRatio = function () {
    var ratio = 1;
    // To account for zoom, change to use deviceXDPI instead of systemXDPI
    if (window.screen.systemXDPI !== undefined
        && window.screen.logicalXDPI !== undefined
        && window.screen.systemXDPI > window.screen.logicalXDPI) {
        // Only allow for values > 1
        ratio = window.screen.systemXDPI / window.screen.logicalXDPI;
    } else if (window.devicePixelRatio !== undefined) {
        ratio = window.devicePixelRatio;
    }
    return ratio;
};

console.log('當前瀏覽器', getDevicePixelRatio());

var swiper = new Swiper('.swiper-container', {
    nextButton: '.swiper-button-next',
    prevButton: '.swiper-button-prev',
    pagination: '.swiper-pagination',
    paginationClickable: true,
    lazyLoadingInPrevNext: true,
	autoplay: true,
	speed: 3500,
	loop: true,
    // Disable preloading of all images
    preloadImages: false,
    lazyLoading: true,
    onLazyImageLoad: function (swiper, slide, image) {
        if ($(slide).find('.swiper-lazy--retina-bg').length) {
            // none
            var bgLazyload = $(slide).find('.swiper-lazy--retina-bg');
            var bgAt1x = bgLazyload.data('bgAt1x');
            var bgAt2x = bgLazyload.data('bgAt2x');
            /*
            if (bgAt1x) {
                // for browser unsupported -webkit-image-set
                bgLazyload.css('background-image', "url(" + bgAt1x + ")");
                if (bgAt2x) {
                    // doesnt work in firefox
                    bgLazyload.css('background-image', "-webkit-image-set(url(" + bgAt1x + ") 1x,url(" + bgAt2x + ") 2x)");
                }
            }*/
            if (bgAt2x && window.getDevicePixelRatio() >= 2) {
                bgLazyload.css('background-image', "url(" + bgAt2x + ")");
            } else {
                bgLazyload.css('background-image', "url(" + bgAt1x + ")");
            }
        }
    },
});