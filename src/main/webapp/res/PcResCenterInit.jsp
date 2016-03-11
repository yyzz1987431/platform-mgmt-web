<%@ page contentType="text/html; charset=utf-8"%>

<%
String ContextPath = request.getContextPath();
%>

<jsp:include page="/layout/jsp/head.jsp"></jsp:include>

<script type="text/javascript">
$(document).ready(function() {
	$('#btn_init').click(function(){
		if(centerSize<3||visitSize<2||slaveSize<1){
			CC.showMsg({msg:"该资源中心服务器不够"});
			return;
		}
		var resId = "";
		resId=$('#sel_resCenter :selected').val();
		
		if(resId=="") return ;
		$('#div-log').show();
		startGetLog();
		$('#div-init-button').hide();
		RS.ajax({url:"/res/resc/initResCenter",ps:{resCenterId:resId,useAgent:true,loadOnly:true},cb:function(result) {
			if(result.resultCode=="000000"){
				CC.showMsg({msg:"初始化资源中心成功！"});
			}else{
				CC.showMsg({msg:result.resultMsg});
			}
		}});
	})
});

</script>

<div class="row">
	<div class="col-lg-12">
		<div class="main-box clearfix">
			<div class="filter-block pull-left">
				<div class="pull-left">
					<div class="form-group pull-left">
						&nbsp;&nbsp;&nbsp;&nbsp;服务器编号:
					</div>
					<div class="form-group pull-left">
						<select id="sel_resCenter" class="form-control" style="width:160px;">
							<option value="99">BIUaa资源中心</option>
						</select>
					</div>
					
				</div>
			</div>
		</div>
	</div>
</div>



<!-- 正文 -->
<div class="row">
	<div class="col-lg-12">
		<div class="main-box clearfix">
			<div class="main-box-body clearfix">
				<div class="table-responsive">
					<table class="table">
						<thead>
							<tr>
								<th class="text-center">服务器编号</th>
								<th class="text-center">服务器IP</th>
								<th class="text-center">所属机房</th>
								<th class="text-center">数据中心</th>
								<th class="text-center">资源中心</th>
								<th class="text-center">网络区域</th>
								<th class="text-center">CPU个数</th>
								<th class="text-center">内存大小</th>
								<th class="text-center">硬盘大小</th>
								<th class="text-center">操作系统</th>
								<th class="text-center">标签</th>
							</tr>
						</thead>
						<tbody id="pcComputerTable">
							
						</tbody>
					</table>
				</div>
			
		</div>
	</div>
</div>
</div>


<div class="row"  id="div-log" style="display: none">
	<div class="col-lg-12">
		<div class="main-box clearfix">
			<div class="main-box-body clearfix">
				<div>日志</div>
				 <div class="filter-block pull-left">
					<div class="form-group pull-left">
						<div>
							<textarea id="logWindow" cols="100%" rows="15%" value=""
								style="	background-color: black;border-style: solid;color: white; font-size: 15px;"></textarea>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>


<div class="row" id= "div-init-button">
	<div class="col-lg-12">
		<div class="main-box clearfix">
			<div class="main-box-body clearfix">
				<div class="form-group">
				<div class="col-lg-offset-2 col-lg-10">
					<button type="submit" id="btn_init" class="btn btn-success">初始化</button>
				</div>
			</div>
				
			</div>
		</div>
	</div>
</div>


	<div id="sel_forcenter"
		style="width: 300px; position: absolute; display: none;"></div>

	
	<script id="pcComputerTable-tmpl" type="text/x-jquery-tmpl">
	{{each(i,row) computerList}}
		<tr>
			<td class="text-center"><a href="<%=ContextPath%>/dispatch/mc/020501?id={{= row.id}}&pageNum={{= pageNum}}">{{= row.code}}</a></td>
			<td class="text-center">{{= row.ip}}</td>
			<td class="text-center">
				{{= PU.getDropValue("DV_COMP_ROOM_CODE",row.roomId,false)}}
			</td>
			<td class="text-center">
				{{= PU.getDropValue("DV_DATA_CENTER_CODE",row.dataCenterId,false)}}
			</td>
			<td class="text-center">
				{{= PU.getDropValue("DV_RES_CENTER_CODE",row.resCenterId,false)}}
			</td>
			<td class="text-center">
				{{= PU.getDropValue("DV_NET_ZONE_CODE",row.netZoneId,false)}}
			</td>
			
			<td class="text-center">
				{{if !CU.isEmpty(row.cpuCount)}}
					{{= row.cpuCount/100}}
				{{/if}}
			</td>
			<td class="text-center">{{= CU.toMegaByteUnit(row.memSize)}}</td>
			<td class="text-center">{{= CU.toMegaByteUnit(row.diskSize)}}</td>
			<td class="text-center">{{= row.osName}}</td>
			<td class="text-center">
				{{if row.status==1}}
					是
				{{else}}
					否
				{{/if}}
			</td>
			<td class="text-center">
				<a id="a_comp_tags_{{= row.id}}" href="###" class="table-link" title="标签详情">
					<span class="fa-stack">
						<i class="fa fa-square fa-stack-2x"></i>
						<i class="fa fa-tags fa-stack-1x fa-inverse"></i>
					</span>
				</a>
			</td>
		</tr>
{{/each}}
</script>

	<jsp:include page="/layout/jsp/footer.jsp"></jsp:include>