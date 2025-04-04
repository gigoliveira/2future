--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4 (Debian 17.4-1.pgdg120+2)
-- Dumped by pg_dump version 17.4 (Debian 17.4-1.pgdg120+2)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64),
    details_json text
);


ALTER TABLE public.admin_event_entity OWNER TO "user";

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO "user";

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO "user";

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO "user";

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO "user";

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO "user";

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO "user";

--
-- Name: client; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO "user";

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.client_attributes OWNER TO "user";

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO "user";

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO "user";

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO "user";

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO "user";

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO "user";

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO "user";

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO "user";

--
-- Name: component; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO "user";

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.component_config OWNER TO "user";

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO "user";

--
-- Name: credential; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO "user";

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO "user";

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO "user";

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO "user";

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255),
    details_json_long_value text
);


ALTER TABLE public.event_entity OWNER TO "user";

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024),
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.fed_user_attribute OWNER TO "user";

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO "user";

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO "user";

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO "user";

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO "user";

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO "user";

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO "user";

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO "user";

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO "user";

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO "user";

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO "user";

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL,
    organization_id character varying(255),
    hide_on_login boolean DEFAULT false
);


ALTER TABLE public.identity_provider OWNER TO "user";

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO "user";

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO "user";

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO "user";

--
-- Name: jgroups_ping; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.jgroups_ping (
    address character varying(200) NOT NULL,
    name character varying(200),
    cluster_name character varying(200) NOT NULL,
    ip character varying(200) NOT NULL,
    coord boolean
);


ALTER TABLE public.jgroups_ping OWNER TO "user";

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36),
    type integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.keycloak_group OWNER TO "user";

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO "user";

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO "user";

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL,
    version integer DEFAULT 0
);


ALTER TABLE public.offline_client_session OWNER TO "user";

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL,
    broker_session_id character varying(1024),
    version integer DEFAULT 0
);


ALTER TABLE public.offline_user_session OWNER TO "user";

--
-- Name: org; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.org (
    id character varying(255) NOT NULL,
    enabled boolean NOT NULL,
    realm_id character varying(255) NOT NULL,
    group_id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(4000),
    alias character varying(255) NOT NULL,
    redirect_url character varying(2048)
);


ALTER TABLE public.org OWNER TO "user";

--
-- Name: org_domain; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.org_domain (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    verified boolean NOT NULL,
    org_id character varying(255) NOT NULL
);


ALTER TABLE public.org_domain OWNER TO "user";

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO "user";

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO "user";

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO "user";

--
-- Name: realm; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO "user";

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO "user";

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO "user";

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO "user";

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO "user";

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO "user";

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO "user";

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO "user";

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO "user";

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO "user";

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO "user";

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO "user";

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO "user";

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO "user";

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO "user";

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO "user";

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO "user";

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO "user";

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO "user";

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO "user";

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO "user";

--
-- Name: revoked_token; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.revoked_token (
    id character varying(255) NOT NULL,
    expire bigint NOT NULL
);


ALTER TABLE public.revoked_token OWNER TO "user";

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO "user";

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO "user";

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO "user";

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.user_attribute OWNER TO "user";

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO "user";

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO "user";

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO "user";

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO "user";

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO "user";

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO "user";

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO "user";

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL,
    membership_type character varying(255) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO "user";

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO "user";

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO "user";

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO "user";

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type, details_json) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
72bf65f2-4e8b-42c1-9c87-c6c70762493a	\N	auth-cookie	a4e86523-4f8b-4056-9322-55cde86f8d6b	03b21981-11c6-4730-847a-4f3e124ac80e	2	10	f	\N	\N
e4b67de6-4468-470c-8585-041ec1b73821	\N	auth-spnego	a4e86523-4f8b-4056-9322-55cde86f8d6b	03b21981-11c6-4730-847a-4f3e124ac80e	3	20	f	\N	\N
6c80a2d0-ec7a-4849-a581-4a4dc0f0ccad	\N	identity-provider-redirector	a4e86523-4f8b-4056-9322-55cde86f8d6b	03b21981-11c6-4730-847a-4f3e124ac80e	2	25	f	\N	\N
1f97cd2f-60e2-4b2c-a432-13b43cd23145	\N	\N	a4e86523-4f8b-4056-9322-55cde86f8d6b	03b21981-11c6-4730-847a-4f3e124ac80e	2	30	t	1b8028ad-beff-45a7-9b3e-5c778a3e3c68	\N
ff6dcca9-edea-453b-89c1-ec55bb9dae15	\N	auth-username-password-form	a4e86523-4f8b-4056-9322-55cde86f8d6b	1b8028ad-beff-45a7-9b3e-5c778a3e3c68	0	10	f	\N	\N
90d309a3-ea09-4947-bddf-1bd7ea2974f2	\N	\N	a4e86523-4f8b-4056-9322-55cde86f8d6b	1b8028ad-beff-45a7-9b3e-5c778a3e3c68	1	20	t	0d6b2a6a-e59a-49cd-b5b9-988c1928ef1b	\N
84deb6a5-c6f5-45ba-8f53-f63b0b3ebef6	\N	conditional-user-configured	a4e86523-4f8b-4056-9322-55cde86f8d6b	0d6b2a6a-e59a-49cd-b5b9-988c1928ef1b	0	10	f	\N	\N
c85f7eca-2b3c-4a13-ad24-95e925b603d6	\N	auth-otp-form	a4e86523-4f8b-4056-9322-55cde86f8d6b	0d6b2a6a-e59a-49cd-b5b9-988c1928ef1b	0	20	f	\N	\N
26f4b00b-79fe-48fa-a93e-777165305362	\N	direct-grant-validate-username	a4e86523-4f8b-4056-9322-55cde86f8d6b	6b76fbfc-6ee2-4c53-b7e0-3866fcd92d38	0	10	f	\N	\N
4cb5f042-9282-4de9-a219-023a585abf03	\N	direct-grant-validate-password	a4e86523-4f8b-4056-9322-55cde86f8d6b	6b76fbfc-6ee2-4c53-b7e0-3866fcd92d38	0	20	f	\N	\N
c2118e94-dc2f-4bd3-a38e-664d1441eced	\N	\N	a4e86523-4f8b-4056-9322-55cde86f8d6b	6b76fbfc-6ee2-4c53-b7e0-3866fcd92d38	1	30	t	055c4ca2-cbbf-4984-a7fb-5f50173d5e21	\N
6a74fb80-dce5-49bd-b775-e41c323d3342	\N	conditional-user-configured	a4e86523-4f8b-4056-9322-55cde86f8d6b	055c4ca2-cbbf-4984-a7fb-5f50173d5e21	0	10	f	\N	\N
e274b86e-5048-46ea-bbb0-5aa023971f0c	\N	direct-grant-validate-otp	a4e86523-4f8b-4056-9322-55cde86f8d6b	055c4ca2-cbbf-4984-a7fb-5f50173d5e21	0	20	f	\N	\N
e9dbea24-122c-4a80-b7bf-74938de1c64e	\N	registration-page-form	a4e86523-4f8b-4056-9322-55cde86f8d6b	f09d464a-0196-4f4d-a472-7e860f239802	0	10	t	08f9256a-551f-4a5e-8a45-dc9bc7a2a167	\N
22020c72-de85-4aca-976f-a6e59fc5aef5	\N	registration-user-creation	a4e86523-4f8b-4056-9322-55cde86f8d6b	08f9256a-551f-4a5e-8a45-dc9bc7a2a167	0	20	f	\N	\N
c38959ed-9ff1-4b15-9d3e-1c8aa7526d38	\N	registration-password-action	a4e86523-4f8b-4056-9322-55cde86f8d6b	08f9256a-551f-4a5e-8a45-dc9bc7a2a167	0	50	f	\N	\N
80413ee6-2588-4376-97cb-bbf730ec5e31	\N	registration-recaptcha-action	a4e86523-4f8b-4056-9322-55cde86f8d6b	08f9256a-551f-4a5e-8a45-dc9bc7a2a167	3	60	f	\N	\N
7bdbee89-6125-4713-b66e-870b3434b8fa	\N	registration-terms-and-conditions	a4e86523-4f8b-4056-9322-55cde86f8d6b	08f9256a-551f-4a5e-8a45-dc9bc7a2a167	3	70	f	\N	\N
9fb654ed-74b6-4247-9941-67743cbc523e	\N	reset-credentials-choose-user	a4e86523-4f8b-4056-9322-55cde86f8d6b	343a2350-0675-4f91-b2db-b15b7fefe948	0	10	f	\N	\N
e18ded5b-d168-4979-b3f7-1ec50aac67f7	\N	reset-credential-email	a4e86523-4f8b-4056-9322-55cde86f8d6b	343a2350-0675-4f91-b2db-b15b7fefe948	0	20	f	\N	\N
b009bc25-a160-425c-a8e0-afaf534c8c61	\N	reset-password	a4e86523-4f8b-4056-9322-55cde86f8d6b	343a2350-0675-4f91-b2db-b15b7fefe948	0	30	f	\N	\N
fd618b15-14b7-4a5f-a507-f88a490b39f6	\N	\N	a4e86523-4f8b-4056-9322-55cde86f8d6b	343a2350-0675-4f91-b2db-b15b7fefe948	1	40	t	a8c3b064-6247-4084-b03f-f52fe836a8fc	\N
36cd3b5d-6a15-4c1d-b5bb-2f462bed8419	\N	conditional-user-configured	a4e86523-4f8b-4056-9322-55cde86f8d6b	a8c3b064-6247-4084-b03f-f52fe836a8fc	0	10	f	\N	\N
368d368b-67a9-4284-8f0d-dfff1e1e7ed6	\N	reset-otp	a4e86523-4f8b-4056-9322-55cde86f8d6b	a8c3b064-6247-4084-b03f-f52fe836a8fc	0	20	f	\N	\N
2684881c-e0d8-4adf-9a5b-c6bd9bcc55ea	\N	client-secret	a4e86523-4f8b-4056-9322-55cde86f8d6b	14b049d8-0e4f-4078-a798-f8ab0fa49490	2	10	f	\N	\N
677cd396-e55e-4a6d-b08a-5ece6b56bc1c	\N	client-jwt	a4e86523-4f8b-4056-9322-55cde86f8d6b	14b049d8-0e4f-4078-a798-f8ab0fa49490	2	20	f	\N	\N
7e9e1cba-c79b-4571-8035-26a18dfbb5f6	\N	client-secret-jwt	a4e86523-4f8b-4056-9322-55cde86f8d6b	14b049d8-0e4f-4078-a798-f8ab0fa49490	2	30	f	\N	\N
f7db588c-5cf1-4847-abb2-9d9a5a71641d	\N	client-x509	a4e86523-4f8b-4056-9322-55cde86f8d6b	14b049d8-0e4f-4078-a798-f8ab0fa49490	2	40	f	\N	\N
2065aa63-45d9-492b-9183-ac0bbc489206	\N	idp-review-profile	a4e86523-4f8b-4056-9322-55cde86f8d6b	9c85948d-2150-4a1e-a2bf-6d60f043616a	0	10	f	\N	cc54176b-366f-4295-9dd8-8c81bea4c267
d5244be9-d4c7-4e93-8af4-245f338fc9ec	\N	\N	a4e86523-4f8b-4056-9322-55cde86f8d6b	9c85948d-2150-4a1e-a2bf-6d60f043616a	0	20	t	ad445196-adf0-4900-a539-9c65ca305502	\N
88644909-122e-48aa-9381-395ef97cde2c	\N	idp-create-user-if-unique	a4e86523-4f8b-4056-9322-55cde86f8d6b	ad445196-adf0-4900-a539-9c65ca305502	2	10	f	\N	bfd5eb73-8c39-4291-870e-935d707f43b5
06597a94-3ccb-423f-b216-061358125caf	\N	\N	a4e86523-4f8b-4056-9322-55cde86f8d6b	ad445196-adf0-4900-a539-9c65ca305502	2	20	t	1a613bae-bfde-4242-8f2a-5b284d2478dc	\N
20127d95-557d-400c-b802-0c15566a2023	\N	idp-confirm-link	a4e86523-4f8b-4056-9322-55cde86f8d6b	1a613bae-bfde-4242-8f2a-5b284d2478dc	0	10	f	\N	\N
bc932e77-6752-4252-890d-e9b70ff5d3bb	\N	\N	a4e86523-4f8b-4056-9322-55cde86f8d6b	1a613bae-bfde-4242-8f2a-5b284d2478dc	0	20	t	eaf9817c-f8fe-4a96-a189-afd0edf25d13	\N
26c602f0-481c-4d40-be10-943794b662d0	\N	idp-email-verification	a4e86523-4f8b-4056-9322-55cde86f8d6b	eaf9817c-f8fe-4a96-a189-afd0edf25d13	2	10	f	\N	\N
2fb5ab37-1ffc-4fcf-a629-63641d4ea879	\N	\N	a4e86523-4f8b-4056-9322-55cde86f8d6b	eaf9817c-f8fe-4a96-a189-afd0edf25d13	2	20	t	11158b30-edf2-4abe-9ac6-71d587f210c5	\N
6edd9e42-2e50-43da-b3f9-c25953e8e871	\N	idp-username-password-form	a4e86523-4f8b-4056-9322-55cde86f8d6b	11158b30-edf2-4abe-9ac6-71d587f210c5	0	10	f	\N	\N
5c83029d-38e6-440a-bf09-c785126f522a	\N	\N	a4e86523-4f8b-4056-9322-55cde86f8d6b	11158b30-edf2-4abe-9ac6-71d587f210c5	1	20	t	905ccf2d-8d69-418e-a9f9-6b6d6b341018	\N
3fb0a3d9-08c2-4149-a204-0752897a8f4e	\N	conditional-user-configured	a4e86523-4f8b-4056-9322-55cde86f8d6b	905ccf2d-8d69-418e-a9f9-6b6d6b341018	0	10	f	\N	\N
63661189-3f78-479a-b0c5-1ab9953f3745	\N	auth-otp-form	a4e86523-4f8b-4056-9322-55cde86f8d6b	905ccf2d-8d69-418e-a9f9-6b6d6b341018	0	20	f	\N	\N
cc38b460-fff0-47c3-a9f6-4906f25e2798	\N	http-basic-authenticator	a4e86523-4f8b-4056-9322-55cde86f8d6b	10e26f9b-cbe5-4029-a087-6fb90d20a961	0	10	f	\N	\N
7216398e-34de-40f7-bba3-43261f467a39	\N	docker-http-basic-authenticator	a4e86523-4f8b-4056-9322-55cde86f8d6b	999fc94d-4669-4023-992c-ad06f0510cde	0	10	f	\N	\N
394a4a66-e86f-418f-8b0a-301a2cdb38e4	\N	auth-cookie	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	76de9e12-a2d1-4a97-8442-366f639c5b30	2	10	f	\N	\N
debe4c30-5bbf-45f9-9b44-b513e9f9703e	\N	auth-spnego	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	76de9e12-a2d1-4a97-8442-366f639c5b30	3	20	f	\N	\N
2d6efc8f-e32b-4fc6-80de-b0379c102802	\N	identity-provider-redirector	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	76de9e12-a2d1-4a97-8442-366f639c5b30	2	25	f	\N	\N
76fce286-237e-48ce-bf78-b14ecae3b26b	\N	\N	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	76de9e12-a2d1-4a97-8442-366f639c5b30	2	30	t	af63e06c-bb0f-4293-a335-7fa5ede3cfe4	\N
615ddd9d-0b1c-4f97-a20a-14c7970e3ae7	\N	auth-username-password-form	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	af63e06c-bb0f-4293-a335-7fa5ede3cfe4	0	10	f	\N	\N
609d7796-0599-4c53-8595-53c525041f04	\N	\N	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	af63e06c-bb0f-4293-a335-7fa5ede3cfe4	1	20	t	dfde97c2-9aa6-4af0-9edc-e73d64553f2c	\N
773a3acc-7e4c-4efc-ad31-88b1dd6114c2	\N	conditional-user-configured	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	dfde97c2-9aa6-4af0-9edc-e73d64553f2c	0	10	f	\N	\N
5b979725-11d5-46af-9df7-71ab036089c7	\N	auth-otp-form	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	dfde97c2-9aa6-4af0-9edc-e73d64553f2c	0	20	f	\N	\N
3770d5b8-a61d-48be-b566-8c07d15ac685	\N	\N	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	76de9e12-a2d1-4a97-8442-366f639c5b30	2	26	t	3a4e3f65-bf26-47fa-abe9-2db70a2fd37f	\N
3fd96d94-7f12-4f88-9b55-e9cf7b3a5abc	\N	\N	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	3a4e3f65-bf26-47fa-abe9-2db70a2fd37f	1	10	t	ccc8120b-9e41-4376-8912-1861501186c1	\N
35987097-b6f7-4f02-94d5-163eb143d921	\N	conditional-user-configured	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	ccc8120b-9e41-4376-8912-1861501186c1	0	10	f	\N	\N
9deea2aa-0893-4c8d-bd21-74cc4e4afd14	\N	organization	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	ccc8120b-9e41-4376-8912-1861501186c1	2	20	f	\N	\N
b5a96f02-a7ce-417d-9765-b91fd09db649	\N	direct-grant-validate-username	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	9480b681-84b6-4ce4-a146-c9ed13c90cf8	0	10	f	\N	\N
de4084ae-dc39-425e-8b90-6137c1ad4be3	\N	direct-grant-validate-password	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	9480b681-84b6-4ce4-a146-c9ed13c90cf8	0	20	f	\N	\N
2a4ee516-dab1-4da3-be48-ad531ad7488c	\N	\N	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	9480b681-84b6-4ce4-a146-c9ed13c90cf8	1	30	t	808a0233-d548-49da-8c9b-f84288e21883	\N
d0153018-edfd-4e9a-84d7-462e7f577da2	\N	conditional-user-configured	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	808a0233-d548-49da-8c9b-f84288e21883	0	10	f	\N	\N
87b1f8d5-533c-4ac4-951d-6cdf505b82d4	\N	direct-grant-validate-otp	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	808a0233-d548-49da-8c9b-f84288e21883	0	20	f	\N	\N
381b51ca-bb90-42e2-9b91-e2f6fe831179	\N	registration-page-form	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	d6547f22-bf7f-4f96-8cf9-4043d2b27714	0	10	t	f1fac98b-b1e4-4c1f-8c0d-09a7154203f7	\N
3efaed45-b586-4014-9ec1-3f80d0ee744c	\N	registration-user-creation	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	f1fac98b-b1e4-4c1f-8c0d-09a7154203f7	0	20	f	\N	\N
a823e5fc-e5f2-403e-b207-fd69173803c0	\N	registration-password-action	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	f1fac98b-b1e4-4c1f-8c0d-09a7154203f7	0	50	f	\N	\N
996265be-eabb-40e8-abaa-f3cf38e40f35	\N	registration-recaptcha-action	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	f1fac98b-b1e4-4c1f-8c0d-09a7154203f7	3	60	f	\N	\N
a88ca3d1-6103-4bc5-be76-90d2e6ee68f5	\N	registration-terms-and-conditions	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	f1fac98b-b1e4-4c1f-8c0d-09a7154203f7	3	70	f	\N	\N
b2a6d6d1-0fbc-4bbf-b352-ede062c8a708	\N	reset-credentials-choose-user	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	a27f3838-a86b-4dce-93a8-b0c81f5048e7	0	10	f	\N	\N
26f06cbe-2a9a-430f-8508-843180228762	\N	reset-credential-email	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	a27f3838-a86b-4dce-93a8-b0c81f5048e7	0	20	f	\N	\N
1cf95efc-13eb-4b2d-b5ee-ca0cef3e2975	\N	reset-password	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	a27f3838-a86b-4dce-93a8-b0c81f5048e7	0	30	f	\N	\N
890a6bd6-9beb-44f7-96e2-ec8dc8e81445	\N	\N	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	a27f3838-a86b-4dce-93a8-b0c81f5048e7	1	40	t	c6b00943-a2f6-4fc1-87fd-5be3fb7d47ad	\N
c556f88d-165f-4600-9677-18664670bfff	\N	conditional-user-configured	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	c6b00943-a2f6-4fc1-87fd-5be3fb7d47ad	0	10	f	\N	\N
256c0fd9-8d02-484a-88e7-6237466d03b9	\N	reset-otp	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	c6b00943-a2f6-4fc1-87fd-5be3fb7d47ad	0	20	f	\N	\N
ea2c32e8-03e4-4679-9481-a2b44eb8d01e	\N	client-secret	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	1c15dbb6-83a5-40a1-83dc-255a3a5de2a5	2	10	f	\N	\N
a8d009f6-73f3-4bab-8b35-7673d9e4a4aa	\N	client-jwt	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	1c15dbb6-83a5-40a1-83dc-255a3a5de2a5	2	20	f	\N	\N
7ad2efd2-cc91-4669-a2c2-ac9fd6120ccf	\N	client-secret-jwt	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	1c15dbb6-83a5-40a1-83dc-255a3a5de2a5	2	30	f	\N	\N
91c015cb-02ac-423c-9387-a851ce7324d8	\N	client-x509	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	1c15dbb6-83a5-40a1-83dc-255a3a5de2a5	2	40	f	\N	\N
1603f3eb-1c62-4fa1-92aa-a7831ef7318f	\N	idp-review-profile	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	cf0e846c-9965-4e68-a926-90da89ceffea	0	10	f	\N	2aa59aa9-7883-4e83-acca-c900249b8c93
4198024c-7212-42d1-8541-c925efa229d3	\N	\N	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	cf0e846c-9965-4e68-a926-90da89ceffea	0	20	t	d690046b-3f46-43cb-b975-f4870bb5a939	\N
d285e2d7-cde3-438f-8e2d-ad01e1216f0c	\N	idp-create-user-if-unique	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	d690046b-3f46-43cb-b975-f4870bb5a939	2	10	f	\N	c5412a54-055c-4f02-8bb0-ec6f69afb652
a6915695-dede-4795-a1a3-9efdaa0edab0	\N	\N	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	d690046b-3f46-43cb-b975-f4870bb5a939	2	20	t	e58b7c50-1898-408a-af66-0e3c3165d333	\N
cb2e9a9b-b6ad-4b09-9a63-92fdb079137a	\N	idp-confirm-link	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	e58b7c50-1898-408a-af66-0e3c3165d333	0	10	f	\N	\N
3592551b-66fc-416a-82d4-2c9fcee14b1e	\N	\N	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	e58b7c50-1898-408a-af66-0e3c3165d333	0	20	t	eaaaec5c-e542-46f2-932a-1d2ab28be1da	\N
d33a199c-9aa2-49e4-a91d-5df64426c763	\N	idp-email-verification	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	eaaaec5c-e542-46f2-932a-1d2ab28be1da	2	10	f	\N	\N
6fa4fc2f-5e60-417d-9b2b-ec765cff4682	\N	\N	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	eaaaec5c-e542-46f2-932a-1d2ab28be1da	2	20	t	197bde08-0c71-403c-956f-ab25bcab07b4	\N
a847fa1c-b85c-4bff-80da-0fd3f88bb367	\N	idp-username-password-form	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	197bde08-0c71-403c-956f-ab25bcab07b4	0	10	f	\N	\N
767c7e6d-09eb-410a-8c9b-8a591b2db96b	\N	\N	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	197bde08-0c71-403c-956f-ab25bcab07b4	1	20	t	29e87a84-79a5-4f11-bf77-f599883907a8	\N
714c0fdb-7ade-415a-9f37-d1ce57977380	\N	conditional-user-configured	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	29e87a84-79a5-4f11-bf77-f599883907a8	0	10	f	\N	\N
486aabd0-bd40-48be-995e-0dbf9612ff7a	\N	auth-otp-form	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	29e87a84-79a5-4f11-bf77-f599883907a8	0	20	f	\N	\N
63c86692-f831-48d2-a09e-86e151ec3edc	\N	\N	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	cf0e846c-9965-4e68-a926-90da89ceffea	1	50	t	b42c1a8c-40ce-4fea-aa6e-e19d8d304ef7	\N
7de6225c-fd05-4d9d-a78c-0110e7b3eeae	\N	conditional-user-configured	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	b42c1a8c-40ce-4fea-aa6e-e19d8d304ef7	0	10	f	\N	\N
16dbb71c-b5cc-4955-bba6-2a5f770ce9cc	\N	idp-add-organization-member	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	b42c1a8c-40ce-4fea-aa6e-e19d8d304ef7	0	20	f	\N	\N
e2e2efc8-b775-40fb-8832-f9b1bce23f41	\N	http-basic-authenticator	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	d7885434-bb7c-41e7-a7fe-a3835b6cb0ea	0	10	f	\N	\N
0129247c-534a-44b5-b007-151050843b4f	\N	docker-http-basic-authenticator	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	6b72a724-8d38-4482-af96-a2cfdcd320a7	0	10	f	\N	\N
c9fd4cb4-983a-4e19-b450-33d1d4a113ef	\N	konneqt-token-authenticator	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	53c54f42-5025-40ca-85a5-f003a68151c2	0	0	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
03b21981-11c6-4730-847a-4f3e124ac80e	browser	Browser based authentication	a4e86523-4f8b-4056-9322-55cde86f8d6b	basic-flow	t	t
1b8028ad-beff-45a7-9b3e-5c778a3e3c68	forms	Username, password, otp and other auth forms.	a4e86523-4f8b-4056-9322-55cde86f8d6b	basic-flow	f	t
0d6b2a6a-e59a-49cd-b5b9-988c1928ef1b	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	a4e86523-4f8b-4056-9322-55cde86f8d6b	basic-flow	f	t
6b76fbfc-6ee2-4c53-b7e0-3866fcd92d38	direct grant	OpenID Connect Resource Owner Grant	a4e86523-4f8b-4056-9322-55cde86f8d6b	basic-flow	t	t
055c4ca2-cbbf-4984-a7fb-5f50173d5e21	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	a4e86523-4f8b-4056-9322-55cde86f8d6b	basic-flow	f	t
f09d464a-0196-4f4d-a472-7e860f239802	registration	Registration flow	a4e86523-4f8b-4056-9322-55cde86f8d6b	basic-flow	t	t
08f9256a-551f-4a5e-8a45-dc9bc7a2a167	registration form	Registration form	a4e86523-4f8b-4056-9322-55cde86f8d6b	form-flow	f	t
343a2350-0675-4f91-b2db-b15b7fefe948	reset credentials	Reset credentials for a user if they forgot their password or something	a4e86523-4f8b-4056-9322-55cde86f8d6b	basic-flow	t	t
a8c3b064-6247-4084-b03f-f52fe836a8fc	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	a4e86523-4f8b-4056-9322-55cde86f8d6b	basic-flow	f	t
14b049d8-0e4f-4078-a798-f8ab0fa49490	clients	Base authentication for clients	a4e86523-4f8b-4056-9322-55cde86f8d6b	client-flow	t	t
9c85948d-2150-4a1e-a2bf-6d60f043616a	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	a4e86523-4f8b-4056-9322-55cde86f8d6b	basic-flow	t	t
ad445196-adf0-4900-a539-9c65ca305502	User creation or linking	Flow for the existing/non-existing user alternatives	a4e86523-4f8b-4056-9322-55cde86f8d6b	basic-flow	f	t
1a613bae-bfde-4242-8f2a-5b284d2478dc	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	a4e86523-4f8b-4056-9322-55cde86f8d6b	basic-flow	f	t
eaf9817c-f8fe-4a96-a189-afd0edf25d13	Account verification options	Method with which to verity the existing account	a4e86523-4f8b-4056-9322-55cde86f8d6b	basic-flow	f	t
11158b30-edf2-4abe-9ac6-71d587f210c5	Verify Existing Account by Re-authentication	Reauthentication of existing account	a4e86523-4f8b-4056-9322-55cde86f8d6b	basic-flow	f	t
905ccf2d-8d69-418e-a9f9-6b6d6b341018	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	a4e86523-4f8b-4056-9322-55cde86f8d6b	basic-flow	f	t
10e26f9b-cbe5-4029-a087-6fb90d20a961	saml ecp	SAML ECP Profile Authentication Flow	a4e86523-4f8b-4056-9322-55cde86f8d6b	basic-flow	t	t
999fc94d-4669-4023-992c-ad06f0510cde	docker auth	Used by Docker clients to authenticate against the IDP	a4e86523-4f8b-4056-9322-55cde86f8d6b	basic-flow	t	t
76de9e12-a2d1-4a97-8442-366f639c5b30	browser	Browser based authentication	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	basic-flow	t	t
af63e06c-bb0f-4293-a335-7fa5ede3cfe4	forms	Username, password, otp and other auth forms.	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	basic-flow	f	t
dfde97c2-9aa6-4af0-9edc-e73d64553f2c	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	basic-flow	f	t
3a4e3f65-bf26-47fa-abe9-2db70a2fd37f	Organization	\N	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	basic-flow	f	t
ccc8120b-9e41-4376-8912-1861501186c1	Browser - Conditional Organization	Flow to determine if the organization identity-first login is to be used	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	basic-flow	f	t
9480b681-84b6-4ce4-a146-c9ed13c90cf8	direct grant	OpenID Connect Resource Owner Grant	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	basic-flow	t	t
808a0233-d548-49da-8c9b-f84288e21883	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	basic-flow	f	t
d6547f22-bf7f-4f96-8cf9-4043d2b27714	registration	Registration flow	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	basic-flow	t	t
f1fac98b-b1e4-4c1f-8c0d-09a7154203f7	registration form	Registration form	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	form-flow	f	t
a27f3838-a86b-4dce-93a8-b0c81f5048e7	reset credentials	Reset credentials for a user if they forgot their password or something	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	basic-flow	t	t
c6b00943-a2f6-4fc1-87fd-5be3fb7d47ad	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	basic-flow	f	t
1c15dbb6-83a5-40a1-83dc-255a3a5de2a5	clients	Base authentication for clients	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	client-flow	t	t
cf0e846c-9965-4e68-a926-90da89ceffea	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	basic-flow	t	t
d690046b-3f46-43cb-b975-f4870bb5a939	User creation or linking	Flow for the existing/non-existing user alternatives	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	basic-flow	f	t
e58b7c50-1898-408a-af66-0e3c3165d333	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	basic-flow	f	t
eaaaec5c-e542-46f2-932a-1d2ab28be1da	Account verification options	Method with which to verity the existing account	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	basic-flow	f	t
197bde08-0c71-403c-956f-ab25bcab07b4	Verify Existing Account by Re-authentication	Reauthentication of existing account	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	basic-flow	f	t
29e87a84-79a5-4f11-bf77-f599883907a8	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	basic-flow	f	t
b42c1a8c-40ce-4fea-aa6e-e19d8d304ef7	First Broker Login - Conditional Organization	Flow to determine if the authenticator that adds organization members is to be used	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	basic-flow	f	t
d7885434-bb7c-41e7-a7fe-a3835b6cb0ea	saml ecp	SAML ECP Profile Authentication Flow	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	basic-flow	t	t
6b72a724-8d38-4482-af96-a2cfdcd320a7	docker auth	Used by Docker clients to authenticate against the IDP	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	basic-flow	t	t
53c54f42-5025-40ca-85a5-f003a68151c2	Konneqt Browser Flow	Browser based authentication	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	basic-flow	t	f
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
cc54176b-366f-4295-9dd8-8c81bea4c267	review profile config	a4e86523-4f8b-4056-9322-55cde86f8d6b
bfd5eb73-8c39-4291-870e-935d707f43b5	create unique user config	a4e86523-4f8b-4056-9322-55cde86f8d6b
2aa59aa9-7883-4e83-acca-c900249b8c93	review profile config	5f0779df-8cd1-4b52-a60e-1e1a4d45427b
c5412a54-055c-4f02-8bb0-ec6f69afb652	create unique user config	5f0779df-8cd1-4b52-a60e-1e1a4d45427b
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
bfd5eb73-8c39-4291-870e-935d707f43b5	false	require.password.update.after.registration
cc54176b-366f-4295-9dd8-8c81bea4c267	missing	update.profile.on.first.login
2aa59aa9-7883-4e83-acca-c900249b8c93	missing	update.profile.on.first.login
c5412a54-055c-4f02-8bb0-ec6f69afb652	false	require.password.update.after.registration
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	t	f	master-realm	0	f	\N	\N	t	\N	f	a4e86523-4f8b-4056-9322-55cde86f8d6b	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
54d8b736-b0fe-4bc6-8be3-6f6cc4d919d4	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	a4e86523-4f8b-4056-9322-55cde86f8d6b	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
4daf458a-6353-4178-8200-93f1810528ce	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	a4e86523-4f8b-4056-9322-55cde86f8d6b	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
51cd7f1a-e974-4a27-8a37-da3bf530de67	t	f	broker	0	f	\N	\N	t	\N	f	a4e86523-4f8b-4056-9322-55cde86f8d6b	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
ee5b168a-aa3e-45a0-8234-372b64c37985	t	t	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	a4e86523-4f8b-4056-9322-55cde86f8d6b	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
86ed8184-0bda-4316-a4bb-affbbaa4e7fe	t	t	admin-cli	0	t	\N	\N	f	\N	f	a4e86523-4f8b-4056-9322-55cde86f8d6b	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
51f791d3-4755-4ea2-95d7-7e542678ef8b	t	f	test-realm	0	f	\N	\N	t	\N	f	a4e86523-4f8b-4056-9322-55cde86f8d6b	\N	0	f	f	test Realm	f	client-secret	\N	\N	\N	t	f	f	f
048bcd9d-39be-4012-abbb-ce0059d5c0e9	t	f	realm-management	0	f	\N	\N	t	\N	f	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
9e9ca8d3-de61-4566-91b1-0be5ae703db7	t	f	account	0	t	\N	/realms/test/account/	f	\N	f	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
3df67013-7d9d-4b13-816f-289b30cea5e4	t	f	account-console	0	t	\N	/realms/test/account/	f	\N	f	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
560b33d3-0bfc-4b3d-9013-214383cbee87	t	f	broker	0	f	\N	\N	t	\N	f	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
c4c5adc2-82c6-40cd-bbce-4357646cb30b	t	t	security-admin-console	0	t	\N	/admin/test/console/	f	\N	f	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
0f0c4c43-df13-4c36-be6c-17a26578c5d0	t	t	admin-cli	0	t	\N	\N	f	\N	f	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
3b16b7ba-488a-4efc-9713-c1d6a43e7abf	t	t	konneqt-client	0	t	\N		f		f	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	openid-connect	-1	t	f		f	client-secret	http://localhost:5173		\N	t	t	t	f
24ec7eab-9e90-4a7a-b133-5ab5f2945566	t	t	spring-api	0	f	XKFih88GMr5ht4b00oAu7zVTvpPNtfYj		f		f	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	openid-connect	-1	t	f		t	client-secret			\N	t	f	f	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
54d8b736-b0fe-4bc6-8be3-6f6cc4d919d4	post.logout.redirect.uris	+
4daf458a-6353-4178-8200-93f1810528ce	post.logout.redirect.uris	+
4daf458a-6353-4178-8200-93f1810528ce	pkce.code.challenge.method	S256
ee5b168a-aa3e-45a0-8234-372b64c37985	post.logout.redirect.uris	+
ee5b168a-aa3e-45a0-8234-372b64c37985	pkce.code.challenge.method	S256
ee5b168a-aa3e-45a0-8234-372b64c37985	client.use.lightweight.access.token.enabled	true
86ed8184-0bda-4316-a4bb-affbbaa4e7fe	client.use.lightweight.access.token.enabled	true
9e9ca8d3-de61-4566-91b1-0be5ae703db7	post.logout.redirect.uris	+
3df67013-7d9d-4b13-816f-289b30cea5e4	post.logout.redirect.uris	+
3df67013-7d9d-4b13-816f-289b30cea5e4	pkce.code.challenge.method	S256
c4c5adc2-82c6-40cd-bbce-4357646cb30b	post.logout.redirect.uris	+
c4c5adc2-82c6-40cd-bbce-4357646cb30b	pkce.code.challenge.method	S256
c4c5adc2-82c6-40cd-bbce-4357646cb30b	client.use.lightweight.access.token.enabled	true
0f0c4c43-df13-4c36-be6c-17a26578c5d0	client.use.lightweight.access.token.enabled	true
3b16b7ba-488a-4efc-9713-c1d6a43e7abf	oidc.ciba.grant.enabled	false
3b16b7ba-488a-4efc-9713-c1d6a43e7abf	backchannel.logout.session.required	true
3b16b7ba-488a-4efc-9713-c1d6a43e7abf	backchannel.logout.revoke.offline.tokens	false
3b16b7ba-488a-4efc-9713-c1d6a43e7abf	realm_client	false
3b16b7ba-488a-4efc-9713-c1d6a43e7abf	display.on.consent.screen	false
3b16b7ba-488a-4efc-9713-c1d6a43e7abf	frontchannel.logout.session.required	true
3b16b7ba-488a-4efc-9713-c1d6a43e7abf	request.object.signature.alg	any
3b16b7ba-488a-4efc-9713-c1d6a43e7abf	request.object.encryption.alg	any
3b16b7ba-488a-4efc-9713-c1d6a43e7abf	request.object.encryption.enc	any
3b16b7ba-488a-4efc-9713-c1d6a43e7abf	request.object.required	not required
3b16b7ba-488a-4efc-9713-c1d6a43e7abf	use.refresh.tokens	true
3b16b7ba-488a-4efc-9713-c1d6a43e7abf	client_credentials.use_refresh_token	false
3b16b7ba-488a-4efc-9713-c1d6a43e7abf	token.response.type.bearer.lower-case	false
3b16b7ba-488a-4efc-9713-c1d6a43e7abf	tls.client.certificate.bound.access.tokens	false
3b16b7ba-488a-4efc-9713-c1d6a43e7abf	require.pushed.authorization.requests	false
3b16b7ba-488a-4efc-9713-c1d6a43e7abf	client.use.lightweight.access.token.enabled	false
3b16b7ba-488a-4efc-9713-c1d6a43e7abf	client.introspection.response.allow.jwt.claim.enabled	false
3b16b7ba-488a-4efc-9713-c1d6a43e7abf	acr.loa.map	{}
3b16b7ba-488a-4efc-9713-c1d6a43e7abf	oauth2.device.authorization.grant.enabled	true
3b16b7ba-488a-4efc-9713-c1d6a43e7abf	post.logout.redirect.uris	http://localhost:5173/*
3b16b7ba-488a-4efc-9713-c1d6a43e7abf	client.secret.creation.time	1743621442
24ec7eab-9e90-4a7a-b133-5ab5f2945566	oauth2.device.authorization.grant.enabled	false
24ec7eab-9e90-4a7a-b133-5ab5f2945566	oidc.ciba.grant.enabled	false
24ec7eab-9e90-4a7a-b133-5ab5f2945566	backchannel.logout.session.required	true
24ec7eab-9e90-4a7a-b133-5ab5f2945566	backchannel.logout.revoke.offline.tokens	false
24ec7eab-9e90-4a7a-b133-5ab5f2945566	client.secret.creation.time	1743652901
24ec7eab-9e90-4a7a-b133-5ab5f2945566	realm_client	false
24ec7eab-9e90-4a7a-b133-5ab5f2945566	display.on.consent.screen	false
24ec7eab-9e90-4a7a-b133-5ab5f2945566	frontchannel.logout.session.required	true
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
3b16b7ba-488a-4efc-9713-c1d6a43e7abf	53c54f42-5025-40ca-85a5-f003a68151c2	browser
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
6b23c029-f918-4656-be8b-ca4eb7cf78a6	offline_access	a4e86523-4f8b-4056-9322-55cde86f8d6b	OpenID Connect built-in scope: offline_access	openid-connect
1c6df122-142d-404e-851e-563f6bb90b31	role_list	a4e86523-4f8b-4056-9322-55cde86f8d6b	SAML role list	saml
07619025-5b64-42ba-bb52-3f89d0993c4b	saml_organization	a4e86523-4f8b-4056-9322-55cde86f8d6b	Organization Membership	saml
9a02c129-f7ab-418b-b873-72b88021d9ae	profile	a4e86523-4f8b-4056-9322-55cde86f8d6b	OpenID Connect built-in scope: profile	openid-connect
5b82719d-857b-4830-adec-6e21218548a3	email	a4e86523-4f8b-4056-9322-55cde86f8d6b	OpenID Connect built-in scope: email	openid-connect
5b6919ad-213c-4524-9de7-d29f6eb87f9e	address	a4e86523-4f8b-4056-9322-55cde86f8d6b	OpenID Connect built-in scope: address	openid-connect
8d3e9730-2a95-496c-a501-86c192aa522e	phone	a4e86523-4f8b-4056-9322-55cde86f8d6b	OpenID Connect built-in scope: phone	openid-connect
6bd4b9cf-2f58-4a31-b376-23fc21507732	roles	a4e86523-4f8b-4056-9322-55cde86f8d6b	OpenID Connect scope for add user roles to the access token	openid-connect
93046ecc-b470-4c00-8c97-a5abe1263d31	web-origins	a4e86523-4f8b-4056-9322-55cde86f8d6b	OpenID Connect scope for add allowed web origins to the access token	openid-connect
28dbe4b5-572e-4486-8984-afc9d301430f	microprofile-jwt	a4e86523-4f8b-4056-9322-55cde86f8d6b	Microprofile - JWT built-in scope	openid-connect
0b028e24-09ef-4f0e-aeda-e80a08091f5f	acr	a4e86523-4f8b-4056-9322-55cde86f8d6b	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
b7fc21ae-98c7-4606-a55f-41faff40d165	basic	a4e86523-4f8b-4056-9322-55cde86f8d6b	OpenID Connect scope for add all basic claims to the token	openid-connect
587d2738-ff4d-4792-aa6d-e4f80825dc00	service_account	a4e86523-4f8b-4056-9322-55cde86f8d6b	Specific scope for a client enabled for service accounts	openid-connect
182072e9-0cbe-4345-968f-281623eed31e	organization	a4e86523-4f8b-4056-9322-55cde86f8d6b	Additional claims about the organization a subject belongs to	openid-connect
1a3e9a03-8d09-4890-8324-5b150ec173c4	offline_access	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	OpenID Connect built-in scope: offline_access	openid-connect
5d8f27f2-0f54-4c57-bf5f-1f9783b09966	role_list	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	SAML role list	saml
1d9019e7-0de0-41f1-adb6-97cf8aad4881	saml_organization	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	Organization Membership	saml
80bad889-41be-4686-91bf-0ac60c774b7d	profile	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	OpenID Connect built-in scope: profile	openid-connect
b4c4e925-3b8a-4258-8526-9b6532f8a99a	email	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	OpenID Connect built-in scope: email	openid-connect
cf859df3-7cdb-4485-9c51-56419ed63518	address	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	OpenID Connect built-in scope: address	openid-connect
481eb095-1f32-48bb-9271-c603ff8d8a3c	phone	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	OpenID Connect built-in scope: phone	openid-connect
b9d2f0f1-cb2b-4c3a-aa13-4d910b4a2f97	roles	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	OpenID Connect scope for add user roles to the access token	openid-connect
22f13a4e-cfbd-4cb5-bbd0-cdcb603032bd	web-origins	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	OpenID Connect scope for add allowed web origins to the access token	openid-connect
6f298998-0954-405c-9408-153ffd0e3ae6	microprofile-jwt	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	Microprofile - JWT built-in scope	openid-connect
956d0e9e-4da0-4244-8a24-8128ca49c3c3	acr	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
cae62eb5-8113-42af-bd43-5a489f49e1bd	basic	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	OpenID Connect scope for add all basic claims to the token	openid-connect
c633ceca-7899-4d26-8a62-62190efafd9a	service_account	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	Specific scope for a client enabled for service accounts	openid-connect
fbe9c5cc-0240-453a-b849-a9e9c5145b26	organization	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	Additional claims about the organization a subject belongs to	openid-connect
76e1958d-1ada-4243-8f35-dd5ebb8abd62	konneqt-client-scope	5f0779df-8cd1-4b52-a60e-1e1a4d45427b		openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
6b23c029-f918-4656-be8b-ca4eb7cf78a6	true	display.on.consent.screen
6b23c029-f918-4656-be8b-ca4eb7cf78a6	${offlineAccessScopeConsentText}	consent.screen.text
1c6df122-142d-404e-851e-563f6bb90b31	true	display.on.consent.screen
1c6df122-142d-404e-851e-563f6bb90b31	${samlRoleListScopeConsentText}	consent.screen.text
07619025-5b64-42ba-bb52-3f89d0993c4b	false	display.on.consent.screen
9a02c129-f7ab-418b-b873-72b88021d9ae	true	display.on.consent.screen
9a02c129-f7ab-418b-b873-72b88021d9ae	${profileScopeConsentText}	consent.screen.text
9a02c129-f7ab-418b-b873-72b88021d9ae	true	include.in.token.scope
5b82719d-857b-4830-adec-6e21218548a3	true	display.on.consent.screen
5b82719d-857b-4830-adec-6e21218548a3	${emailScopeConsentText}	consent.screen.text
5b82719d-857b-4830-adec-6e21218548a3	true	include.in.token.scope
5b6919ad-213c-4524-9de7-d29f6eb87f9e	true	display.on.consent.screen
5b6919ad-213c-4524-9de7-d29f6eb87f9e	${addressScopeConsentText}	consent.screen.text
5b6919ad-213c-4524-9de7-d29f6eb87f9e	true	include.in.token.scope
8d3e9730-2a95-496c-a501-86c192aa522e	true	display.on.consent.screen
8d3e9730-2a95-496c-a501-86c192aa522e	${phoneScopeConsentText}	consent.screen.text
8d3e9730-2a95-496c-a501-86c192aa522e	true	include.in.token.scope
6bd4b9cf-2f58-4a31-b376-23fc21507732	true	display.on.consent.screen
6bd4b9cf-2f58-4a31-b376-23fc21507732	${rolesScopeConsentText}	consent.screen.text
6bd4b9cf-2f58-4a31-b376-23fc21507732	false	include.in.token.scope
93046ecc-b470-4c00-8c97-a5abe1263d31	false	display.on.consent.screen
93046ecc-b470-4c00-8c97-a5abe1263d31		consent.screen.text
93046ecc-b470-4c00-8c97-a5abe1263d31	false	include.in.token.scope
28dbe4b5-572e-4486-8984-afc9d301430f	false	display.on.consent.screen
28dbe4b5-572e-4486-8984-afc9d301430f	true	include.in.token.scope
0b028e24-09ef-4f0e-aeda-e80a08091f5f	false	display.on.consent.screen
0b028e24-09ef-4f0e-aeda-e80a08091f5f	false	include.in.token.scope
b7fc21ae-98c7-4606-a55f-41faff40d165	false	display.on.consent.screen
b7fc21ae-98c7-4606-a55f-41faff40d165	false	include.in.token.scope
587d2738-ff4d-4792-aa6d-e4f80825dc00	false	display.on.consent.screen
587d2738-ff4d-4792-aa6d-e4f80825dc00	false	include.in.token.scope
182072e9-0cbe-4345-968f-281623eed31e	true	display.on.consent.screen
182072e9-0cbe-4345-968f-281623eed31e	${organizationScopeConsentText}	consent.screen.text
182072e9-0cbe-4345-968f-281623eed31e	true	include.in.token.scope
1a3e9a03-8d09-4890-8324-5b150ec173c4	true	display.on.consent.screen
1a3e9a03-8d09-4890-8324-5b150ec173c4	${offlineAccessScopeConsentText}	consent.screen.text
5d8f27f2-0f54-4c57-bf5f-1f9783b09966	true	display.on.consent.screen
5d8f27f2-0f54-4c57-bf5f-1f9783b09966	${samlRoleListScopeConsentText}	consent.screen.text
1d9019e7-0de0-41f1-adb6-97cf8aad4881	false	display.on.consent.screen
80bad889-41be-4686-91bf-0ac60c774b7d	true	display.on.consent.screen
80bad889-41be-4686-91bf-0ac60c774b7d	${profileScopeConsentText}	consent.screen.text
80bad889-41be-4686-91bf-0ac60c774b7d	true	include.in.token.scope
b4c4e925-3b8a-4258-8526-9b6532f8a99a	true	display.on.consent.screen
b4c4e925-3b8a-4258-8526-9b6532f8a99a	${emailScopeConsentText}	consent.screen.text
b4c4e925-3b8a-4258-8526-9b6532f8a99a	true	include.in.token.scope
cf859df3-7cdb-4485-9c51-56419ed63518	true	display.on.consent.screen
cf859df3-7cdb-4485-9c51-56419ed63518	${addressScopeConsentText}	consent.screen.text
cf859df3-7cdb-4485-9c51-56419ed63518	true	include.in.token.scope
481eb095-1f32-48bb-9271-c603ff8d8a3c	true	display.on.consent.screen
481eb095-1f32-48bb-9271-c603ff8d8a3c	${phoneScopeConsentText}	consent.screen.text
481eb095-1f32-48bb-9271-c603ff8d8a3c	true	include.in.token.scope
b9d2f0f1-cb2b-4c3a-aa13-4d910b4a2f97	true	display.on.consent.screen
b9d2f0f1-cb2b-4c3a-aa13-4d910b4a2f97	${rolesScopeConsentText}	consent.screen.text
b9d2f0f1-cb2b-4c3a-aa13-4d910b4a2f97	false	include.in.token.scope
22f13a4e-cfbd-4cb5-bbd0-cdcb603032bd	false	display.on.consent.screen
22f13a4e-cfbd-4cb5-bbd0-cdcb603032bd		consent.screen.text
22f13a4e-cfbd-4cb5-bbd0-cdcb603032bd	false	include.in.token.scope
6f298998-0954-405c-9408-153ffd0e3ae6	false	display.on.consent.screen
6f298998-0954-405c-9408-153ffd0e3ae6	true	include.in.token.scope
956d0e9e-4da0-4244-8a24-8128ca49c3c3	false	display.on.consent.screen
956d0e9e-4da0-4244-8a24-8128ca49c3c3	false	include.in.token.scope
cae62eb5-8113-42af-bd43-5a489f49e1bd	false	display.on.consent.screen
cae62eb5-8113-42af-bd43-5a489f49e1bd	false	include.in.token.scope
c633ceca-7899-4d26-8a62-62190efafd9a	false	display.on.consent.screen
c633ceca-7899-4d26-8a62-62190efafd9a	false	include.in.token.scope
fbe9c5cc-0240-453a-b849-a9e9c5145b26	true	display.on.consent.screen
fbe9c5cc-0240-453a-b849-a9e9c5145b26	${organizationScopeConsentText}	consent.screen.text
fbe9c5cc-0240-453a-b849-a9e9c5145b26	true	include.in.token.scope
76e1958d-1ada-4243-8f35-dd5ebb8abd62	true	display.on.consent.screen
76e1958d-1ada-4243-8f35-dd5ebb8abd62		consent.screen.text
76e1958d-1ada-4243-8f35-dd5ebb8abd62		gui.order
76e1958d-1ada-4243-8f35-dd5ebb8abd62	true	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
54d8b736-b0fe-4bc6-8be3-6f6cc4d919d4	0b028e24-09ef-4f0e-aeda-e80a08091f5f	t
54d8b736-b0fe-4bc6-8be3-6f6cc4d919d4	93046ecc-b470-4c00-8c97-a5abe1263d31	t
54d8b736-b0fe-4bc6-8be3-6f6cc4d919d4	b7fc21ae-98c7-4606-a55f-41faff40d165	t
54d8b736-b0fe-4bc6-8be3-6f6cc4d919d4	5b82719d-857b-4830-adec-6e21218548a3	t
54d8b736-b0fe-4bc6-8be3-6f6cc4d919d4	9a02c129-f7ab-418b-b873-72b88021d9ae	t
54d8b736-b0fe-4bc6-8be3-6f6cc4d919d4	6bd4b9cf-2f58-4a31-b376-23fc21507732	t
54d8b736-b0fe-4bc6-8be3-6f6cc4d919d4	6b23c029-f918-4656-be8b-ca4eb7cf78a6	f
54d8b736-b0fe-4bc6-8be3-6f6cc4d919d4	5b6919ad-213c-4524-9de7-d29f6eb87f9e	f
54d8b736-b0fe-4bc6-8be3-6f6cc4d919d4	8d3e9730-2a95-496c-a501-86c192aa522e	f
54d8b736-b0fe-4bc6-8be3-6f6cc4d919d4	182072e9-0cbe-4345-968f-281623eed31e	f
54d8b736-b0fe-4bc6-8be3-6f6cc4d919d4	28dbe4b5-572e-4486-8984-afc9d301430f	f
4daf458a-6353-4178-8200-93f1810528ce	0b028e24-09ef-4f0e-aeda-e80a08091f5f	t
4daf458a-6353-4178-8200-93f1810528ce	93046ecc-b470-4c00-8c97-a5abe1263d31	t
4daf458a-6353-4178-8200-93f1810528ce	b7fc21ae-98c7-4606-a55f-41faff40d165	t
4daf458a-6353-4178-8200-93f1810528ce	5b82719d-857b-4830-adec-6e21218548a3	t
4daf458a-6353-4178-8200-93f1810528ce	9a02c129-f7ab-418b-b873-72b88021d9ae	t
4daf458a-6353-4178-8200-93f1810528ce	6bd4b9cf-2f58-4a31-b376-23fc21507732	t
4daf458a-6353-4178-8200-93f1810528ce	6b23c029-f918-4656-be8b-ca4eb7cf78a6	f
4daf458a-6353-4178-8200-93f1810528ce	5b6919ad-213c-4524-9de7-d29f6eb87f9e	f
4daf458a-6353-4178-8200-93f1810528ce	8d3e9730-2a95-496c-a501-86c192aa522e	f
4daf458a-6353-4178-8200-93f1810528ce	182072e9-0cbe-4345-968f-281623eed31e	f
4daf458a-6353-4178-8200-93f1810528ce	28dbe4b5-572e-4486-8984-afc9d301430f	f
86ed8184-0bda-4316-a4bb-affbbaa4e7fe	0b028e24-09ef-4f0e-aeda-e80a08091f5f	t
86ed8184-0bda-4316-a4bb-affbbaa4e7fe	93046ecc-b470-4c00-8c97-a5abe1263d31	t
86ed8184-0bda-4316-a4bb-affbbaa4e7fe	b7fc21ae-98c7-4606-a55f-41faff40d165	t
86ed8184-0bda-4316-a4bb-affbbaa4e7fe	5b82719d-857b-4830-adec-6e21218548a3	t
86ed8184-0bda-4316-a4bb-affbbaa4e7fe	9a02c129-f7ab-418b-b873-72b88021d9ae	t
86ed8184-0bda-4316-a4bb-affbbaa4e7fe	6bd4b9cf-2f58-4a31-b376-23fc21507732	t
86ed8184-0bda-4316-a4bb-affbbaa4e7fe	6b23c029-f918-4656-be8b-ca4eb7cf78a6	f
86ed8184-0bda-4316-a4bb-affbbaa4e7fe	5b6919ad-213c-4524-9de7-d29f6eb87f9e	f
86ed8184-0bda-4316-a4bb-affbbaa4e7fe	8d3e9730-2a95-496c-a501-86c192aa522e	f
86ed8184-0bda-4316-a4bb-affbbaa4e7fe	182072e9-0cbe-4345-968f-281623eed31e	f
86ed8184-0bda-4316-a4bb-affbbaa4e7fe	28dbe4b5-572e-4486-8984-afc9d301430f	f
51cd7f1a-e974-4a27-8a37-da3bf530de67	0b028e24-09ef-4f0e-aeda-e80a08091f5f	t
51cd7f1a-e974-4a27-8a37-da3bf530de67	93046ecc-b470-4c00-8c97-a5abe1263d31	t
51cd7f1a-e974-4a27-8a37-da3bf530de67	b7fc21ae-98c7-4606-a55f-41faff40d165	t
51cd7f1a-e974-4a27-8a37-da3bf530de67	5b82719d-857b-4830-adec-6e21218548a3	t
51cd7f1a-e974-4a27-8a37-da3bf530de67	9a02c129-f7ab-418b-b873-72b88021d9ae	t
51cd7f1a-e974-4a27-8a37-da3bf530de67	6bd4b9cf-2f58-4a31-b376-23fc21507732	t
51cd7f1a-e974-4a27-8a37-da3bf530de67	6b23c029-f918-4656-be8b-ca4eb7cf78a6	f
51cd7f1a-e974-4a27-8a37-da3bf530de67	5b6919ad-213c-4524-9de7-d29f6eb87f9e	f
51cd7f1a-e974-4a27-8a37-da3bf530de67	8d3e9730-2a95-496c-a501-86c192aa522e	f
51cd7f1a-e974-4a27-8a37-da3bf530de67	182072e9-0cbe-4345-968f-281623eed31e	f
51cd7f1a-e974-4a27-8a37-da3bf530de67	28dbe4b5-572e-4486-8984-afc9d301430f	f
809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	0b028e24-09ef-4f0e-aeda-e80a08091f5f	t
809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	93046ecc-b470-4c00-8c97-a5abe1263d31	t
809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	b7fc21ae-98c7-4606-a55f-41faff40d165	t
809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	5b82719d-857b-4830-adec-6e21218548a3	t
809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	9a02c129-f7ab-418b-b873-72b88021d9ae	t
809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	6bd4b9cf-2f58-4a31-b376-23fc21507732	t
809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	6b23c029-f918-4656-be8b-ca4eb7cf78a6	f
809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	5b6919ad-213c-4524-9de7-d29f6eb87f9e	f
809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	8d3e9730-2a95-496c-a501-86c192aa522e	f
809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	182072e9-0cbe-4345-968f-281623eed31e	f
809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	28dbe4b5-572e-4486-8984-afc9d301430f	f
ee5b168a-aa3e-45a0-8234-372b64c37985	0b028e24-09ef-4f0e-aeda-e80a08091f5f	t
ee5b168a-aa3e-45a0-8234-372b64c37985	93046ecc-b470-4c00-8c97-a5abe1263d31	t
ee5b168a-aa3e-45a0-8234-372b64c37985	b7fc21ae-98c7-4606-a55f-41faff40d165	t
ee5b168a-aa3e-45a0-8234-372b64c37985	5b82719d-857b-4830-adec-6e21218548a3	t
ee5b168a-aa3e-45a0-8234-372b64c37985	9a02c129-f7ab-418b-b873-72b88021d9ae	t
ee5b168a-aa3e-45a0-8234-372b64c37985	6bd4b9cf-2f58-4a31-b376-23fc21507732	t
ee5b168a-aa3e-45a0-8234-372b64c37985	6b23c029-f918-4656-be8b-ca4eb7cf78a6	f
ee5b168a-aa3e-45a0-8234-372b64c37985	5b6919ad-213c-4524-9de7-d29f6eb87f9e	f
ee5b168a-aa3e-45a0-8234-372b64c37985	8d3e9730-2a95-496c-a501-86c192aa522e	f
ee5b168a-aa3e-45a0-8234-372b64c37985	182072e9-0cbe-4345-968f-281623eed31e	f
ee5b168a-aa3e-45a0-8234-372b64c37985	28dbe4b5-572e-4486-8984-afc9d301430f	f
9e9ca8d3-de61-4566-91b1-0be5ae703db7	cae62eb5-8113-42af-bd43-5a489f49e1bd	t
9e9ca8d3-de61-4566-91b1-0be5ae703db7	22f13a4e-cfbd-4cb5-bbd0-cdcb603032bd	t
9e9ca8d3-de61-4566-91b1-0be5ae703db7	80bad889-41be-4686-91bf-0ac60c774b7d	t
9e9ca8d3-de61-4566-91b1-0be5ae703db7	956d0e9e-4da0-4244-8a24-8128ca49c3c3	t
9e9ca8d3-de61-4566-91b1-0be5ae703db7	b4c4e925-3b8a-4258-8526-9b6532f8a99a	t
9e9ca8d3-de61-4566-91b1-0be5ae703db7	b9d2f0f1-cb2b-4c3a-aa13-4d910b4a2f97	t
9e9ca8d3-de61-4566-91b1-0be5ae703db7	cf859df3-7cdb-4485-9c51-56419ed63518	f
9e9ca8d3-de61-4566-91b1-0be5ae703db7	1a3e9a03-8d09-4890-8324-5b150ec173c4	f
9e9ca8d3-de61-4566-91b1-0be5ae703db7	fbe9c5cc-0240-453a-b849-a9e9c5145b26	f
9e9ca8d3-de61-4566-91b1-0be5ae703db7	6f298998-0954-405c-9408-153ffd0e3ae6	f
9e9ca8d3-de61-4566-91b1-0be5ae703db7	481eb095-1f32-48bb-9271-c603ff8d8a3c	f
3df67013-7d9d-4b13-816f-289b30cea5e4	cae62eb5-8113-42af-bd43-5a489f49e1bd	t
3df67013-7d9d-4b13-816f-289b30cea5e4	22f13a4e-cfbd-4cb5-bbd0-cdcb603032bd	t
3df67013-7d9d-4b13-816f-289b30cea5e4	80bad889-41be-4686-91bf-0ac60c774b7d	t
3df67013-7d9d-4b13-816f-289b30cea5e4	956d0e9e-4da0-4244-8a24-8128ca49c3c3	t
3df67013-7d9d-4b13-816f-289b30cea5e4	b4c4e925-3b8a-4258-8526-9b6532f8a99a	t
3df67013-7d9d-4b13-816f-289b30cea5e4	b9d2f0f1-cb2b-4c3a-aa13-4d910b4a2f97	t
3df67013-7d9d-4b13-816f-289b30cea5e4	cf859df3-7cdb-4485-9c51-56419ed63518	f
3df67013-7d9d-4b13-816f-289b30cea5e4	1a3e9a03-8d09-4890-8324-5b150ec173c4	f
3df67013-7d9d-4b13-816f-289b30cea5e4	fbe9c5cc-0240-453a-b849-a9e9c5145b26	f
3df67013-7d9d-4b13-816f-289b30cea5e4	6f298998-0954-405c-9408-153ffd0e3ae6	f
3df67013-7d9d-4b13-816f-289b30cea5e4	481eb095-1f32-48bb-9271-c603ff8d8a3c	f
0f0c4c43-df13-4c36-be6c-17a26578c5d0	cae62eb5-8113-42af-bd43-5a489f49e1bd	t
0f0c4c43-df13-4c36-be6c-17a26578c5d0	22f13a4e-cfbd-4cb5-bbd0-cdcb603032bd	t
0f0c4c43-df13-4c36-be6c-17a26578c5d0	80bad889-41be-4686-91bf-0ac60c774b7d	t
0f0c4c43-df13-4c36-be6c-17a26578c5d0	956d0e9e-4da0-4244-8a24-8128ca49c3c3	t
0f0c4c43-df13-4c36-be6c-17a26578c5d0	b4c4e925-3b8a-4258-8526-9b6532f8a99a	t
0f0c4c43-df13-4c36-be6c-17a26578c5d0	b9d2f0f1-cb2b-4c3a-aa13-4d910b4a2f97	t
0f0c4c43-df13-4c36-be6c-17a26578c5d0	cf859df3-7cdb-4485-9c51-56419ed63518	f
0f0c4c43-df13-4c36-be6c-17a26578c5d0	1a3e9a03-8d09-4890-8324-5b150ec173c4	f
0f0c4c43-df13-4c36-be6c-17a26578c5d0	fbe9c5cc-0240-453a-b849-a9e9c5145b26	f
0f0c4c43-df13-4c36-be6c-17a26578c5d0	6f298998-0954-405c-9408-153ffd0e3ae6	f
0f0c4c43-df13-4c36-be6c-17a26578c5d0	481eb095-1f32-48bb-9271-c603ff8d8a3c	f
560b33d3-0bfc-4b3d-9013-214383cbee87	cae62eb5-8113-42af-bd43-5a489f49e1bd	t
560b33d3-0bfc-4b3d-9013-214383cbee87	22f13a4e-cfbd-4cb5-bbd0-cdcb603032bd	t
560b33d3-0bfc-4b3d-9013-214383cbee87	80bad889-41be-4686-91bf-0ac60c774b7d	t
560b33d3-0bfc-4b3d-9013-214383cbee87	956d0e9e-4da0-4244-8a24-8128ca49c3c3	t
560b33d3-0bfc-4b3d-9013-214383cbee87	b4c4e925-3b8a-4258-8526-9b6532f8a99a	t
560b33d3-0bfc-4b3d-9013-214383cbee87	b9d2f0f1-cb2b-4c3a-aa13-4d910b4a2f97	t
560b33d3-0bfc-4b3d-9013-214383cbee87	cf859df3-7cdb-4485-9c51-56419ed63518	f
560b33d3-0bfc-4b3d-9013-214383cbee87	1a3e9a03-8d09-4890-8324-5b150ec173c4	f
560b33d3-0bfc-4b3d-9013-214383cbee87	fbe9c5cc-0240-453a-b849-a9e9c5145b26	f
560b33d3-0bfc-4b3d-9013-214383cbee87	6f298998-0954-405c-9408-153ffd0e3ae6	f
560b33d3-0bfc-4b3d-9013-214383cbee87	481eb095-1f32-48bb-9271-c603ff8d8a3c	f
048bcd9d-39be-4012-abbb-ce0059d5c0e9	cae62eb5-8113-42af-bd43-5a489f49e1bd	t
048bcd9d-39be-4012-abbb-ce0059d5c0e9	22f13a4e-cfbd-4cb5-bbd0-cdcb603032bd	t
048bcd9d-39be-4012-abbb-ce0059d5c0e9	80bad889-41be-4686-91bf-0ac60c774b7d	t
048bcd9d-39be-4012-abbb-ce0059d5c0e9	956d0e9e-4da0-4244-8a24-8128ca49c3c3	t
048bcd9d-39be-4012-abbb-ce0059d5c0e9	b4c4e925-3b8a-4258-8526-9b6532f8a99a	t
048bcd9d-39be-4012-abbb-ce0059d5c0e9	b9d2f0f1-cb2b-4c3a-aa13-4d910b4a2f97	t
048bcd9d-39be-4012-abbb-ce0059d5c0e9	cf859df3-7cdb-4485-9c51-56419ed63518	f
048bcd9d-39be-4012-abbb-ce0059d5c0e9	1a3e9a03-8d09-4890-8324-5b150ec173c4	f
048bcd9d-39be-4012-abbb-ce0059d5c0e9	fbe9c5cc-0240-453a-b849-a9e9c5145b26	f
048bcd9d-39be-4012-abbb-ce0059d5c0e9	6f298998-0954-405c-9408-153ffd0e3ae6	f
048bcd9d-39be-4012-abbb-ce0059d5c0e9	481eb095-1f32-48bb-9271-c603ff8d8a3c	f
c4c5adc2-82c6-40cd-bbce-4357646cb30b	cae62eb5-8113-42af-bd43-5a489f49e1bd	t
c4c5adc2-82c6-40cd-bbce-4357646cb30b	22f13a4e-cfbd-4cb5-bbd0-cdcb603032bd	t
c4c5adc2-82c6-40cd-bbce-4357646cb30b	80bad889-41be-4686-91bf-0ac60c774b7d	t
c4c5adc2-82c6-40cd-bbce-4357646cb30b	956d0e9e-4da0-4244-8a24-8128ca49c3c3	t
c4c5adc2-82c6-40cd-bbce-4357646cb30b	b4c4e925-3b8a-4258-8526-9b6532f8a99a	t
c4c5adc2-82c6-40cd-bbce-4357646cb30b	b9d2f0f1-cb2b-4c3a-aa13-4d910b4a2f97	t
c4c5adc2-82c6-40cd-bbce-4357646cb30b	cf859df3-7cdb-4485-9c51-56419ed63518	f
c4c5adc2-82c6-40cd-bbce-4357646cb30b	1a3e9a03-8d09-4890-8324-5b150ec173c4	f
c4c5adc2-82c6-40cd-bbce-4357646cb30b	fbe9c5cc-0240-453a-b849-a9e9c5145b26	f
c4c5adc2-82c6-40cd-bbce-4357646cb30b	6f298998-0954-405c-9408-153ffd0e3ae6	f
c4c5adc2-82c6-40cd-bbce-4357646cb30b	481eb095-1f32-48bb-9271-c603ff8d8a3c	f
3b16b7ba-488a-4efc-9713-c1d6a43e7abf	cae62eb5-8113-42af-bd43-5a489f49e1bd	t
3b16b7ba-488a-4efc-9713-c1d6a43e7abf	22f13a4e-cfbd-4cb5-bbd0-cdcb603032bd	t
3b16b7ba-488a-4efc-9713-c1d6a43e7abf	80bad889-41be-4686-91bf-0ac60c774b7d	t
3b16b7ba-488a-4efc-9713-c1d6a43e7abf	956d0e9e-4da0-4244-8a24-8128ca49c3c3	t
3b16b7ba-488a-4efc-9713-c1d6a43e7abf	b4c4e925-3b8a-4258-8526-9b6532f8a99a	t
3b16b7ba-488a-4efc-9713-c1d6a43e7abf	b9d2f0f1-cb2b-4c3a-aa13-4d910b4a2f97	t
3b16b7ba-488a-4efc-9713-c1d6a43e7abf	cf859df3-7cdb-4485-9c51-56419ed63518	f
3b16b7ba-488a-4efc-9713-c1d6a43e7abf	1a3e9a03-8d09-4890-8324-5b150ec173c4	f
3b16b7ba-488a-4efc-9713-c1d6a43e7abf	fbe9c5cc-0240-453a-b849-a9e9c5145b26	f
3b16b7ba-488a-4efc-9713-c1d6a43e7abf	6f298998-0954-405c-9408-153ffd0e3ae6	f
3b16b7ba-488a-4efc-9713-c1d6a43e7abf	481eb095-1f32-48bb-9271-c603ff8d8a3c	f
24ec7eab-9e90-4a7a-b133-5ab5f2945566	76e1958d-1ada-4243-8f35-dd5ebb8abd62	t
24ec7eab-9e90-4a7a-b133-5ab5f2945566	cae62eb5-8113-42af-bd43-5a489f49e1bd	t
24ec7eab-9e90-4a7a-b133-5ab5f2945566	22f13a4e-cfbd-4cb5-bbd0-cdcb603032bd	t
24ec7eab-9e90-4a7a-b133-5ab5f2945566	80bad889-41be-4686-91bf-0ac60c774b7d	t
24ec7eab-9e90-4a7a-b133-5ab5f2945566	956d0e9e-4da0-4244-8a24-8128ca49c3c3	t
24ec7eab-9e90-4a7a-b133-5ab5f2945566	b4c4e925-3b8a-4258-8526-9b6532f8a99a	t
24ec7eab-9e90-4a7a-b133-5ab5f2945566	b9d2f0f1-cb2b-4c3a-aa13-4d910b4a2f97	t
24ec7eab-9e90-4a7a-b133-5ab5f2945566	cf859df3-7cdb-4485-9c51-56419ed63518	f
24ec7eab-9e90-4a7a-b133-5ab5f2945566	1a3e9a03-8d09-4890-8324-5b150ec173c4	f
24ec7eab-9e90-4a7a-b133-5ab5f2945566	fbe9c5cc-0240-453a-b849-a9e9c5145b26	f
24ec7eab-9e90-4a7a-b133-5ab5f2945566	6f298998-0954-405c-9408-153ffd0e3ae6	f
24ec7eab-9e90-4a7a-b133-5ab5f2945566	481eb095-1f32-48bb-9271-c603ff8d8a3c	f
24ec7eab-9e90-4a7a-b133-5ab5f2945566	c633ceca-7899-4d26-8a62-62190efafd9a	t
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
6b23c029-f918-4656-be8b-ca4eb7cf78a6	196ca212-4cec-4659-bda1-255e1ad196b6
1a3e9a03-8d09-4890-8324-5b150ec173c4	1f7f6f1a-33a6-4feb-812c-9a8fae7bf89c
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
78b8f6af-29e8-4f47-b810-e750097ea7db	Trusted Hosts	a4e86523-4f8b-4056-9322-55cde86f8d6b	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	a4e86523-4f8b-4056-9322-55cde86f8d6b	anonymous
a9da6ed4-c0fb-4c77-a307-74046658b407	Consent Required	a4e86523-4f8b-4056-9322-55cde86f8d6b	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	a4e86523-4f8b-4056-9322-55cde86f8d6b	anonymous
66711895-b804-48aa-b040-7df1cbd2b368	Full Scope Disabled	a4e86523-4f8b-4056-9322-55cde86f8d6b	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	a4e86523-4f8b-4056-9322-55cde86f8d6b	anonymous
2c62c86c-bbd7-46a8-a587-f9c2d67a23d1	Max Clients Limit	a4e86523-4f8b-4056-9322-55cde86f8d6b	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	a4e86523-4f8b-4056-9322-55cde86f8d6b	anonymous
b79820f5-5f36-4649-a4dc-5dba24fb62a3	Allowed Protocol Mapper Types	a4e86523-4f8b-4056-9322-55cde86f8d6b	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	a4e86523-4f8b-4056-9322-55cde86f8d6b	anonymous
2d74d551-f271-4e3a-b315-054c2d57d3e4	Allowed Client Scopes	a4e86523-4f8b-4056-9322-55cde86f8d6b	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	a4e86523-4f8b-4056-9322-55cde86f8d6b	anonymous
a192cddd-2daf-40a5-aefe-d155fcc93eec	Allowed Protocol Mapper Types	a4e86523-4f8b-4056-9322-55cde86f8d6b	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	a4e86523-4f8b-4056-9322-55cde86f8d6b	authenticated
c88ffae6-5857-4825-bcd5-2008a9a06d95	Allowed Client Scopes	a4e86523-4f8b-4056-9322-55cde86f8d6b	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	a4e86523-4f8b-4056-9322-55cde86f8d6b	authenticated
d3ee6da5-034b-4a8c-bff4-5ea111b742b9	rsa-generated	a4e86523-4f8b-4056-9322-55cde86f8d6b	rsa-generated	org.keycloak.keys.KeyProvider	a4e86523-4f8b-4056-9322-55cde86f8d6b	\N
37005787-d836-44ec-b439-9177061cf324	rsa-enc-generated	a4e86523-4f8b-4056-9322-55cde86f8d6b	rsa-enc-generated	org.keycloak.keys.KeyProvider	a4e86523-4f8b-4056-9322-55cde86f8d6b	\N
45e2f017-750d-4177-8697-a4ce347262cd	hmac-generated-hs512	a4e86523-4f8b-4056-9322-55cde86f8d6b	hmac-generated	org.keycloak.keys.KeyProvider	a4e86523-4f8b-4056-9322-55cde86f8d6b	\N
990d47fd-570b-4760-b295-24bf469239e7	aes-generated	a4e86523-4f8b-4056-9322-55cde86f8d6b	aes-generated	org.keycloak.keys.KeyProvider	a4e86523-4f8b-4056-9322-55cde86f8d6b	\N
93bc550e-9cf6-40dd-8de7-738da371614c	\N	a4e86523-4f8b-4056-9322-55cde86f8d6b	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	a4e86523-4f8b-4056-9322-55cde86f8d6b	\N
4a42119b-8b2e-4284-b5a5-6a4657e9b722	rsa-generated	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	rsa-generated	org.keycloak.keys.KeyProvider	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	\N
eba06685-4c0b-41e8-a2f6-34df4efd8b98	rsa-enc-generated	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	rsa-enc-generated	org.keycloak.keys.KeyProvider	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	\N
7312581e-95bc-4ef0-a416-e9902f4729b9	hmac-generated-hs512	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	hmac-generated	org.keycloak.keys.KeyProvider	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	\N
5c0bcc8b-151d-48dd-8274-04b269a87d3c	aes-generated	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	aes-generated	org.keycloak.keys.KeyProvider	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	\N
a6226255-8139-4f7d-aea7-0c2773f254ac	Trusted Hosts	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	anonymous
f7e8929e-f53a-4103-98ec-42cedb4b9af0	Consent Required	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	anonymous
786313b8-978d-4f51-a2d5-332dec43c07c	Full Scope Disabled	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	anonymous
a3c50668-06b4-497d-8db6-9abc1102652a	Max Clients Limit	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	anonymous
152ee543-9228-4d35-b4fd-810730090680	Allowed Protocol Mapper Types	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	anonymous
3005daeb-7d60-4830-86ee-b092ffcaacae	Allowed Client Scopes	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	anonymous
248c1a02-b8b7-47c0-829f-fa4286ad9380	Allowed Protocol Mapper Types	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	authenticated
51c90634-af87-4813-bd52-3386af95062f	Allowed Client Scopes	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	authenticated
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
a67d346d-e263-4806-807f-7431f10ffa78	2d74d551-f271-4e3a-b315-054c2d57d3e4	allow-default-scopes	true
3cb89620-576d-4803-a264-4d8703bf06c2	2c62c86c-bbd7-46a8-a587-f9c2d67a23d1	max-clients	200
9cf7baa6-2ef9-430e-83e9-e7e05ff8248a	78b8f6af-29e8-4f47-b810-e750097ea7db	host-sending-registration-request-must-match	true
fae59577-c04f-423c-bf46-f6fbd21987bb	78b8f6af-29e8-4f47-b810-e750097ea7db	client-uris-must-match	true
eb94a140-71c2-40d1-9fbe-3ea7a1d49332	c88ffae6-5857-4825-bcd5-2008a9a06d95	allow-default-scopes	true
bf4c515a-5d9d-4162-ba51-297dedf5de36	b79820f5-5f36-4649-a4dc-5dba24fb62a3	allowed-protocol-mapper-types	saml-role-list-mapper
d9eb9780-6445-426d-8935-ecb215e1104f	b79820f5-5f36-4649-a4dc-5dba24fb62a3	allowed-protocol-mapper-types	saml-user-property-mapper
98bc8ec2-0002-490a-8f5d-6999ba8d7067	b79820f5-5f36-4649-a4dc-5dba24fb62a3	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
b6a607bf-5c75-4ff0-b5e6-2b230bbb6bda	b79820f5-5f36-4649-a4dc-5dba24fb62a3	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
d4845f8e-2de9-4087-815d-fbb6d75efd61	b79820f5-5f36-4649-a4dc-5dba24fb62a3	allowed-protocol-mapper-types	oidc-address-mapper
ee5f736f-7ebc-40df-bff8-b3c325fe8432	b79820f5-5f36-4649-a4dc-5dba24fb62a3	allowed-protocol-mapper-types	saml-user-attribute-mapper
64d6383f-84f6-4b26-a5e0-4fa9dfc7904f	b79820f5-5f36-4649-a4dc-5dba24fb62a3	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
3abe9518-9183-47c2-9fe2-8caa7843cb1b	b79820f5-5f36-4649-a4dc-5dba24fb62a3	allowed-protocol-mapper-types	oidc-full-name-mapper
22600fdc-6a41-494f-90b2-d13db4f72fa3	a192cddd-2daf-40a5-aefe-d155fcc93eec	allowed-protocol-mapper-types	saml-user-attribute-mapper
b9a38219-e9e7-43ce-97d6-871b25085bc6	a192cddd-2daf-40a5-aefe-d155fcc93eec	allowed-protocol-mapper-types	saml-user-property-mapper
90aeb81b-ef4b-4cfa-9922-6af6edc7a8f8	a192cddd-2daf-40a5-aefe-d155fcc93eec	allowed-protocol-mapper-types	oidc-full-name-mapper
cbb566b3-251b-43ff-bc53-7c72ef2a27bd	a192cddd-2daf-40a5-aefe-d155fcc93eec	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
88f52972-7a9b-44a5-952f-9b9bd00957a4	a192cddd-2daf-40a5-aefe-d155fcc93eec	allowed-protocol-mapper-types	oidc-address-mapper
75c25b2c-af81-459d-ac06-3655e96b63fd	a192cddd-2daf-40a5-aefe-d155fcc93eec	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
67a6f4cc-8a12-46a3-a8e0-dafef6d4bad2	a192cddd-2daf-40a5-aefe-d155fcc93eec	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
a8f47307-d80b-4f53-998b-fcfb030c8c4c	a192cddd-2daf-40a5-aefe-d155fcc93eec	allowed-protocol-mapper-types	saml-role-list-mapper
d2e371eb-9825-4217-a52b-740fba498f26	37005787-d836-44ec-b439-9177061cf324	certificate	MIICmzCCAYMCBgGV87xPqzANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUwNDAxMjM0MDU5WhcNMzUwNDAxMjM0MjM5WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDBgXT6VS1sn64kOhRCW3eHSDu7T6KGzHOf5BOQljujJrrjud+U54Ch4yDn824TlLx8TBTqiDGOH1wqi7tW98NwtT9RKDyRaUqb7PcqTtt78Xzfen+KfpU4yj9XyqqF4iffUxavanBhrO9kuPxqDR9UnjFKOiYhSF/w/2LrXX+CLYEGx4Z8SiAtrZulm2snzpvfaFMxzK2RCvBv1XaGS2NllF/OcVsJ+n4HYk9+rrvPCGriwPF5H9PSxd9sLM/9QEwzImG/z+/H5LJBC6hUfE4Lo/UX1oUqLiEWYcl5zRlOnFnodNnfBPcLxovCFy/aSh7kjqUW/UpU6reJGWheYag3AgMBAAEwDQYJKoZIhvcNAQELBQADggEBAItQjwUvE7QyrE3BKlhPqWVQw+FIPqmMJQMvL6ND0znVFzlG5R3xd9XqlDTEKF/6oF0rkxWgpFP98XeGuAlW7/JWcmzhb4jXBhDAvORdWgEz5ycO56EhxJ7M46KSqo/EeJUEup7vy5AdfkO6OrqVwr4M8gjJqlxj8ZGXAiAGGyBYUyZld6IZuVe6qzR+klYtFBhaRuNIUcBSzNLIam19GDrQCVoc7sWzPUtkURhotkScjv5wsSaXR1M7yhRcBza3CxKuCG8/OUcfubSPs20xHp2QOmm8RXe0/gcTTSi9ohE2BN9PlpKv6d5c257laKY5opBW1yh94e1sJiDFBUS43ko=
8e68232d-1e15-4111-8a2a-f48456b08eb9	37005787-d836-44ec-b439-9177061cf324	keyUse	ENC
2f197692-6015-4c01-8d05-6d973d4ebb3d	37005787-d836-44ec-b439-9177061cf324	privateKey	MIIEpAIBAAKCAQEAwYF0+lUtbJ+uJDoUQlt3h0g7u0+ihsxzn+QTkJY7oya647nflOeAoeMg5/NuE5S8fEwU6ogxjh9cKou7VvfDcLU/USg8kWlKm+z3Kk7be/F833p/in6VOMo/V8qqheIn31MWr2pwYazvZLj8ag0fVJ4xSjomIUhf8P9i611/gi2BBseGfEogLa2bpZtrJ86b32hTMcytkQrwb9V2hktjZZRfznFbCfp+B2JPfq67zwhq4sDxeR/T0sXfbCzP/UBMMyJhv8/vx+SyQQuoVHxOC6P1F9aFKi4hFmHJec0ZTpxZ6HTZ3wT3C8aLwhcv2koe5I6lFv1KVOq3iRloXmGoNwIDAQABAoIBAF9FSB06E5+/7IKMj83t76cM8s+xkRDyF1lY9yMAPIOCvZACQyiyZBwQUfKxYPhGChjecovYGyHgocWWv1k9qh1TN0XTXCKxptinLjfH1Hss9bCnxKSg1wI7XT1xnExHgR8MbwZVjtggR0sdYrUqGctVCWqEv6IyWn4ylvbPtUgXGLtw1KiWk+W5uTyxP6+xSl3MoNrgw6Q8a0Bt7E/g8cLHj3gKf+2sWMCP2JnXXTU4nMZtF4AwsG4zlqE4MSUFyJokIE9qb65eTm4sMXu5GJTVNeq5+2zbMOHVDeUU1Vqutdb3MOUJe4z5VhAK3AKD+HMIFjtq58NhrPrEiiFC/Q0CgYEA7Cq0j8UX3Kt0kuwQWM3uoUrZKabjoTa0xfXyr+6UQhiRxCJWeQWKRbt/q3nw3PxmDRq/BS54n1s5zf2wJgTyJfQRchQfTcv3OskRF6rDFcj9USH4QhkpcvtRE6BckKy/iYydXtnTsIVXjnOz1tXAfoWy/5D+7dDEeRsS0Yi/JOMCgYEA0cGXEx+pFAysPCc0wWjdwsW5zk9z2yiYKAyukZBYvztUss2G5EDaX1kSGqcsV4x2zRoUwDRbeIBSaN1us4lbmraHiG0Y51H5n3/cMl5zJBW/H2GNXdEmNgB0lK86stYvsALAXb0Ctuzmri2cFC8Za9L6iABRWUv2OZIZ5Kv/I50CgYEAo+AuUuUM3c8LoTe1UCn1wG5TqpdntOJlJki4EmSW9BZgb5z0LB4wCJtGyBJhlLZ/ifBZRJsukEWZIts6c+dSsAtgX6ye3DkAYQZMmgOgQ2mofbf4sMUNAgBqDhhkou98KVItkTfNsNuWGf8nd5fzbtgPkU9n1lXbP74NnOAq4skCgYEAk2L2JsfeZGorM/FQjn6DJHMPBjqp69rwX2PZ3gqRcX3dG+5y1DwFtW2+3N+Ots3KRIAJCK1BgMCaJ3lAagMgTOvo/CG8l/3v6vVK4lGfkkF9lC1VyhBGSzeysy8VjcgWphSo2rUPDT4VMVp3C2+06yDKTXn7r0VC9F0GuLlqg7kCgYA5HpwEY1ssKDA0ET5cRucjL17OaB4RYnjPbJ0eqfpjKfrEAdlXONStzDUvmtJGl+0Citdihb0AdlVVSwst5cFCUCbjTV+iLUIMnP10Xf5T2+ROjs4bGy8HicLds8lOjZpqgfl9ReO2AID+aY8Idl88P6XTA8s4aT+R2RDhtIjdOA==
c5d1a7ed-23f9-4ce3-b04b-b48ab8b0cd2a	37005787-d836-44ec-b439-9177061cf324	algorithm	RSA-OAEP
b98ea6f8-0fff-42f4-a936-c08910e82dea	37005787-d836-44ec-b439-9177061cf324	priority	100
5aaf636a-ecc8-4aac-b9f5-79887f9ca50d	d3ee6da5-034b-4a8c-bff4-5ea111b742b9	keyUse	SIG
c0d13ea8-ebca-4c96-be4b-f6826cfe5825	d3ee6da5-034b-4a8c-bff4-5ea111b742b9	privateKey	MIIEogIBAAKCAQEAvKdUMh+tA31G6LnyCqwTzDlgtCQYT5XHYMp4peMt6c3E5n+woOpLl8ViCvLlXgK6qfyGP0ArfJmKKYepwfXQf7NCva6IMcJnJER48MBt2NxXLVWYPVkrqHsd7kLiQ2fXS/jeTVy8rfbYAzkO2MwIZRTLoFFl2bgz/24XDikSEhyywN6cmBaPqjKJqHlk4Gm7vpj+SJNbOD1Oe/dUW9qpr/Bl6pYzOE6nZuMrTQyVmdDtegvijA77uGhRXcXJKve+qfkQpCi/4N9CSpPUHiAewOGQ3g/gmebWgS7jDyqvSSi5kxVcUAvH1DKVBTlSFdqSLRHufNMl1+4FUc1jUSn49wIDAQABAoIBABgMNF1XUFSbiYhs+3+Ew9lKjxsnZrnuW8XoyUxMEzQ0eJ7xM/CvLQehr4e5wqcjLewxNmOlqGVvpP76PhdtYDCHB0DqmI3PPBqRZ+E4hkgYfjxXJtrbHQeS+hO/DtyMxhL3HE88PQjn6E0w3sWf7IoGBpbfCV6hbm9m9yVk8tq/+aYqRGrNJmRaDgQ7EYT1yujS3sIzj0ASNyhU+wJCAfCRtn/N0V5PxJTIVDwW4u4adMMbwovJH8Eb1DEdEblkv/x8/H3D98qPcVBPf6U8cMrcXzIegHDJkK8ZiJT375Ysnr7Gq9gsW1Kn8+hDwFzVANfSoWuoJ9hHKBrWADm4zNECgYEA57vTxovMGh1Z4+xniygirOmL075vPQIURpX5SOw+IDPuxGXtzXqWiyGgyviTHi0rYjR5b2qdUN6HhnrlX455MXK0YVEe5DzuAbBhCgTSDHZKMkRJ+VhK11N3zsGiWcAqfaGcpnRGR5slhX+qBT3L8Qhpw9EwmG/zYBoxtF1yT2sCgYEA0GijTYbhUE1mRc9nSym+JP/mBBRGRbE+MufjV+Kt4CDCWVXyVgwiDM8hIIQu+GfDLk+rKM1d8l33beIp7rb0y5GzGIhoAorGyJuk+Gj6C3LSY124V29kLftzy3oyFbsez6p05DpFfFSnHxULomJXoijm4zMn3noW8t6NrV31m6UCgYBgQiZDCBj9FAod4jpUlJRqzQx3JViht/ZiJ7QINZHM4KWi0VBJlU1pd8uJ5F2AIHUv8uoqfNfiGr2i//O9kLoI70O8VO0HE8Qt0W1Nsxjpck15ueIcgC9+aD6RFN/ydh9wVixy/EOhRPH+FTyztqq7cao1W/TarU4kMl1JNbPhBwKBgHcVAxJ+Wmnu/9wtyUC6Zkpv6bc0+n5B619c/psuC9n//ezb3i9qmV4mUDBrNwd7CpyAqzUSO3cMWB/yVbFv2uoio2oGLyAcub7QqG/EU/OMtUhPudBD9sMLZbvDY7DlDZLtPANYhHGpUSDCfrZXaOlgY6U4irRloI0/u0ZvZLJ9AoGAYp/lXzdSpF/xk7Lgq196CKaNKzgFVzCAITqRnxd0a3QAkQXdXIKzy3X3+GcXhDW4DbZ5N48snP0TB0+otFLqDaUC64Lk1gP6I53SGRgkLArPfsZjSNwQOrBeysOdsf/cUc4LYi5rRxaB9ZyKCL0YVpxXycEuQyHpRBeEBE/FYCw=
b3199ac7-91e8-4181-9f8d-c05b234b3c92	d3ee6da5-034b-4a8c-bff4-5ea111b742b9	priority	100
b9a51052-f285-4704-adcc-c7548f736459	d3ee6da5-034b-4a8c-bff4-5ea111b742b9	certificate	MIICmzCCAYMCBgGV87xPBzANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUwNDAxMjM0MDU5WhcNMzUwNDAxMjM0MjM5WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC8p1QyH60DfUboufIKrBPMOWC0JBhPlcdgynil4y3pzcTmf7Cg6kuXxWIK8uVeArqp/IY/QCt8mYoph6nB9dB/s0K9rogxwmckRHjwwG3Y3FctVZg9WSuoex3uQuJDZ9dL+N5NXLyt9tgDOQ7YzAhlFMugUWXZuDP/bhcOKRISHLLA3pyYFo+qMomoeWTgabu+mP5Ik1s4PU5791Rb2qmv8GXqljM4Tqdm4ytNDJWZ0O16C+KMDvu4aFFdxckq976p+RCkKL/g30JKk9QeIB7A4ZDeD+CZ5taBLuMPKq9JKLmTFVxQC8fUMpUFOVIV2pItEe580yXX7gVRzWNRKfj3AgMBAAEwDQYJKoZIhvcNAQELBQADggEBAFahTvBACdh8drLsT7MTAGcExgpxg/82L/rJ270qKk4mJMvC1KMiCQxnkcvvv6va7DJkK0H2u40kKRZymapJed6tCU+SuGjXZcvLppbfw4kNga4Rk3kHRY+fXE9WJLOhmlWaeHIfUHdEkP/zYbetGP2qTOKuP1TPExCP4nhxLRtUKCW7Ju4utr51CWUTX9WFWD55lp7AXmNCeBnEh/IJoFu3h097wBHnZJCyJCQNfX8oQl1bsw3USKjOyQzXP1JVrRpz7hcRjR4vcHFNAkRUdyW/oi+EOxv2LQhyGaZwYdGrlSDxozDv5eoPw1oHgf+XMHULE0HWLcCDB8YjHM/Relc=
c9d80ba8-84a8-4fce-b1ed-93a21ad22828	990d47fd-570b-4760-b295-24bf469239e7	priority	100
7b384e14-47f0-44a8-8c69-57920be10382	990d47fd-570b-4760-b295-24bf469239e7	secret	lxrag6_ZS8cEV3eQUqVReA
968cf1b8-26a7-48b4-a599-4a4e75262902	990d47fd-570b-4760-b295-24bf469239e7	kid	c7a1576b-b3c7-489c-b72d-5e5a343c231c
aa74fe8d-3ff7-43c9-aefc-656ae5af2541	45e2f017-750d-4177-8697-a4ce347262cd	kid	0062aa5c-0019-4125-bff2-7f5351290d85
1dd59924-5698-408c-9fc3-2061e5ab10fa	45e2f017-750d-4177-8697-a4ce347262cd	algorithm	HS512
f1fba292-eb13-40d3-bdd1-06db54cb48fe	45e2f017-750d-4177-8697-a4ce347262cd	priority	100
4312371d-b163-4524-bbda-c47103c1e55e	45e2f017-750d-4177-8697-a4ce347262cd	secret	kaOlVoz_C8iYBl6R8_kw6kKPVw1tkzSB7lfi68SOu_5l6Qu0YkCmlu6k0_JF_dMPfWU1uouc0T2lf57zQRAwKEV-lR17h5YPHSvcyEb7ycluMhA3JSt-vj_Vcy74oTLMPuV_aH5coMS_FAJZ0nWV7pliR1TJNBCf0lBe6FeU0qU
21d2f903-600d-40c4-a90f-f82878a62874	93bc550e-9cf6-40dd-8de7-738da371614c	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}]}
7d910ba4-2c56-4b33-b2d7-ebcff0e29ba8	5c0bcc8b-151d-48dd-8274-04b269a87d3c	secret	ffsHR-iLSIN3OgmaJXUKhQ
a99aadb8-360f-458c-b327-8009aec8f73a	5c0bcc8b-151d-48dd-8274-04b269a87d3c	priority	100
0e027684-426f-447f-9607-f1e91b184773	5c0bcc8b-151d-48dd-8274-04b269a87d3c	kid	9fe9f2c7-a54d-4045-91b0-767c867ba160
6d94b840-8aba-4411-b089-823879567efb	eba06685-4c0b-41e8-a2f6-34df4efd8b98	algorithm	RSA-OAEP
ee7d00ea-c433-4488-9797-3aca6b48f08c	eba06685-4c0b-41e8-a2f6-34df4efd8b98	keyUse	ENC
cefe6055-9ea7-4739-b2c6-ebbaaf45bb2a	eba06685-4c0b-41e8-a2f6-34df4efd8b98	priority	100
893c364d-0182-49e8-be7c-f2561315e127	eba06685-4c0b-41e8-a2f6-34df4efd8b98	privateKey	MIIEogIBAAKCAQEAqJF+9N3rtxb0vY7YAHvGr/ubVN9NOE+8uJgG0yKhZfADcAMCCuL6zyhhzEWACB8kf34whWXeE0/1qoJ/cNqCEBOnMV26l+OsaTkghjKJN4XBf5K+LaBzQSx9hvwJoPBOC8ZNtNijOOz9MnWuqBCBjqGlbvpSjYzwX5QYzVLe17aYwKkMsL5LOCyaeFEHOMzOEU1wYJWRFGJ0nfbq+C4O/+D4N2nU4oPFUn88HxioS9Jsm9ffRDJUgIx0OS6qjFiygWMCAU2z5btSCeGQ1l7zv48FwbbXHgSc0xAdFEEBd0z9XOq6yX/VgTf/XHsuh5YGXgaGLqcghsGIbgp+B0rSUwIDAQABAoIBACiUhiyqtBEqjJaJqcRMB+PbvWQsManJwFPr/VCcuKASrLEteDNouxpdzVVgsdbCsIWkukeS42hgynJW4hkn8UGviYNf3gisvZfDMeo8hj4AjDmK+Q+A3d4luL5jNGozD4bUIWbU9E5C9x1LqVU6TAYrMelKh88dy8wmmeXr+kuRfBs8HOMbP6SixHmFup3EzLGyaiza0UhrR4EwXM8obxFRFeEoW11ygEi8A3WkMmcODN/y+NxA/mdpuWUExPab0eXW5QDcIinlitJ+loViqw46YJ5RPa+5/QBbxYeNA8OJT2W3xv6m++vvbJgfCak8MzYBOuYGNyCJID3bdrPdJVECgYEA5nv+r3Kfqj4PYgs7QGPvd2bUoMa2REWRQGYTMwOvSeYNCLYI1wNE7aP/C6roa0HT7zwdD6mA2P8QwcbFZw9fT5lbkNLFH7IJ8g/J5TYa3acxuB5HGWzPSQnVaA2FcTjY0t/9L2v6e90wsgt1h+X5mzGRht1tAGYW1Z3qOPadwzsCgYEAuzrHu0kvBXOC9ONe0xckRZJbq7ylIIXa9QatgczJLe0GZU2lZIWZIRGWygYVVbLeWMzaY+AL1dBfZtp7qhR7NB2cdzSmB2xgJr8nBSVqKXRkZYc82w/kp8Ax7jwG2QJiI8lAvZQKhm0dFcxIKlnL208sgB3Jzjz+WREAxAeLC8kCgYBIlLeJTJFXLR/vAhZwmofok+tVjf4L1dR98ScOo5RpsxZbreduvkrQgxpn9DQowpwY9Fc6fWhj7T67pvq3D7I2ANdC7fzBlHFpVut/UOB4+JPBpVdCfG9yUrRvhgKFux8cmQjEDD7fDrKs/srONu+5nYx0afpPa9a5Anel5JOdzQKBgBH4OEc/ZOXvCjiawfUcmXyb6XR4LJkMf9FYjLqSfxSLVTvP0fnt4J6N450MLGwHONPpBWTkkf45e46RlaDjSlfcJ7JBOVYpDqlpW0NhLelApIoiCrMzuUxoY+JrnHSjh+vLWw1W8hOo0UvQSXTXHXu1A55gPYgvznGZ8ireVngRAoGAJj89VaLXPTYwHpfitJrl9WQ348gbKr9NfUFsKIGqTJBD1ShV/x7SxbNh8W6RvYenUiCAEqyHtOSBWqbhQ+m6FHNxHa+SnDsRPkGSiXYSj88NV/mLWs3UGtaOWvFJFVtsO8FyHb6zoFd7c9LnJaB3lDE5xfBiTMwWlfM2aFry+9Y=
1c905be8-4e4b-44b9-ab5d-982adf03760e	eba06685-4c0b-41e8-a2f6-34df4efd8b98	certificate	MIIClzCCAX8CBgGV9tnufDANBgkqhkiG9w0BAQsFADAPMQ0wCwYDVQQDDAR0ZXN0MB4XDTI1MDQwMjE0MTIxMloXDTM1MDQwMjE0MTM1MlowDzENMAsGA1UEAwwEdGVzdDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKiRfvTd67cW9L2O2AB7xq/7m1TfTThPvLiYBtMioWXwA3ADAgri+s8oYcxFgAgfJH9+MIVl3hNP9aqCf3DaghATpzFdupfjrGk5IIYyiTeFwX+Svi2gc0EsfYb8CaDwTgvGTbTYozjs/TJ1rqgQgY6hpW76Uo2M8F+UGM1S3te2mMCpDLC+SzgsmnhRBzjMzhFNcGCVkRRidJ326vguDv/g+Ddp1OKDxVJ/PB8YqEvSbJvX30QyVICMdDkuqoxYsoFjAgFNs+W7UgnhkNZe87+PBcG21x4EnNMQHRRBAXdM/Vzqusl/1YE3/1x7LoeWBl4Ghi6nIIbBiG4KfgdK0lMCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAksv4lFJ2EjU6vq5sn5/jlNODQ5UyJi84kK25HxIEZMaU4VcCRaT6kTvLUE1I5jROfwH9Btsl5rUDruFwr+ZhNaN5UmvvqRSqErWCUw1r9b/Pxk0242P31YrLpp2UK5HJ/bZSr1n0HiX6vxBkoQJ4sj5GLVqmRpnlxEnjqhDG7PffZrk3zg6EXegwQwePV4eKT4NcvP88k2jjfzE7To8a3gNjGFoQIfwuU3C7pKw4P62bsqnFU3osRoBSF17n8S5YXXc4quZK1DKMxaoBUY8Ia8CakA7K/N+C0otG5K36NuZRzMsbuNPQ/3UVrjdslKHO2C15B0SH4xHgmq5xOWKvxA==
e6a60e4e-4f5c-445c-aba2-a4c215905c1b	4a42119b-8b2e-4284-b5a5-6a4657e9b722	keyUse	SIG
9fd85d74-d538-4ad7-80f0-1e89a017e7de	4a42119b-8b2e-4284-b5a5-6a4657e9b722	priority	100
2bbe98e6-8dca-43ec-bc4c-2ef0a93575df	4a42119b-8b2e-4284-b5a5-6a4657e9b722	privateKey	MIIEpAIBAAKCAQEAjLOkDZIaoSFD16maDwKJqsDhxigmWzNv7sVBdjGBM9FNzdr5CGnZBlNdWRXT1k7Pv/udST06X5BjbZnRuImC01Ni0mfZ++28GypdA0ijMDN4vXZhAB3CTpf4OmDYH4zSWka9bRsNFrTPhZLuu0oOCBAA8rRD3ddjiYqP7EIJGVnbHFdka3gpM3N4+J7CgtNLsfNREUVIoysElk7/o6GZWZtk84gF769Vxe4rYxE3QGh1uGM7TVWqR+UeO2ZC3D1qJvWH97lULMO/e9XoBzs18bTfrD4c2RV54SjuXoCNnYTYyVOz/z/3aEvYpO9DiMI1nhC0fzJT50N3mNvNFiDJIwIDAQABAoIBAArDdVHacvIPnuaBIXlzer+WyM7FZIXGjhIIggT+LYGeyeJtFW741fLfbr0xZ8a1ubvYjkQ7jFsiKxEH2tzQnDL5Zo5tBmZ43dKAL6RgKqe10E9CHpKJNEOZ6ZHhtbbYKYFhdv1BPAOYKmXwAxZNyHwCaWgntSdj4kfz0yXCOXr4YTlv6dshheLjCaQWZOeT9LNGx1ceE+oAUsTlzaaHdiI4HYLCCkBg08WXCNHrRUj7LeLtmSqNJPx5AK3ZJ7uS/9DZ13D/7AJ5Ygs9HUCIxAhcMtx301+e8eXDnAYE7cYnfCdTgsxz00YEA0BDQQOgWXOwH3NhEq8dqx32rbfCOZECgYEAwRuDp7FuXBndWDC4K7nJaVfm6edNeINWAXm2pmBD0bpqG/j1JyEGR6OsMaPl5yKxI6XkhIe074qTvtFLqfvf0YUvszkoD5fyyump8i5/BG9wwBHI2UkbjsrHPiuxGKpEGSKUq6x2sskWt9o6vjIQatTSFVF2eGz+NqI/Tdx1HzECgYEAuobBi0vaNdvHlI7PvTYDJ8JEcA3WQ3g76gDdW1BuuV3E62NtXV5yg2BvjZl7D8PSslgrh2d6nBIbavZNrkJ+xEWsl2a/YGPT3W8B4rddeD++8S3qfDFrH0MjH1qqs+FKloFCGkYKNSH2ia9V6gOFcNAOvnQ/2YcRsdRVYjml4JMCgYEApIXomUrWF6oBp0162+Yh75pwpf/nRTHAaOll8EI8Bceo98QYOgos64RLBM/64/3upcyE8VUdlqieUAjJSj3J5xxuE2gy9XYj6TVDEY8DsKexjDKayGU9EV86eYGIFNebxT5tJAZ/6rrgnCtVuQ22Zw6DHp6VLOzPeYSqIpAdSUECgYAUn32atyJDPi+M31VcqDIlHTeP5BfCkfKd5saSqAv19sYk+HNJFX43xFvRHh0bGx2almEJsYk+5Emfw+fG0pdNgB6bBsM2FxN/shxVQszU1Md5xwfb/2LGrBegCdhB1zD1/wid+wx5321wv7ASFZ2VYYufxx6gIGz2anGeUJ1kfQKBgQCl1NiCFlWENVwkSqmyjcom4SgrovIbiw7AGvLh4aocJ9F4N+5xIRCsWTiZfhqEyLXGCTa2fTh3aubFwd6/V4hD4qxksVFch4AGKY7tCrqGuwAIPHOJQJV0ktsR8HWm+T0J9b3OzBX1HtJNwhZ2UtAcTsTHG6DnxMvSrtMmM20cKA==
d1974ae3-61c7-46fe-b619-6db6bd9678ab	4a42119b-8b2e-4284-b5a5-6a4657e9b722	certificate	MIIClzCCAX8CBgGV9tnt4zANBgkqhkiG9w0BAQsFADAPMQ0wCwYDVQQDDAR0ZXN0MB4XDTI1MDQwMjE0MTIxMloXDTM1MDQwMjE0MTM1MlowDzENMAsGA1UEAwwEdGVzdDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAIyzpA2SGqEhQ9epmg8CiarA4cYoJlszb+7FQXYxgTPRTc3a+Qhp2QZTXVkV09ZOz7/7nUk9Ol+QY22Z0biJgtNTYtJn2fvtvBsqXQNIozAzeL12YQAdwk6X+Dpg2B+M0lpGvW0bDRa0z4WS7rtKDggQAPK0Q93XY4mKj+xCCRlZ2xxXZGt4KTNzePiewoLTS7HzURFFSKMrBJZO/6OhmVmbZPOIBe+vVcXuK2MRN0BodbhjO01VqkflHjtmQtw9aib1h/e5VCzDv3vV6Ac7NfG036w+HNkVeeEo7l6AjZ2E2MlTs/8/92hL2KTvQ4jCNZ4QtH8yU+dDd5jbzRYgySMCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAJ9wKn8Cm/3CLd6yYgO6i+UnZvAEM+t92XUthAxcP9iuRLjZj6dBM604Pwu6FC4f+UttFTfO1yAd40s3wxr5Ys+KUCul/YkBDDcLjFXb3g3edUwzDDAKP9fXTJwhlKI9f4/Vb4PIaIYb+9YlnzJtRAuA9DFy4BWMfbTYSe4HN+ODshO3l9D/Kknlnf+I6ae+Ag9PMQ02Fb912UoLRO6AntpoU9ai0ixXyf2Ls0nkCz3Hh6WGxOlyswR74eBCR8yIHTpGB3UwwhL2iY7GmiFHBmZz/GrosNtzSrS164lS7iNr8Tf3qiF+4jBnTAnMypa9GODLoJBooDzQ5FYqeYiR9wQ==
4650435d-231d-41cb-b8a3-41e7aca24be7	7312581e-95bc-4ef0-a416-e9902f4729b9	kid	a9962ce9-2c8f-4953-9ad6-b50ebc4c90a3
6e309cd9-5cc9-429e-9d62-85bbf7c08148	7312581e-95bc-4ef0-a416-e9902f4729b9	secret	WQoKnfO-bxCGQki5icgj1M47wC5nzBJYr2zcHEkJlR61Ox2C2XN2OOza-2TDZjdpDG3SGbLMo2_mARFBaGEC2covNOteWqWJtBwoVUwbKjeYDdeu2YCZ-bOMgLnDIWJahbY1Mxg2HrEtyCfCgwGWHvoJSiDcL14y9HFIUPHu6kI
5a76d518-4a59-4077-9bcf-d9fbaa24335e	7312581e-95bc-4ef0-a416-e9902f4729b9	priority	100
cdf0dadb-d264-43d6-8f33-2e85dd2b76ed	7312581e-95bc-4ef0-a416-e9902f4729b9	algorithm	HS512
97fd37a9-7a0b-4d1c-b3b7-9befa96d3a9c	51c90634-af87-4813-bd52-3386af95062f	allow-default-scopes	true
f15b7a1d-2109-4f79-80ff-fa09cf30555c	a3c50668-06b4-497d-8db6-9abc1102652a	max-clients	200
c9291670-f2e0-4e4a-9668-52941a59a42c	248c1a02-b8b7-47c0-829f-fa4286ad9380	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
f1fe5c8b-e7f2-4e76-afa0-0dca658c2017	248c1a02-b8b7-47c0-829f-fa4286ad9380	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
df69bb75-446b-4686-adce-b1f678f10439	248c1a02-b8b7-47c0-829f-fa4286ad9380	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
dde9c398-29d7-472d-ab6e-86464a796539	248c1a02-b8b7-47c0-829f-fa4286ad9380	allowed-protocol-mapper-types	oidc-address-mapper
0e0ae38f-e56e-4ad4-a01f-0678736e6ad6	248c1a02-b8b7-47c0-829f-fa4286ad9380	allowed-protocol-mapper-types	oidc-full-name-mapper
00b87daa-8e34-4aff-8f14-f4972e3324ee	248c1a02-b8b7-47c0-829f-fa4286ad9380	allowed-protocol-mapper-types	saml-user-property-mapper
563de0a9-685e-4c92-b1e9-f1787e3d4cf7	248c1a02-b8b7-47c0-829f-fa4286ad9380	allowed-protocol-mapper-types	saml-role-list-mapper
793f8f57-25b3-4336-b13f-a39540af9dd9	248c1a02-b8b7-47c0-829f-fa4286ad9380	allowed-protocol-mapper-types	saml-user-attribute-mapper
f9b00b83-c335-4a40-b23f-25816fd889e5	152ee543-9228-4d35-b4fd-810730090680	allowed-protocol-mapper-types	oidc-full-name-mapper
17303306-2023-4388-b365-e63864adfeae	152ee543-9228-4d35-b4fd-810730090680	allowed-protocol-mapper-types	saml-role-list-mapper
d6d1b233-ec45-4350-9894-a9c9eca53c20	152ee543-9228-4d35-b4fd-810730090680	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
dbb1a61f-6c80-40b2-b7e7-32e65850e1dc	152ee543-9228-4d35-b4fd-810730090680	allowed-protocol-mapper-types	saml-user-attribute-mapper
6b4f1d11-60c2-46ef-a88a-34cb403714e5	152ee543-9228-4d35-b4fd-810730090680	allowed-protocol-mapper-types	saml-user-property-mapper
28bc70eb-9e07-4ca4-8a3e-c75a9d1a84e0	152ee543-9228-4d35-b4fd-810730090680	allowed-protocol-mapper-types	oidc-address-mapper
db7bc6d1-bd22-45f8-8906-79412bca4886	152ee543-9228-4d35-b4fd-810730090680	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
072c8fdd-e5fa-4f06-8a3f-2c68ba2af342	152ee543-9228-4d35-b4fd-810730090680	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
52ca5c86-4b20-4497-878f-9e418f6c9db1	3005daeb-7d60-4830-86ee-b092ffcaacae	allow-default-scopes	true
c1cda2da-c110-4326-bc37-8810cb344bd3	a6226255-8139-4f7d-aea7-0c2773f254ac	host-sending-registration-request-must-match	true
0cff586e-b459-48e3-b861-439580935de8	a6226255-8139-4f7d-aea7-0c2773f254ac	client-uris-must-match	true
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.composite_role (composite, child_role) FROM stdin;
aae70eac-253c-46e5-861a-a64a163947dc	5bcb517f-e149-4fb0-87a4-8b8b864a77fc
aae70eac-253c-46e5-861a-a64a163947dc	6edfb956-2d1f-4990-9a23-4849ceb90bc0
aae70eac-253c-46e5-861a-a64a163947dc	bd64d826-0214-491f-a522-a91d706dae2e
aae70eac-253c-46e5-861a-a64a163947dc	63b681f3-ec37-464a-ac7b-889e13f4a6ba
aae70eac-253c-46e5-861a-a64a163947dc	cf357c1b-ad24-4643-9177-eb66416366fe
aae70eac-253c-46e5-861a-a64a163947dc	4dc4d419-5fe0-484e-a8a7-4ca306706435
aae70eac-253c-46e5-861a-a64a163947dc	052cddc5-33b7-4f80-b42d-0613687b3671
aae70eac-253c-46e5-861a-a64a163947dc	3fb1852b-18af-4ee1-829d-c73e3d885fc9
aae70eac-253c-46e5-861a-a64a163947dc	2e877bd2-e7f4-46db-8703-0b599d7d7a92
aae70eac-253c-46e5-861a-a64a163947dc	4ce7fae4-2d2e-4097-abb6-08e1ab93ca1b
aae70eac-253c-46e5-861a-a64a163947dc	6b683b36-9d35-410a-9d8c-7adab59681a2
aae70eac-253c-46e5-861a-a64a163947dc	a8555301-b568-406f-8ef3-5c2f9429994d
aae70eac-253c-46e5-861a-a64a163947dc	4b101ff6-ef77-47a7-acc9-a667198c60c4
aae70eac-253c-46e5-861a-a64a163947dc	dc061fd1-4cb9-41a8-8e38-56fbe3c91d06
aae70eac-253c-46e5-861a-a64a163947dc	66086df4-b3cc-49d5-a52f-9f277a3f6d30
aae70eac-253c-46e5-861a-a64a163947dc	27632828-c556-4bc0-89b3-0cea75291675
aae70eac-253c-46e5-861a-a64a163947dc	f39781ec-b5ce-48d7-9029-bde94caf15bd
aae70eac-253c-46e5-861a-a64a163947dc	92f0f051-57fb-4c59-a13b-0cd67fc179e7
63b681f3-ec37-464a-ac7b-889e13f4a6ba	66086df4-b3cc-49d5-a52f-9f277a3f6d30
63b681f3-ec37-464a-ac7b-889e13f4a6ba	92f0f051-57fb-4c59-a13b-0cd67fc179e7
cf357c1b-ad24-4643-9177-eb66416366fe	27632828-c556-4bc0-89b3-0cea75291675
f358359a-8685-476e-a74e-0a0377ff1d90	349d671c-628f-4114-8c90-59c19961449a
f358359a-8685-476e-a74e-0a0377ff1d90	c6cb6148-7b94-42b1-9302-4191f23e742d
c6cb6148-7b94-42b1-9302-4191f23e742d	b49f4c56-6368-4174-a1c0-f9ba4032a157
d76bb048-3e95-449f-9756-d9f19c1eb8ac	0b85ec03-1d7e-4be6-a024-29f1bdf43045
aae70eac-253c-46e5-861a-a64a163947dc	ac53543a-5c2a-413a-a5e9-e8b19c66b543
f358359a-8685-476e-a74e-0a0377ff1d90	196ca212-4cec-4659-bda1-255e1ad196b6
f358359a-8685-476e-a74e-0a0377ff1d90	dee247b6-bfc5-4a21-9ca4-a357c72cde54
aae70eac-253c-46e5-861a-a64a163947dc	1958d560-94df-4dac-922e-65583fd875ca
aae70eac-253c-46e5-861a-a64a163947dc	bfae202e-6562-4345-8ac4-b92908ab6bc8
aae70eac-253c-46e5-861a-a64a163947dc	a368ed7c-56ed-4b50-957a-dcba8d480f34
aae70eac-253c-46e5-861a-a64a163947dc	fc87848e-47f5-4363-be1a-6f93236375be
aae70eac-253c-46e5-861a-a64a163947dc	94117808-2068-4389-ba04-fbf55f43f9d6
aae70eac-253c-46e5-861a-a64a163947dc	a8c24bbe-f0a6-4f5b-9d70-e41d4e660927
aae70eac-253c-46e5-861a-a64a163947dc	6ec88491-be49-4f04-89f0-a2a3113ab602
aae70eac-253c-46e5-861a-a64a163947dc	4c917e01-d2f3-4473-af48-ddb8f38f1241
aae70eac-253c-46e5-861a-a64a163947dc	10032791-ab1d-445e-af8b-7e8fc63746dc
aae70eac-253c-46e5-861a-a64a163947dc	a2be13bc-f3cb-4ad4-bb33-b7cc94dc1ef6
aae70eac-253c-46e5-861a-a64a163947dc	ea1fc714-01dd-429e-8409-d644bb1d765f
aae70eac-253c-46e5-861a-a64a163947dc	ed0f8ab6-d884-4e23-82aa-ffc59c6151be
aae70eac-253c-46e5-861a-a64a163947dc	e3ddb173-90b1-4c2c-8956-cdef61946fb5
aae70eac-253c-46e5-861a-a64a163947dc	0a9c7768-5f06-41a4-8958-992ec72aa16a
aae70eac-253c-46e5-861a-a64a163947dc	424123bc-667d-4d3d-8560-7052d9a22352
aae70eac-253c-46e5-861a-a64a163947dc	7f715848-9f30-4611-b3c7-92e2c6ef23c6
aae70eac-253c-46e5-861a-a64a163947dc	63f7dc38-0516-4c7d-b0a1-1c2429ae994c
a368ed7c-56ed-4b50-957a-dcba8d480f34	63f7dc38-0516-4c7d-b0a1-1c2429ae994c
a368ed7c-56ed-4b50-957a-dcba8d480f34	0a9c7768-5f06-41a4-8958-992ec72aa16a
fc87848e-47f5-4363-be1a-6f93236375be	424123bc-667d-4d3d-8560-7052d9a22352
261120ed-ecda-4dc0-8886-756007628a2e	8f711594-27f4-4ed5-adfe-e569c4786186
261120ed-ecda-4dc0-8886-756007628a2e	0926c9dc-c619-4344-b1cc-49c8f1be1aeb
261120ed-ecda-4dc0-8886-756007628a2e	cd21d870-d152-4006-9d9b-796e39bd3265
261120ed-ecda-4dc0-8886-756007628a2e	e46ba619-1d4a-4447-b037-ee95c72e5be7
261120ed-ecda-4dc0-8886-756007628a2e	4319b703-8946-4b25-81d8-0cb7a6def9b9
261120ed-ecda-4dc0-8886-756007628a2e	0daa9904-4613-4534-aeae-45cfe2fec85b
261120ed-ecda-4dc0-8886-756007628a2e	51d184a3-7c57-428a-a790-2d3c243c75cf
261120ed-ecda-4dc0-8886-756007628a2e	a981dc53-8fe4-4133-b2d1-5a9688a39b7b
261120ed-ecda-4dc0-8886-756007628a2e	1ff41b1d-59a0-4bd6-b461-510dd205b487
261120ed-ecda-4dc0-8886-756007628a2e	c7ad4b1f-ce49-4c10-93d5-293b1b8edcf3
261120ed-ecda-4dc0-8886-756007628a2e	949c2cff-bb32-4b64-b944-7932b1d90074
261120ed-ecda-4dc0-8886-756007628a2e	3ba256db-d208-48e8-9e71-9e9196cb28bf
261120ed-ecda-4dc0-8886-756007628a2e	a4f6be3f-4e85-45c0-b9ad-39f4ae2b3a17
261120ed-ecda-4dc0-8886-756007628a2e	af64b97d-ff4a-4839-84f7-384eab5e8a62
261120ed-ecda-4dc0-8886-756007628a2e	9ff64081-f6fd-4641-8b42-b9f6fc1e7552
261120ed-ecda-4dc0-8886-756007628a2e	b68c8f60-124d-400f-9487-1cbddd256dea
261120ed-ecda-4dc0-8886-756007628a2e	33af9bb7-c326-43c2-90a9-738883d31f8e
a47668a7-90ba-4d44-96c4-93930acdfabc	5566ff9e-93fd-4202-a52b-142927d14966
cd21d870-d152-4006-9d9b-796e39bd3265	33af9bb7-c326-43c2-90a9-738883d31f8e
cd21d870-d152-4006-9d9b-796e39bd3265	af64b97d-ff4a-4839-84f7-384eab5e8a62
e46ba619-1d4a-4447-b037-ee95c72e5be7	9ff64081-f6fd-4641-8b42-b9f6fc1e7552
a47668a7-90ba-4d44-96c4-93930acdfabc	f7ecb692-039e-4a6a-8349-a700e511d8f5
f7ecb692-039e-4a6a-8349-a700e511d8f5	edb6a64b-0dea-42b8-898e-7d86cdf36263
8d3b45cd-a682-4f75-b886-532cdfe4e575	44facf02-2abf-48ac-a488-abd5c035f19c
aae70eac-253c-46e5-861a-a64a163947dc	3c0414c6-9bc3-487f-bf9f-8e33e747ffb2
261120ed-ecda-4dc0-8886-756007628a2e	1f161cf9-4c6d-4bef-9373-93df71186e5b
a47668a7-90ba-4d44-96c4-93930acdfabc	1f7f6f1a-33a6-4feb-812c-9a8fae7bf89c
a47668a7-90ba-4d44-96c4-93930acdfabc	20974b02-dc6f-4ef5-8d6b-22e1284b1814
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
3189a717-ab08-4408-aa39-b1c14e6a4307	\N	password	c0ff7eb4-4791-4ed3-803c-20f007adc569	1743550959965	\N	{"value":"NuKgfXjHiuc8BNLzN1wW+o5oJEuOv8becw3Vp8z+3wk=","salt":"VDKywQCR/yMLFvuAUeZDKA==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
2aa07b6b-acc6-4493-9991-543d39d38dce	\N	password	5f40838c-6e18-4a41-b816-e29a9e019286	1743551260809	My password	{"value":"WzyUQp5rxqNvBLrecyzUnKF9l4owAD/aCDdZW3zMrA8=","salt":"HysJsbp7PmDmB0sRW+OOIg==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2025-04-01 23:42:20.001764	1	EXECUTED	9:6f1016664e21e16d26517a4418f5e3df	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.29.1	\N	\N	3550939158
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2025-04-01 23:42:20.041189	2	MARK_RAN	9:828775b1596a07d1200ba1d49e5e3941	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.29.1	\N	\N	3550939158
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2025-04-01 23:42:20.167726	3	EXECUTED	9:5f090e44a7d595883c1fb61f4b41fd38	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.29.1	\N	\N	3550939158
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2025-04-01 23:42:20.185775	4	EXECUTED	9:c07e577387a3d2c04d1adc9aaad8730e	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	3550939158
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2025-04-01 23:42:20.460749	5	EXECUTED	9:b68ce996c655922dbcd2fe6b6ae72686	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.29.1	\N	\N	3550939158
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2025-04-01 23:42:20.474459	6	MARK_RAN	9:543b5c9989f024fe35c6f6c5a97de88e	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.29.1	\N	\N	3550939158
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2025-04-01 23:42:20.754019	7	EXECUTED	9:765afebbe21cf5bbca048e632df38336	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.29.1	\N	\N	3550939158
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2025-04-01 23:42:20.767912	8	MARK_RAN	9:db4a145ba11a6fdaefb397f6dbf829a1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.29.1	\N	\N	3550939158
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2025-04-01 23:42:20.80044	9	EXECUTED	9:9d05c7be10cdb873f8bcb41bc3a8ab23	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.29.1	\N	\N	3550939158
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2025-04-01 23:42:21.063639	10	EXECUTED	9:18593702353128d53111f9b1ff0b82b8	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.29.1	\N	\N	3550939158
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2025-04-01 23:42:21.248424	11	EXECUTED	9:6122efe5f090e41a85c0f1c9e52cbb62	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	3550939158
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2025-04-01 23:42:21.261896	12	MARK_RAN	9:e1ff28bf7568451453f844c5d54bb0b5	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	3550939158
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2025-04-01 23:42:21.369667	13	EXECUTED	9:7af32cd8957fbc069f796b61217483fd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	3550939158
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-04-01 23:42:21.427877	14	EXECUTED	9:6005e15e84714cd83226bf7879f54190	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.29.1	\N	\N	3550939158
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-04-01 23:42:21.435997	15	MARK_RAN	9:bf656f5a2b055d07f314431cae76f06c	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	3550939158
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-04-01 23:42:21.448247	16	MARK_RAN	9:f8dadc9284440469dcf71e25ca6ab99b	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.29.1	\N	\N	3550939158
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-04-01 23:42:21.464879	17	EXECUTED	9:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.29.1	\N	\N	3550939158
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2025-04-01 23:42:21.593648	18	EXECUTED	9:3368ff0be4c2855ee2dd9ca813b38d8e	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.29.1	\N	\N	3550939158
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2025-04-01 23:42:21.708569	19	EXECUTED	9:8ac2fb5dd030b24c0570a763ed75ed20	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.29.1	\N	\N	3550939158
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2025-04-01 23:42:21.729195	20	EXECUTED	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.29.1	\N	\N	3550939158
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2025-04-01 23:42:21.737137	21	MARK_RAN	9:831e82914316dc8a57dc09d755f23c51	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.29.1	\N	\N	3550939158
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2025-04-01 23:42:21.747746	22	MARK_RAN	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.29.1	\N	\N	3550939158
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2025-04-01 23:42:22.011801	23	EXECUTED	9:bc3d0f9e823a69dc21e23e94c7a94bb1	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.29.1	\N	\N	3550939158
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2025-04-01 23:42:22.043152	24	EXECUTED	9:c9999da42f543575ab790e76439a2679	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.29.1	\N	\N	3550939158
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2025-04-01 23:42:22.051275	25	MARK_RAN	9:0d6c65c6f58732d81569e77b10ba301d	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.29.1	\N	\N	3550939158
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2025-04-01 23:42:23.072957	26	EXECUTED	9:fc576660fc016ae53d2d4778d84d86d0	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.29.1	\N	\N	3550939158
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2025-04-01 23:42:23.211942	27	EXECUTED	9:43ed6b0da89ff77206289e87eaa9c024	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.29.1	\N	\N	3550939158
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2025-04-01 23:42:23.226598	28	EXECUTED	9:44bae577f551b3738740281eceb4ea70	update tableName=RESOURCE_SERVER_POLICY		\N	4.29.1	\N	\N	3550939158
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2025-04-01 23:42:23.331969	29	EXECUTED	9:bd88e1f833df0420b01e114533aee5e8	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.29.1	\N	\N	3550939158
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2025-04-01 23:42:23.366719	30	EXECUTED	9:a7022af5267f019d020edfe316ef4371	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.29.1	\N	\N	3550939158
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2025-04-01 23:42:23.428995	31	EXECUTED	9:fc155c394040654d6a79227e56f5e25a	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.29.1	\N	\N	3550939158
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2025-04-01 23:42:23.452289	32	EXECUTED	9:eac4ffb2a14795e5dc7b426063e54d88	customChange		\N	4.29.1	\N	\N	3550939158
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-04-01 23:42:23.480225	33	EXECUTED	9:54937c05672568c4c64fc9524c1e9462	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	3550939158
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-04-01 23:42:23.488509	34	MARK_RAN	9:3a32bace77c84d7678d035a7f5a8084e	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.29.1	\N	\N	3550939158
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-04-01 23:42:23.577014	35	EXECUTED	9:33d72168746f81f98ae3a1e8e0ca3554	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.29.1	\N	\N	3550939158
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2025-04-01 23:42:23.596756	36	EXECUTED	9:61b6d3d7a4c0e0024b0c839da283da0c	addColumn tableName=REALM		\N	4.29.1	\N	\N	3550939158
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-04-01 23:42:23.612913	37	EXECUTED	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	3550939158
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2025-04-01 23:42:23.631138	38	EXECUTED	9:a2b870802540cb3faa72098db5388af3	addColumn tableName=FED_USER_CONSENT		\N	4.29.1	\N	\N	3550939158
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2025-04-01 23:42:23.646395	39	EXECUTED	9:132a67499ba24bcc54fb5cbdcfe7e4c0	addColumn tableName=IDENTITY_PROVIDER		\N	4.29.1	\N	\N	3550939158
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-04-01 23:42:23.652589	40	MARK_RAN	9:938f894c032f5430f2b0fafb1a243462	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.29.1	\N	\N	3550939158
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-04-01 23:42:23.661962	41	MARK_RAN	9:845c332ff1874dc5d35974b0babf3006	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.29.1	\N	\N	3550939158
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2025-04-01 23:42:23.687823	42	EXECUTED	9:fc86359c079781adc577c5a217e4d04c	customChange		\N	4.29.1	\N	\N	3550939158
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-04-01 23:42:27.483433	43	EXECUTED	9:59a64800e3c0d09b825f8a3b444fa8f4	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.29.1	\N	\N	3550939158
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2025-04-01 23:42:27.506757	44	EXECUTED	9:d48d6da5c6ccf667807f633fe489ce88	addColumn tableName=USER_ENTITY		\N	4.29.1	\N	\N	3550939158
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-04-01 23:42:27.533614	45	EXECUTED	9:dde36f7973e80d71fceee683bc5d2951	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.29.1	\N	\N	3550939158
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-04-01 23:42:27.561135	46	EXECUTED	9:b855e9b0a406b34fa323235a0cf4f640	customChange		\N	4.29.1	\N	\N	3550939158
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-04-01 23:42:27.568392	47	MARK_RAN	9:51abbacd7b416c50c4421a8cabf7927e	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.29.1	\N	\N	3550939158
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-04-01 23:42:27.922507	48	EXECUTED	9:bdc99e567b3398bac83263d375aad143	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.29.1	\N	\N	3550939158
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-04-01 23:42:27.940406	49	EXECUTED	9:d198654156881c46bfba39abd7769e69	addColumn tableName=REALM		\N	4.29.1	\N	\N	3550939158
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2025-04-01 23:42:28.021884	50	EXECUTED	9:cfdd8736332ccdd72c5256ccb42335db	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.29.1	\N	\N	3550939158
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2025-04-01 23:42:28.863718	51	EXECUTED	9:7c84de3d9bd84d7f077607c1a4dcb714	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.29.1	\N	\N	3550939158
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2025-04-01 23:42:28.879621	52	EXECUTED	9:5a6bb36cbefb6a9d6928452c0852af2d	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	3550939158
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2025-04-01 23:42:28.897548	53	EXECUTED	9:8f23e334dbc59f82e0a328373ca6ced0	update tableName=REALM		\N	4.29.1	\N	\N	3550939158
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2025-04-01 23:42:28.913066	54	EXECUTED	9:9156214268f09d970cdf0e1564d866af	update tableName=CLIENT		\N	4.29.1	\N	\N	3550939158
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-04-01 23:42:28.934299	55	EXECUTED	9:db806613b1ed154826c02610b7dbdf74	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.29.1	\N	\N	3550939158
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-04-01 23:42:28.951493	56	EXECUTED	9:229a041fb72d5beac76bb94a5fa709de	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.29.1	\N	\N	3550939158
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-04-01 23:42:29.089204	57	EXECUTED	9:079899dade9c1e683f26b2aa9ca6ff04	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.29.1	\N	\N	3550939158
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-04-01 23:42:30.09785	58	EXECUTED	9:139b79bcbbfe903bb1c2d2a4dbf001d9	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.29.1	\N	\N	3550939158
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2025-04-01 23:42:30.168233	59	EXECUTED	9:b55738ad889860c625ba2bf483495a04	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.29.1	\N	\N	3550939158
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2025-04-01 23:42:30.192287	60	EXECUTED	9:e0057eac39aa8fc8e09ac6cfa4ae15fe	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.29.1	\N	\N	3550939158
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2025-04-01 23:42:30.227145	61	EXECUTED	9:42a33806f3a0443fe0e7feeec821326c	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.29.1	\N	\N	3550939158
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2025-04-01 23:42:30.243408	62	EXECUTED	9:9968206fca46eecc1f51db9c024bfe56	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.29.1	\N	\N	3550939158
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2025-04-01 23:42:30.258439	63	EXECUTED	9:92143a6daea0a3f3b8f598c97ce55c3d	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.29.1	\N	\N	3550939158
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2025-04-01 23:42:30.273379	64	EXECUTED	9:82bab26a27195d889fb0429003b18f40	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.29.1	\N	\N	3550939158
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2025-04-01 23:42:30.287442	65	EXECUTED	9:e590c88ddc0b38b0ae4249bbfcb5abc3	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.29.1	\N	\N	3550939158
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2025-04-01 23:42:30.387618	66	EXECUTED	9:5c1f475536118dbdc38d5d7977950cc0	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.29.1	\N	\N	3550939158
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2025-04-01 23:42:30.478891	67	EXECUTED	9:e7c9f5f9c4d67ccbbcc215440c718a17	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.29.1	\N	\N	3550939158
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2025-04-01 23:42:30.499376	68	EXECUTED	9:88e0bfdda924690d6f4e430c53447dd5	addColumn tableName=REALM		\N	4.29.1	\N	\N	3550939158
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2025-04-01 23:42:30.611344	69	EXECUTED	9:f53177f137e1c46b6a88c59ec1cb5218	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.29.1	\N	\N	3550939158
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2025-04-01 23:42:30.634939	70	EXECUTED	9:a74d33da4dc42a37ec27121580d1459f	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.29.1	\N	\N	3550939158
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2025-04-01 23:42:30.651068	71	EXECUTED	9:fd4ade7b90c3b67fae0bfcfcb42dfb5f	addColumn tableName=RESOURCE_SERVER		\N	4.29.1	\N	\N	3550939158
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-04-01 23:42:30.68683	72	EXECUTED	9:aa072ad090bbba210d8f18781b8cebf4	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	3550939158
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-04-01 23:42:30.717367	73	EXECUTED	9:1ae6be29bab7c2aa376f6983b932be37	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	3550939158
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-04-01 23:42:30.72722	74	MARK_RAN	9:14706f286953fc9a25286dbd8fb30d97	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	3550939158
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-04-01 23:42:30.818959	75	EXECUTED	9:2b9cc12779be32c5b40e2e67711a218b	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.29.1	\N	\N	3550939158
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-04-01 23:42:30.921598	76	EXECUTED	9:91fa186ce7a5af127a2d7a91ee083cc5	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.29.1	\N	\N	3550939158
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-04-01 23:42:30.939228	77	EXECUTED	9:6335e5c94e83a2639ccd68dd24e2e5ad	addColumn tableName=CLIENT		\N	4.29.1	\N	\N	3550939158
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-04-01 23:42:30.945218	78	MARK_RAN	9:6bdb5658951e028bfe16fa0a8228b530	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.29.1	\N	\N	3550939158
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-04-01 23:42:30.998485	79	EXECUTED	9:d5bc15a64117ccad481ce8792d4c608f	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.29.1	\N	\N	3550939158
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-04-01 23:42:31.005442	80	MARK_RAN	9:077cba51999515f4d3e7ad5619ab592c	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.29.1	\N	\N	3550939158
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-04-01 23:42:31.100328	81	EXECUTED	9:be969f08a163bf47c6b9e9ead8ac2afb	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.29.1	\N	\N	3550939158
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-04-01 23:42:31.106902	82	MARK_RAN	9:6d3bb4408ba5a72f39bd8a0b301ec6e3	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	3550939158
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-04-01 23:42:31.127166	83	EXECUTED	9:966bda61e46bebf3cc39518fbed52fa7	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	3550939158
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-04-01 23:42:31.133683	84	MARK_RAN	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	3550939158
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-04-01 23:42:31.22858	85	EXECUTED	9:7d93d602352a30c0c317e6a609b56599	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	3550939158
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2025-04-01 23:42:31.246882	86	EXECUTED	9:71c5969e6cdd8d7b6f47cebc86d37627	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.29.1	\N	\N	3550939158
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2025-04-01 23:42:31.280317	87	EXECUTED	9:a9ba7d47f065f041b7da856a81762021	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.29.1	\N	\N	3550939158
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2025-04-01 23:42:31.299902	88	EXECUTED	9:fffabce2bc01e1a8f5110d5278500065	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.29.1	\N	\N	3550939158
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-04-01 23:42:31.328792	89	EXECUTED	9:fa8a5b5445e3857f4b010bafb5009957	addColumn tableName=REALM; customChange		\N	4.29.1	\N	\N	3550939158
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-04-01 23:42:31.354433	90	EXECUTED	9:67ac3241df9a8582d591c5ed87125f39	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.29.1	\N	\N	3550939158
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-04-01 23:42:31.457578	91	EXECUTED	9:ad1194d66c937e3ffc82386c050ba089	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	3550939158
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-04-01 23:42:31.492771	92	EXECUTED	9:d9be619d94af5a2f5d07b9f003543b91	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.29.1	\N	\N	3550939158
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-04-01 23:42:31.499438	93	MARK_RAN	9:544d201116a0fcc5a5da0925fbbc3bde	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.29.1	\N	\N	3550939158
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-04-01 23:42:31.529846	94	EXECUTED	9:43c0c1055b6761b4b3e89de76d612ccf	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.29.1	\N	\N	3550939158
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-04-01 23:42:31.539115	95	MARK_RAN	9:8bd711fd0330f4fe980494ca43ab1139	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.29.1	\N	\N	3550939158
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-04-01 23:42:31.565504	96	EXECUTED	9:e07d2bc0970c348bb06fb63b1f82ddbf	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.29.1	\N	\N	3550939158
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-04-01 23:42:31.806873	97	EXECUTED	9:24fb8611e97f29989bea412aa38d12b7	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	3550939158
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-04-01 23:42:31.813685	98	MARK_RAN	9:259f89014ce2506ee84740cbf7163aa7	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	3550939158
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-04-01 23:42:31.858957	99	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	3550939158
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-04-01 23:42:31.985892	100	EXECUTED	9:60ca84a0f8c94ec8c3504a5a3bc88ee8	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	3550939158
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-04-01 23:42:31.995456	101	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	3550939158
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-04-01 23:42:32.136286	102	EXECUTED	9:0b305d8d1277f3a89a0a53a659ad274c	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.29.1	\N	\N	3550939158
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-04-01 23:42:32.163938	103	EXECUTED	9:2c374ad2cdfe20e2905a84c8fac48460	customChange		\N	4.29.1	\N	\N	3550939158
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2025-04-01 23:42:32.198595	104	EXECUTED	9:47a760639ac597360a8219f5b768b4de	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.29.1	\N	\N	3550939158
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2025-04-01 23:42:32.310311	105	EXECUTED	9:a6272f0576727dd8cad2522335f5d99e	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.29.1	\N	\N	3550939158
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2025-04-01 23:42:32.41976	106	EXECUTED	9:015479dbd691d9cc8669282f4828c41d	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.29.1	\N	\N	3550939158
18.0.15-30992-index-consent	keycloak	META-INF/jpa-changelog-18.0.15.xml	2025-04-01 23:42:32.553873	107	EXECUTED	9:80071ede7a05604b1f4906f3bf3b00f0	createIndex indexName=IDX_USCONSENT_SCOPE_ID, tableName=USER_CONSENT_CLIENT_SCOPE		\N	4.29.1	\N	\N	3550939158
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2025-04-01 23:42:32.582645	108	EXECUTED	9:9518e495fdd22f78ad6425cc30630221	customChange		\N	4.29.1	\N	\N	3550939158
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-04-01 23:42:32.721975	109	EXECUTED	9:e5f243877199fd96bcc842f27a1656ac	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.29.1	\N	\N	3550939158
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-04-01 23:42:32.732567	110	MARK_RAN	9:1a6fcaa85e20bdeae0a9ce49b41946a5	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.29.1	\N	\N	3550939158
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-04-01 23:42:32.787279	111	EXECUTED	9:3f332e13e90739ed0c35b0b25b7822ca	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	3550939158
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2025-04-01 23:42:32.811811	112	EXECUTED	9:7ee1f7a3fb8f5588f171fb9a6ab623c0	customChange		\N	4.29.1	\N	\N	3550939158
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2025-04-01 23:42:32.842349	113	EXECUTED	9:3d7e830b52f33676b9d64f7f2b2ea634	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	4.29.1	\N	\N	3550939158
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2025-04-01 23:42:32.850792	114	MARK_RAN	9:627d032e3ef2c06c0e1f73d2ae25c26c	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	4.29.1	\N	\N	3550939158
22.0.0-17484-updated	keycloak	META-INF/jpa-changelog-22.0.0.xml	2025-04-01 23:42:32.87668	115	EXECUTED	9:90af0bfd30cafc17b9f4d6eccd92b8b3	customChange		\N	4.29.1	\N	\N	3550939158
22.0.5-24031	keycloak	META-INF/jpa-changelog-22.0.0.xml	2025-04-01 23:42:32.883407	116	MARK_RAN	9:a60d2d7b315ec2d3eba9e2f145f9df28	customChange		\N	4.29.1	\N	\N	3550939158
23.0.0-12062	keycloak	META-INF/jpa-changelog-23.0.0.xml	2025-04-01 23:42:32.911971	117	EXECUTED	9:2168fbe728fec46ae9baf15bf80927b8	addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG		\N	4.29.1	\N	\N	3550939158
23.0.0-17258	keycloak	META-INF/jpa-changelog-23.0.0.xml	2025-04-01 23:42:32.926349	118	EXECUTED	9:36506d679a83bbfda85a27ea1864dca8	addColumn tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	3550939158
24.0.0-9758	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-04-01 23:42:33.283066	119	EXECUTED	9:502c557a5189f600f0f445a9b49ebbce	addColumn tableName=USER_ATTRIBUTE; addColumn tableName=FED_USER_ATTRIBUTE; createIndex indexName=USER_ATTR_LONG_VALUES, tableName=USER_ATTRIBUTE; createIndex indexName=FED_USER_ATTR_LONG_VALUES, tableName=FED_USER_ATTRIBUTE; createIndex indexName...		\N	4.29.1	\N	\N	3550939158
24.0.0-9758-2	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-04-01 23:42:33.304408	120	EXECUTED	9:bf0fdee10afdf597a987adbf291db7b2	customChange		\N	4.29.1	\N	\N	3550939158
24.0.0-26618-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-04-01 23:42:33.323147	121	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	3550939158
24.0.0-26618-reindex	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-04-01 23:42:33.413435	122	EXECUTED	9:08707c0f0db1cef6b352db03a60edc7f	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	3550939158
24.0.2-27228	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-04-01 23:42:33.43361	123	EXECUTED	9:eaee11f6b8aa25d2cc6a84fb86fc6238	customChange		\N	4.29.1	\N	\N	3550939158
24.0.2-27967-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-04-01 23:42:33.440087	124	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	3550939158
24.0.2-27967-reindex	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-04-01 23:42:33.44998	125	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	3550939158
25.0.0-28265-tables	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-04-01 23:42:33.474899	126	EXECUTED	9:deda2df035df23388af95bbd36c17cef	addColumn tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	3550939158
25.0.0-28265-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-04-01 23:42:33.56058	127	EXECUTED	9:3e96709818458ae49f3c679ae58d263a	createIndex indexName=IDX_OFFLINE_USS_BY_LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	3550939158
25.0.0-28265-index-cleanup-uss-createdon	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-04-01 23:42:33.676579	128	EXECUTED	9:78ab4fc129ed5e8265dbcc3485fba92f	dropIndex indexName=IDX_OFFLINE_USS_CREATEDON, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	3550939158
25.0.0-28265-index-cleanup-uss-preload	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-04-01 23:42:33.770726	129	EXECUTED	9:de5f7c1f7e10994ed8b62e621d20eaab	dropIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	3550939158
25.0.0-28265-index-cleanup-uss-by-usersess	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-04-01 23:42:33.861871	130	EXECUTED	9:6eee220d024e38e89c799417ec33667f	dropIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	3550939158
25.0.0-28265-index-cleanup-css-preload	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-04-01 23:42:33.981824	131	EXECUTED	9:5411d2fb2891d3e8d63ddb55dfa3c0c9	dropIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	3550939158
25.0.0-28265-index-2-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-04-01 23:42:33.989954	132	MARK_RAN	9:b7ef76036d3126bb83c2423bf4d449d6	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	3550939158
25.0.0-28265-index-2-not-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-04-01 23:42:34.103894	133	EXECUTED	9:23396cf51ab8bc1ae6f0cac7f9f6fcf7	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	3550939158
25.0.0-org	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-04-01 23:42:34.141027	134	EXECUTED	9:5c859965c2c9b9c72136c360649af157	createTable tableName=ORG; addUniqueConstraint constraintName=UK_ORG_NAME, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_GROUP, tableName=ORG; createTable tableName=ORG_DOMAIN		\N	4.29.1	\N	\N	3550939158
unique-consentuser	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-04-01 23:42:34.181855	135	EXECUTED	9:5857626a2ea8767e9a6c66bf3a2cb32f	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.29.1	\N	\N	3550939158
unique-consentuser-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-04-01 23:42:34.189409	136	MARK_RAN	9:b79478aad5adaa1bc428e31563f55e8e	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.29.1	\N	\N	3550939158
25.0.0-28861-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-04-01 23:42:34.376556	137	EXECUTED	9:b9acb58ac958d9ada0fe12a5d4794ab1	createIndex indexName=IDX_PERM_TICKET_REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; createIndex indexName=IDX_PERM_TICKET_OWNER, tableName=RESOURCE_SERVER_PERM_TICKET		\N	4.29.1	\N	\N	3550939158
26.0.0-org-alias	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-04-01 23:42:34.4015	138	EXECUTED	9:6ef7d63e4412b3c2d66ed179159886a4	addColumn tableName=ORG; update tableName=ORG; addNotNullConstraint columnName=ALIAS, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_ALIAS, tableName=ORG		\N	4.29.1	\N	\N	3550939158
26.0.0-org-group	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-04-01 23:42:34.43459	139	EXECUTED	9:da8e8087d80ef2ace4f89d8c5b9ca223	addColumn tableName=KEYCLOAK_GROUP; update tableName=KEYCLOAK_GROUP; addNotNullConstraint columnName=TYPE, tableName=KEYCLOAK_GROUP; customChange		\N	4.29.1	\N	\N	3550939158
26.0.0-org-indexes	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-04-01 23:42:34.527522	140	EXECUTED	9:79b05dcd610a8c7f25ec05135eec0857	createIndex indexName=IDX_ORG_DOMAIN_ORG_ID, tableName=ORG_DOMAIN		\N	4.29.1	\N	\N	3550939158
26.0.0-org-group-membership	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-04-01 23:42:34.551733	141	EXECUTED	9:a6ace2ce583a421d89b01ba2a28dc2d4	addColumn tableName=USER_GROUP_MEMBERSHIP; update tableName=USER_GROUP_MEMBERSHIP; addNotNullConstraint columnName=MEMBERSHIP_TYPE, tableName=USER_GROUP_MEMBERSHIP		\N	4.29.1	\N	\N	3550939158
31296-persist-revoked-access-tokens	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-04-01 23:42:34.57434	142	EXECUTED	9:64ef94489d42a358e8304b0e245f0ed4	createTable tableName=REVOKED_TOKEN; addPrimaryKey constraintName=CONSTRAINT_RT, tableName=REVOKED_TOKEN		\N	4.29.1	\N	\N	3550939158
31725-index-persist-revoked-access-tokens	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-04-01 23:42:34.664583	143	EXECUTED	9:b994246ec2bf7c94da881e1d28782c7b	createIndex indexName=IDX_REV_TOKEN_ON_EXPIRE, tableName=REVOKED_TOKEN		\N	4.29.1	\N	\N	3550939158
26.0.0-idps-for-login	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-04-01 23:42:34.860011	144	EXECUTED	9:51f5fffadf986983d4bd59582c6c1604	addColumn tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_REALM_ORG, tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_FOR_LOGIN, tableName=IDENTITY_PROVIDER; customChange		\N	4.29.1	\N	\N	3550939158
26.0.0-32583-drop-redundant-index-on-client-session	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-04-01 23:42:34.94012	145	EXECUTED	9:24972d83bf27317a055d234187bb4af9	dropIndex indexName=IDX_US_SESS_ID_ON_CL_SESS, tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	3550939158
26.0.0.32582-remove-tables-user-session-user-session-note-and-client-session	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-04-01 23:42:34.98464	146	EXECUTED	9:febdc0f47f2ed241c59e60f58c3ceea5	dropTable tableName=CLIENT_SESSION_ROLE; dropTable tableName=CLIENT_SESSION_NOTE; dropTable tableName=CLIENT_SESSION_PROT_MAPPER; dropTable tableName=CLIENT_SESSION_AUTH_STATUS; dropTable tableName=CLIENT_USER_SESSION_NOTE; dropTable tableName=CLI...		\N	4.29.1	\N	\N	3550939158
26.0.0-33201-org-redirect-url	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-04-01 23:42:35.000177	147	EXECUTED	9:4d0e22b0ac68ebe9794fa9cb752ea660	addColumn tableName=ORG		\N	4.29.1	\N	\N	3550939158
29399-jdbc-ping-default	keycloak	META-INF/jpa-changelog-26.1.0.xml	2025-04-01 23:42:35.021654	148	EXECUTED	9:007dbe99d7203fca403b89d4edfdf21e	createTable tableName=JGROUPS_PING; addPrimaryKey constraintName=CONSTRAINT_JGROUPS_PING, tableName=JGROUPS_PING		\N	4.29.1	\N	\N	3550939158
26.1.0-34013	keycloak	META-INF/jpa-changelog-26.1.0.xml	2025-04-01 23:42:35.049048	149	EXECUTED	9:e6b686a15759aef99a6d758a5c4c6a26	addColumn tableName=ADMIN_EVENT_ENTITY		\N	4.29.1	\N	\N	3550939158
26.1.0-34380	keycloak	META-INF/jpa-changelog-26.1.0.xml	2025-04-01 23:42:35.065986	150	EXECUTED	9:ac8b9edb7c2b6c17a1c7a11fcf5ccf01	dropTable tableName=USERNAME_LOGIN_FAILURE		\N	4.29.1	\N	\N	3550939158
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
a4e86523-4f8b-4056-9322-55cde86f8d6b	6b23c029-f918-4656-be8b-ca4eb7cf78a6	f
a4e86523-4f8b-4056-9322-55cde86f8d6b	1c6df122-142d-404e-851e-563f6bb90b31	t
a4e86523-4f8b-4056-9322-55cde86f8d6b	07619025-5b64-42ba-bb52-3f89d0993c4b	t
a4e86523-4f8b-4056-9322-55cde86f8d6b	9a02c129-f7ab-418b-b873-72b88021d9ae	t
a4e86523-4f8b-4056-9322-55cde86f8d6b	5b82719d-857b-4830-adec-6e21218548a3	t
a4e86523-4f8b-4056-9322-55cde86f8d6b	5b6919ad-213c-4524-9de7-d29f6eb87f9e	f
a4e86523-4f8b-4056-9322-55cde86f8d6b	8d3e9730-2a95-496c-a501-86c192aa522e	f
a4e86523-4f8b-4056-9322-55cde86f8d6b	6bd4b9cf-2f58-4a31-b376-23fc21507732	t
a4e86523-4f8b-4056-9322-55cde86f8d6b	93046ecc-b470-4c00-8c97-a5abe1263d31	t
a4e86523-4f8b-4056-9322-55cde86f8d6b	28dbe4b5-572e-4486-8984-afc9d301430f	f
a4e86523-4f8b-4056-9322-55cde86f8d6b	0b028e24-09ef-4f0e-aeda-e80a08091f5f	t
a4e86523-4f8b-4056-9322-55cde86f8d6b	b7fc21ae-98c7-4606-a55f-41faff40d165	t
a4e86523-4f8b-4056-9322-55cde86f8d6b	182072e9-0cbe-4345-968f-281623eed31e	f
5f0779df-8cd1-4b52-a60e-1e1a4d45427b	1a3e9a03-8d09-4890-8324-5b150ec173c4	f
5f0779df-8cd1-4b52-a60e-1e1a4d45427b	5d8f27f2-0f54-4c57-bf5f-1f9783b09966	t
5f0779df-8cd1-4b52-a60e-1e1a4d45427b	1d9019e7-0de0-41f1-adb6-97cf8aad4881	t
5f0779df-8cd1-4b52-a60e-1e1a4d45427b	80bad889-41be-4686-91bf-0ac60c774b7d	t
5f0779df-8cd1-4b52-a60e-1e1a4d45427b	b4c4e925-3b8a-4258-8526-9b6532f8a99a	t
5f0779df-8cd1-4b52-a60e-1e1a4d45427b	cf859df3-7cdb-4485-9c51-56419ed63518	f
5f0779df-8cd1-4b52-a60e-1e1a4d45427b	481eb095-1f32-48bb-9271-c603ff8d8a3c	f
5f0779df-8cd1-4b52-a60e-1e1a4d45427b	b9d2f0f1-cb2b-4c3a-aa13-4d910b4a2f97	t
5f0779df-8cd1-4b52-a60e-1e1a4d45427b	22f13a4e-cfbd-4cb5-bbd0-cdcb603032bd	t
5f0779df-8cd1-4b52-a60e-1e1a4d45427b	6f298998-0954-405c-9408-153ffd0e3ae6	f
5f0779df-8cd1-4b52-a60e-1e1a4d45427b	956d0e9e-4da0-4244-8a24-8128ca49c3c3	t
5f0779df-8cd1-4b52-a60e-1e1a4d45427b	cae62eb5-8113-42af-bd43-5a489f49e1bd	t
5f0779df-8cd1-4b52-a60e-1e1a4d45427b	fbe9c5cc-0240-453a-b849-a9e9c5145b26	f
5f0779df-8cd1-4b52-a60e-1e1a4d45427b	76e1958d-1ada-4243-8f35-dd5ebb8abd62	t
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id, details_json_long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only, organization_id, hide_on_login) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: jgroups_ping; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.jgroups_ping (address, name, cluster_name, ip, coord) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.keycloak_group (id, name, parent_group, realm_id, type) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
f358359a-8685-476e-a74e-0a0377ff1d90	a4e86523-4f8b-4056-9322-55cde86f8d6b	f	${role_default-roles}	default-roles-master	a4e86523-4f8b-4056-9322-55cde86f8d6b	\N	\N
5bcb517f-e149-4fb0-87a4-8b8b864a77fc	a4e86523-4f8b-4056-9322-55cde86f8d6b	f	${role_create-realm}	create-realm	a4e86523-4f8b-4056-9322-55cde86f8d6b	\N	\N
aae70eac-253c-46e5-861a-a64a163947dc	a4e86523-4f8b-4056-9322-55cde86f8d6b	f	${role_admin}	admin	a4e86523-4f8b-4056-9322-55cde86f8d6b	\N	\N
6edfb956-2d1f-4990-9a23-4849ceb90bc0	809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	t	${role_create-client}	create-client	a4e86523-4f8b-4056-9322-55cde86f8d6b	809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	\N
bd64d826-0214-491f-a522-a91d706dae2e	809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	t	${role_view-realm}	view-realm	a4e86523-4f8b-4056-9322-55cde86f8d6b	809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	\N
63b681f3-ec37-464a-ac7b-889e13f4a6ba	809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	t	${role_view-users}	view-users	a4e86523-4f8b-4056-9322-55cde86f8d6b	809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	\N
cf357c1b-ad24-4643-9177-eb66416366fe	809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	t	${role_view-clients}	view-clients	a4e86523-4f8b-4056-9322-55cde86f8d6b	809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	\N
4dc4d419-5fe0-484e-a8a7-4ca306706435	809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	t	${role_view-events}	view-events	a4e86523-4f8b-4056-9322-55cde86f8d6b	809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	\N
052cddc5-33b7-4f80-b42d-0613687b3671	809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	t	${role_view-identity-providers}	view-identity-providers	a4e86523-4f8b-4056-9322-55cde86f8d6b	809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	\N
3fb1852b-18af-4ee1-829d-c73e3d885fc9	809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	t	${role_view-authorization}	view-authorization	a4e86523-4f8b-4056-9322-55cde86f8d6b	809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	\N
2e877bd2-e7f4-46db-8703-0b599d7d7a92	809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	t	${role_manage-realm}	manage-realm	a4e86523-4f8b-4056-9322-55cde86f8d6b	809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	\N
4ce7fae4-2d2e-4097-abb6-08e1ab93ca1b	809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	t	${role_manage-users}	manage-users	a4e86523-4f8b-4056-9322-55cde86f8d6b	809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	\N
6b683b36-9d35-410a-9d8c-7adab59681a2	809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	t	${role_manage-clients}	manage-clients	a4e86523-4f8b-4056-9322-55cde86f8d6b	809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	\N
a8555301-b568-406f-8ef3-5c2f9429994d	809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	t	${role_manage-events}	manage-events	a4e86523-4f8b-4056-9322-55cde86f8d6b	809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	\N
4b101ff6-ef77-47a7-acc9-a667198c60c4	809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	t	${role_manage-identity-providers}	manage-identity-providers	a4e86523-4f8b-4056-9322-55cde86f8d6b	809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	\N
dc061fd1-4cb9-41a8-8e38-56fbe3c91d06	809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	t	${role_manage-authorization}	manage-authorization	a4e86523-4f8b-4056-9322-55cde86f8d6b	809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	\N
66086df4-b3cc-49d5-a52f-9f277a3f6d30	809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	t	${role_query-users}	query-users	a4e86523-4f8b-4056-9322-55cde86f8d6b	809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	\N
27632828-c556-4bc0-89b3-0cea75291675	809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	t	${role_query-clients}	query-clients	a4e86523-4f8b-4056-9322-55cde86f8d6b	809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	\N
f39781ec-b5ce-48d7-9029-bde94caf15bd	809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	t	${role_query-realms}	query-realms	a4e86523-4f8b-4056-9322-55cde86f8d6b	809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	\N
92f0f051-57fb-4c59-a13b-0cd67fc179e7	809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	t	${role_query-groups}	query-groups	a4e86523-4f8b-4056-9322-55cde86f8d6b	809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	\N
349d671c-628f-4114-8c90-59c19961449a	54d8b736-b0fe-4bc6-8be3-6f6cc4d919d4	t	${role_view-profile}	view-profile	a4e86523-4f8b-4056-9322-55cde86f8d6b	54d8b736-b0fe-4bc6-8be3-6f6cc4d919d4	\N
c6cb6148-7b94-42b1-9302-4191f23e742d	54d8b736-b0fe-4bc6-8be3-6f6cc4d919d4	t	${role_manage-account}	manage-account	a4e86523-4f8b-4056-9322-55cde86f8d6b	54d8b736-b0fe-4bc6-8be3-6f6cc4d919d4	\N
b49f4c56-6368-4174-a1c0-f9ba4032a157	54d8b736-b0fe-4bc6-8be3-6f6cc4d919d4	t	${role_manage-account-links}	manage-account-links	a4e86523-4f8b-4056-9322-55cde86f8d6b	54d8b736-b0fe-4bc6-8be3-6f6cc4d919d4	\N
8012748e-8daa-44ab-b3a3-fe0d994e65e9	54d8b736-b0fe-4bc6-8be3-6f6cc4d919d4	t	${role_view-applications}	view-applications	a4e86523-4f8b-4056-9322-55cde86f8d6b	54d8b736-b0fe-4bc6-8be3-6f6cc4d919d4	\N
0b85ec03-1d7e-4be6-a024-29f1bdf43045	54d8b736-b0fe-4bc6-8be3-6f6cc4d919d4	t	${role_view-consent}	view-consent	a4e86523-4f8b-4056-9322-55cde86f8d6b	54d8b736-b0fe-4bc6-8be3-6f6cc4d919d4	\N
d76bb048-3e95-449f-9756-d9f19c1eb8ac	54d8b736-b0fe-4bc6-8be3-6f6cc4d919d4	t	${role_manage-consent}	manage-consent	a4e86523-4f8b-4056-9322-55cde86f8d6b	54d8b736-b0fe-4bc6-8be3-6f6cc4d919d4	\N
82403810-6f6e-4b7a-b8ac-eb19d379e8f5	54d8b736-b0fe-4bc6-8be3-6f6cc4d919d4	t	${role_view-groups}	view-groups	a4e86523-4f8b-4056-9322-55cde86f8d6b	54d8b736-b0fe-4bc6-8be3-6f6cc4d919d4	\N
58bd5551-5ff1-4f47-859f-e576cb9b4d7f	54d8b736-b0fe-4bc6-8be3-6f6cc4d919d4	t	${role_delete-account}	delete-account	a4e86523-4f8b-4056-9322-55cde86f8d6b	54d8b736-b0fe-4bc6-8be3-6f6cc4d919d4	\N
748c770b-a6c5-4fa4-98c1-86b1d5fd72ca	51cd7f1a-e974-4a27-8a37-da3bf530de67	t	${role_read-token}	read-token	a4e86523-4f8b-4056-9322-55cde86f8d6b	51cd7f1a-e974-4a27-8a37-da3bf530de67	\N
ac53543a-5c2a-413a-a5e9-e8b19c66b543	809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	t	${role_impersonation}	impersonation	a4e86523-4f8b-4056-9322-55cde86f8d6b	809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	\N
196ca212-4cec-4659-bda1-255e1ad196b6	a4e86523-4f8b-4056-9322-55cde86f8d6b	f	${role_offline-access}	offline_access	a4e86523-4f8b-4056-9322-55cde86f8d6b	\N	\N
dee247b6-bfc5-4a21-9ca4-a357c72cde54	a4e86523-4f8b-4056-9322-55cde86f8d6b	f	${role_uma_authorization}	uma_authorization	a4e86523-4f8b-4056-9322-55cde86f8d6b	\N	\N
a47668a7-90ba-4d44-96c4-93930acdfabc	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	f	${role_default-roles}	default-roles-test	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	\N	\N
1958d560-94df-4dac-922e-65583fd875ca	51f791d3-4755-4ea2-95d7-7e542678ef8b	t	${role_create-client}	create-client	a4e86523-4f8b-4056-9322-55cde86f8d6b	51f791d3-4755-4ea2-95d7-7e542678ef8b	\N
bfae202e-6562-4345-8ac4-b92908ab6bc8	51f791d3-4755-4ea2-95d7-7e542678ef8b	t	${role_view-realm}	view-realm	a4e86523-4f8b-4056-9322-55cde86f8d6b	51f791d3-4755-4ea2-95d7-7e542678ef8b	\N
a368ed7c-56ed-4b50-957a-dcba8d480f34	51f791d3-4755-4ea2-95d7-7e542678ef8b	t	${role_view-users}	view-users	a4e86523-4f8b-4056-9322-55cde86f8d6b	51f791d3-4755-4ea2-95d7-7e542678ef8b	\N
fc87848e-47f5-4363-be1a-6f93236375be	51f791d3-4755-4ea2-95d7-7e542678ef8b	t	${role_view-clients}	view-clients	a4e86523-4f8b-4056-9322-55cde86f8d6b	51f791d3-4755-4ea2-95d7-7e542678ef8b	\N
94117808-2068-4389-ba04-fbf55f43f9d6	51f791d3-4755-4ea2-95d7-7e542678ef8b	t	${role_view-events}	view-events	a4e86523-4f8b-4056-9322-55cde86f8d6b	51f791d3-4755-4ea2-95d7-7e542678ef8b	\N
a8c24bbe-f0a6-4f5b-9d70-e41d4e660927	51f791d3-4755-4ea2-95d7-7e542678ef8b	t	${role_view-identity-providers}	view-identity-providers	a4e86523-4f8b-4056-9322-55cde86f8d6b	51f791d3-4755-4ea2-95d7-7e542678ef8b	\N
6ec88491-be49-4f04-89f0-a2a3113ab602	51f791d3-4755-4ea2-95d7-7e542678ef8b	t	${role_view-authorization}	view-authorization	a4e86523-4f8b-4056-9322-55cde86f8d6b	51f791d3-4755-4ea2-95d7-7e542678ef8b	\N
4c917e01-d2f3-4473-af48-ddb8f38f1241	51f791d3-4755-4ea2-95d7-7e542678ef8b	t	${role_manage-realm}	manage-realm	a4e86523-4f8b-4056-9322-55cde86f8d6b	51f791d3-4755-4ea2-95d7-7e542678ef8b	\N
10032791-ab1d-445e-af8b-7e8fc63746dc	51f791d3-4755-4ea2-95d7-7e542678ef8b	t	${role_manage-users}	manage-users	a4e86523-4f8b-4056-9322-55cde86f8d6b	51f791d3-4755-4ea2-95d7-7e542678ef8b	\N
a2be13bc-f3cb-4ad4-bb33-b7cc94dc1ef6	51f791d3-4755-4ea2-95d7-7e542678ef8b	t	${role_manage-clients}	manage-clients	a4e86523-4f8b-4056-9322-55cde86f8d6b	51f791d3-4755-4ea2-95d7-7e542678ef8b	\N
ea1fc714-01dd-429e-8409-d644bb1d765f	51f791d3-4755-4ea2-95d7-7e542678ef8b	t	${role_manage-events}	manage-events	a4e86523-4f8b-4056-9322-55cde86f8d6b	51f791d3-4755-4ea2-95d7-7e542678ef8b	\N
ed0f8ab6-d884-4e23-82aa-ffc59c6151be	51f791d3-4755-4ea2-95d7-7e542678ef8b	t	${role_manage-identity-providers}	manage-identity-providers	a4e86523-4f8b-4056-9322-55cde86f8d6b	51f791d3-4755-4ea2-95d7-7e542678ef8b	\N
e3ddb173-90b1-4c2c-8956-cdef61946fb5	51f791d3-4755-4ea2-95d7-7e542678ef8b	t	${role_manage-authorization}	manage-authorization	a4e86523-4f8b-4056-9322-55cde86f8d6b	51f791d3-4755-4ea2-95d7-7e542678ef8b	\N
0a9c7768-5f06-41a4-8958-992ec72aa16a	51f791d3-4755-4ea2-95d7-7e542678ef8b	t	${role_query-users}	query-users	a4e86523-4f8b-4056-9322-55cde86f8d6b	51f791d3-4755-4ea2-95d7-7e542678ef8b	\N
424123bc-667d-4d3d-8560-7052d9a22352	51f791d3-4755-4ea2-95d7-7e542678ef8b	t	${role_query-clients}	query-clients	a4e86523-4f8b-4056-9322-55cde86f8d6b	51f791d3-4755-4ea2-95d7-7e542678ef8b	\N
7f715848-9f30-4611-b3c7-92e2c6ef23c6	51f791d3-4755-4ea2-95d7-7e542678ef8b	t	${role_query-realms}	query-realms	a4e86523-4f8b-4056-9322-55cde86f8d6b	51f791d3-4755-4ea2-95d7-7e542678ef8b	\N
63f7dc38-0516-4c7d-b0a1-1c2429ae994c	51f791d3-4755-4ea2-95d7-7e542678ef8b	t	${role_query-groups}	query-groups	a4e86523-4f8b-4056-9322-55cde86f8d6b	51f791d3-4755-4ea2-95d7-7e542678ef8b	\N
261120ed-ecda-4dc0-8886-756007628a2e	048bcd9d-39be-4012-abbb-ce0059d5c0e9	t	${role_realm-admin}	realm-admin	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	048bcd9d-39be-4012-abbb-ce0059d5c0e9	\N
8f711594-27f4-4ed5-adfe-e569c4786186	048bcd9d-39be-4012-abbb-ce0059d5c0e9	t	${role_create-client}	create-client	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	048bcd9d-39be-4012-abbb-ce0059d5c0e9	\N
0926c9dc-c619-4344-b1cc-49c8f1be1aeb	048bcd9d-39be-4012-abbb-ce0059d5c0e9	t	${role_view-realm}	view-realm	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	048bcd9d-39be-4012-abbb-ce0059d5c0e9	\N
cd21d870-d152-4006-9d9b-796e39bd3265	048bcd9d-39be-4012-abbb-ce0059d5c0e9	t	${role_view-users}	view-users	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	048bcd9d-39be-4012-abbb-ce0059d5c0e9	\N
e46ba619-1d4a-4447-b037-ee95c72e5be7	048bcd9d-39be-4012-abbb-ce0059d5c0e9	t	${role_view-clients}	view-clients	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	048bcd9d-39be-4012-abbb-ce0059d5c0e9	\N
4319b703-8946-4b25-81d8-0cb7a6def9b9	048bcd9d-39be-4012-abbb-ce0059d5c0e9	t	${role_view-events}	view-events	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	048bcd9d-39be-4012-abbb-ce0059d5c0e9	\N
0daa9904-4613-4534-aeae-45cfe2fec85b	048bcd9d-39be-4012-abbb-ce0059d5c0e9	t	${role_view-identity-providers}	view-identity-providers	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	048bcd9d-39be-4012-abbb-ce0059d5c0e9	\N
51d184a3-7c57-428a-a790-2d3c243c75cf	048bcd9d-39be-4012-abbb-ce0059d5c0e9	t	${role_view-authorization}	view-authorization	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	048bcd9d-39be-4012-abbb-ce0059d5c0e9	\N
a981dc53-8fe4-4133-b2d1-5a9688a39b7b	048bcd9d-39be-4012-abbb-ce0059d5c0e9	t	${role_manage-realm}	manage-realm	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	048bcd9d-39be-4012-abbb-ce0059d5c0e9	\N
1ff41b1d-59a0-4bd6-b461-510dd205b487	048bcd9d-39be-4012-abbb-ce0059d5c0e9	t	${role_manage-users}	manage-users	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	048bcd9d-39be-4012-abbb-ce0059d5c0e9	\N
c7ad4b1f-ce49-4c10-93d5-293b1b8edcf3	048bcd9d-39be-4012-abbb-ce0059d5c0e9	t	${role_manage-clients}	manage-clients	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	048bcd9d-39be-4012-abbb-ce0059d5c0e9	\N
949c2cff-bb32-4b64-b944-7932b1d90074	048bcd9d-39be-4012-abbb-ce0059d5c0e9	t	${role_manage-events}	manage-events	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	048bcd9d-39be-4012-abbb-ce0059d5c0e9	\N
3ba256db-d208-48e8-9e71-9e9196cb28bf	048bcd9d-39be-4012-abbb-ce0059d5c0e9	t	${role_manage-identity-providers}	manage-identity-providers	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	048bcd9d-39be-4012-abbb-ce0059d5c0e9	\N
a4f6be3f-4e85-45c0-b9ad-39f4ae2b3a17	048bcd9d-39be-4012-abbb-ce0059d5c0e9	t	${role_manage-authorization}	manage-authorization	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	048bcd9d-39be-4012-abbb-ce0059d5c0e9	\N
af64b97d-ff4a-4839-84f7-384eab5e8a62	048bcd9d-39be-4012-abbb-ce0059d5c0e9	t	${role_query-users}	query-users	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	048bcd9d-39be-4012-abbb-ce0059d5c0e9	\N
9ff64081-f6fd-4641-8b42-b9f6fc1e7552	048bcd9d-39be-4012-abbb-ce0059d5c0e9	t	${role_query-clients}	query-clients	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	048bcd9d-39be-4012-abbb-ce0059d5c0e9	\N
b68c8f60-124d-400f-9487-1cbddd256dea	048bcd9d-39be-4012-abbb-ce0059d5c0e9	t	${role_query-realms}	query-realms	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	048bcd9d-39be-4012-abbb-ce0059d5c0e9	\N
33af9bb7-c326-43c2-90a9-738883d31f8e	048bcd9d-39be-4012-abbb-ce0059d5c0e9	t	${role_query-groups}	query-groups	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	048bcd9d-39be-4012-abbb-ce0059d5c0e9	\N
5566ff9e-93fd-4202-a52b-142927d14966	9e9ca8d3-de61-4566-91b1-0be5ae703db7	t	${role_view-profile}	view-profile	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	9e9ca8d3-de61-4566-91b1-0be5ae703db7	\N
f7ecb692-039e-4a6a-8349-a700e511d8f5	9e9ca8d3-de61-4566-91b1-0be5ae703db7	t	${role_manage-account}	manage-account	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	9e9ca8d3-de61-4566-91b1-0be5ae703db7	\N
edb6a64b-0dea-42b8-898e-7d86cdf36263	9e9ca8d3-de61-4566-91b1-0be5ae703db7	t	${role_manage-account-links}	manage-account-links	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	9e9ca8d3-de61-4566-91b1-0be5ae703db7	\N
e17114bc-121e-4c04-af12-d91203615f38	9e9ca8d3-de61-4566-91b1-0be5ae703db7	t	${role_view-applications}	view-applications	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	9e9ca8d3-de61-4566-91b1-0be5ae703db7	\N
44facf02-2abf-48ac-a488-abd5c035f19c	9e9ca8d3-de61-4566-91b1-0be5ae703db7	t	${role_view-consent}	view-consent	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	9e9ca8d3-de61-4566-91b1-0be5ae703db7	\N
8d3b45cd-a682-4f75-b886-532cdfe4e575	9e9ca8d3-de61-4566-91b1-0be5ae703db7	t	${role_manage-consent}	manage-consent	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	9e9ca8d3-de61-4566-91b1-0be5ae703db7	\N
c3b367aa-ea8a-4367-b115-e8910cc00fca	9e9ca8d3-de61-4566-91b1-0be5ae703db7	t	${role_view-groups}	view-groups	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	9e9ca8d3-de61-4566-91b1-0be5ae703db7	\N
aa7bb8c8-f160-4cde-aaa0-58ae063962cd	9e9ca8d3-de61-4566-91b1-0be5ae703db7	t	${role_delete-account}	delete-account	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	9e9ca8d3-de61-4566-91b1-0be5ae703db7	\N
3c0414c6-9bc3-487f-bf9f-8e33e747ffb2	51f791d3-4755-4ea2-95d7-7e542678ef8b	t	${role_impersonation}	impersonation	a4e86523-4f8b-4056-9322-55cde86f8d6b	51f791d3-4755-4ea2-95d7-7e542678ef8b	\N
1f161cf9-4c6d-4bef-9373-93df71186e5b	048bcd9d-39be-4012-abbb-ce0059d5c0e9	t	${role_impersonation}	impersonation	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	048bcd9d-39be-4012-abbb-ce0059d5c0e9	\N
d8a92605-fd49-453b-9db1-6ce7ab6b03bd	560b33d3-0bfc-4b3d-9013-214383cbee87	t	${role_read-token}	read-token	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	560b33d3-0bfc-4b3d-9013-214383cbee87	\N
1f7f6f1a-33a6-4feb-812c-9a8fae7bf89c	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	f	${role_offline-access}	offline_access	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	\N	\N
20974b02-dc6f-4ef5-8d6b-22e1284b1814	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	f	${role_uma_authorization}	uma_authorization	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	\N	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.migration_model (id, version, update_time) FROM stdin;
8iiu6	26.1.4	1743550956
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id, version) FROM stdin;
b1c2841a-f69f-4ffc-9f98-aaf5aedde979	3b16b7ba-488a-4efc-9713-c1d6a43e7abf	0	1743726666	{"authMethod":"openid-connect","redirectUri":"http://localhost:5173/callback","notes":{"clientId":"3b16b7ba-488a-4efc-9713-c1d6a43e7abf","scope":"openid","userSessionStartedAt":"1743724678","iss":"http://localhost:8080/realms/test","startedAt":"1743724763","response_type":"code","level-of-authentication":"-1","redirect_uri":"http://localhost:5173/callback","client_request_param_konneqt_token":"diego@gmail.com"}}	local	local	4
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh, broker_session_id, version) FROM stdin;
b1c2841a-f69f-4ffc-9f98-aaf5aedde979	4e48928f-011c-4328-a833-650027c2134c	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	1743724678	0	{"ipAddress":"172.17.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTcuMC4xIiwib3MiOiJXaW5kb3dzIiwib3NWZXJzaW9uIjoiMTAiLCJicm93c2VyIjoiRWRnZS8xMzQuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1743726666","authenticators-completed":"{\\"c9fd4cb4-983a-4e19-b450-33d1d4a113ef\\":1743726666}"},"state":"LOGGED_IN"}	1743726666	\N	7
\.


--
-- Data for Name: org; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.org (id, enabled, realm_id, group_id, name, description, alias, redirect_url) FROM stdin;
\.


--
-- Data for Name: org_domain; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.org_domain (id, name, verified, org_id) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
6718419b-99fd-43e2-879f-aa8fe8ed3cf7	audience resolve	openid-connect	oidc-audience-resolve-mapper	4daf458a-6353-4178-8200-93f1810528ce	\N
7a826397-2047-459c-929e-64c7266ca5b1	locale	openid-connect	oidc-usermodel-attribute-mapper	ee5b168a-aa3e-45a0-8234-372b64c37985	\N
3c693984-7560-4888-a12b-e5751a47ad0d	role list	saml	saml-role-list-mapper	\N	1c6df122-142d-404e-851e-563f6bb90b31
0d914a0f-9005-4af7-9062-8e2739f34291	organization	saml	saml-organization-membership-mapper	\N	07619025-5b64-42ba-bb52-3f89d0993c4b
608cb55d-1e31-4949-a173-508fb0128704	full name	openid-connect	oidc-full-name-mapper	\N	9a02c129-f7ab-418b-b873-72b88021d9ae
31cd1884-eef3-4125-a452-890ef160823d	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	9a02c129-f7ab-418b-b873-72b88021d9ae
b13d005e-bdf8-4b00-9954-97785df4749e	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	9a02c129-f7ab-418b-b873-72b88021d9ae
88f6deb4-7712-4b1c-b26c-a69615fdc68f	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	9a02c129-f7ab-418b-b873-72b88021d9ae
9ec7cfd4-ddc3-4f35-8198-c127fb67d188	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	9a02c129-f7ab-418b-b873-72b88021d9ae
7b386fed-2e44-4aee-b80b-a4b642f503ca	username	openid-connect	oidc-usermodel-attribute-mapper	\N	9a02c129-f7ab-418b-b873-72b88021d9ae
4749848b-7300-473a-9801-59447b219966	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	9a02c129-f7ab-418b-b873-72b88021d9ae
c78c0991-c4e1-4902-8fda-f79aeafe84f4	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	9a02c129-f7ab-418b-b873-72b88021d9ae
3545b1b6-8910-4389-8bf0-1c1fa4e02f2f	website	openid-connect	oidc-usermodel-attribute-mapper	\N	9a02c129-f7ab-418b-b873-72b88021d9ae
1958b884-ff7e-4b40-b2af-21a88e2487bb	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	9a02c129-f7ab-418b-b873-72b88021d9ae
a6d75bda-67c3-4a68-aa3f-e5b72022e479	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	9a02c129-f7ab-418b-b873-72b88021d9ae
2ce7b3b6-ef67-4a79-8e4f-b1eb4d01329a	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	9a02c129-f7ab-418b-b873-72b88021d9ae
8eeb9fb4-0f60-464a-9577-488a785beea8	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	9a02c129-f7ab-418b-b873-72b88021d9ae
63a6d5cf-e24d-4099-b6ec-eb4fe358750a	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	9a02c129-f7ab-418b-b873-72b88021d9ae
e222131f-e205-4845-bc7c-d4a0e91a4af0	email	openid-connect	oidc-usermodel-attribute-mapper	\N	5b82719d-857b-4830-adec-6e21218548a3
3c10e37c-ec66-4605-9f31-6c72ecf63f0f	email verified	openid-connect	oidc-usermodel-property-mapper	\N	5b82719d-857b-4830-adec-6e21218548a3
51da0e55-a04c-44e7-bc4c-8c8dfedd761c	address	openid-connect	oidc-address-mapper	\N	5b6919ad-213c-4524-9de7-d29f6eb87f9e
cd8a23b8-4abc-4647-b78e-4ad3a8cf70bd	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	8d3e9730-2a95-496c-a501-86c192aa522e
4284fb58-842e-4457-ab90-7e89a34d5e86	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	8d3e9730-2a95-496c-a501-86c192aa522e
ed412e71-888e-4ba6-97a9-4593f75f00ec	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	6bd4b9cf-2f58-4a31-b376-23fc21507732
be1eb893-0abb-439d-95c8-dc43c2e1e835	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	6bd4b9cf-2f58-4a31-b376-23fc21507732
2554aca2-afe7-4d4a-b72b-51ba27dcf3a9	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	6bd4b9cf-2f58-4a31-b376-23fc21507732
a6a413da-8a7a-4f77-aeda-177effc1abb5	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	93046ecc-b470-4c00-8c97-a5abe1263d31
72aab4cb-a963-46ef-8927-46a50ff99fe4	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	28dbe4b5-572e-4486-8984-afc9d301430f
5e257217-f38c-4025-b288-15581dc9e8cd	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	28dbe4b5-572e-4486-8984-afc9d301430f
bc06db17-b28d-4015-8d0a-f7809d0638cb	acr loa level	openid-connect	oidc-acr-mapper	\N	0b028e24-09ef-4f0e-aeda-e80a08091f5f
a5e2f8e2-cbb4-4686-aeaf-83e0baee5adc	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	b7fc21ae-98c7-4606-a55f-41faff40d165
4887a2d4-63d9-4d05-9cce-184acd9b7936	sub	openid-connect	oidc-sub-mapper	\N	b7fc21ae-98c7-4606-a55f-41faff40d165
582e17cf-cab4-4a15-ad62-57c5b4fb3526	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	\N	587d2738-ff4d-4792-aa6d-e4f80825dc00
0585dc84-d391-49c8-96cc-d92a9f20ac6c	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	\N	587d2738-ff4d-4792-aa6d-e4f80825dc00
17865905-b3b4-4a14-bbf1-399e2a167fc7	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	\N	587d2738-ff4d-4792-aa6d-e4f80825dc00
743798b3-7bbe-42b0-aa86-dd57b4901e59	organization	openid-connect	oidc-organization-membership-mapper	\N	182072e9-0cbe-4345-968f-281623eed31e
f286fc93-825b-4254-801c-916066fc36d6	audience resolve	openid-connect	oidc-audience-resolve-mapper	3df67013-7d9d-4b13-816f-289b30cea5e4	\N
98644ebd-3fce-4bde-b671-ca6dace8a112	role list	saml	saml-role-list-mapper	\N	5d8f27f2-0f54-4c57-bf5f-1f9783b09966
82357e40-43fa-40fb-9e3e-e453bada054f	organization	saml	saml-organization-membership-mapper	\N	1d9019e7-0de0-41f1-adb6-97cf8aad4881
188e0c6d-4aac-42f9-a4c0-8e3de700f0ba	full name	openid-connect	oidc-full-name-mapper	\N	80bad889-41be-4686-91bf-0ac60c774b7d
d9f0f730-e057-46fc-a516-98471ef556af	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	80bad889-41be-4686-91bf-0ac60c774b7d
763e8bdb-4b16-4e9a-b7a2-6c2bddb288d5	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	80bad889-41be-4686-91bf-0ac60c774b7d
7f9ce69c-dd88-4dd3-ae20-e64f873d9d6c	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	80bad889-41be-4686-91bf-0ac60c774b7d
0de36c89-87a8-448d-ad36-7c2ea7cb16cd	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	80bad889-41be-4686-91bf-0ac60c774b7d
6cf4c073-34ad-4333-ac59-c755f0a3de92	username	openid-connect	oidc-usermodel-attribute-mapper	\N	80bad889-41be-4686-91bf-0ac60c774b7d
921c01ed-f8c5-4e32-bd70-53b4e96e7232	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	80bad889-41be-4686-91bf-0ac60c774b7d
bd5e0d23-ad74-488b-9be7-6d69e0881e57	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	80bad889-41be-4686-91bf-0ac60c774b7d
8955e885-a428-4010-9ccf-95054667ace6	website	openid-connect	oidc-usermodel-attribute-mapper	\N	80bad889-41be-4686-91bf-0ac60c774b7d
8165c08f-d8ee-43f0-8892-140fe1e960d7	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	80bad889-41be-4686-91bf-0ac60c774b7d
8bec2f28-dfbc-4c9e-8adf-4a0093b36088	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	80bad889-41be-4686-91bf-0ac60c774b7d
396006b1-4d9f-4706-b5f6-0494c6c883cc	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	80bad889-41be-4686-91bf-0ac60c774b7d
f43d3d12-c8a2-46c9-a89c-7590cba4ddea	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	80bad889-41be-4686-91bf-0ac60c774b7d
e7e1b390-1849-47f5-a7ef-a403f2399067	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	80bad889-41be-4686-91bf-0ac60c774b7d
ed750baa-f156-4bcc-8e9d-3bb5a455c551	email	openid-connect	oidc-usermodel-attribute-mapper	\N	b4c4e925-3b8a-4258-8526-9b6532f8a99a
cf42046a-524e-4a4c-b076-6f94abae96ed	email verified	openid-connect	oidc-usermodel-property-mapper	\N	b4c4e925-3b8a-4258-8526-9b6532f8a99a
7a727c55-1e36-4eaa-8588-8c4c8563d438	address	openid-connect	oidc-address-mapper	\N	cf859df3-7cdb-4485-9c51-56419ed63518
0e38b198-45be-47a4-8c3d-0254baddbbff	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	481eb095-1f32-48bb-9271-c603ff8d8a3c
ac8e7740-4b69-43e1-89ae-9ffc1bfef8c6	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	481eb095-1f32-48bb-9271-c603ff8d8a3c
57b62e43-ffec-425d-8608-46d79237487e	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	b9d2f0f1-cb2b-4c3a-aa13-4d910b4a2f97
296bf9c4-3fb5-40cc-aef9-e0802b0ebb76	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	b9d2f0f1-cb2b-4c3a-aa13-4d910b4a2f97
32107030-2e3e-4b46-88c9-d07680b4f4c7	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	b9d2f0f1-cb2b-4c3a-aa13-4d910b4a2f97
3e9fb413-876a-4d0e-bbf6-2a03dced7a29	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	22f13a4e-cfbd-4cb5-bbd0-cdcb603032bd
6b1f88ee-bbf2-437e-bd0a-e45b5c8a52bc	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	6f298998-0954-405c-9408-153ffd0e3ae6
4f53e7ca-3f4e-4a51-8979-2e9eb9e57217	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	6f298998-0954-405c-9408-153ffd0e3ae6
7dcba050-0f58-48fc-a580-077504783e4a	acr loa level	openid-connect	oidc-acr-mapper	\N	956d0e9e-4da0-4244-8a24-8128ca49c3c3
02203e30-f560-473b-9183-767961c978c9	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	cae62eb5-8113-42af-bd43-5a489f49e1bd
bd0256bc-60d7-445e-b581-1305e9d69dbe	sub	openid-connect	oidc-sub-mapper	\N	cae62eb5-8113-42af-bd43-5a489f49e1bd
20c75609-4bd8-47e8-980c-67739e3e5abc	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	\N	c633ceca-7899-4d26-8a62-62190efafd9a
fcd86128-ebd9-4416-b699-594395dc7ecf	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	\N	c633ceca-7899-4d26-8a62-62190efafd9a
4d8ac621-bd3f-4036-b8ff-164db3f8f125	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	\N	c633ceca-7899-4d26-8a62-62190efafd9a
edf4e5ec-6225-406c-b2c3-a56599800c29	organization	openid-connect	oidc-organization-membership-mapper	\N	fbe9c5cc-0240-453a-b849-a9e9c5145b26
8ea722ba-1256-47f1-94c6-2cbc467e65cc	locale	openid-connect	oidc-usermodel-attribute-mapper	c4c5adc2-82c6-40cd-bbce-4357646cb30b	\N
3364af96-25e6-44af-8483-1ccec645977f	Claims	openid-connect	oidc-claims-param-token-mapper	\N	76e1958d-1ada-4243-8f35-dd5ebb8abd62
553bbb28-38f6-47d2-8b65-759ba95766eb	Konneqt-Audience	openid-connect	oidc-audience-mapper	\N	76e1958d-1ada-4243-8f35-dd5ebb8abd62
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
7a826397-2047-459c-929e-64c7266ca5b1	true	introspection.token.claim
7a826397-2047-459c-929e-64c7266ca5b1	true	userinfo.token.claim
7a826397-2047-459c-929e-64c7266ca5b1	locale	user.attribute
7a826397-2047-459c-929e-64c7266ca5b1	true	id.token.claim
7a826397-2047-459c-929e-64c7266ca5b1	true	access.token.claim
7a826397-2047-459c-929e-64c7266ca5b1	locale	claim.name
7a826397-2047-459c-929e-64c7266ca5b1	String	jsonType.label
3c693984-7560-4888-a12b-e5751a47ad0d	false	single
3c693984-7560-4888-a12b-e5751a47ad0d	Basic	attribute.nameformat
3c693984-7560-4888-a12b-e5751a47ad0d	Role	attribute.name
1958b884-ff7e-4b40-b2af-21a88e2487bb	true	introspection.token.claim
1958b884-ff7e-4b40-b2af-21a88e2487bb	true	userinfo.token.claim
1958b884-ff7e-4b40-b2af-21a88e2487bb	gender	user.attribute
1958b884-ff7e-4b40-b2af-21a88e2487bb	true	id.token.claim
1958b884-ff7e-4b40-b2af-21a88e2487bb	true	access.token.claim
1958b884-ff7e-4b40-b2af-21a88e2487bb	gender	claim.name
1958b884-ff7e-4b40-b2af-21a88e2487bb	String	jsonType.label
2ce7b3b6-ef67-4a79-8e4f-b1eb4d01329a	true	introspection.token.claim
2ce7b3b6-ef67-4a79-8e4f-b1eb4d01329a	true	userinfo.token.claim
2ce7b3b6-ef67-4a79-8e4f-b1eb4d01329a	zoneinfo	user.attribute
2ce7b3b6-ef67-4a79-8e4f-b1eb4d01329a	true	id.token.claim
2ce7b3b6-ef67-4a79-8e4f-b1eb4d01329a	true	access.token.claim
2ce7b3b6-ef67-4a79-8e4f-b1eb4d01329a	zoneinfo	claim.name
2ce7b3b6-ef67-4a79-8e4f-b1eb4d01329a	String	jsonType.label
31cd1884-eef3-4125-a452-890ef160823d	true	introspection.token.claim
31cd1884-eef3-4125-a452-890ef160823d	true	userinfo.token.claim
31cd1884-eef3-4125-a452-890ef160823d	lastName	user.attribute
31cd1884-eef3-4125-a452-890ef160823d	true	id.token.claim
31cd1884-eef3-4125-a452-890ef160823d	true	access.token.claim
31cd1884-eef3-4125-a452-890ef160823d	family_name	claim.name
31cd1884-eef3-4125-a452-890ef160823d	String	jsonType.label
3545b1b6-8910-4389-8bf0-1c1fa4e02f2f	true	introspection.token.claim
3545b1b6-8910-4389-8bf0-1c1fa4e02f2f	true	userinfo.token.claim
3545b1b6-8910-4389-8bf0-1c1fa4e02f2f	website	user.attribute
3545b1b6-8910-4389-8bf0-1c1fa4e02f2f	true	id.token.claim
3545b1b6-8910-4389-8bf0-1c1fa4e02f2f	true	access.token.claim
3545b1b6-8910-4389-8bf0-1c1fa4e02f2f	website	claim.name
3545b1b6-8910-4389-8bf0-1c1fa4e02f2f	String	jsonType.label
4749848b-7300-473a-9801-59447b219966	true	introspection.token.claim
4749848b-7300-473a-9801-59447b219966	true	userinfo.token.claim
4749848b-7300-473a-9801-59447b219966	profile	user.attribute
4749848b-7300-473a-9801-59447b219966	true	id.token.claim
4749848b-7300-473a-9801-59447b219966	true	access.token.claim
4749848b-7300-473a-9801-59447b219966	profile	claim.name
4749848b-7300-473a-9801-59447b219966	String	jsonType.label
608cb55d-1e31-4949-a173-508fb0128704	true	introspection.token.claim
608cb55d-1e31-4949-a173-508fb0128704	true	userinfo.token.claim
608cb55d-1e31-4949-a173-508fb0128704	true	id.token.claim
608cb55d-1e31-4949-a173-508fb0128704	true	access.token.claim
63a6d5cf-e24d-4099-b6ec-eb4fe358750a	true	introspection.token.claim
63a6d5cf-e24d-4099-b6ec-eb4fe358750a	true	userinfo.token.claim
63a6d5cf-e24d-4099-b6ec-eb4fe358750a	updatedAt	user.attribute
63a6d5cf-e24d-4099-b6ec-eb4fe358750a	true	id.token.claim
63a6d5cf-e24d-4099-b6ec-eb4fe358750a	true	access.token.claim
63a6d5cf-e24d-4099-b6ec-eb4fe358750a	updated_at	claim.name
63a6d5cf-e24d-4099-b6ec-eb4fe358750a	long	jsonType.label
7b386fed-2e44-4aee-b80b-a4b642f503ca	true	introspection.token.claim
7b386fed-2e44-4aee-b80b-a4b642f503ca	true	userinfo.token.claim
7b386fed-2e44-4aee-b80b-a4b642f503ca	username	user.attribute
7b386fed-2e44-4aee-b80b-a4b642f503ca	true	id.token.claim
7b386fed-2e44-4aee-b80b-a4b642f503ca	true	access.token.claim
7b386fed-2e44-4aee-b80b-a4b642f503ca	preferred_username	claim.name
7b386fed-2e44-4aee-b80b-a4b642f503ca	String	jsonType.label
88f6deb4-7712-4b1c-b26c-a69615fdc68f	true	introspection.token.claim
88f6deb4-7712-4b1c-b26c-a69615fdc68f	true	userinfo.token.claim
88f6deb4-7712-4b1c-b26c-a69615fdc68f	middleName	user.attribute
88f6deb4-7712-4b1c-b26c-a69615fdc68f	true	id.token.claim
88f6deb4-7712-4b1c-b26c-a69615fdc68f	true	access.token.claim
88f6deb4-7712-4b1c-b26c-a69615fdc68f	middle_name	claim.name
88f6deb4-7712-4b1c-b26c-a69615fdc68f	String	jsonType.label
8eeb9fb4-0f60-464a-9577-488a785beea8	true	introspection.token.claim
8eeb9fb4-0f60-464a-9577-488a785beea8	true	userinfo.token.claim
8eeb9fb4-0f60-464a-9577-488a785beea8	locale	user.attribute
8eeb9fb4-0f60-464a-9577-488a785beea8	true	id.token.claim
8eeb9fb4-0f60-464a-9577-488a785beea8	true	access.token.claim
8eeb9fb4-0f60-464a-9577-488a785beea8	locale	claim.name
8eeb9fb4-0f60-464a-9577-488a785beea8	String	jsonType.label
9ec7cfd4-ddc3-4f35-8198-c127fb67d188	true	introspection.token.claim
9ec7cfd4-ddc3-4f35-8198-c127fb67d188	true	userinfo.token.claim
9ec7cfd4-ddc3-4f35-8198-c127fb67d188	nickname	user.attribute
9ec7cfd4-ddc3-4f35-8198-c127fb67d188	true	id.token.claim
9ec7cfd4-ddc3-4f35-8198-c127fb67d188	true	access.token.claim
9ec7cfd4-ddc3-4f35-8198-c127fb67d188	nickname	claim.name
9ec7cfd4-ddc3-4f35-8198-c127fb67d188	String	jsonType.label
a6d75bda-67c3-4a68-aa3f-e5b72022e479	true	introspection.token.claim
a6d75bda-67c3-4a68-aa3f-e5b72022e479	true	userinfo.token.claim
a6d75bda-67c3-4a68-aa3f-e5b72022e479	birthdate	user.attribute
a6d75bda-67c3-4a68-aa3f-e5b72022e479	true	id.token.claim
a6d75bda-67c3-4a68-aa3f-e5b72022e479	true	access.token.claim
a6d75bda-67c3-4a68-aa3f-e5b72022e479	birthdate	claim.name
a6d75bda-67c3-4a68-aa3f-e5b72022e479	String	jsonType.label
b13d005e-bdf8-4b00-9954-97785df4749e	true	introspection.token.claim
b13d005e-bdf8-4b00-9954-97785df4749e	true	userinfo.token.claim
b13d005e-bdf8-4b00-9954-97785df4749e	firstName	user.attribute
b13d005e-bdf8-4b00-9954-97785df4749e	true	id.token.claim
b13d005e-bdf8-4b00-9954-97785df4749e	true	access.token.claim
b13d005e-bdf8-4b00-9954-97785df4749e	given_name	claim.name
b13d005e-bdf8-4b00-9954-97785df4749e	String	jsonType.label
c78c0991-c4e1-4902-8fda-f79aeafe84f4	true	introspection.token.claim
c78c0991-c4e1-4902-8fda-f79aeafe84f4	true	userinfo.token.claim
c78c0991-c4e1-4902-8fda-f79aeafe84f4	picture	user.attribute
c78c0991-c4e1-4902-8fda-f79aeafe84f4	true	id.token.claim
c78c0991-c4e1-4902-8fda-f79aeafe84f4	true	access.token.claim
c78c0991-c4e1-4902-8fda-f79aeafe84f4	picture	claim.name
c78c0991-c4e1-4902-8fda-f79aeafe84f4	String	jsonType.label
3c10e37c-ec66-4605-9f31-6c72ecf63f0f	true	introspection.token.claim
3c10e37c-ec66-4605-9f31-6c72ecf63f0f	true	userinfo.token.claim
3c10e37c-ec66-4605-9f31-6c72ecf63f0f	emailVerified	user.attribute
3c10e37c-ec66-4605-9f31-6c72ecf63f0f	true	id.token.claim
3c10e37c-ec66-4605-9f31-6c72ecf63f0f	true	access.token.claim
3c10e37c-ec66-4605-9f31-6c72ecf63f0f	email_verified	claim.name
3c10e37c-ec66-4605-9f31-6c72ecf63f0f	boolean	jsonType.label
e222131f-e205-4845-bc7c-d4a0e91a4af0	true	introspection.token.claim
e222131f-e205-4845-bc7c-d4a0e91a4af0	true	userinfo.token.claim
e222131f-e205-4845-bc7c-d4a0e91a4af0	email	user.attribute
e222131f-e205-4845-bc7c-d4a0e91a4af0	true	id.token.claim
e222131f-e205-4845-bc7c-d4a0e91a4af0	true	access.token.claim
e222131f-e205-4845-bc7c-d4a0e91a4af0	email	claim.name
e222131f-e205-4845-bc7c-d4a0e91a4af0	String	jsonType.label
51da0e55-a04c-44e7-bc4c-8c8dfedd761c	formatted	user.attribute.formatted
51da0e55-a04c-44e7-bc4c-8c8dfedd761c	country	user.attribute.country
51da0e55-a04c-44e7-bc4c-8c8dfedd761c	true	introspection.token.claim
51da0e55-a04c-44e7-bc4c-8c8dfedd761c	postal_code	user.attribute.postal_code
51da0e55-a04c-44e7-bc4c-8c8dfedd761c	true	userinfo.token.claim
51da0e55-a04c-44e7-bc4c-8c8dfedd761c	street	user.attribute.street
51da0e55-a04c-44e7-bc4c-8c8dfedd761c	true	id.token.claim
51da0e55-a04c-44e7-bc4c-8c8dfedd761c	region	user.attribute.region
51da0e55-a04c-44e7-bc4c-8c8dfedd761c	true	access.token.claim
51da0e55-a04c-44e7-bc4c-8c8dfedd761c	locality	user.attribute.locality
4284fb58-842e-4457-ab90-7e89a34d5e86	true	introspection.token.claim
4284fb58-842e-4457-ab90-7e89a34d5e86	true	userinfo.token.claim
4284fb58-842e-4457-ab90-7e89a34d5e86	phoneNumberVerified	user.attribute
4284fb58-842e-4457-ab90-7e89a34d5e86	true	id.token.claim
4284fb58-842e-4457-ab90-7e89a34d5e86	true	access.token.claim
4284fb58-842e-4457-ab90-7e89a34d5e86	phone_number_verified	claim.name
4284fb58-842e-4457-ab90-7e89a34d5e86	boolean	jsonType.label
cd8a23b8-4abc-4647-b78e-4ad3a8cf70bd	true	introspection.token.claim
cd8a23b8-4abc-4647-b78e-4ad3a8cf70bd	true	userinfo.token.claim
cd8a23b8-4abc-4647-b78e-4ad3a8cf70bd	phoneNumber	user.attribute
cd8a23b8-4abc-4647-b78e-4ad3a8cf70bd	true	id.token.claim
cd8a23b8-4abc-4647-b78e-4ad3a8cf70bd	true	access.token.claim
cd8a23b8-4abc-4647-b78e-4ad3a8cf70bd	phone_number	claim.name
cd8a23b8-4abc-4647-b78e-4ad3a8cf70bd	String	jsonType.label
2554aca2-afe7-4d4a-b72b-51ba27dcf3a9	true	introspection.token.claim
2554aca2-afe7-4d4a-b72b-51ba27dcf3a9	true	access.token.claim
be1eb893-0abb-439d-95c8-dc43c2e1e835	true	introspection.token.claim
be1eb893-0abb-439d-95c8-dc43c2e1e835	true	multivalued
be1eb893-0abb-439d-95c8-dc43c2e1e835	foo	user.attribute
be1eb893-0abb-439d-95c8-dc43c2e1e835	true	access.token.claim
be1eb893-0abb-439d-95c8-dc43c2e1e835	resource_access.${client_id}.roles	claim.name
be1eb893-0abb-439d-95c8-dc43c2e1e835	String	jsonType.label
ed412e71-888e-4ba6-97a9-4593f75f00ec	true	introspection.token.claim
ed412e71-888e-4ba6-97a9-4593f75f00ec	true	multivalued
ed412e71-888e-4ba6-97a9-4593f75f00ec	foo	user.attribute
ed412e71-888e-4ba6-97a9-4593f75f00ec	true	access.token.claim
ed412e71-888e-4ba6-97a9-4593f75f00ec	realm_access.roles	claim.name
ed412e71-888e-4ba6-97a9-4593f75f00ec	String	jsonType.label
a6a413da-8a7a-4f77-aeda-177effc1abb5	true	introspection.token.claim
a6a413da-8a7a-4f77-aeda-177effc1abb5	true	access.token.claim
5e257217-f38c-4025-b288-15581dc9e8cd	true	introspection.token.claim
5e257217-f38c-4025-b288-15581dc9e8cd	true	multivalued
5e257217-f38c-4025-b288-15581dc9e8cd	foo	user.attribute
5e257217-f38c-4025-b288-15581dc9e8cd	true	id.token.claim
5e257217-f38c-4025-b288-15581dc9e8cd	true	access.token.claim
5e257217-f38c-4025-b288-15581dc9e8cd	groups	claim.name
5e257217-f38c-4025-b288-15581dc9e8cd	String	jsonType.label
72aab4cb-a963-46ef-8927-46a50ff99fe4	true	introspection.token.claim
72aab4cb-a963-46ef-8927-46a50ff99fe4	true	userinfo.token.claim
72aab4cb-a963-46ef-8927-46a50ff99fe4	username	user.attribute
72aab4cb-a963-46ef-8927-46a50ff99fe4	true	id.token.claim
72aab4cb-a963-46ef-8927-46a50ff99fe4	true	access.token.claim
72aab4cb-a963-46ef-8927-46a50ff99fe4	upn	claim.name
72aab4cb-a963-46ef-8927-46a50ff99fe4	String	jsonType.label
bc06db17-b28d-4015-8d0a-f7809d0638cb	true	introspection.token.claim
bc06db17-b28d-4015-8d0a-f7809d0638cb	true	id.token.claim
bc06db17-b28d-4015-8d0a-f7809d0638cb	true	access.token.claim
4887a2d4-63d9-4d05-9cce-184acd9b7936	true	introspection.token.claim
4887a2d4-63d9-4d05-9cce-184acd9b7936	true	access.token.claim
a5e2f8e2-cbb4-4686-aeaf-83e0baee5adc	AUTH_TIME	user.session.note
a5e2f8e2-cbb4-4686-aeaf-83e0baee5adc	true	introspection.token.claim
a5e2f8e2-cbb4-4686-aeaf-83e0baee5adc	true	id.token.claim
a5e2f8e2-cbb4-4686-aeaf-83e0baee5adc	true	access.token.claim
a5e2f8e2-cbb4-4686-aeaf-83e0baee5adc	auth_time	claim.name
a5e2f8e2-cbb4-4686-aeaf-83e0baee5adc	long	jsonType.label
0585dc84-d391-49c8-96cc-d92a9f20ac6c	clientHost	user.session.note
0585dc84-d391-49c8-96cc-d92a9f20ac6c	true	introspection.token.claim
0585dc84-d391-49c8-96cc-d92a9f20ac6c	true	id.token.claim
0585dc84-d391-49c8-96cc-d92a9f20ac6c	true	access.token.claim
0585dc84-d391-49c8-96cc-d92a9f20ac6c	clientHost	claim.name
0585dc84-d391-49c8-96cc-d92a9f20ac6c	String	jsonType.label
17865905-b3b4-4a14-bbf1-399e2a167fc7	clientAddress	user.session.note
17865905-b3b4-4a14-bbf1-399e2a167fc7	true	introspection.token.claim
17865905-b3b4-4a14-bbf1-399e2a167fc7	true	id.token.claim
17865905-b3b4-4a14-bbf1-399e2a167fc7	true	access.token.claim
17865905-b3b4-4a14-bbf1-399e2a167fc7	clientAddress	claim.name
17865905-b3b4-4a14-bbf1-399e2a167fc7	String	jsonType.label
582e17cf-cab4-4a15-ad62-57c5b4fb3526	client_id	user.session.note
582e17cf-cab4-4a15-ad62-57c5b4fb3526	true	introspection.token.claim
582e17cf-cab4-4a15-ad62-57c5b4fb3526	true	id.token.claim
582e17cf-cab4-4a15-ad62-57c5b4fb3526	true	access.token.claim
582e17cf-cab4-4a15-ad62-57c5b4fb3526	client_id	claim.name
582e17cf-cab4-4a15-ad62-57c5b4fb3526	String	jsonType.label
743798b3-7bbe-42b0-aa86-dd57b4901e59	true	introspection.token.claim
743798b3-7bbe-42b0-aa86-dd57b4901e59	true	multivalued
743798b3-7bbe-42b0-aa86-dd57b4901e59	true	id.token.claim
743798b3-7bbe-42b0-aa86-dd57b4901e59	true	access.token.claim
743798b3-7bbe-42b0-aa86-dd57b4901e59	organization	claim.name
743798b3-7bbe-42b0-aa86-dd57b4901e59	String	jsonType.label
98644ebd-3fce-4bde-b671-ca6dace8a112	false	single
98644ebd-3fce-4bde-b671-ca6dace8a112	Basic	attribute.nameformat
98644ebd-3fce-4bde-b671-ca6dace8a112	Role	attribute.name
0de36c89-87a8-448d-ad36-7c2ea7cb16cd	true	introspection.token.claim
0de36c89-87a8-448d-ad36-7c2ea7cb16cd	true	userinfo.token.claim
0de36c89-87a8-448d-ad36-7c2ea7cb16cd	nickname	user.attribute
0de36c89-87a8-448d-ad36-7c2ea7cb16cd	true	id.token.claim
0de36c89-87a8-448d-ad36-7c2ea7cb16cd	true	access.token.claim
0de36c89-87a8-448d-ad36-7c2ea7cb16cd	nickname	claim.name
0de36c89-87a8-448d-ad36-7c2ea7cb16cd	String	jsonType.label
188e0c6d-4aac-42f9-a4c0-8e3de700f0ba	true	introspection.token.claim
188e0c6d-4aac-42f9-a4c0-8e3de700f0ba	true	userinfo.token.claim
188e0c6d-4aac-42f9-a4c0-8e3de700f0ba	true	id.token.claim
188e0c6d-4aac-42f9-a4c0-8e3de700f0ba	true	access.token.claim
396006b1-4d9f-4706-b5f6-0494c6c883cc	true	introspection.token.claim
396006b1-4d9f-4706-b5f6-0494c6c883cc	true	userinfo.token.claim
396006b1-4d9f-4706-b5f6-0494c6c883cc	zoneinfo	user.attribute
396006b1-4d9f-4706-b5f6-0494c6c883cc	true	id.token.claim
396006b1-4d9f-4706-b5f6-0494c6c883cc	true	access.token.claim
396006b1-4d9f-4706-b5f6-0494c6c883cc	zoneinfo	claim.name
396006b1-4d9f-4706-b5f6-0494c6c883cc	String	jsonType.label
6cf4c073-34ad-4333-ac59-c755f0a3de92	true	introspection.token.claim
6cf4c073-34ad-4333-ac59-c755f0a3de92	true	userinfo.token.claim
6cf4c073-34ad-4333-ac59-c755f0a3de92	username	user.attribute
6cf4c073-34ad-4333-ac59-c755f0a3de92	true	id.token.claim
6cf4c073-34ad-4333-ac59-c755f0a3de92	true	access.token.claim
6cf4c073-34ad-4333-ac59-c755f0a3de92	preferred_username	claim.name
6cf4c073-34ad-4333-ac59-c755f0a3de92	String	jsonType.label
763e8bdb-4b16-4e9a-b7a2-6c2bddb288d5	true	introspection.token.claim
763e8bdb-4b16-4e9a-b7a2-6c2bddb288d5	true	userinfo.token.claim
763e8bdb-4b16-4e9a-b7a2-6c2bddb288d5	firstName	user.attribute
763e8bdb-4b16-4e9a-b7a2-6c2bddb288d5	true	id.token.claim
763e8bdb-4b16-4e9a-b7a2-6c2bddb288d5	true	access.token.claim
763e8bdb-4b16-4e9a-b7a2-6c2bddb288d5	given_name	claim.name
763e8bdb-4b16-4e9a-b7a2-6c2bddb288d5	String	jsonType.label
7f9ce69c-dd88-4dd3-ae20-e64f873d9d6c	true	introspection.token.claim
7f9ce69c-dd88-4dd3-ae20-e64f873d9d6c	true	userinfo.token.claim
7f9ce69c-dd88-4dd3-ae20-e64f873d9d6c	middleName	user.attribute
7f9ce69c-dd88-4dd3-ae20-e64f873d9d6c	true	id.token.claim
7f9ce69c-dd88-4dd3-ae20-e64f873d9d6c	true	access.token.claim
7f9ce69c-dd88-4dd3-ae20-e64f873d9d6c	middle_name	claim.name
7f9ce69c-dd88-4dd3-ae20-e64f873d9d6c	String	jsonType.label
8165c08f-d8ee-43f0-8892-140fe1e960d7	true	introspection.token.claim
8165c08f-d8ee-43f0-8892-140fe1e960d7	true	userinfo.token.claim
8165c08f-d8ee-43f0-8892-140fe1e960d7	gender	user.attribute
8165c08f-d8ee-43f0-8892-140fe1e960d7	true	id.token.claim
8165c08f-d8ee-43f0-8892-140fe1e960d7	true	access.token.claim
8165c08f-d8ee-43f0-8892-140fe1e960d7	gender	claim.name
8165c08f-d8ee-43f0-8892-140fe1e960d7	String	jsonType.label
8955e885-a428-4010-9ccf-95054667ace6	true	introspection.token.claim
8955e885-a428-4010-9ccf-95054667ace6	true	userinfo.token.claim
8955e885-a428-4010-9ccf-95054667ace6	website	user.attribute
8955e885-a428-4010-9ccf-95054667ace6	true	id.token.claim
8955e885-a428-4010-9ccf-95054667ace6	true	access.token.claim
8955e885-a428-4010-9ccf-95054667ace6	website	claim.name
8955e885-a428-4010-9ccf-95054667ace6	String	jsonType.label
8bec2f28-dfbc-4c9e-8adf-4a0093b36088	true	introspection.token.claim
8bec2f28-dfbc-4c9e-8adf-4a0093b36088	true	userinfo.token.claim
8bec2f28-dfbc-4c9e-8adf-4a0093b36088	birthdate	user.attribute
8bec2f28-dfbc-4c9e-8adf-4a0093b36088	true	id.token.claim
8bec2f28-dfbc-4c9e-8adf-4a0093b36088	true	access.token.claim
8bec2f28-dfbc-4c9e-8adf-4a0093b36088	birthdate	claim.name
8bec2f28-dfbc-4c9e-8adf-4a0093b36088	String	jsonType.label
921c01ed-f8c5-4e32-bd70-53b4e96e7232	true	introspection.token.claim
921c01ed-f8c5-4e32-bd70-53b4e96e7232	true	userinfo.token.claim
921c01ed-f8c5-4e32-bd70-53b4e96e7232	profile	user.attribute
921c01ed-f8c5-4e32-bd70-53b4e96e7232	true	id.token.claim
921c01ed-f8c5-4e32-bd70-53b4e96e7232	true	access.token.claim
921c01ed-f8c5-4e32-bd70-53b4e96e7232	profile	claim.name
921c01ed-f8c5-4e32-bd70-53b4e96e7232	String	jsonType.label
bd5e0d23-ad74-488b-9be7-6d69e0881e57	true	introspection.token.claim
bd5e0d23-ad74-488b-9be7-6d69e0881e57	true	userinfo.token.claim
bd5e0d23-ad74-488b-9be7-6d69e0881e57	picture	user.attribute
bd5e0d23-ad74-488b-9be7-6d69e0881e57	true	id.token.claim
bd5e0d23-ad74-488b-9be7-6d69e0881e57	true	access.token.claim
bd5e0d23-ad74-488b-9be7-6d69e0881e57	picture	claim.name
bd5e0d23-ad74-488b-9be7-6d69e0881e57	String	jsonType.label
d9f0f730-e057-46fc-a516-98471ef556af	true	introspection.token.claim
d9f0f730-e057-46fc-a516-98471ef556af	true	userinfo.token.claim
d9f0f730-e057-46fc-a516-98471ef556af	lastName	user.attribute
d9f0f730-e057-46fc-a516-98471ef556af	true	id.token.claim
d9f0f730-e057-46fc-a516-98471ef556af	true	access.token.claim
d9f0f730-e057-46fc-a516-98471ef556af	family_name	claim.name
d9f0f730-e057-46fc-a516-98471ef556af	String	jsonType.label
e7e1b390-1849-47f5-a7ef-a403f2399067	true	introspection.token.claim
e7e1b390-1849-47f5-a7ef-a403f2399067	true	userinfo.token.claim
e7e1b390-1849-47f5-a7ef-a403f2399067	updatedAt	user.attribute
e7e1b390-1849-47f5-a7ef-a403f2399067	true	id.token.claim
e7e1b390-1849-47f5-a7ef-a403f2399067	true	access.token.claim
e7e1b390-1849-47f5-a7ef-a403f2399067	updated_at	claim.name
e7e1b390-1849-47f5-a7ef-a403f2399067	long	jsonType.label
f43d3d12-c8a2-46c9-a89c-7590cba4ddea	true	introspection.token.claim
f43d3d12-c8a2-46c9-a89c-7590cba4ddea	true	userinfo.token.claim
f43d3d12-c8a2-46c9-a89c-7590cba4ddea	locale	user.attribute
f43d3d12-c8a2-46c9-a89c-7590cba4ddea	true	id.token.claim
f43d3d12-c8a2-46c9-a89c-7590cba4ddea	true	access.token.claim
f43d3d12-c8a2-46c9-a89c-7590cba4ddea	locale	claim.name
f43d3d12-c8a2-46c9-a89c-7590cba4ddea	String	jsonType.label
cf42046a-524e-4a4c-b076-6f94abae96ed	true	introspection.token.claim
cf42046a-524e-4a4c-b076-6f94abae96ed	true	userinfo.token.claim
cf42046a-524e-4a4c-b076-6f94abae96ed	emailVerified	user.attribute
cf42046a-524e-4a4c-b076-6f94abae96ed	true	id.token.claim
cf42046a-524e-4a4c-b076-6f94abae96ed	true	access.token.claim
cf42046a-524e-4a4c-b076-6f94abae96ed	email_verified	claim.name
cf42046a-524e-4a4c-b076-6f94abae96ed	boolean	jsonType.label
ed750baa-f156-4bcc-8e9d-3bb5a455c551	true	introspection.token.claim
ed750baa-f156-4bcc-8e9d-3bb5a455c551	true	userinfo.token.claim
ed750baa-f156-4bcc-8e9d-3bb5a455c551	email	user.attribute
ed750baa-f156-4bcc-8e9d-3bb5a455c551	true	id.token.claim
ed750baa-f156-4bcc-8e9d-3bb5a455c551	true	access.token.claim
ed750baa-f156-4bcc-8e9d-3bb5a455c551	email	claim.name
ed750baa-f156-4bcc-8e9d-3bb5a455c551	String	jsonType.label
7a727c55-1e36-4eaa-8588-8c4c8563d438	formatted	user.attribute.formatted
7a727c55-1e36-4eaa-8588-8c4c8563d438	country	user.attribute.country
7a727c55-1e36-4eaa-8588-8c4c8563d438	true	introspection.token.claim
7a727c55-1e36-4eaa-8588-8c4c8563d438	postal_code	user.attribute.postal_code
7a727c55-1e36-4eaa-8588-8c4c8563d438	true	userinfo.token.claim
7a727c55-1e36-4eaa-8588-8c4c8563d438	street	user.attribute.street
7a727c55-1e36-4eaa-8588-8c4c8563d438	true	id.token.claim
7a727c55-1e36-4eaa-8588-8c4c8563d438	region	user.attribute.region
7a727c55-1e36-4eaa-8588-8c4c8563d438	true	access.token.claim
7a727c55-1e36-4eaa-8588-8c4c8563d438	locality	user.attribute.locality
0e38b198-45be-47a4-8c3d-0254baddbbff	true	introspection.token.claim
0e38b198-45be-47a4-8c3d-0254baddbbff	true	userinfo.token.claim
0e38b198-45be-47a4-8c3d-0254baddbbff	phoneNumber	user.attribute
0e38b198-45be-47a4-8c3d-0254baddbbff	true	id.token.claim
0e38b198-45be-47a4-8c3d-0254baddbbff	true	access.token.claim
0e38b198-45be-47a4-8c3d-0254baddbbff	phone_number	claim.name
0e38b198-45be-47a4-8c3d-0254baddbbff	String	jsonType.label
ac8e7740-4b69-43e1-89ae-9ffc1bfef8c6	true	introspection.token.claim
ac8e7740-4b69-43e1-89ae-9ffc1bfef8c6	true	userinfo.token.claim
ac8e7740-4b69-43e1-89ae-9ffc1bfef8c6	phoneNumberVerified	user.attribute
ac8e7740-4b69-43e1-89ae-9ffc1bfef8c6	true	id.token.claim
ac8e7740-4b69-43e1-89ae-9ffc1bfef8c6	true	access.token.claim
ac8e7740-4b69-43e1-89ae-9ffc1bfef8c6	phone_number_verified	claim.name
ac8e7740-4b69-43e1-89ae-9ffc1bfef8c6	boolean	jsonType.label
296bf9c4-3fb5-40cc-aef9-e0802b0ebb76	true	introspection.token.claim
296bf9c4-3fb5-40cc-aef9-e0802b0ebb76	true	multivalued
296bf9c4-3fb5-40cc-aef9-e0802b0ebb76	foo	user.attribute
296bf9c4-3fb5-40cc-aef9-e0802b0ebb76	true	access.token.claim
296bf9c4-3fb5-40cc-aef9-e0802b0ebb76	resource_access.${client_id}.roles	claim.name
296bf9c4-3fb5-40cc-aef9-e0802b0ebb76	String	jsonType.label
32107030-2e3e-4b46-88c9-d07680b4f4c7	true	introspection.token.claim
32107030-2e3e-4b46-88c9-d07680b4f4c7	true	access.token.claim
57b62e43-ffec-425d-8608-46d79237487e	true	introspection.token.claim
57b62e43-ffec-425d-8608-46d79237487e	true	multivalued
57b62e43-ffec-425d-8608-46d79237487e	foo	user.attribute
57b62e43-ffec-425d-8608-46d79237487e	true	access.token.claim
57b62e43-ffec-425d-8608-46d79237487e	realm_access.roles	claim.name
57b62e43-ffec-425d-8608-46d79237487e	String	jsonType.label
3e9fb413-876a-4d0e-bbf6-2a03dced7a29	true	introspection.token.claim
3e9fb413-876a-4d0e-bbf6-2a03dced7a29	true	access.token.claim
4f53e7ca-3f4e-4a51-8979-2e9eb9e57217	true	introspection.token.claim
4f53e7ca-3f4e-4a51-8979-2e9eb9e57217	true	multivalued
4f53e7ca-3f4e-4a51-8979-2e9eb9e57217	foo	user.attribute
4f53e7ca-3f4e-4a51-8979-2e9eb9e57217	true	id.token.claim
4f53e7ca-3f4e-4a51-8979-2e9eb9e57217	true	access.token.claim
4f53e7ca-3f4e-4a51-8979-2e9eb9e57217	groups	claim.name
4f53e7ca-3f4e-4a51-8979-2e9eb9e57217	String	jsonType.label
6b1f88ee-bbf2-437e-bd0a-e45b5c8a52bc	true	introspection.token.claim
6b1f88ee-bbf2-437e-bd0a-e45b5c8a52bc	true	userinfo.token.claim
6b1f88ee-bbf2-437e-bd0a-e45b5c8a52bc	username	user.attribute
6b1f88ee-bbf2-437e-bd0a-e45b5c8a52bc	true	id.token.claim
6b1f88ee-bbf2-437e-bd0a-e45b5c8a52bc	true	access.token.claim
6b1f88ee-bbf2-437e-bd0a-e45b5c8a52bc	upn	claim.name
6b1f88ee-bbf2-437e-bd0a-e45b5c8a52bc	String	jsonType.label
7dcba050-0f58-48fc-a580-077504783e4a	true	introspection.token.claim
7dcba050-0f58-48fc-a580-077504783e4a	true	id.token.claim
7dcba050-0f58-48fc-a580-077504783e4a	true	access.token.claim
02203e30-f560-473b-9183-767961c978c9	AUTH_TIME	user.session.note
02203e30-f560-473b-9183-767961c978c9	true	introspection.token.claim
02203e30-f560-473b-9183-767961c978c9	true	id.token.claim
02203e30-f560-473b-9183-767961c978c9	true	access.token.claim
02203e30-f560-473b-9183-767961c978c9	auth_time	claim.name
02203e30-f560-473b-9183-767961c978c9	long	jsonType.label
bd0256bc-60d7-445e-b581-1305e9d69dbe	true	introspection.token.claim
bd0256bc-60d7-445e-b581-1305e9d69dbe	true	access.token.claim
20c75609-4bd8-47e8-980c-67739e3e5abc	client_id	user.session.note
20c75609-4bd8-47e8-980c-67739e3e5abc	true	introspection.token.claim
20c75609-4bd8-47e8-980c-67739e3e5abc	true	id.token.claim
20c75609-4bd8-47e8-980c-67739e3e5abc	true	access.token.claim
20c75609-4bd8-47e8-980c-67739e3e5abc	client_id	claim.name
20c75609-4bd8-47e8-980c-67739e3e5abc	String	jsonType.label
4d8ac621-bd3f-4036-b8ff-164db3f8f125	clientAddress	user.session.note
4d8ac621-bd3f-4036-b8ff-164db3f8f125	true	introspection.token.claim
4d8ac621-bd3f-4036-b8ff-164db3f8f125	true	id.token.claim
4d8ac621-bd3f-4036-b8ff-164db3f8f125	true	access.token.claim
4d8ac621-bd3f-4036-b8ff-164db3f8f125	clientAddress	claim.name
4d8ac621-bd3f-4036-b8ff-164db3f8f125	String	jsonType.label
fcd86128-ebd9-4416-b699-594395dc7ecf	clientHost	user.session.note
fcd86128-ebd9-4416-b699-594395dc7ecf	true	introspection.token.claim
fcd86128-ebd9-4416-b699-594395dc7ecf	true	id.token.claim
fcd86128-ebd9-4416-b699-594395dc7ecf	true	access.token.claim
fcd86128-ebd9-4416-b699-594395dc7ecf	clientHost	claim.name
fcd86128-ebd9-4416-b699-594395dc7ecf	String	jsonType.label
edf4e5ec-6225-406c-b2c3-a56599800c29	true	introspection.token.claim
edf4e5ec-6225-406c-b2c3-a56599800c29	true	multivalued
edf4e5ec-6225-406c-b2c3-a56599800c29	true	id.token.claim
edf4e5ec-6225-406c-b2c3-a56599800c29	true	access.token.claim
edf4e5ec-6225-406c-b2c3-a56599800c29	organization	claim.name
edf4e5ec-6225-406c-b2c3-a56599800c29	String	jsonType.label
8ea722ba-1256-47f1-94c6-2cbc467e65cc	true	introspection.token.claim
8ea722ba-1256-47f1-94c6-2cbc467e65cc	true	userinfo.token.claim
8ea722ba-1256-47f1-94c6-2cbc467e65cc	locale	user.attribute
8ea722ba-1256-47f1-94c6-2cbc467e65cc	true	id.token.claim
8ea722ba-1256-47f1-94c6-2cbc467e65cc	true	access.token.claim
8ea722ba-1256-47f1-94c6-2cbc467e65cc	locale	claim.name
8ea722ba-1256-47f1-94c6-2cbc467e65cc	String	jsonType.label
3364af96-25e6-44af-8483-1ccec645977f	true	id.token.claim
3364af96-25e6-44af-8483-1ccec645977f	true	userinfo.token.claim
553bbb28-38f6-47d2-8b65-759ba95766eb	konneqt-client	included.client.audience
553bbb28-38f6-47d2-8b65-759ba95766eb	true	id.token.claim
553bbb28-38f6-47d2-8b65-759ba95766eb	false	lightweight.claim
553bbb28-38f6-47d2-8b65-759ba95766eb	true	access.token.claim
553bbb28-38f6-47d2-8b65-759ba95766eb	true	introspection.token.claim
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
5f0779df-8cd1-4b52-a60e-1e1a4d45427b	60	300	300	\N	\N	\N	t	f	0	\N	test	0	\N	f	f	f	f	NONE	1800	36000	f	f	51f791d3-4755-4ea2-95d7-7e542678ef8b	1800	f	\N	t	f	f	f	0	1	30	6	HmacSHA1	totp	76de9e12-a2d1-4a97-8442-366f639c5b30	d6547f22-bf7f-4f96-8cf9-4043d2b27714	9480b681-84b6-4ce4-a146-c9ed13c90cf8	a27f3838-a86b-4dce-93a8-b0c81f5048e7	1c15dbb6-83a5-40a1-83dc-255a3a5de2a5	2592000	f	900	t	f	6b72a724-8d38-4482-af96-a2cfdcd320a7	0	f	0	0	a47668a7-90ba-4d44-96c4-93930acdfabc
a4e86523-4f8b-4056-9322-55cde86f8d6b	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	809c5e1b-41ea-43b5-8d50-2f07c7b09c0a	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	03b21981-11c6-4730-847a-4f3e124ac80e	f09d464a-0196-4f4d-a472-7e860f239802	6b76fbfc-6ee2-4c53-b7e0-3866fcd92d38	343a2350-0675-4f91-b2db-b15b7fefe948	14b049d8-0e4f-4078-a798-f8ab0fa49490	2592000	f	900	t	f	999fc94d-4669-4023-992c-ad06f0510cde	0	f	0	0	f358359a-8685-476e-a74e-0a0377ff1d90
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	a4e86523-4f8b-4056-9322-55cde86f8d6b	
_browser_header.xContentTypeOptions	a4e86523-4f8b-4056-9322-55cde86f8d6b	nosniff
_browser_header.referrerPolicy	a4e86523-4f8b-4056-9322-55cde86f8d6b	no-referrer
_browser_header.xRobotsTag	a4e86523-4f8b-4056-9322-55cde86f8d6b	none
_browser_header.xFrameOptions	a4e86523-4f8b-4056-9322-55cde86f8d6b	SAMEORIGIN
_browser_header.contentSecurityPolicy	a4e86523-4f8b-4056-9322-55cde86f8d6b	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	a4e86523-4f8b-4056-9322-55cde86f8d6b	1; mode=block
_browser_header.strictTransportSecurity	a4e86523-4f8b-4056-9322-55cde86f8d6b	max-age=31536000; includeSubDomains
bruteForceProtected	a4e86523-4f8b-4056-9322-55cde86f8d6b	false
permanentLockout	a4e86523-4f8b-4056-9322-55cde86f8d6b	false
maxTemporaryLockouts	a4e86523-4f8b-4056-9322-55cde86f8d6b	0
bruteForceStrategy	a4e86523-4f8b-4056-9322-55cde86f8d6b	MULTIPLE
maxFailureWaitSeconds	a4e86523-4f8b-4056-9322-55cde86f8d6b	900
minimumQuickLoginWaitSeconds	a4e86523-4f8b-4056-9322-55cde86f8d6b	60
waitIncrementSeconds	a4e86523-4f8b-4056-9322-55cde86f8d6b	60
quickLoginCheckMilliSeconds	a4e86523-4f8b-4056-9322-55cde86f8d6b	1000
maxDeltaTimeSeconds	a4e86523-4f8b-4056-9322-55cde86f8d6b	43200
failureFactor	a4e86523-4f8b-4056-9322-55cde86f8d6b	30
realmReusableOtpCode	a4e86523-4f8b-4056-9322-55cde86f8d6b	false
firstBrokerLoginFlowId	a4e86523-4f8b-4056-9322-55cde86f8d6b	9c85948d-2150-4a1e-a2bf-6d60f043616a
displayName	a4e86523-4f8b-4056-9322-55cde86f8d6b	Keycloak
displayNameHtml	a4e86523-4f8b-4056-9322-55cde86f8d6b	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	a4e86523-4f8b-4056-9322-55cde86f8d6b	RS256
offlineSessionMaxLifespanEnabled	a4e86523-4f8b-4056-9322-55cde86f8d6b	false
offlineSessionMaxLifespan	a4e86523-4f8b-4056-9322-55cde86f8d6b	5184000
bruteForceProtected	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	false
permanentLockout	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	false
maxTemporaryLockouts	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	0
bruteForceStrategy	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	MULTIPLE
maxFailureWaitSeconds	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	900
minimumQuickLoginWaitSeconds	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	60
waitIncrementSeconds	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	60
quickLoginCheckMilliSeconds	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	1000
maxDeltaTimeSeconds	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	43200
failureFactor	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	30
realmReusableOtpCode	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	false
defaultSignatureAlgorithm	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	RS256
offlineSessionMaxLifespanEnabled	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	false
offlineSessionMaxLifespan	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	5184000
actionTokenGeneratedByAdminLifespan	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	43200
actionTokenGeneratedByUserLifespan	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	300
oauth2DeviceCodeLifespan	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	600
oauth2DevicePollingInterval	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	5
webAuthnPolicyRpEntityName	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	keycloak
webAuthnPolicySignatureAlgorithms	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	ES256,RS256
webAuthnPolicyRpId	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	
webAuthnPolicyAttestationConveyancePreference	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	not specified
webAuthnPolicyAuthenticatorAttachment	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	not specified
webAuthnPolicyRequireResidentKey	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	not specified
webAuthnPolicyUserVerificationRequirement	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	not specified
webAuthnPolicyCreateTimeout	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	0
webAuthnPolicyAvoidSameAuthenticatorRegister	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	false
webAuthnPolicyRpEntityNamePasswordless	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	ES256,RS256
webAuthnPolicyRpIdPasswordless	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	
webAuthnPolicyAttestationConveyancePreferencePasswordless	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	not specified
webAuthnPolicyRequireResidentKeyPasswordless	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	not specified
webAuthnPolicyCreateTimeoutPasswordless	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	false
cibaBackchannelTokenDeliveryMode	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	poll
cibaExpiresIn	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	120
cibaInterval	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	5
cibaAuthRequestedUserHint	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	login_hint
parRequestUriLifespan	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	60
firstBrokerLoginFlowId	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	cf0e846c-9965-4e68-a926-90da89ceffea
acr.loa.map	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	{}
displayName	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	
displayNameHtml	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	
organizationsEnabled	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	false
adminPermissionsEnabled	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	false
verifiableCredentialsEnabled	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	false
clientSessionIdleTimeout	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	0
clientSessionMaxLifespan	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	0
clientOfflineSessionIdleTimeout	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	0
clientOfflineSessionMaxLifespan	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	0
client-policies.profiles	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	{"profiles":[]}
client-policies.policies	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	{"policies":[]}
frontendUrl	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	
_browser_header.contentSecurityPolicyReportOnly	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	
_browser_header.xContentTypeOptions	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	nosniff
_browser_header.referrerPolicy	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	no-referrer
_browser_header.xRobotsTag	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	none
_browser_header.xFrameOptions	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	SAMEORIGIN
_browser_header.contentSecurityPolicy	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	1; mode=block
_browser_header.strictTransportSecurity	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	max-age=31536000; includeSubDomains
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
a4e86523-4f8b-4056-9322-55cde86f8d6b	jboss-logging
5f0779df-8cd1-4b52-a60e-1e1a4d45427b	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	a4e86523-4f8b-4056-9322-55cde86f8d6b
password	password	t	t	5f0779df-8cd1-4b52-a60e-1e1a4d45427b
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.redirect_uris (client_id, value) FROM stdin;
54d8b736-b0fe-4bc6-8be3-6f6cc4d919d4	/realms/master/account/*
4daf458a-6353-4178-8200-93f1810528ce	/realms/master/account/*
ee5b168a-aa3e-45a0-8234-372b64c37985	/admin/master/console/*
9e9ca8d3-de61-4566-91b1-0be5ae703db7	/realms/test/account/*
3df67013-7d9d-4b13-816f-289b30cea5e4	/realms/test/account/*
c4c5adc2-82c6-40cd-bbce-4357646cb30b	/admin/test/console/*
3b16b7ba-488a-4efc-9713-c1d6a43e7abf	http://localhost:5173/*
24ec7eab-9e90-4a7a-b133-5ab5f2945566	/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
c4af4611-a4f5-4284-8466-48dfbdc8d10d	VERIFY_EMAIL	Verify Email	a4e86523-4f8b-4056-9322-55cde86f8d6b	t	f	VERIFY_EMAIL	50
4fae6b62-91d6-4a32-b9ad-66f0b239f46f	UPDATE_PROFILE	Update Profile	a4e86523-4f8b-4056-9322-55cde86f8d6b	t	f	UPDATE_PROFILE	40
66e82bba-c8aa-45b4-b33e-4739696bac37	CONFIGURE_TOTP	Configure OTP	a4e86523-4f8b-4056-9322-55cde86f8d6b	t	f	CONFIGURE_TOTP	10
ea6dac38-3bd1-4719-8008-389e9d476f83	UPDATE_PASSWORD	Update Password	a4e86523-4f8b-4056-9322-55cde86f8d6b	t	f	UPDATE_PASSWORD	30
4ecf79a8-d106-4748-b660-b078e3d285c0	TERMS_AND_CONDITIONS	Terms and Conditions	a4e86523-4f8b-4056-9322-55cde86f8d6b	f	f	TERMS_AND_CONDITIONS	20
d109453f-1db8-407d-b3aa-7453f8c505ce	delete_account	Delete Account	a4e86523-4f8b-4056-9322-55cde86f8d6b	f	f	delete_account	60
af889955-ed82-4265-91d5-49c538d4fe9e	delete_credential	Delete Credential	a4e86523-4f8b-4056-9322-55cde86f8d6b	t	f	delete_credential	100
2e3fe2ed-884c-4d3a-bea0-3a06e9d88b3c	update_user_locale	Update User Locale	a4e86523-4f8b-4056-9322-55cde86f8d6b	t	f	update_user_locale	1000
35632ed2-6a2b-4d5b-b926-4ed039d31cce	webauthn-register	Webauthn Register	a4e86523-4f8b-4056-9322-55cde86f8d6b	t	f	webauthn-register	70
64a16d74-0d1d-4cd6-a6d5-6838f6bd2d73	webauthn-register-passwordless	Webauthn Register Passwordless	a4e86523-4f8b-4056-9322-55cde86f8d6b	t	f	webauthn-register-passwordless	80
9f5dbed2-e3a9-4240-8958-ddc6b8a56ca8	VERIFY_PROFILE	Verify Profile	a4e86523-4f8b-4056-9322-55cde86f8d6b	t	f	VERIFY_PROFILE	90
8ed89cc6-2b55-4df0-ba34-4da4e345ed79	VERIFY_EMAIL	Verify Email	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	t	f	VERIFY_EMAIL	50
9c5d7bbd-03a0-4498-b107-8af37cb11875	UPDATE_PROFILE	Update Profile	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	t	f	UPDATE_PROFILE	40
11afdaaf-b999-4b0c-a0ce-cd5e52bd12b3	CONFIGURE_TOTP	Configure OTP	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	t	f	CONFIGURE_TOTP	10
89f614c2-8676-4513-905a-1cd3961d552a	UPDATE_PASSWORD	Update Password	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	t	f	UPDATE_PASSWORD	30
52b5af8d-9716-443b-b45d-bcd1912e3cb0	TERMS_AND_CONDITIONS	Terms and Conditions	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	f	f	TERMS_AND_CONDITIONS	20
146cafc9-3998-4c4c-a31b-867c35b5cafa	delete_account	Delete Account	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	f	f	delete_account	60
7816c628-8402-410d-ae70-867becc1f9fd	delete_credential	Delete Credential	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	t	f	delete_credential	100
176373fe-65b1-4903-9f4b-918afb4c349f	update_user_locale	Update User Locale	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	t	f	update_user_locale	1000
b92fda83-f69f-4d91-8470-8f5ebe7426b8	webauthn-register	Webauthn Register	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	t	f	webauthn-register	70
52ac475f-239f-4c6f-babc-8132ceb451a9	webauthn-register-passwordless	Webauthn Register Passwordless	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	t	f	webauthn-register-passwordless	80
2390b928-b9ce-4e68-8c14-d1bfe668008d	VERIFY_PROFILE	Verify Profile	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	t	f	VERIFY_PROFILE	90
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: revoked_token; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.revoked_token (id, expire) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
4daf458a-6353-4178-8200-93f1810528ce	82403810-6f6e-4b7a-b8ac-eb19d379e8f5
4daf458a-6353-4178-8200-93f1810528ce	c6cb6148-7b94-42b1-9302-4191f23e742d
3df67013-7d9d-4b13-816f-289b30cea5e4	f7ecb692-039e-4a6a-8349-a700e511d8f5
3df67013-7d9d-4b13-816f-289b30cea5e4	c3b367aa-ea8a-4367-b115-e8910cc00fca
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.user_attribute (name, value, user_id, id, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
is_temporary_admin	true	c0ff7eb4-4791-4ed3-803c-20f007adc569	9d25a87f-535a-4923-802b-a383865a7934	\N	\N	\N
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
c0ff7eb4-4791-4ed3-803c-20f007adc569	\N	e1ab16ad-e85e-4681-8ef0-0c21b20174a7	f	t	\N	\N	\N	a4e86523-4f8b-4056-9322-55cde86f8d6b	admin	1743550959736	\N	0
5f40838c-6e18-4a41-b816-e29a9e019286	diegoboliveira@gmail.com	diegoboliveira@gmail.com	t	t	\N	\N	\N	a4e86523-4f8b-4056-9322-55cde86f8d6b	teste	1743551174100	\N	0
4e48928f-011c-4328-a833-650027c2134c	diego@gmail.com	diego@gmail.com	f	t	\N	diego	brandao	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	diego@gmail.com	1743651623350	\N	0
e9e23729-849d-46e8-9648-8e77cd432f5c	diegoboliveira@gmail.com	diegoboliveira@gmail.com	f	t	\N	diego	oliveira	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	diegoboliveira@gmail.com	1743652194860	\N	0
51999ff8-b173-4545-a0b3-cbf01267056d	\N	148c23c6-4ff2-4884-9c85-213a14910ed1	f	t	\N	\N	\N	5f0779df-8cd1-4b52-a60e-1e1a4d45427b	service-account-spring-api	1743652901012	24ec7eab-9e90-4a7a-b133-5ab5f2945566	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.user_group_membership (group_id, user_id, membership_type) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
f358359a-8685-476e-a74e-0a0377ff1d90	c0ff7eb4-4791-4ed3-803c-20f007adc569
aae70eac-253c-46e5-861a-a64a163947dc	c0ff7eb4-4791-4ed3-803c-20f007adc569
f358359a-8685-476e-a74e-0a0377ff1d90	5f40838c-6e18-4a41-b816-e29a9e019286
aae70eac-253c-46e5-861a-a64a163947dc	5f40838c-6e18-4a41-b816-e29a9e019286
a47668a7-90ba-4d44-96c4-93930acdfabc	4e48928f-011c-4328-a833-650027c2134c
a47668a7-90ba-4d44-96c4-93930acdfabc	e9e23729-849d-46e8-9648-8e77cd432f5c
a47668a7-90ba-4d44-96c4-93930acdfabc	51999ff8-b173-4545-a0b3-cbf01267056d
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.web_origins (client_id, value) FROM stdin;
ee5b168a-aa3e-45a0-8234-372b64c37985	+
c4c5adc2-82c6-40cd-bbce-4357646cb30b	+
3b16b7ba-488a-4efc-9713-c1d6a43e7abf	/*
3b16b7ba-488a-4efc-9713-c1d6a43e7abf	http://localhost:5173
24ec7eab-9e90-4a7a-b133-5ab5f2945566	/*
\.


--
-- Name: org_domain ORG_DOMAIN_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.org_domain
    ADD CONSTRAINT "ORG_DOMAIN_pkey" PRIMARY KEY (id, name);


--
-- Name: org ORG_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT "ORG_pkey" PRIMARY KEY (id);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: jgroups_ping constraint_jgroups_ping; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.jgroups_ping
    ADD CONSTRAINT constraint_jgroups_ping PRIMARY KEY (address);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: revoked_token constraint_rt; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.revoked_token
    ADD CONSTRAINT constraint_rt PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: user_consent uk_external_consent; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_external_consent UNIQUE (client_storage_provider, external_client_id, user_id);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_local_consent; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_local_consent UNIQUE (client_id, user_id);


--
-- Name: org uk_org_alias; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_alias UNIQUE (realm_id, alias);


--
-- Name: org uk_org_group; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_group UNIQUE (group_id);


--
-- Name: org uk_org_name; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_name UNIQUE (realm_id, name);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: fed_user_attr_long_values; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX fed_user_attr_long_values ON public.fed_user_attribute USING btree (long_value_hash, name);


--
-- Name: fed_user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX fed_user_attr_long_values_lower_case ON public.fed_user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, substr(value, 1, 255));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_idp_for_login; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_idp_for_login ON public.identity_provider USING btree (realm_id, enabled, link_only, hide_on_login, organization_id);


--
-- Name: idx_idp_realm_org; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_idp_realm_org ON public.identity_provider USING btree (realm_id, organization_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_uss_by_broker_session_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_offline_uss_by_broker_session_id ON public.offline_user_session USING btree (broker_session_id, realm_id);


--
-- Name: idx_offline_uss_by_last_session_refresh; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_offline_uss_by_last_session_refresh ON public.offline_user_session USING btree (realm_id, offline_flag, last_session_refresh);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_org_domain_org_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_org_domain_org_id ON public.org_domain USING btree (org_id);


--
-- Name: idx_perm_ticket_owner; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_perm_ticket_owner ON public.resource_server_perm_ticket USING btree (owner);


--
-- Name: idx_perm_ticket_requester; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_perm_ticket_requester ON public.resource_server_perm_ticket USING btree (requester);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_rev_token_on_expire; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_rev_token_on_expire ON public.revoked_token USING btree (expire);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_usconsent_scope_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_usconsent_scope_id ON public.user_consent_client_scope USING btree (scope_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: user_attr_long_values; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX user_attr_long_values ON public.user_attribute USING btree (long_value_hash, name);


--
-- Name: user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX user_attr_long_values_lower_case ON public.user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

