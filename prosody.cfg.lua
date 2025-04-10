-- Prosody XMPP Server Configuration
--
-- Information on configuring Prosody can be found on our
-- website at https://prosody.im/doc/configure
--
-- Tip: You can check that the syntax of this file is correct
-- when you have finished by running this command:
--     prosodyctl check config
-- If there are any errors, it will let you know what and where
-- they are, otherwise it will keep quiet.
--
-- Good luck, and happy Jabbering!


---------- Server-wide settings ----------
-- Settings in this section apply to the whole server and are the default settings
-- for any virtual hosts

-- This is a (by default, empty) list of accounts that are admins
-- for the server. Note that you must create the accounts separately
-- (see https://prosody.im/doc/creating_accounts for info)
-- Example: admins = { "user1@example.com", "user2@example.net" }
admins = {"jjj333@pain.agency"}

-- This option allows you to specify additional locations where Prosody
-- will search first for modules. For additional modules you can install, see
-- the community module repository at https://modules.prosody.im/
--plugin_paths = {}

-- This is the list of modules Prosody will load on startup.
-- Documentation for bundled modules can be found at: https://prosody.im/doc/modules
modules_enabled = {

        -- Generally required
                "disco"; -- Service discovery
                "roster"; -- Allow users to have a roster. Recommended ;)
                "saslauth"; -- Authentication for clients and servers. Recommended if you want to log in.
                "tls"; -- Add support for secure TLS on c2s/s2s connections

        -- Not essential, but recommended
                "blocklist"; -- Allow users to block communications with other users
                "bookmarks"; -- Synchronise the list of open rooms between clients
                "carbons"; -- Keep multiple online clients in sync
                "dialback"; -- Support for verifying remote servers using DNS
                "limits"; -- Enable bandwidth limiting for XMPP connections
                "pep"; -- Allow users to store public and private data in their account
                "private"; -- Legacy account storage mechanism (XEP-0049)
                "smacks"; -- Stream management and resumption (XEP-0198)
                "vcard4"; -- User profiles (stored in PEP)
                "vcard_legacy"; -- Conversion between legacy vCard and PEP Avatar, vcard

        -- Nice to have
                "csi_simple"; -- Simple but effective traffic optimizations for mobile devices
                "ping"; -- Replies to XMPP pings with pongs
                "register"; -- Allow users to register on this server using a client and change passwords
                "time"; -- Let others know the time here on this server
                "uptime"; -- Report how long server has been running
                "version"; -- Replies to server version requests
                "mam"; -- Store recent messages to allow multi-device synchronization
                "turn_external"; -- Provide external STUN/TURN service for e.g. audio/video calls

        -- Admin interfaces
                "admin_adhoc"; -- Allows administration via an XMPP client that supports ad-hoc commands
                "admin_shell"; -- Allow secure administration via 'prosodyctl shell'

        -- HTTP modules
                "bosh"; -- Enable BOSH clients, aka "Jabber over HTTP"
                --"http_openmetrics"; -- for exposing metrics to stats collectors
                "websocket"; -- XMPP over WebSockets
                "http_libjs";

        -- Other specific functionality
                "announce"; -- Send announcement to all online users
                --"groups"; -- Shared roster support
                --"legacyauth"; -- Legacy authentication. Only used by some old clients and bots.
                "mimicking"; -- Prevent address spoofing
                --"motd"; -- Send a message to users when they log in
                "s2s_bidi"; -- Bi-directional server-to-server (XEP-0288)
                "server_contact_info"; -- Publish contact information for this service
                "tombstones"; -- Prevent registration of deleted accounts
                "watchregistrations"; -- Alert admins of registrations
                "welcome"; -- Welcome users who register accounts

                -- USER ENABLED MODULES
                "cloud_notify";
                "cloud_notify_extensions";
                --"http_files";
                "http_altconnect";
                "lastactivity";
                "privilege";
                "mod_invites";
                "invites"; -- Create and manage invites
                "invites_adhoc"; -- Allow admins/users to create invitations via their client
                "invites_register"; -- Allows invited users to create accounts
                "invites_register_web"; -- web regis
                "invites_page"; --web page for registration
                "invites_api"; --api for generating invites
                "register_apps"; --app list for registration webpage
}

-- These modules are auto-loaded, but should you want
-- to disable them then uncomment them here:
modules_disabled = {
        -- "offline"; -- Store offline messages
        -- "c2s"; -- Handle client connections
        -- "s2s"; -- Handle server-to-server connections
        -- "posix"; -- POSIX functionality, sends server to background, etc.
}

--invite configuration
allow_registration = true
registration_invite_only = true
invites_page = "http://localhost:5281/invites_page?{invite.token}"
invites_registration_page = "register?t={invite.token}&c={app.id}"
site_name = "pain.agency"
http_external_url = "https://xmpp-registration.pain.agency/"
site_apps = {
    {
        name  = "Gajim";
        text  = [[A fully-featured desktop chat client for Windows and Linux.]];
        image = "https://gajim.org/img/gajim-logo.png";
        link  = "https://gajim.org/";
        platforms = { "Windows", "Linux" };
        download = {
            buttons = {
                { 
                    text = "Download Gajim";
                    url = "https://gajim.org/download/";
                    target = "_blank";
                };
            };
        };
    };
}

-- Server-to-server authentication
-- Require valid certificates for server-to-server connections?
-- If false, other methods such as dialback (DNS) may be used instead.

s2s_secure_auth = true
c2s_require_encryption = true
s2s_require_encryption = true

-- Some servers have invalid or self-signed certificates. You can list
-- remote domains here that will not be required to authenticate using
-- certificates. They will be authenticated using other methods instead,
-- even when s2s_secure_auth is enabled.

--s2s_insecure_domains = { "insecure.example" }

-- Even if you disable s2s_secure_auth, you can still require valid
-- certificates for some domains by specifying a list here.

--s2s_secure_domains = { "jabber.org" }

plugin_server = "https://modules.prosody.im/rocks/"

-- Rate limits
-- Enable rate limits for incoming client and server connections. These help
-- protect from excessive resource consumption and denial-of-service attacks.

limits = {
        c2s = {
                rate = "10mb/s";
        };
        s2sin = {
                rate = "5mb/s";
        };
}

-- Required for init scripts and prosodyctl
pidfile = "/var/run/prosody/prosody.pid"

-- Authentication
-- Select the authentication backend to use. The 'internal' providers
-- use Prosody's configured data storage to store the authentication data.
-- For more information see https://prosody.im/doc/authentication

authentication = "internal_hashed"

-- Many authentication providers, including the default one, allow you to
-- create user accounts via Prosody's admin interfaces. For details, see the
-- documentation at https://prosody.im/doc/creating_accounts


-- Storage
-- Select the storage backend to use. By default Prosody uses flat files
-- in its configured data directory, but it also supports more backends
-- through modules. An "sql" backend is included by default, but requires
-- additional dependencies. See https://prosody.im/doc/storage for more info.

--storage = "sql" -- Default is "internal"

-- For the "sql" backend, you can uncomment *one* of the below to configure:
--sql = { driver = "SQLite3", database = "prosody.sqlite" } -- Default. 'database' is the filename.
--sql = { driver = "MySQL", database = "prosody", username = "prosody", password = "secret", host = "localhost" }
--sql = { driver = "PostgreSQL", database = "prosody", username = "prosody", password = "secret", host = "localhost" }


-- Archiving configuration
-- If mod_mam is enabled, Prosody will store a copy of every message. This
-- is used to synchronize conversations between multiple clients, even if
-- they are offline. This setting controls how long Prosody will keep
-- messages in the archive before removing them.

archive_expires_after = "4w" -- Remove archived messages after 4 week

-- You can also configure messages to be stored in-memory only. For more
-- archiving options, see https://prosody.im/doc/modules/mod_mam


-- Audio/video call relay (STUN/TURN)
-- To ensure clients connected to the server can establish connections for
-- low-latency media streaming (such as audio and video calls), it is
-- recommended to run a STUN/TURN server for clients to use. If you do this,
-- specify the details here so clients can discover it.
-- Find more information at https://prosody.im/doc/turn

-- Specify the address of the TURN service (you may use the same domain as XMPP)
--turn_external_host = "turn.example.com"

-- This secret must be set to the same value in both Prosody and the TURN server
--turn_external_secret = "your-secret-turn-access-token"


-- Logging configuration
-- For advanced logging see https://prosody.im/doc/logging
log = {
        info = "/var/log/prosody/prosody.log"; -- Change 'info' to 'debug' for verbose logging
        error = "/var/log/prosody/prosody.err";
        -- "*syslog"; -- Uncomment this for logging to syslog
        -- "*console"; -- Log to the console, useful for debugging when running in the foreground
}


-- Uncomment to enable statistics
-- For more info see https://prosody.im/doc/statistics
-- statistics = "internal"


-- Certificates
-- Every virtual host and component needs a certificate so that clients and
-- servers can securely verify its identity. Prosody will automatically load
-- certificates/keys from the directory specified here.
-- For more information, including how to use 'prosodyctl' to auto-import certificates
-- (from e.g. Let's Encrypt) see https://prosody.im/doc/certificates

-- Location of directory to find certificates in (relative to main config file):
certificates = "certs"

-- User Settings
user_tombstone_expire = 60 * 86400
smacks_hibernation_time = 86400

expose_publisher = true
c2s_ports = { 5222 }
s2s_ports = { 5269 }
c2s_direct_tls_ports = { 5223 }
s2s_direct_tls_ports = { 5270 }
http_ports = { 5280 }

pep_max_items = 10000

-- turn_external_host = "screm.test4d.org"
-- turn_external_secret = "secret"

contact_info = {
        admin = { "mailto:jjj333.p.1325@gmail.com", "xmpp:jjj333@pain.agency", "tel:+17404811253" },
        support = { "mailto:jjj333.p.1325@gmail.com", "xmpp:jjj333@pain.agency", "tel:+17404811253" },
        abuse = { "mailto:jjj333.p.1325@gmail.com", "xmpp:jjj333@pain.agency", "tel:+17404811253" }
}

trusted_proxies = { "127.0.0.1", "::1"}
--groups_file = "/etc/prosody/groups.ini"

-- Reserved usernames
-- See https://modules.prosody.im/mod_block_registrations

block_registrations_users = { "pain.agency", "jjj333_p", "jjj333_p_1325", "jjj333.p.1325", "admin", "administrator", "root", "xmpp", "postmaster", "webmaster", "hostmaster" }

----------- Virtual hosts -----------
-- You need to add a VirtualHost entry for each domain you wish Prosody to serve.
-- Settings under each VirtualHost entry apply *only* to that host.

VirtualHost "pain.agency"
-- Prosody requires at least one enabled VirtualHost to function. You can
-- safely remove or disable 'localhost' once you have added another.
invite_expiry = 86400 * 7
modules_enabled = {
    "invites";
    "invites_adhoc";
    "invites_register";
}

--VirtualHost "example.com"

------ Components ------
-- You can specify components to add hosts that provide special services,
-- like multi-user conferences, and transports.
-- For more information on components, see https://prosody.im/doc/components

---Set up a MUC (multi-user chat) room server on conference.example.com:
--Component "conference.example.com" "muc"
--- Store MUC messages in an archive and allow users to access it
--modules_enabled = { "muc_mam" }

Component "group.pain.agency" "muc"
name = "Rooms / Groups (MUC)"
restrict_room_creation = "local"
component_admins_as_room_owners = true
muc_tombstones = true
muc_tombstone_expiry = 60*86400
max_history_messages = 1
muc_room_default_history_length = 100

-- MUC MAM
-- See https://prosody.im/doc/modules/mod_muc_mam
modules_enabled = { "muc_mam", "vcard_muc", "muc_moderation", "muc_offline_delivery" }
muc_log_by_default = true
muc_log_presences = false
log_all_rooms = true
muc_log_expires_after = "1w"
muc_log_cleanup_interval = 4*60*60

---Set up a file sharing component
--Component "share.example.com" "http_file_share"
-- See https://prosody.im/doc/modules/mod_http_file_share
Component "downloadable.pain.agency" "http_file_share"
name = "Hypertext (HTTP file share)"
http_file_share_size_limit = 512*1024*1024
http_file_share_daily_quota = 100*1024*1024 -- 100 MiB per day per user
http_file_share_global_quota = 20*1024*1024*1024
http_file_share_expires_after = 28*86400
http_external_url = "https://downloadable.pain.agency/"

-- Beacon (publish-subscribe)
-- See https://prosody.im/doc/modules/mod_pubsub
Component "beacon.pain.agency" "pubsub"
name = "Beacon (publish-subscribe)"
pubsub_max_items = 10000
expose_publisher = true

-- Relayer (SOCKS5 bytestreams)
-- See https://prosody.im/doc/modules/mod_proxy65
Component "relay.pain.agency" "proxy65"
name = "Relayer (SOCKS5 bytestreams)"

---Set up an external component (default component port is 5347)
--
-- External components allow adding various services, such as gateways/
-- bridges to non-XMPP networks and services. For more info
-- see: https://prosody.im/doc/components#adding_an_external_component
--
--Component "gateway.example.com"
--      component_secret = "password
---------- End of the Prosody Configuration file ----------
-- You usually **DO NOT** want to add settings here at the end, as they would
-- only apply to the last defined VirtualHost or Component.
--
-- Settings for the global section should go higher up, before the first
-- VirtualHost or Component line, while settings intended for specific hosts
-- should go under the corresponding VirtualHost or Component line.
--
-- For more information see https://prosody.im/doc/configure

-- invite url
-- To allow invitation through a token, mod_register
-- allow_registration = false
-- registration_invite_only = true
