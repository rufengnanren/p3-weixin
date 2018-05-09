$('#randCodeImage').click(function(){
    reloadRandCodeImage();
});
/**
 * 刷新验证码
 */
function reloadRandCodeImage() {
    var date = new Date();
    var img = document.getElementById("randCodeImage");
    img.src='../randCodeImage?a=' + date.getTime();
}

function popup(id){
	$("#"+id).show();
}

function popuphide(id){
	$("#"+id).hide();
}

function msgTip(msg){
	$("#tip_msg_content").html(msg);
	popup('tip_msg');
}

function goBargain(){
	 var url = "../gzbargain/goBargain.do";
	 var act_bargain_registrationId =$("#act_bargain_registrationId").val();
	 var act_bargain_openid =$("#act_bargain_openid").val();
	 var act_bargain_subscribe =$("#act_bargain_subscribe").val();
	 if(act_bargain_subscribe==0){
	   popup("act_focus");
	   return;
	 }
	 $.ajax({
	      url:url,
	      cache:false,
	      type:"post",
	      data:{
	      	registrationId:act_bargain_registrationId,
	      	openid:act_bargain_openid,
	      	subscribe:act_bargain_subscribe
	      },
		  dataType:"json",
	      success: function(data){
	    	  	if(data.success){
	    	  		reloadRandCodeImage();
	    	  		popup('act_bargain')
	        	}else{
	        		$("#tip_msg_content").html(data.msg);
	        		popup('tip_msg');
	        	}
	      },  
	      error: function(data, status, e){  
	      }
	    });
}

//砍价
function bargain(){
	$("#bargainSubmit").attr("disabled","true");
	var url = $('#actBargainForm').attr("action");
	var act_bargain_nickname =$("#act_bargain_nickname").val();
	if(act_bargain_nickname==''){
		 msgTip("请填写姓名或昵称！")
		 $("#bargainSubmit").removeAttr("disabled");
	     return;
	}
	var act_bargain_randCode =$("#act_bargain_randCode").val();
	if(act_bargain_randCode==''){
		 msgTip("请填写验证码！")
		 $("#bargainSubmit").removeAttr("disabled");
	     return;
	}
	$('#actBargainForm').ajaxSubmit({
        url: url,
        type: 'post',
        dataType: 'json',
        success: function(data, status){
        	if(data.success){
        	    popuphide('act_bargain');
        		popup('act_bargain_success');
        		$("#act_cut_price").html(data.obj.cutPrice);
        	}else{
        		$("#tip_msg_content").html(data.msg);
	        	popup('tip_msg');
        	}
        	$("#bargainSubmit").removeAttr("disabled");
        }
	}); 
}
//我要参加
function join(){
	var act_focus_subscribe = $("#act_focus_subscribe").val();
	if(act_focus_subscribe==0){
	   popup("act_focus");
	   return;
	}else{
		var url = "../gzbargain/toIndex.do";
		url = url+"?actId="+$("#act_focus_actId").val();
		url = url+"&openid="+$("#act_focus_openid").val();
		//url = url+"&nickname="+$("#act_focus_nickname").val();
		url = url+"&subscribe="+act_focus_subscribe;
		url = url+"&jwid="+$("#act_focus_jwid").val();
		location.href=url;
	}
}

//去奖品
function goReceivePrize(){
	 $("#goReceivePrizeButton").attr("disabled","true");
	 var url = "../gzbargain/goReceivePrize.do";
	 var receive_prize_actId =$("#receive_prize_actId").val();
	 var receive_prize_openid =$("#receive_prize_openid").val();
	 var receive_prize_nickname =$("#receive_prize_nickname").val();
	 var receive_prize_subscribe =$("#receive_prize_subscribe").val();
	 $.ajax({
	      url:url,
	      cache:false,
	      type:"post",
	      data:{
	      	actId:receive_prize_actId,
	      	openid:receive_prize_openid,
	      	nickname:receive_prize_nickname,
	      	subscribe:receive_prize_subscribe
	      },
		  dataType:"json",
	      success: function(data){
	    	  	if(data.success){
	    	  		popup('receive_prize');
	    	  		$("#receive_prize_id").val(data.obj.id);
	    	  		$("#receive_prize_realName").val(data.obj.realName);
	    	  		$("#receive_prize_mobile").val(data.obj.mobile);
	    	  		if(data.obj.address==null){
	    	  			data.obj.address = "";
	    	  		}
	    	  		$("#receive_prize_address").text(data.obj.address);
	        	}else{
	        		$("#tip_msg_content").html(data.msg);
	        		popup('tip_msg');
	        	}
	        	$("#goReceivePrizeButton").removeAttr("disabled");
	      },  
	      error: function(data, status, e){  
	      }
	    });

}

//领取奖品
function receivePrize(){
	$("#receivePrizeButton").attr("disabled","true");
	var url = $('#receivePrizeForm').attr("action");
	var receive_prize_realName =$("#receive_prize_realName").val();
	if(receive_prize_realName==''){
		 msgTip("请填写你的真实姓名！")
		 $("#receivePrizeButton").removeAttr("disabled");
	     return;
	}
	var receive_prize_mobile =$("#receive_prize_mobile").val();
	if(receive_prize_mobile==''){
		 msgTip("请输入你真实有效的手机号码！")
		 $("#receivePrizeButton").removeAttr("disabled");
	     return;
	}
	var regu=/^[1][3-8]+\d{9}$/;
	var re=new RegExp(regu);
	if(!re.test(receive_prize_mobile)){
		msgTip("手机号码格式有误！")
		$("#receivePrizeButton").removeAttr("disabled");
	    return;
	}
	var receive_prize_address =$("#receive_prize_address").val();
	if(receive_prize_address==''){
		 msgTip("请输入你的详细地址！")
		 $("#receivePrizeButton").removeAttr("disabled");
	     return;
	}
	
	$('#receivePrizeForm').ajaxSubmit({
        url: url,
        type: 'post',
        dataType: 'json',
        success: function(data, status){
        	if(data.success){
        		popuphide('receive_prize');
        		popup('receive_prize_success');
        		var date = data.obj;
        		var info = "<p>您已经成功领到了免费门票，快快邀请小伙伴儿，一起嗨翻东海音乐节！您的门票将于"+date+"统一寄出，请耐心等待哦~</p>"
        		$("#bargain_desc").html(info);
        	}else{
        		$("#tip_msg_content").html(data.msg);
	        	popup('tip_msg');
        	}
        	$("#receivePrizeButton").removeAttr("disabled");
        }
	}); 

}