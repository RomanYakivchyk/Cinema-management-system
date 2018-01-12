package com.spring.config;

import com.spring.config.security.SecurityConfig;
import com.spring.utility.LocalDateConverter;
import com.spring.utility.LocalDateTimeConverter;
import com.spring.utility.TechnologyConverter;

import java.io.IOException;

import org.springframework.context.annotation.*;
import org.springframework.format.FormatterRegistry;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

@Configuration
@EnableWebMvc
@EnableAspectJAutoProxy
@ComponentScan(basePackages = "com.spring")
@Import({JdbcConfig.class,SecurityConfig.class})
public class AppConfig extends WebMvcConfigurerAdapter {

	@Bean
	public ViewResolver viewResolver() {
		InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
		viewResolver.setViewClass(JstlView.class);
		viewResolver.setPrefix("/WEB-INF/views/");
		viewResolver.setSuffix(".jsp");

		return viewResolver;
	}

	@Bean(name="multipartResolver")
	 public CommonsMultipartResolver getResolver() throws IOException {
	  CommonsMultipartResolver resolver = new CommonsMultipartResolver();
	  //Set the maximum allowed size (in bytes) for each individual file.
	  resolver.setMaxUploadSizePerFile(5 * 1024 * 1024);//5MB
	  return resolver;
	}

	@Override
	public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
		configurer.enable();
	}

	@Override
	public void addResourceHandlers(final ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
	}
	
	@Override
    public void addFormatters(FormatterRegistry registry) {
        registry.addConverter(new LocalDateConverter("yyyy-MM-dd"));
        registry.addConverter(new LocalDateTimeConverter("yyyy-MM-dd HH:mm"));
        registry.addConverter(new TechnologyConverter());
    }
	
}