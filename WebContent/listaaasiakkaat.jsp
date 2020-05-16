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

#uusiAsiakas, #takaisin{
	color: white;	
	cursor: pointer;	
}

.poista{
	color: red;
	text-decoration: underline;
	cursor: pointer;	
}

</style>

</head>
<body>

<input type="text" id="haku" onkeyup="hakuFunction()" placeholder="Hae asiakkaita..." title="Hakusana">

<table id="listaus">
	<thead>	
	
	<tr>
			<th colspan="6"><span id="uusiAsiakas">Lisää uusi asiakas</span></th>
		</tr>
				
		<tr Class="header">
			<th>Asiakasnumero</th>		
			<th>Etunimi</th>
			<th>Sukunimi</th>
			<th>Puhelin</th>
			<th>Sähköposti</th>	
			
			<th></th>
									
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
        	htmlStr+="<tr id='rivi_"+field.asiakas_id+"'>";
        	htmlStr+="<td>"+field.asiakas_id+"</td>";
        	htmlStr+="<td>"+field.etunimi+"</td>";
        	htmlStr+="<td>"+field.sukunimi+"</td>";
        	htmlStr+="<td>"+field.puhelin+"</td>";
        	htmlStr+="<td>"+field.sposti+"</td>";  
        	htmlStr+="<td><span class='poista' onclick=poista('"+field.asiakas_id+"')>Poista</span></td>"; 
        	htmlStr+="</tr>";
        	$("#listaus tbody").append(htmlStr);
        });	
    }});
	
	$("#uusiAsiakas").click(function(){
		document.location="lisaaasiakas.jsp";
	});
	
});	

function hakuFunction() {
	  var input, filter, table, tr, td, i, txtValue;
	  input = document.getElementById("haku");
	  filter = input.value.toUpperCase();
	  table = document.getElementById("listaus");
	  tr = table.getElementsByTagName("tr");
	  for (i = 0; i < tr.length; i++) {
	    td = tr[i].getElementsByTagName("td")[0,1,2,3,4];
	    if (td) {
	      txtValue = td.textContent || td.innerText;
	      if (txtValue.toUpperCase().indexOf(filter) > -1) {
	        tr[i].style.display = "";
	      } else {
	        tr[i].style.display = "none";
	      }
	    }       
	  }}
	  
function poista(asiakas_id){
	if(confirm("Poista asiakas " + asiakas_id +"?")){
		$.ajax({url:"asiakkaat/"+asiakas_id, type:"DELETE", dataType:"json", success:function(result) { //result on joko {"response:1"} tai {"response:0"}
	        if(result.response==0){
	        	$("#ilmo").html("Asiakkaan poisto epäonnistui.");
	        }else if(result.response==1){
	        	$("#rivi_"+asiakas_id).css("background-color", "red"); //Värjätään poistetun asiakkaan rivi
	        	alert("Asiakkaan " + rekno +" poisto onnistui.");
				        	
			}
	    }});
	}
}

</script>
</body>
</html>