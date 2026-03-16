package com.knowyourself.quiz;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@SpringBootApplication
@EnableJpaRepositories
@EnableTransactionManagement
public class KnowYourselfApplication {

    public static void main(String[] args) {
        SpringApplication.run(KnowYourselfApplication.class, args);
        System.out.println("\n" +
                "╔═══════════════════════════════════════════════════╗\n" +
                "║                                                   ║\n" +
                "║        Know Yourself - Quiz Application          ║\n" +
                "║                                                   ║\n" +
                "║        Backend Server Running Successfully        ║\n" +
                "║                                                   ║\n" +
                "║        API: http://localhost:8080/api            ║\n" +
                "║        Frontend: http://localhost:3000            ║\n" +
                "║                                                   ║\n" +
                "╚═══════════════════════════════════════════════════╝\n");
    }
}
