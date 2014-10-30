<jsp:include page='<%=(String) request.getAttribute("includeHeader")%>' />
<div class="container">
	<div class="page-header">
		<div class="pull-right form-inline">
			<div class="btn-group">
				 	<form action="advising" method="post" name="advisor_form">
				 	<input type=hidden name=advisor_button id="advisor_button">
		    		<%@ page import= "java.util.ArrayList" %>
		    		
		    		<!-- begin processing advisors  -->
		    		<% ArrayList<String> array = (ArrayList<String>)session.getAttribute("advisors");
		    			if (array != null){ %>
		    				<button type="button" id="all1" onclick="alladvisors()">All</button>
		    				<script> function alladvisors(){
		    							document.getElementById("advisor_button").value = "all";
		    							advisor_form.submit();
		    						 }
		    				</script>
		    			<%	for (int i=0;i<array.size();i++){ %>
		    					<button type="button" id="button1<%=i%>" onclick="button<%=i%>()"><%=array.get(i)%></button>
								<script> function button<%=i%>(){
										document.getElementById("advisor_button").value = "<%=array.get(i)%>";
										advisor_form.submit();
								}</script>
						<%	}
		    			} 
		    			else{%>
		    				<label> Log in to see Advisor schedules. </label>
					 <% } %>
					 <!-- end processing advisors -->	 
					</form>

			</div>
		</div>
	</div>
	<div class="date-display span12">
		<h3></h3>
	</div>
	
			<div id='calendar'></div>
		<%@ page import= "uta.mav.appoint.TimeSlotComponent" %>
		<%@ page import= "uta.mav.appoint.PrimitiveTimeSlot" %>
		<%@ page import= "uta.mav.appoint.CompositeTimeSlot" %>
		<%@ page import= "uta.mav.appoint.beans.AdvisingSchedule" %>
		<%@ page import= "uta.mav.appoint.beans.Appointment" %>
		
		<!--  begin processing schedules -->
		<% ArrayList<TimeSlotComponent> schedules = (ArrayList<TimeSlotComponent>)session.getAttribute("schedules");
		   ArrayList<Appointment> appointments = (ArrayList<Appointment>)session.getAttribute("appointments");
		    			if (schedules != null){%>
		    				<script>
		    				$(document).ready(function(){
		    					$('#calendar').fullCalendar({
		    						header: {
		    							left:'month,basicWeek,basicDay',
		    							right: 'today, prev,next',
		    							center: 'title'
		    						},
		    						displayEventEnd : {
		    							month: true,
		    							basicWeek: true,
		    							'default' : true,
		    						},
		    						eventClick: function(event,element){
		    							if (event.id > 0){
		    							document.getElementById("id1").value = event.id;
		    							document.getElementById("pname").value = event.title;
		    							addAppt.submit();
		    							}
		    							else{
		    								updateAppt.submit();
		    							}
		    						},
		    					events: [
		 		    		<% int i = 0;
									for (i=0;i<schedules.size();i++){%> 
		 								{
		 									title:'<%=schedules.get(i).getName()%>',
		 									start:'<%=schedules.get(i).getDate()+"T"+schedules.get(i).getStartTime()%>',
		 									end:'<%=schedules.get(i).getDate()+"T"+schedules.get(i).getEndTime()%>',
		 									id:<%=i%>,
		 									backgroundColor: 'blue'
		 								}
		 								<%if(i != (schedules.size()-1)||appointments != null){%>,<%}%>
		 					 		<%}	
									if (appointments != null){
										for(i=0;i<appointments.size();i++){%>
		 									{
 												title:'<%=appointments.get(i).getAppointmentType()%>',
 												start:'<%=appointments.get(i).getAdvisingDate()+"T"+appointments.get(i).getAdvisingStartTime()%>',
 												end:'<%=appointments.get(i).getAdvisingDate()+"T"+appointments.get(i).getAdvisingEndTime()%>',
 												id:<%=-i%>,
 												backgroundColor: 'orange'
 											}
 											<%if(i != (appointments.size()-1)){%>,<%}
 										}
									}%>		 					 
		 					 			]
		    					});
		    				});
	 						</script>	
		 						<%}%>

	<form name=addAppt action="schedule" method="get">
		<input type="hidden" name=id1 id="id1">
		<input type="hidden" name=pname id="pname">
	</form>		 							
	
	<form name=updateAppt action="appointments" method="get">
	</form>
  	
	<br/><br/><hr>
</div>
<%@include file="templates/footer.jsp" %>