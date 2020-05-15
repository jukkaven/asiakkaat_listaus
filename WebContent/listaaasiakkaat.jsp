<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<title>Insert title here</title>

<style>

#haku {
  width: 40%;
  padding: 12px 20px 12px 40px;
  border: 1px solid #ddd;
  margin-bottom: 12px;
}

#listaus {
  width: 80%;
}

#listaus th, #listaus td {
  text-align: left;
  padding: 12px;
  border: 1px solid #ddd;
  border-collapse: collapse;
}

#listaus tr {
  border-bottom: 1px solid #ddd;
}

#listaus th{
background-color: steelblue;
}

#listaus td{
  background-color: lightgray;
}
</style>

</head>
<body>

<input type="text" id="haku" onkeyup="hakuFunction()" placeholder="Hae asiakkaita..." title="Hakusana">

<table id="listaus">
	<thead>				
		<tr Class="header">
					
			<th>Etunimi</th>
			<th>Sukunimi</th>
			<th>Puhelin</th>
			<th>Sähköposti</th>							
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>
<script>
$(document).ready(function(){
	$.ajax({url:"asiakkaat", type:"GET", dataType:"json", success:function(result){//Funktio palauttaa tiedot json-objektina		
		$.each(result.asiakkaat, function(i, field){  
        	var htmlStr;
        	htmlStr+="<tr>";
        	htmlStr+="<td>"+field.etunimi+"</td>";
        	htmlStr+="<td>"+field.sukunimi+"</td>";
        	htmlStr+="<td>"+field.puhelin+"</td>";
        	htmlStr+="<td>"+field.sposti+"</td>";  
        	htmlStr+="</tr>";
        	$("#listaus tbody").append(htmlStr);
        });	
    }});
});	

function hakuFunction() {
	  var input, filter, table, tr, td, i, txtValue;
	  input = document.getElementById("haku");
	  filter = input.value.toUpperCase();
	  table = document.getElementById("listaus");
	  tr = table.getElementsByTagName("tr");
	  for (i = 0; i < tr.length; i++) {
	    td = tr[i].getElementsByTagName("td")[0,1,2,3];
	    if (td) {
	      txtValue = td.textContent || td.innerText;
	      if (txtValue.toUpperCase().indexOf(filter) > -1) {
	        tr[i].style.display = "";
	      } else {
	        tr[i].style.display = "none";
	      }
	    }       
	  }}

</script>
</body>
</html>