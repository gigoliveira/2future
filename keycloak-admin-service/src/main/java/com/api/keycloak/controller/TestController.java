package com.api.keycloak.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class TestController {

    @GetMapping("/public")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<String> publicEndpoint() {
        return ResponseEntity.ok(" Endpoint público: Qualquer um pode acessar!");
    }

    @GetMapping("/admin")
    @PreAuthorize("hasRole('admin')")
    public ResponseEntity<String> adminEndpoint() {
        return ResponseEntity.ok("🔐 Endpoint privado: Apenas admins podem acessar!");
    }
}
