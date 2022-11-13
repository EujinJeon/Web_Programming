if(!window.App) {
	App = {};
}
if(!App.board){
	App.board = {};
}

/**
 * 모듈 초기화
 */
$(function() {
	
	var board = new App.board.scheduleCalendar();
	board.init();
	
});

/**
 * 학사일정 Full Calendar
 */
App.board.scheduleCalendar = function() {

	var self;

	return {

		init: function() {

			self = this;
			
			// Full Calendar Load
			self.loadCalendar();
			
			// Full Calendar 'dayClick' 이벤트가 'overflow-y : scroll' 이 잡혀있으면 먹통됨!!!!!
			$('html').css('overflow-y' , 'initial');
			
			// 팝업 닫기
			//$('.btn-popup-close').click(function() { $('.popup-wrap').fadeOut(); } );
			
			// 이전달, 다음달 텍스트 추가
			$('#calendar button.fc-prev-button > span').append('<i class="hide">이전달 이동</i>');
			$('#calendar button.fc-next-button > span').append('<i class="hide">다음달 이동</i>');
			
		},	
		showPopup : function ( date, list ) {

			var $tbody = $('#day-reservation > tbody');
			$tbody.children().remove();
			
			$('.popup-wrap .reserv-title-box p').text( date + ' ' + $m('일정') );
			$.each ( list, function ( index ) {
				
				var data = list[index];
				
				$tbody.append('<tr>\
					<td>' + (typeof(data.category) != 'undefined' && data.category == 'home' ? $m('학사') : $m('게시판') ) + '</td>\
					<td>' + data.start_date + (typeof(data.end_date) != 'undefined' && data.start_date != data.end_date ? ' ~ ' + data.end_date : '' ) + '</td>\
					<td class="no-right">' +  data.description +'</td>\
				</tr>');
				
			});
			
			$('.popup-wrap').fadeIn();
			$('.popup-wrap .b-reserv-popup-wrap').focus(); // 팝업 포커스 이동

			$('.btn-popup-close').on('click', function(e) {
				
				close( date );
				
			});
			
			function close() {
				
				$('.popup-wrap').fadeOut(); 
				$('.fc-bg .fc-day[data-date=' + date + ']').focus();
			}
			
			
		},
		loadCalendar  : function() {
			
			$('#calendar').fullCalendar({
				
				// 더 보기 클릭 이벤트
				eventLimitClick : function ( cellInfo ){
					
					var info = cellInfo.segs
					// 선택 날짜
					, date = moment( cellInfo.date._d ).format('YYYY-MM-DD')
					, list = [];

					$.each ( info, function ( index ) {
						
						var $this = $(this)
							//, data = $this[0].footprint.eventDef.miscProps;
							, data = $this[0].footprint.eventDef;

							//data.start_date = data.startDt;
						data.start_date = data.dateProfile.start.format('YYYY-MM-DD');
							
						data.end_date = data.miscProps.endDt;
						
						data.description = data.title;
						
						list.push ( data );

					});
					
					self.showPopup ( date, list );
					
			    },
			    // 이벤트 Bar 클릭 이벤트
			    /*
			    eventClick : function ( event, el, jsEvent, view ) {
			    	
			    	var list = [], moment = $('#calendar').fullCalendar('getDate');
			    		list.push( event );
			    	
			    	     var yy=moment.format("YYYY");

					    var mm=moment.format("MM");
					
					    var dd=moment.format("DD");
					
					    var ss=moment.format("dd");
			    	
			    },
			    */
			    // 날짜 영역 클릭 이벤트
				dayClick: function( date, allDay, jsEvent, view ) {
					
  					var currentDt = date.format('YYYY-MM-DD')
 						, parseDt = parseInt( currentDt.replaceAll('-', '') );
 						
				  	var list = $('#calendar').fullCalendar('clientEvents')
				  		, procList = [];
					
				  	$.each ( list, function ( index ){
				  		
				  		var event = list[index]
				  			, start = event.start
							, end = event.end;
					
						var parseStart = parseInt( start.format('YYYY-MM-DD').replaceAll('-', '') )
							, parseEnd =  (end ? parseInt( moment(end).add(-1, 'd').format('YYYY-MM-DD').replaceAll('-', '') ) : 0);

						// 선택 날짜 범위에 있는 일정을 담아준다
						/*
						if( 
							( 
								( typeof(termChk) == 'undefined' || ( typeof(termChk) != 'undefined' && termChk == 'Y' ) ) 
								&&  
								( parseStart <= parseDt && parseDt <= parseEnd )
							)
							|| ( typeof(termChk) != 'undefined' && termChk == 'N' && parseStart == parseDt ) 
						) 
						*/	
						
						if( 
							( parseStart <= parseDt && parseDt <= parseEnd )
							|| ( parseEnd == 0 && parseStart == parseDt ) 
						) {
							
							// 학사일정 데이터 
							event.start_date = start.format('YYYY-MM-DD');
							
							if ( end ) {
								event.end_date = end.add(-1, 'd').format('YYYY-MM-DD');	
							}
							
							event.description = event.title;
							
							procList.push ( event );
						}
						
				  	});
					
				  	// 날짜순 정렬
				  	procList.sort( function(a, b) {

				  		if ( a['end'] == null ) {
				  			a['end'] = a['start'];
				  		}
				  		
				  		if ( b['end'] == null ) {
				  			b['end'] = b['start'];
				  		}

				  		return a['start'] - b['start'] || a['end'] - b['end'];
				  		
				  	});

				  	if ( procList.length > 0 ) {
				  		
						self.showPopup ( currentDt, procList );
						
				  	}
	
			 	},  
			 	
			 	fixedWeekCount: false,
				contentHeight : 'auto',
    			height : 'parent',
    			eventLimitText : '추가일정',
			    header: {
			        left: '',
			        center: 'prev, title, next',
			        right: ''
			    },
				views: {
					month: { // name of view
				      titleFormat: 'YYYY. MM'
				    }
    			},
    			displayEventTime : false,
			    //defaultDate: srDate,
				navLinks: false, // can click day/week names to navigate views
				//editable: true,
				eventLimit: 4, // allow "more" link when too many events
				events: function(start, end, timezone, callback) {

					$.ajax({
	       				url: '?mode=getCalendarData',
						dataType: 'json',
						type: 'POST',
						data: {
							start: moment(start).format('YYYY-MM-DD'),
							end: moment(end).format('YYYY-MM-DD')
						},
						success: function(data) {
							if(data.items) {
								
								$.each( data.items, function(i) {
									var start = data.items[i].start
										, end = moment(data.items[i].end);
									
									if ( start != end ) {
										
										data.items[i].end = moment(end).add(1, 'd').format('YYYY-MM-DD');
										
									}

								});
								
								callback(data.items);
							}
						}
					});
				},
				eventRender: function(event, element, view) {
					
					// 학사 DB 일정 Bar 색상 설정
					if ( typeof(event.category) != 'undefined' && event.category == 'home' ) {
						
						element.closest('.fc-day-grid-event').addClass('board-calendar-home');
						
					} 
					// CMS 등록 일정 Bar 색상 설정
					else {
						
						element.closest('.fc-day-grid-event').addClass('board-calendar-board');
						
					}
					
					//cursor : pointer
					var start = event.start
					, end = event.end;
					
					var date = start.format('YYYY-MM-DD');
					
					if ( end != null) {
						
						//var term = end.diff( start, 'days') + 1;
						var term = end.diff( start, 'days');

						for ( var i = 0; i <= term; i ++ ) {
						 
						 	var dt = moment(date).add(i, 'd').format('YYYY-MM-DD');
							$('.fc-bg .fc-day[data-date=' + dt + ']').css('cursor', 'pointer');
							//$('.fc-content-skeleton .fc-day-top[data-date=' + dt + ']').css('cursor', 'pointer');
							// Allow keyboard to access and interact with calendar days
							$('.fc-bg .fc-day[data-date=' + dt + ']').attr('tabindex','0');
							$('.fc-bg .fc-day[data-date=' + dt + ']').on('keydown', function(e) {
								
								var $this = $(this);

								if (e.which === 32 || e.which === 13) {
									
									$('.fc-bg .fc-day[data-date=' + $this.attr('data-date') + ']').blur();
									
									//$('.popup-wrap .b-reserv-popup-wrap').attr('tabindex', -1).focus();
									$('#calendar').fullCalendar('publiclyTrigger','dayClick', {args : [moment($this.attr('data-date'))]})
						    	}
								
							});
							
						}
						
						
					} else { 
						
						$('.fc-bg .fc-day[data-date=' + date + ']').css('cursor', 'pointer');
						//$('.fc-content-skeleton .fc-day-top[data-date=' +  date + ']').css('cursor', 'pointer');
						// Allow keyboard to access and interact with calendar days
						$('.fc-bg .fc-day[data-date=' + date + ']').attr('tabindex','0');
						$('.fc-bg .fc-day[data-date=' + date + ']').on('keydown', function(e) {
							
							var $this = $(this);

							if (e.which === 32 || e.which === 13) {
								
								$('.fc-bg .fc-day[data-date=' + $this.attr('data-date') + ']').blur();
								
								//$('.popup-wrap .b-reserv-popup-wrap').attr('tabindex', -1).focus();
								$('#calendar').fullCalendar('publiclyTrigger','dayClick', {args : [moment($this.attr('data-date'))]})
					    	}
							
						});
					}
				
				}				
			});
			
		}
	}
};


