package com.cv.s01serviceregistry;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.server.EnableEurekaServer;

@SpringBootApplication
@EnableEurekaServer
public class S01ServiceRegistry {

    public static void main(String[] args) {
        SpringApplication.run(S01ServiceRegistry.class, args);
    }

}
