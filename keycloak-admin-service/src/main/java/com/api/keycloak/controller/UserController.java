package com.api.keycloak.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.api.keycloak.dto.UserProfileDto;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.web.bind.annotation.CrossOrigin;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/api/user")
public class UserController {

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

    @GetMapping("/profile")
    @PreAuthorize("isAuthenticated()")
    public UserProfileDto getUserProfile(@AuthenticationPrincipal Jwt jwt) {
        if (jwt == null) {
            throw new IllegalStateException("Usuário não autenticado!");
        }

        return new UserProfileDto(
                jwt.getClaim("name"),
                jwt.getClaim("preferred_username"),
                jwt.getClaim("given_name"),
                jwt.getClaim("family_name"),
                jwt.getClaim("email")
        );
    }
}
