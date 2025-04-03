package com.api.keycloak.dto;

public record UserProfileDto(
        String name,
        String preferredUsername,
        String givenName,
        String familyName,
        String email
) {}
