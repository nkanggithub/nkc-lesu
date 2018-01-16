<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.nkang.kxmoment.util.OAuthUitl.SNSUserInfo,java.lang.*"%>
<%@ page import="java.util.*,org.json.JSONObject"%>
<%@ page import="com.nkang.kxmoment.util.MongoDBBasic"%>
<%@ page import="com.nkang.kxmoment.baseobject.WeChatMDLUser"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.nkang.kxmoment.util.*"%>
<%

String uid = request.getParameter("UID"); 

String name = "";
String headImgUrl ="";
String phone="";
HashMap<String, String> res=MongoDBBasic.getWeChatUserFromOpenID(uid);
if(res!=null){
	if(res.get("HeadUrl")!=null){
		headImgUrl=res.get("HeadUrl");
	}
	if(res.get("NickName")!=null){
		name=res.get("NickName");
	}

	if(res.get("phone")!=null){
		phone=res.get("phone");
	}
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>乐数-练习参数</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<link rel="stylesheet" type="text/css" href="../nkang/assets_athena/bootstrap/css/bootstrap.min.css" />

<link rel="stylesheet" type="text/css" href="../MetroStyleFiles/sweetalert.css" />
<script src="../MetroStyleFiles/sweetalert.min.js"></script>
<link rel="stylesheet" type="text/css" href="../nkang/css_athena/style.css" />
<script type="text/javascript" src="../Jsp/JS/jquery-1.8.0.js"></script>

<style type="text/css">
* {
	margin: 0;
}

.usedPanel {
	width: 90%;
	margin-left: 5%;
}

.item.{
height:35px;
width:100%;
}
.title {
	height: 100%;
	width: 30%;
	line-height: 55px;
	text-align: center;
	font-size: 15px;
	float: left;
}

.value {
	height: 100%;
	width: 60%;
	line-height: 45px;
	text-align: center;
	font-size: 13px;
	float: left;
	border-bottom: 1px solid black;
}

.
#footer {
	bottom: 0;
	color: #757575;
	font-size: 12px;
	padding: 10px 1%;
	position: fixed;
	text-align: center;
	width: 70%;
	z-index: 1002;
	left: 0;
}

.editText {
	margin: 0;
	margin-top: 8px;
	width: 80px;
}

.classText {
	margin: 0;
	margin-top: 8px;
	width: 70px;
	font-size: 14px;
	text-align:right;
}

.editInput {
	height: 30px;
	padding-left: 10px;
	margin-top: 10px;
	border-radius: 5px !important;
	margin-left: 5px;
	line-height: 30px;
	font-size: 14px;
	width:80%;
}
textarea{
height:100px!important;}
.usedPanel {
	
}

.usedDetailPanel {
	width: 90%;
	margin-left: 5%;
	padding-BOTTOM: 30PX;
	/* padding-TOP: 10PX; */
	border: 1px solid #CFCFCF;
	border-radius: 5px;
	BACKGROUND: rgba(252, 251, 251, 0.41);
}
</style>
<script>
$(function(){
	findParentList();
	function findParentList(){
		$.ajax({
			 url:'../ClassRecord/getAllOpenIDHasClass',
			 type:"GET",
			 data : {},
			 success:function(data){
				 if(data){

						var keys="";
						for(var key in data){
							keys+=key+",";
							
						}

						keyArrays=keys.split(",");
						keyArrays.splice(keyArrays.length-1,1);
					 var select="";
					 for(var i=0;i<keyArrays.length;i++){
						 select+="<option value='"+keyArrays[i]+"' >"+data[keyArrays[i]]+"</option>";
					 }
					 $("#studentsList").html(select);
					 getClassRecordById(keyArrays[0]);
				 }
				 
			}
		});
		
	}
	$("#updateExpenseBtn").click(function(){
		var datas=$("#updateExpenseForm").serialize();
			$.ajax({
			url:"../ClassRecord/addClassExpenseRecord",
			data:datas,
			type:"POST",
			dataType:"json",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			cache:false,
			async:false,
			success:function(result) {
					swal("更改成功!", "恭喜!", "success"); 
			}
		}); 
	});

	var records;

	function getClassRecordById(id){

		jQuery.ajax({
			type : "GET",
			url : "../ClassRecord/getClassTypeRecords",
			data : {
				openID : id
			},
			cache : false,
			success : function(data) {
				records=data;
				var keys="";
				for(var key in data){
					keys+=key+",";
					
				}
				keyArrays=keys.split(",");
				keyArrays.splice(keyArrays.length-1,1);
				var index=keyArrays[0];

				 var select="";
				 for(var i=0;i<keyArrays.length;i++){
					 select+="<option value='"+keyArrays[i]+"' >"+keyArrays[i]+"</option>";;
				 }
				 $("#typeList").html(select);
				var district=data[index]==null?'':data[index].district;
				$("#expenseDistrict").val(district);
			}
		});
	}
	function getClassRecordByStudent(obj){

		var openid=$(obj).find("option:selected").val();
		jQuery.ajax({
			type : "GET",
			url : "../ClassRecord/getClassTypeRecords",
			data : {
				openID : openid
			},
			cache : false,
			success : function(data) {
				records=data;
				var keys="";
				for(var key in data){
					keys+=key+",";
					
				}
				keyArrays=keys.split(",");
				var index=keyArrays[0];

				 var select="";
				 for(var i=0;i<keyArrays.length;i++){
					 select+="<option value='"+keyArrays[i]+"' >"+keyArrays[i]+"</option>";;
				 }
				 $("#typeList").html(select);
				var district=data[index]==null?'':data[index].district;
				$("#expenseDistrict").val(district);
			}
		});
	}
	function getClassRecordByType(obj){

		var ct=$(obj).find("option:selected").val();
		var district=records[ct]==null?'':records[ct].district;
		$("#expenseDistrict").val(district);
	}
	window.getClassRecordByType=getClassRecordByType;
	window.getClassRecordByStudent=getClassRecordByStudent;
	window.getClassRecordById=getClassRecordById;
});
</script>
</head>
<body>
	<div id="data_model_div" style="height: 100px">
		<i class="icon"
			style="position: absolute; top: 25px; z-index: 100; right: 20px;">
			<!-- <img class="exit" src="http://leshu.bj.bcebos.com/icon/EXIT1.png"
			style="width: 30px; height: 30px;"> -->
			<div
				style="width: 30px; height: 30px; float: left; border-radius: 50%; overflow: hidden;">
				<img class="exit"
					src="<%=headImgUrl %>"
					style="width: 30px; height: 30px;">
			</div> <span
			style="position: relative; top: 8px; left: 5px; font-style: normal"><%=name %></span>
		</i> <img
			style="position: absolute; top: 8px; left: 10px; z-index: 100; height: 60px;"
			class="HpLogo"
			src="http://leshu.bj.bcebos.com/standard/leshuLogo.png" alt="Logo">
		<div
			style="width: 100%; height: 80px; background: white; position: absolute; border-bottom: 4px solid #20b672;">
		</div>
	</div>
	<div id="UpdateClassPart" class="bouncePart form-horizontal"
		style="position: absolute; z-index: 999; top: 110px; width: 90%; margin-left: 5%;">
		<div id="UpdateClassPartDiv"
			style="margin-top: 0px; margin-bottom: -20px; background-color: #fff;">
			<form id="updateExpenseForm">
				<input type="hidden" name="teacherOpenID" id="teacher_uid"
					value="<%=uid %>">
					
				<input type="hidden" name="teacherName" id="teacher_name"
					value="<%=name %>">
				<table id="tableForm" style="margin-top: -10px; width: 100%;">
					<tbody>
					
						<tr>
							<td><p class="classText">学员姓名</p></td>
							<td><select id="studentsList" class="editInput" onchange="getClassRecordByStudent(this)" name="studentOpenID"></select></td>
						</tr>
						<tr>
							<td><p class="classText">消费项目</p></td>
							<td><select id="typeList" name="expenseOption" onchange="getClassRecordByType(this)" class="editInput">
							</select></td>
						</tr>
						<tr>
							<td><p class="classText">消费时间</p></td>
							<td align="left" class="tdText">
							<input class="editInput"  name="expenseTime" type="date" id="expenseTime"   value="">'
							</td>
						</tr>
						<tr>
							<td><p class="classText">课消校区</p></td>
							<td><input class="editInput"  name="expenseDistrict" type="text" id="expenseDistrict"   value=""/>'
							</td>
						</tr>
						<tr>
							<td><p class="classText">消费课时</p></td>
							<td><input class="editInput" type="text" name="expenseClassCount"
								id="totalClass" value=""></td>
						</tr>
						<tr>
							<td><p class="classText">老师评语</p></td>
							<td><textarea class="editInput" name="teacherComment" ></textarea></td>
						</tr>
					</tbody>
				</table>
			</form>
			<button class="btnAthena EbtnLess"
				style="background-color: #20b672; margin-left: 90px; margin-top: 15px;"
				id="updateExpenseBtn">确定</button>
		</div>
	</div>
</body>
</html>