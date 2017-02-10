package es.tml.fff.controladores;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;

import com.drew.imaging.ImageMetadataReader;
import com.drew.metadata.Directory;
import com.drew.metadata.Metadata;
import com.drew.metadata.Tag;

import es.tml.fff.beans.DatosFormularioConversion;
import es.tml.fff.enums.TipoConversionEnum;

public class ControladorConversion
{
	private DatosFormularioConversion datos;
	private String directorioEntrada;
	private String directorioSalida;
	private TipoConversionEnum tipoConversion;
	private String formatoEntrada;
	private String formatoSalida;
	private List<String> listaErrores;
	
	int ok = 0;
	int ko = 0;
	int total = 0;
	
	private static final Logger log = Logger.getLogger(ControladorConversion.class);
	
	/**
	 * Constructor
	 * 
	 * @param datos Datos con los que se va a realizar la conversión
	 */
	public ControladorConversion(DatosFormularioConversion datos)
	{
		this.datos = datos;
		this.directorioEntrada = datos.getDirectorioEntrada();
		this.directorioSalida = datos.getDirectorioSalida();
		this.tipoConversion = datos.getTipoConversion();
		this.formatoEntrada = datos.getFormatoEntrada();
		this.formatoSalida = datos.getFormatoSalida();
		
		this.datos.setResultado("");
		this.datos.setErrores("");
		listaErrores = new ArrayList<String>();
	}
	
	/**
	 * Entrada al programa
	 */
	public void conversion()
	{
		long id = System.currentTimeMillis();
		
		try
		{
			log.debug("\n\n\n\n\n\n\n\n\n\n");
			log.debug("--------------------------------------- INICIO (" + id + ") ---------------------------------");
			
			comprobarDatos();
			ejecutar();
		}
		catch (Exception e)
		{
			log.error("Error ejecutando el programa", e);
		}
		finally
		{
			log.debug("--------------------------------------- FIN (" + id + ") ------------------------------------");
		}
		
		try
		{
			datos.setResultado(procesarResultados());
			datos.setErrores(procesarErrores());
		}
		catch (Exception e)
		{
			log.fatal("Error guardando los resultados: ", e);
		}
	}
	
	/**
	 * Comprueba los datos
	 * 
	 * @throws Exception
	 */
	private void comprobarDatos() throws Exception
	{
		boolean error = false;
		
		// Campos vacíos
		if ("".equals(directorioEntrada))
		{
			listaErrores.add("No se ha especificado directorio de entrada");
			error = true;
		}
		
		if ("".equals(directorioSalida))
		{
			listaErrores.add("No se ha especificado directorio de salida");
			error = true;
		}
		
		if ("".equals(formatoEntrada))
		{
			listaErrores.add("No se ha especificado un formato de entrada");
			error = true;
		}
		
		if ("".equals(formatoSalida))
		{
			listaErrores.add("No se ha especificado un formato de salida");
			error = true;
		}
		
		if (error)
		{
			throw new Exception("Error en los datos de entrada del formulario");
		}
		
		// Directorios
		if (!directorioEntrada.endsWith("\\"))
		{
			directorioEntrada += "\\";
		}
		
		if (!directorioSalida.endsWith("\\"))
		{
			directorioSalida += "\\";
		}
	}
	
	/**
	 * Ejecuta el programa
	 * 
	 * @throws Exception
	 */
	private void ejecutar() throws Exception
	{
		// Se obtienen los formatos de las fotos
		SimpleDateFormat sdfEntrada = new SimpleDateFormat(formatoEntrada);
		SimpleDateFormat sdfSalida = new SimpleDateFormat(formatoSalida);
		
		// Se cargan las fotos
		String[] ficheros = new File(directorioEntrada).list();
		
		String nuevoNombreFichero = "";
		Date fechaConversion = null;
		
		for (String nombreFichero : ficheros)
		{
			try
			{
				total++;
				
				log.debug("Procesando el fichero '" + nombreFichero + "'");
				
				// Si se hace conversion con la fecha de la informacion EXIF de la foto
				if (TipoConversionEnum.EXIF.equals(tipoConversion))
				{
					fechaConversion = obtenerFechaExif(sdfEntrada, directorioEntrada + nombreFichero);
				}
				// Si se hace la conversion por el formato de la fecha en el nombre de fichero
				else
				{
					fechaConversion = obtenerFechaFormatoNombre(sdfEntrada, nombreFichero);
				}
				
				nuevoNombreFichero = sdfSalida.format(fechaConversion);
				File fichero = new File(directorioEntrada + nombreFichero);
				
				// Se renombra y se comprueba que se haya renombrado correctamente
				if (!fichero.renameTo(new File(directorioSalida + nuevoNombreFichero)))
				{
					throw new Exception("Error al renombrar el fichero, de '" + nombreFichero + "' a '" + nuevoNombreFichero + "'");
				}
				
				log.debug("Fichero '" + nombreFichero + "' renombrado correctamente a '" + nuevoNombreFichero + "'");
				ok++;
			}
			catch(Exception e)
			{
				listaErrores.add(nombreFichero + ": " + e.getMessage());
				log.error("Error renombrando el fichero '" + nombreFichero + "' con el formato '" + formatoEntrada + "'", e);
				ko++;
			}
		}
	}
	
	/**
	 * Obtiene la fecha de la foto a partir del formato del nombre del fichero
	 * 
	 * @param sdfEntrada Formato de entrada
	 * @param nombreFichero Nombre del fichero
	 * @return Fecha de la foto
	 * @throws Exception
	 */
	private Date obtenerFechaFormatoNombre(SimpleDateFormat sdfEntrada, String nombreFichero) throws Exception
	{
		return sdfEntrada.parse(nombreFichero);
	}

	/**
	 * Obtiene la fecha de la foto a partir de la informaci�n EXIF de la misma
	 * 
	 * @param sdfEntrada Formato de entrada
	 * @param rutaNombreFichero Ruta del fichero
	 * @return Fecha de la foto
	 * @throws Exception
	 */
	private Date obtenerFechaExif(SimpleDateFormat sdfEntrada, String rutaNombreFichero) throws Exception
	{
		Date fechaConversion = null;
		boolean continuar = true;
		
		Metadata metadata = ImageMetadataReader.readMetadata(new File(rutaNombreFichero));

		for (Directory directory : metadata.getDirectories())
		{
			for (Tag tag : directory.getTags())
			{
				if (tag.getTagName().equals("Date/Time"))
				{
					fechaConversion = sdfEntrada.parse(tag.getDescription());
					continuar = false;
					break;
				}
			}
			
			if (!continuar)
			{
				break;
			}
		}
		
		if (fechaConversion == null)
		{
			throw new Exception("No se ha encontrado etiqueta EXIF de fecha");
		}
		
		return fechaConversion;
	}
	
	/**
	 * Procesa el resultado de la ejecución del programa
	 * 
	 * return Resultado
	 */
	private String procesarResultados()
	{
		StringBuilder sbWeb = new StringBuilder();
		StringBuilder sbLog = new StringBuilder();
		
		if (total == 0)
		{
			sbLog.append("No se ha procesado ningún fichero");
			sbWeb.append("No se ha procesado ningún fichero");
		}
		else
		{
			sbLog.append("\n\t - Total correctos:   ").append(ok)
					.append("\n\t - Total incorrectos: ").append(ko)
					.append("\n\t - Total procesados:  ").append(total);
			
			sbWeb.append("- Total correctos:   ").append(ok).append("<br>")
					.append("- Total incorrectos: ").append(ko).append("<br>")
					.append("- Total procesados:  ").append(total);
		}
		
		log.info(sbLog.toString());
		
		return sbWeb.toString();
	}
	
	/**
	 * Procesa los errores de la ejecución del programa
	 * 
	 * @return Errores
	 */
	private String procesarErrores()
	{
		StringBuilder sbWeb = new StringBuilder();
		StringBuilder sbLog = new StringBuilder();
		
		for (String error : listaErrores)
		{
			sbWeb.append("<div class=\"div_conversion_error\">")
					.append("- ")
					.append(error)
					.append("</div>");
			
			sbLog.append("\n\t - ").append(error);
		}
		
		if (sbLog.length() > 0)
		{
			sbLog.insert(0, "Errores:");
			log.error(sbLog.toString());
		}
		
		return sbWeb.toString();
	}
}
