/* 메인비주얼 object-fit : IE대응 */	
if($(document).find('.vi-img-box').length > 0){	
	var mainViImg = new App.ObjectFit();
	mainViImg.init(".vi-img-box");
}