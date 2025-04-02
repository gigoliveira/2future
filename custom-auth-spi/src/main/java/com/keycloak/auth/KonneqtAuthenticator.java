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

    private static final String KONNEQT_TOKEN_HEADER = "X-Konneqt-Token";
    private static final String REALM_NAME = "test";

    @Override
    public void authenticate(AuthenticationFlowContext context) {
        String token = context.getHttpRequest().getHttpHeaders().getHeaderString(KONNEQT_TOKEN_HEADER);
        
        if (token == null || token.isEmpty()) {
            Response challenge = context.form()
                    .setError("Missing token")
                    .createForm("error.ftl");
            context.failureChallenge(AuthenticationFlowError.INVALID_CREDENTIALS, challenge);
            return;
        }

        // In a real implementation, you would validate the token properly
        String email = token; // Assuming token is the email for this example
        
        RealmModel realm = context.getSession().realms().getRealmByName(REALM_NAME);
        if (realm == null) {
            context.failure(AuthenticationFlowError.INVALID_USER);
            return;
        }

        UserModel user = context.getSession().users().getUserByEmail(realm, email);
        
        if (user == null) {
            // Auto-create user if not exists
            user = context.getSession().users().addUser(realm, UUID.randomUUID().toString());
            user.setEmail(email);
            user.setEnabled(true);
            user.setEmailVerified(true);
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