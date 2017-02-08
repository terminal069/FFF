package es.tml.fff.beans;

import es.tml.fff.enums.TipoConversionEnum;

public class DatosFormularioConversion
{
	private String directorioEntrada;
	private String directorioSalida;
	private TipoConversionEnum tipoConversion;
	private String formatoEntrada;
	private String formatoSalida;
	private String resultado;
	private String errores;
	
	public String getDirectorioEntrada()
	{
		return directorioEntrada;
	}
	
	public void setDirectorioEntrada(String directorioEntrada)
	{
		this.directorioEntrada = directorioEntrada;
	}
	
	public String getDirectorioSalida()
	{
		return directorioSalida;
	}
	
	public void setDirectorioSalida(String directorioSalida)
	{
		this.directorioSalida = directorioSalida;
	}
	
	public TipoConversionEnum getTipoConversion()
	{
		return tipoConversion;
	}
	
	public void setTipoConversion(TipoConversionEnum tipoConversion)
	{
		this.tipoConversion = tipoConversion;
	}
	
	public String getFormatoEntrada()
	{
		return formatoEntrada;
	}
	
	public void setFormatoEntrada(String formatoEntrada)
	{
		this.formatoEntrada = formatoEntrada;
	}
	
	public String getFormatoSalida()
	{
		return formatoSalida;
	}
	
	public void setFormatoSalida(String formatoSalida)
	{
		this.formatoSalida = formatoSalida;
	}
	
	public String getResultado()
	{
		return resultado;
	}
	
	public void setResultado(String resultado)
	{
		this.resultado = resultado;
	}
	
	public String getErrores()
	{
		return errores;
	}
	
	public void setErrores(String errores)
	{
		this.errores = errores;
	}
	
}
