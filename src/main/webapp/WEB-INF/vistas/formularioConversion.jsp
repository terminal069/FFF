<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Formulario Conversión</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script language="Javascript" src="js/jquery-3.1.0.min.js"></script>
<script language="Javascript" src="js/funciones.js"></script>
<link type="text/css" href="css/estilos.css" rel="stylesheet" />
</head>
<body>
	<form:form modelAttribute="formularioConversion" action="conversion.do" method="POST">
		<div class="web">
			<div class="contenedor">
				<div class="div_cabecera div_conversion_cabecera sombra borde_redondeado">
					FORMULARIO CONVERSIÓN
				</div>
				<div class="div_resultados div_conversion_resultado sombra borde_redondeado" id="contenedorResultadoId" style="display: none">
					<div class="div_texto_centrado">
						Resultado
					</div>
					<div id="resultadoId">
						${formularioConversion.resultado}
					</div>
				</div>
				<div class="div_resultados div_conversion_errores sombra borde_redondeado" id="contenedorErroresId" style="display: none">
					<div class="div_texto_centrado">
						Errores
					</div>
					<div id="erroresId">
						${formularioConversion.errores}
					</div>
				</div>
				<div class="div_conversion_formulario">
					<div class="div_fila">
						<div class="div_columna div_columna_1_2 sombra borde_redondeado">
							<div class="div_etiqueta">
								<form:label path="tipoConversion">Tipo de conversión:</form:label>
							</div>
							<div class="div_campo">
								<form:select path="tipoConversion" id="tipoConversionId" onchange="comprobarTipoConversion();">
									<form:option value="POR_NOMBRE">Por nombre</form:option>
									<form:option value="EXIF">Etiqueta EXIF</form:option>
								</form:select>
							</div>
						</div>
					</div>
					<div class="div_fila">
						<div class="div_columna div_columna_1_2 sombra borde_redondeado">
							<div class="div_etiqueta">
								<form:label cssClass="etiqueta" path="directorioEntrada">Directorio entrada:</form:label>
							</div>
							<div class="div_campo">
								<form:input path="directorioEntrada" />
							</div>
						</div>
						<div class="div_columna div_columna_2_2 sombra borde_redondeado">
							<div class="div_etiqueta">
								<form:label path="formatoEntrada">Formato entrada: <img src="img/ayuda.png" onclick="mostrarAyudaFormato('formatoEntradaId');" class="ayuda_formato"></form:label>
							</div>
							<div class="div_campo">
								<form:input path="formatoEntrada" id="formatoEntradaId" />
							</div>
						</div>
					</div>
					<div class="div_fila">
						<div class="div_columna div_columna_1_2 sombra borde_redondeado">
							<div class="div_etiqueta">
								<form:label path="directorioSalida">Directorio salida:</form:label>
							</div>
							<div class="div_campo">
								<form:input path="directorioSalida" />
							</div>
						</div>
						<div class="div_columna div_columna_2_2 sombra borde_redondeado">
							<div class="div_etiqueta">
								<form:label path="formatoSalida">Formato salida: <img src="img/ayuda.png" onclick="mostrarAyudaFormato('formatoSalidaId');" class="ayuda_formato"></form:label>
							</div>
							<div class="div_campo">
								<form:input path="formatoSalida" id="formatoSalidaId" />
							</div>
						</div>
					</div>
				</div>
				<div class="div_boton_gigante">
					<input type="submit" value="Convertir" class="boton_gigante sombra">
				</div>
			</div>
			<div class="div_pie">
				&#169;&nbsp;Powered by TML
			</div>
		</div>
	</form:form>
	<div id="contenedorAyudaFormatoId" style="display: none;">
		<input type="hidden" id="ayudaFormatoId">
		<div class="capaBloqueo" onclick="ocultarAyudaFormato();"></div>
		<div class="popup div_popup_ayuda_formato sombra borde_redondeado">
			<div class="div_popup sombra">
				<table class="tabla_desplegable">
					<thead id="cabeceraTablaPatronesFechaId" onclick="mostrarCuerpoTabla('cabeceraTablaPatronesFechaId', 'cuerpoTablaPatronesFechaId', 'textoCabeceraTablaPatronesFechaId', 'Patrones de fecha');">
						<tr>
							<th colspan="4" id="textoCabeceraTablaPatronesFechaId">&#9660; Patrones de fecha &#9660;</th>
						</tr>
					</thead>
					<tbody id="cuerpoTablaPatronesFechaId" style="display: none">
						<tr>
							<th>Patrón</th>
							<th>Componente de fecha u hora</th>
							<th>Presentación</th>
							<th>Ejemplo</th>
						</tr>
						<tr class="fila_tabla_impar">
							<td>G</td>
							<td>Era designator</td>
							<td>Text</td>
							<td>AD</td>
						</tr>
						<tr class="fila_tabla_par">
							<td>y</td>
							<td>Year</td>
							<td>Year</td>
							<td>1996; 96</td>
						</tr>
						<tr class="fila_tabla_impar">
							<td>Y</td>
							<td>Week year</td>
							<td>Year</td>
							<td>2009; 09</td>
						</tr>
						<tr class="fila_tabla_par">
							<td>M</td>
							<td>Month in year</td>
							<td>Month</td>
							<td>July; Jul; 07</td>
						</tr>
						<tr class="fila_tabla_impar">
							<td>w</td>
							<td>Week in year</td>
							<td>Number</td>
							<td>27</td>
						</tr>
						<tr class="fila_tabla_par">
							<td>W</td>
							<td>Week in month</td>
							<td>Number</td>
							<td>2</td>
						</tr>
						<tr class="fila_tabla_impar">
							<td>D</td>
							<td>Day in year</td>
							<td>Number</td>
							<td>189</td>
						</tr>
						<tr class="fila_tabla_par">
							<td>d</td>
							<td>Day in month</td>
							<td>Number</td>
							<td>10</td>
						</tr>
						<tr class="fila_tabla_impar">
							<td>F</td>
							<td>Day of week in month</td>
							<td>Number</td>
							<td>2</td>
						</tr>
						<tr class="fila_tabla_par">
							<td>E</td>
							<td>Day name in week</td>
							<td>Text</td>
							<td>Tuesday; Tue</td>
						</tr>
						<tr class="fila_tabla_impar">
							<td>u</td>
							<td>Day number of week (1 = Monday, ..., 7 = Sunday)</td>
							<td>Number</td>
							<td>1</td>
						</tr>
						<tr class="fila_tabla_par">
							<td>a</td>
							<td>Am/pm marker</td>
							<td>Text</td>
							<td>PM</td>
						</tr>
						<tr class="fila_tabla_impar">
							<td>H</td>
							<td>Hour in day (0-23)</td>
							<td>Number</td>
							<td>0</td>
						</tr>
						<tr class="fila_tabla_par">
							<td>k</td>
							<td>Hour in day (1-24)</td>
							<td>Number</td>
							<td>24</td>
						</tr>
						<tr class="fila_tabla_impar">
							<td>K</td>
							<td>Hour in am/pm (0-11)</td>
							<td>Number</td>
							<td>0</td>
						</tr>
						<tr class="fila_tabla_par">
							<td>h</td>
							<td>Hour in am/pm (1-12)</td>
							<td>Number</td>
							<td>12</td>
						</tr>
						<tr class="fila_tabla_impar">
							<td>m</td>
							<td>Minute in hour</td>
							<td>Number</td>
							<td>30</td>
						</tr>
						<tr class="fila_tabla_par">
							<td>s</td>
							<td>Second in minute</td>
							<td>Number</td>
							<td>55</td>
						</tr>
						<tr class="fila_tabla_impar">
							<td>S</td>
							<td>Millisecond</td>
							<td>Number</td>
							<td>978</td>
						</tr>
						<tr class="fila_tabla_par">
							<td>z</td>
							<td>Time zone</td>
							<td>General time zone</td>
							<td>Pacific Standard Time; PST; GMT-08:00</td>
						</tr>
						<tr class="fila_tabla_impar">
							<td>Z</td>
							<td>Time zone</td>
							<td>RFC 822 time zone</td>
							<td>-0800</td>
						</tr>
						<tr class="fila_tabla_par">
							<td>X</td>
							<td>Time zone</td>
							<td>ISO 8601 time zone</td>
							<td>-08; -0800; -08:00</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="div_popup sombra">
				<table class="tabla_desplegable">
					<thead id="cabeceraTablaEjemplosPatronesFechaId" onclick="mostrarCuerpoTabla('cabeceraTablaEjemplosPatronesFechaId', 'cuerpoTablaEjemplosPatronesFechaId', 'textoCabeceraTablaEjemplosPatronesFechaId', 'Ejemplos de patrones de fecha');">
						<tr>
							<th colspan="2" id="textoCabeceraTablaEjemplosPatronesFechaId">&#9660; Ejemplos de patrones de fecha &#9660;</th>
						</tr>
					</thead>
					<tbody id="cuerpoTablaEjemplosPatronesFechaId" style="display: none">
						<tr>
							<th>Patron de fecha y hora</th>
							<th>Resultado</th>
						</tr>
						<tr class="fila_tabla_impar">
							<td>"yyyy.MM.dd G 'at' HH:mm:ss z"</td>
							<td>2001.07.04 AD at 12:08:56 PDT</td>
						</tr>
						<tr class="fila_tabla_par">
							<td>"EEE, MMM d, ''yy"</td>
							<td>Wed, Jul 4, '01</td>
						</tr>
						<tr class="fila_tabla_impar">
							<td>"h:mm a"</td>
							<td>12:08 PM</td>
						</tr>
						<tr class="fila_tabla_par">
							<td>"hh 'o''clock' a, zzzz"</td>
							<td>12 o'clock PM, Pacific Daylight Time</td>
						</tr>
						<tr class="fila_tabla_impar">
							<td>"K:mm a, z"</td>
							<td>0:08 PM, PDT</td>
						</tr>
						<tr class="fila_tabla_par">
							<td>"yyyyy.MMMMM.dd GGG hh:mm aaa"</td>
							<td>02001.July.04 AD 12:08 PM</td>
						</tr>
						<tr class="fila_tabla_impar">
							<td>"EEE, d MMM yyyy HH:mm:ss Z"</td>
							<td>Wed, 4 Jul 2001 12:08:56 -0700</td>
						</tr>
						<tr class="fila_tabla_par">
							<td>"yyMMddHHmmssZ"</td>
							<td>010704120856-0700</td>
						</tr>
						<tr class="fila_tabla_impar">
							<td>"yyyy-MM-dd'T'HH:mm:ss.SSSZ"</td>
							<td>2001-07-04T12:08:56.235-0700</td>
						</tr>
						<tr class="fila_tabla_par">
							<td>"yyyy-MM-dd'T'HH:mm:ss.SSSXXX"</td>
							<td>2001-07-04T12:08:56.235-07:00</td>
						</tr>
						<tr class="fila_tabla_impar">
							<td>"YYYY-'W'ww-u"</td>
							<td>2001-W27-3</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="div_popup div_patrones_conocidos sombra borde_redondeado">
				<div class="div_etiqueta">Patrones conocidos:</div>
				<select onchange="cargarPatronPopup(this.value);" id="selectCargarPatronId">
					<option value="0">Selecciona un patrón o insértalo a mano...</option>
					<option value="">-</option>
					<option value="EXIF">EXIF</option>
					<option value="AND_EST">Android estándar</option>
					<option value="AND_MILI">Android con milisegundos</option>
					<option value="IPHONE_ESP">iPhone (hora con espacios)</option>
					<option value="IPHONE_PUN">iPhone (hora con puntos)</option>
					<option value="">-</option>
					<option value="SALIDA_EST">Salida estándar</option>
				</select>
				<div class="div_patron_cargado"><input type="text" id="patronSeleccionadoId"></div>
			</div>
			<div class="div_popup div_boton_gigante">
				<input type="button" value="Cargar" class="boton_gigante sombra" onclick="cargarPatron();">
			</div>
		</div>
	</div>
</body>
</html>