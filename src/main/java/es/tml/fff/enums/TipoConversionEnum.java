package es.tml.fff.enums;

public enum TipoConversionEnum
{	
	POR_NOMBRE("Por nombre"),
	EXIF("Etiqueta EXIF");
	
	private String nombre;
	
	public String getNombre()
	{
		return nombre;
	}
	
	TipoConversionEnum(String nombre)
	{
		this.nombre = nombre;
	}
	
	public String toString()
	{
		return getNombre();
	}
}
