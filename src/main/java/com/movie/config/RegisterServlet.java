package com.movie.config;

import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

public class RegisterServlet extends AbstractAnnotationConfigDispatcherServletInitializer {

	@Override
	protected Class<?>[] getRootConfigClasses() {
		return null;
	}

	@Override
	protected Class<?>[] getServletConfigClasses() {
		return new Class[] { ConfigClass.class };
	}

	@SuppressWarnings("null")
	@Override
	protected String[] getServletMappings() {
		return new String[] { "/" };
	}

}
