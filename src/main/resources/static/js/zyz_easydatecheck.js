function compareTime(beginTime,endTime) {
	 	beginTime=beginTime.replace(/-/g,"/");
		endTime=endTime.replace(/-/g,"/"); 
		return Date.parse(beginTime)<Date.parse(endTime);
	}
	
function showtimedatediv(startTime,endTime){
	$('#starttime').datebox({});
	$('#endtime').datebox({});
	$('#timedatespan').show();
	var startDate= new Date(startTime);
	var endDate= new Date(endTime);
	var monthfir = parseInt(startDate.getMonth()+1);
	$('#starttime').datebox('setValue',startDate.getFullYear()+"-"+monthfir+"-"+startDate.getDate());
	var monthsec = parseInt(endDate.getMonth()+1);
	$('#endtime').datebox('setValue',endDate.getFullYear()+"-"+monthsec+"-"+endDate.getDate());
	$('#timedatespan').show();
} 

function toPage(_url,limitTime,date_start_time,date_end_time,browerStartTime,browerEndTime){
		if(limitTime=="otherdate"){
			if(date_start_time==""){
				date_start_time=new Date(browerStartTime);
				var  year=date_start_time.getFullYear();
				var month=parseInt(date_start_time.getMonth()+1);
				var day=date_start_time.getDate();
				date_start_time=year+"-"+month+"-"+day;
			}
			if(date_end_time==""){
				date_end_time=new Date(browerEndTime);
				var  year=date_end_time.getFullYear();
				var month=parseInt(date_end_time.getMonth()+1);
				var day=date_end_time.getDate();
				date_end_time=year+"-"+month+"-"+day;
			} 
			if(compareTime(date_start_time,date_end_time)){
				jump(_url+'?startTime='+date_start_time+'&endTime='+date_end_time+'&timeLimit='+limitTime);	
			}else{
				$.messager.alert("操作提示","结束日期必须在开始日期之后");
			}
		}else{ 
			jump(_url+'?timeLimit='+limitTime);	
		}
	}