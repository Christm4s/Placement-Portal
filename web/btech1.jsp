<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@include file="header.jsp" %>
 <%@include file="variables.jsp" %>
 <script src="js/jquery.js"></script>
<script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.prettyPhoto.js"></script>
    <script src="js/jquery.isotope.min.js"></script>
    <script src="js/main.js"></script>
    <script src="js/wow.min.js"></script> 
   <script type="text/javascript"></script>
   
   <script>
         $(document).ready(function(){
                $("#vcode").blur(function(){
                var a=$(this).val()
                if(a==0)
                    {
                     $("#ans").html("")     
                    }
                    else
                    {
                       
                    $.ajax({
                        url:"code.jsp",
                        data:{"code":a},
                        beforeSend:function (){
                         $("#ans").html("<img src='images/preloader.gif' width='100px' align='center'>")
                        }
                        })
                                .done(function(data){
                                 
                         $("#ans").html(data)
                 var ele=document.getElementById('ans');
                        })
                    }
                })
            })
    </script>
<%
  String mail=session.getAttribute("mail").toString();
    if(request.getParameter("submit1")!=null ) 
    {  
        if(request.getParameter("vcode").toString().equals(session.getAttribute("vcode").toString()))
        {
           try
{
    
Class.forName("com.mysql.jdbc.Driver");
Connection myconnection=DriverManager.getConnection(PATH+PLACE,USERNAME,PASSWORD);
try
{
String q="insert into otherstudentinfo (`email`, `fname`, `mname`, `gender`, `dateofbirth`, `weight`, `height`, `contact`, `address`, "
        + "`tmarks`, `tboard`, `tyear`, `twmarks`, `twboard`, `twyear`,"
        + " `dmarks`, `dboard`, "
        + "`dyear`, `bmarks`, `backlogs`) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";  
PreparedStatement mystatement=myconnection.prepareStatement(q);
mystatement.setString(1, mail);  
mystatement.setString(2, request.getParameter("fname"));

mystatement.setString(3,request.getParameter("mname"));
mystatement.setString(5,request.getParameter("dob"));

     mystatement.setString(4,request.getParameter("gender")); 
mystatement.setString(6,request.getParameter("weight"));
     mystatement.setString(7,request.getParameter("height"));
mystatement.setString(8,request.getParameter("contact")); 
     mystatement.setString(9,request.getParameter("address"));
     mystatement.setString(10,request.getParameter("tmarks"));
    
     mystatement.setString(11,request.getParameter("tb")); 
mystatement.setString(12,request.getParameter("ty"));
     if(request.getParameter("twmarks")!=null) 
             {
    mystatement.setString(13,request.getParameter("twmarks"));
     mystatement.setString(14,request.getParameter("twb"));
      mystatement.setString(15,request.getParameter("twy"));
             }
     else
     {
    mystatement.setString(13,"0"); 
    mystatement.setString(14,"0");
    mystatement.setString(15,"0");
     }
        
      if(request.getParameter("dmarks")!=null) 
             {
     mystatement.setString(17,request.getParameter("db"));
     mystatement.setString(18,request.getParameter("dy"));
    mystatement.setString(16,request.getParameter("dmarks"));
             }
     else
     {
    mystatement.setString(17,"0"); 
    mystatement.setString(18,"0");
    mystatement.setString(16,"0");
     }
      mystatement.setString(19,request.getParameter("bmarks"));
    mystatement.setString(20,request.getParameter("backlog"));
   
if(mystatement.executeUpdate()==1)
{
  
   // out.println("<script> alert('Successfully Registered with Daviet Placement.') </script>");
  response.sendRedirect("studentpanel.jsp?m=success");
  
   }
else
{
        //out.println("<h1>fdbdgbgfhgfhjgfjdfkidan</h1>");
        }
}
catch(Exception e)
{
out.println("Error in Query " + e.getMessage());
}
finally
{
    myconnection.close();
}
}
catch(Exception e)
{
out.println("Error in Connection " + e.getMessage());
}

    }
    else
    {
        out.print("<div class='panel-heading' style='height:0px'><b>Kindly Input the correct verification Code</b></p></div>"); 
    }
    }
    
    %>
    <body>
    <div class="login">
     <div class="form" >
        <div class="container" style="height:80px">
           
		
                <form class="form" name="f1" method="post"><br>
                    
                       <table width="100%"  cellpadding="15px" cellspacing="30px" border="1px">
                           <thead> <tr ><th colspan="2"><h1 align="center">B.TECH Placement Registration</h1></th></tr>
                               <tr> <th colspan="2"><h2 align="center">Personal Details</h2></th></tr>
                               <tr ><th><b>Name</b></th><td><input type="text"  name="sname" placeholder="Name" value="<%=session.getAttribute("name")%>" disabled><br></td></tr>
                               <tr ><th> <b> Roll no.</b></th><td><input type='text' value=<%= session.getAttribute("rno")%> disabled><br></td></tr>
                           <tr ><th><b> Father's Name </b></th><td><input type="text"  name="fname" placeholder="Father's Name" required=""><br></td></tr>
                               <tr ><th> <b> Mother's Name </b></th><td><input type="text"  name="mname" placeholder="Mother's Name" required=""><br></td></tr>
                               <tr><th><b> Date Of Birth </b></th>
                                   <td><input type="date" name="dob" placeholder="Date Of Birth" required=""></td></tr>
                               <tr><th> <b>Choose Gender</b></th><br>
                           <th> <b>Male</b><input type='radio' name='gender' value='Male'><b>Female</b><input type='radio' name='gender' value='Female'></th></tr>
                       <tr><th><b>Weight(in Kgs)</b></th>
                           <td> <input type="text" name="weight" placeholder="Weight(Kgs)" required=""></td></tr>
                  <tr><th><b>Height(in cm)</b></th> 
                        <td><input type="text"  name="height" placeholder="Height(cm)" required=""></td></tr>
                <tr><th><b>Contact</b></th>
                        <td><input type="number"  name="contact" placeholder="Contact" required=""></td></tr>
                    <tr><th><b>Permament Address:</b><br></th>
                        <td><textarea  name="address" placeholder="Permament Address" rows='4' cols='40'></textarea></td></tr>
                        
                          <tr><th colspan="2"><legend align='center'>10th</legend></th></tr> <tr><th><b>Marks:(Without % Sign)</b></th><br>
 <td><input type="text"  name="tmarks" placeholder="Upto 2 decimel places.." required=""></td></tr>
 <tr><th><b>Board:</b></th>
     <td><input type="text"  name="tb" placeholder="Board" required=""></td></tr>
                       <tr><th><b>Passing Year:</b></th>
                           <td><input type="number"  name="ty" placeholder="Year" required=""></td></tr>
                      <tr><th colspan="2"><legend align='center'>12th</legend></th></tr> <tr><th><b>Marks:(Without % Sign)</b></th><br>
 <td><input type="text"  name="twmarks" placeholder="Upto 2 decimel places.." ></td></tr>
 <tr><th><b>Board:</b></th>
     <td><input type="text"  name="twb" placeholder="Board"></td></tr>
                       <tr><th><b>Passing Year:</b></th>
                           <td><input type="number"  name="twy" placeholder="Year"></td></tr>
                        <tr><th colspan="2"><legend align='center'>Diploma</legend></th></tr> <tr><th><b>Marks:</b></th><br>
 <td><input type="text"  name="dmarks" placeholder="Upto 2 decimel places.." ></td></tr>
 <tr><th><b>Board:</b></th>
     <td><input type="text"  name="db" placeholder="Board" ></td></tr>
                       <tr><th><b>Passing Year:</b></th>
                           <td><input type="number"  name="dy" placeholder="Year" ></td></tr>
                       <tr><th colspan="2"><legend align='center'>B.TECH.</legend></th></tr> <tr><th><b>Marks (Without % Sign) (Till Date)</b></th><br>
 <td><input type="text"  name="bmarks" placeholder="Upto 2 decimel places.." required=""></td></tr>
 <tr><th><b>No. of Backlogs</b></th>
     <td><select  name="backlog" required="">
 <option value='0'>No Backlog</option>
 <%
     for(int i=1;i<=10;i++)
 {
   out.println("<option value="+i+">"+i+"</option>");   
 }
   %> 
         </select> </td>
   <tr><th><b>Verification Code:(Check your email):</b></th><td ><input type="text" name="vcode" id="vcode"></td><td  colspan="2"><div id="ans"></div></td></tr>
 <tr><th colspan="2"><h3 align='center'><input type="submit"  name="submit1" value="Save" style="height:40px;width:150px;color:red"></h3></th></tr>
 </thead></table>
    <%@include file="footer.jsp" %>
 </form>
 </div> </div> </div>

 </body>
</html>

