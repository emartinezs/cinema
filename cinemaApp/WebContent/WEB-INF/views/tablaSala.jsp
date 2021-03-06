<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Salas</title>
<link href="resources/css/bootstrap.css" rel="stylesheet">
 <!-- Material Design Bootstrap -->
    <link href="resources/css/mdb.css" rel="stylesheet">
    <link href="resources/js/mdb.js" rel="stylesheet">
<script src="resources/js/sweetalert2.min.js"></script>
<link rel="stylesheet" href="resources/css/sweetalert2.min.css">
<script src="resources/js/jquery-3.3.0.js"></script>
</head>
<body>
	<h1>Salas</h1>
	<form:form action="${pageContext.request.contextPath}/administracion">
		<input class="btn btn-primary" type="submit" value="Menu">
	</form:form>
	<form:form action="${pageContext.request.contextPath}/formAddSala">
		<input class="btn btn-primary" type="submit" value="Nueva Sala">
	</form:form>
	
	<table class="table">
		<thead class="thead">
		<tr>
			<th colspan="3">Acci&oacute;n</th>
			<th>C&oacute;digo</th>
			<th>Descripci&oacute;n</th>
			<th>Estado</th>
			<th>Fecha Creaci&oacute;n</th>
			<th>Usuario Creaci&oacute;n</th>
			<th>Fecha Modificaci&oacute;n</th>
			<th>Usuario Modificaci&oacute;n	</th>
		</tr>
		</thead>
		<c:forEach items="${salas}" var="sala">
			<tr>
				<td>
					<button class="btn btn-outline-primary" onclick="ver(${sala.id});">Ver</button>
				</td>
				<td>
					<form:form action="${pageContext.request.contextPath}/formEditSala">
						<input type="hidden" name="id" value="${sala.id}">
						<input class="btn btn-outline-primary" type="submit" value="Editar">
					</form:form>
				</td>
				<td>
					<form:form id="form" action="${pageContext.request.contextPath}/activarSala" onsubmit="return confirm('Confirm')">
						<input class="btn btn-outline-primary" type="hidden" name="id" value="${sala.id}">
						<c:choose>
							<c:when test="${sala.activo == true}">
								<input class="btn btn-outline-primary" type="submit" value="Inactivar">
							</c:when>
							<c:otherwise>
								<input class="btn btn-outline-primary" type="submit" value="Activar">
							</c:otherwise>
						</c:choose>
					</form:form>
				</td>
				<td>${sala.id}</td>
				<td>${sala.numero}</td>
				<td>${sala.activoDelegate}</td>
				<td>${sala.fechaCreacionDelegate}</td>
				<td>${sala.usuarioCreacion.username}</td>
				<td>${sala.fechaModificacionDelegate}</td>
				<td>${sala.usuarioModificacion.username}</td>
			</tr>
		</c:forEach>
	</table>
	
	<script>
	ver = function(id){
		$.ajax({
            type : 'POST',
            url : '${pageContext.request.contextPath}/verSala',
            data: {id:id},
            dataType: 'json',
            success : function(response) {
            	console.log(response);
            	
            	Swal.fire({
       				type: 'info',
            		title: 'Sala',
            		html:
            		    'Numero: ' + response.numero + "<br>" +
            		    'Descripcion: ' + response.descripcion + "<br>" +
            		    'Asientos: ' + response.capacidad + "<br>",
            		 });
            },
            error : function() {
                alert("Error");
            }
        });
	}
	</script>
</body>
</html>