package com.rbac.console;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class})
@EnableAutoConfiguration
@ComponentScan("com.rbac.console")
public class ConsoleApplication  extends SpringBootServletInitializer {
	public static void main(String[] args) {
		SpringApplication.run(ConsoleApplication.class, args);
	}
	protected SpringApplicationBuilder config(SpringApplicationBuilder applicationBuilder){
		return applicationBuilder.sources(ConsoleApplication.class);
	}

}
