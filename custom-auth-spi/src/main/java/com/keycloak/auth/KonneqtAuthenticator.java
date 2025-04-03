package com.keycloak.auth;

import org.keycloak.authentication.AuthenticationFlowContext;
import org.keycloak.authentication.AuthenticationFlowError;
import org.keycloak.authentication.Authenticator;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.RealmModel;
import org.keycloak.models.UserModel;

import jakarta.ws.rs.core.Response;
import java.util.UUID;

public class KonneqtAuthenticator implements Authenticator {

    private static final String KONNEQT_TOKEN_PARAM = "konneqt_token";

    @Override
    public void authenticate(AuthenticationFlowContext context) {
        // Try to get token from query parameter first
        String token = context.getUriInfo().getQueryParameters().getFirst(KONNEQT_TOKEN_PARAM);
        
        // Fallback to header if not in query params
        if (token == null) {
            token = context.getHttpRequest().getHttpHeaders().getHeaderString("X-Konneqt-Token");
        }

        if (token == null || token.isEmpty()) {
            Response errorResponse = Response.status(Response.Status.BAD_REQUEST)
                .entity("{\"error\": \"missing_token\", \"error_description\": \"Konneqt token is required\"}")
                .build();
            context.failure(AuthenticationFlowError.INVALID_CREDENTIALS, errorResponse);
            return;
        }

        // Rest of your authentication logic...
        RealmModel realm = context.getRealm();
        UserModel user = context.getSession().users().getUserByEmail(realm, token);
        
        if (user == null) {
            user = context.getSession().users().addUser(realm, UUID.randomUUID().toString());
            user.setEmail(token);
            user.setEnabled(true);
        }

        context.setUser(user);
        context.success();
    }
    
    @Override
    public void action(AuthenticationFlowContext context) {
    }

    @Override
    public boolean requiresUser() {
        return false;
    }

    @Override
    public boolean configuredFor(KeycloakSession session, RealmModel realm, UserModel user) {
        return true;
    }

    @Override
    public void setRequiredActions(KeycloakSession session, RealmModel realm, UserModel user) {
    }

    @Override
    public void close() {
    }
}