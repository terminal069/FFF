package es.tml.fff.controladores;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import es.tml.fff.beans.DatosFormularioConversion;
import es.tml.fff.enums.TipoConversionEnum;

@Controller
public class ControladorPrincipal
{
	private final String FORMATO_DEFECTO_SALIDA = "yyyyMMdd_HHmmss'.jpg'";
	
	/**
	 * Entrada del programa desde la página de inicio
	 * 
	 * @return
	 */
	@RequestMapping("/inicio.do")
	public ModelAndView inicio()
	{
		DatosFormularioConversion dfc = new DatosFormularioConversion();
		dfc.setDirectorioEntrada("");
		dfc.setDirectorioSalida("");
		dfc.setTipoConversion(TipoConversionEnum.EXIF);
		dfc.setFormatoEntrada("");
		dfc.setFormatoSalida(FORMATO_DEFECTO_SALIDA);
		
		return new ModelAndView("formularioConversion", "formularioConversion", dfc);
	}
	
	@RequestMapping("/conversion.do")
	public ModelAndView conversion(@ModelAttribute DatosFormularioConversion formularioConversion)
	{
		ControladorConversion controladorConversion = new ControladorConversion(formularioConversion);
		controladorConversion.conversion();
		
		return new ModelAndView("formularioConversion", "formularioConversion", formularioConversion);
	}
	
}
