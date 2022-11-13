if(!window.App) {
	App = {};
}
if(!App.app){
	App.app = {};
}

$(function() {
	
	var app = new App.app.curriculum();
	
	app.init();
});


App.app.curriculum = function() {
	
	var self;
	
	return {
		init: function() {
			self = this;
			
			// 교과목 번호 클립보드에 저장
			self.clipboardStore();
			
			self.selectBoxBind();
			
		},
		
		// 교과목 번호 클립보드에 저장
		clipboardStore : function() {

			$('#selectSubjectNo').click(function(){
				var checklength = $("input:checkbox[id=objSbjtNo]:checked").length;
				//var aad = $("input:checkbox[id=objSbjtNo]:checked").val();
				if(checklength == 0){
					return alert("교과목을 선택하여 주십시오.");
				}
				
			
				var list ="";
				//교과목 목록
				$("input:checkbox[id=objSbjtNo]:checked").each(function(index, item) {
					var list1 = item.value;
					
					if(index == 0 ){list += list1}
					else{list += ","+list1}
				});
				
				$('#copy_text_input').val(list);
				$('#copy_text_input').select();
				document.execCommand( 'Copy' );
				
				alert("클립보드에 복사된 교과목번호 : "+list+" 페이지에서 등록 하시기 바랍니다.");
				
			});
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

	        
	        
	        //20210917 주석처리된 것을 해제 교육과정에서만 사용
  	        $box.each(function(){

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
	        });
	        
		}
		
		
	}
};