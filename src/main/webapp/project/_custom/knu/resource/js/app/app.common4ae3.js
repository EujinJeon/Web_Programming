if(!window.App) {
	App = {};
}
if(!App.app){
	App.app = {};
}


$(function() {
	
	var app = new App.app.Common();
	
	app.init();
	
});


$(document).on("click",".searchOption",function(e){

	e.preventDefault();

	var value    = $(this).attr("data-value");
	var text    = $(this).text();
	
	var $container =  $(this).closest('.b-sel-box');
	
	$container.find('input[type=hidden]').val(value);
	
	// 검색 분류
	$container.find("a.b-sel-title").text(text);
	
	$container.find('li').removeClass('selected');
	
	//선택시 리스트 보이지 않게 하기
	$(this).parent().parent().removeClass('on');

});

App.app.Common = function() {
	
	var self;
	
	return {
		init: function() {

			self = this;
			
			//self.yearPicker();
			
			self.selectBoxBind();
			
			self.changeTab();
			
			self.clickTab();
			
			// 캘린더 datepicker, class 에 calendar 가 있으면 datepicker 생성
			self.datePicker();
			
		},
		// 탭 클릭
		clickTab : function () {
			
			
			$('[class^=app-tab]').click(function(e) {
				
				e.preventDefault();
				
				var $this = $(this), value = $this.attr('data-value'), key;
				
				key = self.setKey( $this.attr('class') ); 
				
				$('input[name=' + key + ']').val(value);
				$('form[name=searchForm]').submit();
				
			});
		},
		// 모바일 탭 선택
		changeTab : function() {
			
			var className, classes, index, key;
			
			$('[class*=mapp-tab]').change(function(e) {

				var $this = $(this), selectedNm = $this.children("option:selected").text(), value = $(this).children("option:selected").val();
				$this.siblings("label").text( selectedNm );
			
				key = self.setKey( $this.attr('class'), 'mobile' ); 

				$('input[name=' + key + ']').val(value);
				$('form[name=searchForm]').submit();
				
			});
			
		},
		// 탭 클릭시 폼전송 될 데이터 키 추출
		setKey : function( items, device ) {
			
			var className, classes, index, key;
			className = items.replace(/\s{2,20}/g,' ');
			
			classes = className.split(' ');
				
			for(var j=0; j<classes.length; j++) {
				className = classes[j];
				
				if( typeof(device) != 'undefined' && device == 'mobile' ) {
					
					index = className.indexOf('mapp-tab-');
					
				} else {
					
					index = className.indexOf('app-tab-');
					
				}
				
				// key class 가 존재
				if(index > -1) {
					var strs = className.split('-');
					key = strs[2];
				}
			}
			
			return key;
			
		},
		// 캘린더 datepicker, class 에 calendar 가 있으면 datepicker 생성
		datePicker :function() {
			
			$('input.calendar').datepicker({
				dateFormat: 'yy-mm-dd',
				monthNames: ['01','02','03','04','05','06','07','08','09','10','11','12'],
				monthNamesShort: ['01','02','03','04','05','06','07','08','09','10','11','12'],
				dayNames: ['Su','Mo','Tu','We','Th','Fr','Sa'],
				dayNamesShort: ['Su','Mo','Tu','We','Th','Fr','Sa'],
				dayNamesMin: ['Su','Mo','Tu','We','Th','Fr','Sa'],
				showMonthAfterYear: true,
				buttonImageOnly: true,
				changeMonth: true,
				changeYear: true			
			});
			
		},
		yearPicker: function() {
			/*
			 $('.year-picker input.yearpicker').datepicker({
			    startView: 2,
			    minViewMode: 2,
			    maxViewMode: 2,
			    autoclose:true,
			    format:'yyyy'
			});
			*/
			$('input.yearpicker').yearpicker();
		},
		selectBoxBind : function(){
			
			// 셀렉트 박스 초기값 설정
			function init( $box ) {

				var val = $box.find('input[type=hidden]').val(), text;
				$box.find('[data-value]').each(function( index, item ) {
					var $item = $(item);
					if(index == 0 && !$item.attr('data-value')) {
						text = $item.text();
					}
					if($item.attr('data-value') == val) {
						$item.parent().addClass('selected');
						text = $item.text();
						return false;
					}
				});
				$box.find("a.b-sel-title").text(text);

			}

			self = this;
	        $box = $(".b-sel-box");

  	        /*$box.each(function(){

				init( $(this) );
				
	          $(this).click(function(){

	          	 if($(this).find("ul").is(":hidden")){

			        $(this).find("ul").show();
			        $(this).css({zIndex: "10"});

			      }else if($(this).find("ul").is(":visible")){

			        $(this).find("ul").hide();
			        $(this).css({zIndex: "0"});

			      }


	          });
	        });*/
	        
		}
	}
};
