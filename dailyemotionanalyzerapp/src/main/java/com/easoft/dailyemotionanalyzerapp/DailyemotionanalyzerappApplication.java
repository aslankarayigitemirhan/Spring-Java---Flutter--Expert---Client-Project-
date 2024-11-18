package com.easoft.dailyemotionanalyzerapp;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@EntityScan(basePackages = "com.easoft")
@ComponentScan(basePackages = "com.easoft")
@EnableJpaRepositories(basePackages = "com.easoft")
public class DailyemotionanalyzerappApplication {

	public static void main(String[] args) {
		SpringApplication.run(DailyemotionanalyzerappApplication.class, args);
	}

}
