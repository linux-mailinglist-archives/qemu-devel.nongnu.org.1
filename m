Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CD17DDF93
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 11:39:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy8bA-0003DQ-2O; Wed, 01 Nov 2023 06:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qy8b7-0003DE-Uf
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 06:37:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qy8as-0006au-6k
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 06:37:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698835018;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=D8qqcDffLhD6YuOVnvzeKkhYfetqH3Z2J3GGeLyOpA8=;
 b=givlrCNUxmhpBhNyNLDFAQOzhYKuMwfZ2FPeCg9ilC8dEYfo+0KS/Pex8hEAGMWL9XH3hk
 uMDDeF3bSWN8kOk+rN2rwrzOqf+qjpujLtvJTecVRmogiB/M0mEt3RMDegjJMQlPEJE4B+
 h0xJwIYcznF4gIUZQCAwpRM6lzLbHpk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-Ccmta2GIMSyCYC1DHYm-lA-1; Wed,
 01 Nov 2023 06:36:57 -0400
X-MC-Unique: Ccmta2GIMSyCYC1DHYm-lA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EFF293C025A1
 for <qemu-devel@nongnu.org>; Wed,  1 Nov 2023 10:36:56 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F2C771121308;
 Wed,  1 Nov 2023 10:36:55 +0000 (UTC)
Date: Wed, 1 Nov 2023 10:36:53 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Anthony Harivel <aharivel@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com
Subject: Re: [PATCH v2 2/3] tools: build qemu-vmsr-helper
Message-ID: <ZUIqRRqKhICx6zef@redhat.com>
References: <20231031144605.64822-1-aharivel@redhat.com>
 <20231031144605.64822-3-aharivel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231031144605.64822-3-aharivel@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Oct 31, 2023 at 03:46:02PM +0100, Anthony Harivel wrote:
> Introduce a privileged helper to access RAPL MSR.
> 
> The privileged helper tool, qemu-vmsr-helper, is designed to provide
> virtual machines with the ability to read specific RAPL (Running Average
> Power Limit) MSRs without requiring CAP_SYS_RAWIO privileges or relying
> on external, out-of-tree patches.
> 
> The helper tool leverages Unix permissions and SO_PEERCRED socket
> options to enforce access control, ensuring that only processes
> explicitly requesting read access via readmsr() from a valid Thread ID
> can access these MSRs.
> 
> The list of RAPL MSRs that are allowed to be read by the helper tool is
> defined in rapl-msr-index.h. This list corresponds to the RAPL MSRs that
> will be supported in the next commit titled "Add support for RAPL MSRs
> in KVM/QEMU."
> 
> Signed-off-by: Anthony Harivel <aharivel@redhat.com>
> ---
>  docs/tools/index.rst            |   1 +
>  docs/tools/qemu-vmsr-helper.rst |  89 ++++++
>  meson.build                     |   5 +
>  tools/i386/qemu-vmsr-helper.c   | 507 ++++++++++++++++++++++++++++++++
>  tools/i386/rapl-msr-index.h     |  28 ++

Missing  .service and .socket unit files needed for systemd integration.
See those present for qemu-pr-helper for examples

>  5 files changed, 630 insertions(+)
>  create mode 100644 docs/tools/qemu-vmsr-helper.rst
>  create mode 100644 tools/i386/qemu-vmsr-helper.c
>  create mode 100644 tools/i386/rapl-msr-index.h





> diff --git a/tools/i386/qemu-vmsr-helper.c b/tools/i386/qemu-vmsr-helper.c
> new file mode 100644
> index 000000000000..1d82a2753e44
> --- /dev/null
> +++ b/tools/i386/qemu-vmsr-helper.c

> +#define MAX_PATH_LEN 50
> +#define MAX_LINE_LEN 500
> +#define PR_OUT_FIXED_PARAM_SIZE 24

These latter two constants are not used.

> +
> +static char *socket_path;
> +static char *pidfile;
> +static enum { RUNNING, TERMINATE, TERMINATING } state;
> +static QIOChannelSocket *server_ioc;
> +static int server_watch;
> +static int num_active_sockets = 1;
> +static int noisy;
> +static int verbose;
> +
> +#ifdef CONFIG_LIBCAP_NG
> +static int uid = -1;
> +static int gid = -1;
> +#endif
> +
> +static void compute_default_paths(void)
> +{
> +    g_autofree char *state = qemu_get_local_state_dir();
> +
> +    socket_path = g_build_filename(state, "run", "qemu-vmsr-helper.sock", NULL);
> +    pidfile = g_build_filename(state, "run", "qemu-vmsr-helper.pid", NULL);
> +}
> +
> +/*
> + * Check if the TID that request the MSR read
> + * belongs to the peer. It should a TID of a vCPU.
> + */
> +static bool is_tid_present(pid_t pid, pid_t tid)
> +{
> +    char pidStr[20];
> +    char tidStr[20];
> +
> +    snprintf(pidStr, sizeof(pidStr), "%d", pid);
> +    snprintf(tidStr, sizeof(tidStr), "%d", tid);

g_strdup_printf() not an unchecked static buffer.

> +
> +    char pidPath[256];
> +    char tidPath[256];
> +
> +    snprintf(pidPath, sizeof(pidPath), "/proc/%s", pidStr);

You never read this variable once built

> +    snprintf(tidPath, sizeof(tidPath), "/proc/%s/task/%s", pidStr, tidStr);

g_build_file_name

> +
> +    /* Check if the TID directory exists within the PID directory */
> +    if (access(tidPath, F_OK) == 0) {
> +        return true;
> +    }
> +
> +    return false;
> +}

> +static uint64_t vmsr_read_msr(uint32_t reg, unsigned int cpu_id)
> +{
> +    int fd;
> +    uint64_t data;
> +
> +    char path[MAX_PATH_LEN];
> +    snprintf(path, MAX_PATH_LEN, "/dev/cpu/%u/msr", cpu_id);

g_strdup_printf

> +
> +    fd = open(path , O_RDONLY);
> +    if (fd < 0) {
> +        return 0;
> +    }
> +    if (pread(fd, &data, sizeof data, reg) != sizeof data) {
> +        data = 0;
> +    }
> +
> +    close(fd);
> +    return data;
> +}
> +
> +static void usage(const char *name)
> +{
> +    (printf) (
> +"Usage: %s [OPTIONS] FILE\n"
> +"Virtual RAPL MSR helper program for QEMU\n"
> +"\n"
> +"  -h, --help                display this help and exit\n"
> +"  -V, --version             output version information and exit\n"
> +"\n"
> +"  -d, --daemon              run in the background\n"
> +"  -f, --pidfile=PATH        PID file when running as a daemon\n"
> +"                            (default '%s')\n"
> +"  -k, --socket=PATH         path to the unix socket\n"
> +"                            (default '%s')\n"
> +"  -T, --trace [[enable=]<pattern>][,events=<file>][,file=<file>]\n"
> +"                            specify tracing options\n"
> +#ifdef CONFIG_LIBCAP_NG
> +"  -u, --user=USER           user to drop privileges to\n"
> +"  -g, --group=GROUP         group to drop privileges to\n"
> +#endif
> +"\n"
> +QEMU_HELP_BOTTOM "\n"
> +    , name, pidfile, socket_path);
> +}
> +
> +static void version(const char *name)
> +{
> +    printf(
> +"%s " QEMU_FULL_VERSION "\n"
> +"Written by Anthony Harivel.\n"
> +"\n"
> +QEMU_COPYRIGHT "\n"
> +"This is free software; see the source for copying conditions.  There is NO\n"
> +"warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.\n"
> +    , name);
> +}
> +
> +typedef struct VMSRHelperClient {
> +    QIOChannelSocket *ioc;
> +    Coroutine *co;
> +    int fd;

This FD field is set to -1 and never changed / read thereafter AFAICS,
so please remove it.

> +} VMSRHelperClient;
> +
> +static void coroutine_fn vh_co_entry(void *opaque)
> +{
> +    VMSRHelperClient *client = opaque;
> +    uint64_t vmsr;
> +    uint32_t request[3];
> +    struct ucred cred;
> +    int r;
> +    Error *local_err = NULL;
> +
> +    qio_channel_set_blocking(QIO_CHANNEL(client->ioc),
> +                             false, NULL);
> +
> +    qio_channel_set_follow_coroutine_ctx(QIO_CHANNEL(client->ioc), true);
> +
> +    /*
> +     * Check peer credentials
> +     * Only QEMU PID/TID are allowed
> +     */
> +    qio_channel_get_peercred(QIO_CHANNEL(client->ioc), &cred, &local_err);
> +
> +    if (cred.pid == 0) {
> +        if (local_err != NULL) {
> +            error_report_err(local_err);
> +        }
> +        error_report("Failed to get peer credentials");
> +        goto out;
> +    }
> +
> +    /*
> +     * Read the requested MSR
> +     * Only RAPL MSR in rapl-msr-index.h is allowed
> +     */
> +    r = qio_channel_read_all(QIO_CHANNEL(client->ioc),
> +                             (char *) &request, sizeof(request), NULL);

The 'NULL' should be &local_err, so that the next error_report
line actually gives a useful error message with actual details.

> +    if (!is_msr_allowed(request[0]) || r < 0) {

request[0] is accessing uninitialized memory in case that r < 0.
You must check for errors first.

> +        error_report("Read request fail: %d, %d", request[0], request[1]);

use error_report_err in the 'r < 0' case.

> +        goto out;
> +    }
> +
> +    vmsr = vmsr_read_msr(request[0], request[1]);
> +
> +    if (!is_tid_present(cred.pid, request[2])) {
> +        error_report("requested TID not in peer PID");
> +        vmsr = 0;
> +    }
> +
> +    r = qio_channel_write_all(QIO_CHANNEL(client->ioc),
> +                         (char *) &vmsr, sizeof(vmsr), NULL);

Again you must pass &local_err...

> +    if (r < 0) {
> +        error_report("write vmsr failed");

and use error_report_err

> +        goto out;
> +    }
> +
> +out:
> +    object_unref(OBJECT(client->ioc));
> +    g_free(client);
> +}
> +
> +static gboolean accept_client(QIOChannel *ioc,
> +                              GIOCondition cond,
> +                              gpointer opaque)
> +{
> +    QIOChannelSocket *cioc;
> +    VMSRHelperClient *vmsrh;
> +
> +    cioc = qio_channel_socket_accept(QIO_CHANNEL_SOCKET(ioc),
> +                                     NULL);
> +    if (!cioc) {
> +        return TRUE;
> +    }
> +
> +    vmsrh = g_new(VMSRHelperClient, 1);
> +    vmsrh->ioc = cioc;
> +    vmsrh->fd = -1;
> +    vmsrh->co = qemu_coroutine_create(vh_co_entry, vmsrh);
> +    qemu_coroutine_enter(vmsrh->co);
> +
> +    return TRUE;
> +}
> +
> +static void termsig_handler(int signum)
> +{
> +    qatomic_cmpxchg(&state, RUNNING, TERMINATE);
> +    qemu_notify_event();
> +}
> +
> +static void close_server_socket(void)
> +{
> +    assert(server_ioc);
> +
> +    g_source_remove(server_watch);
> +    server_watch = -1;
> +    object_unref(OBJECT(server_ioc));
> +    num_active_sockets--;
> +}
> +
> +#ifdef CONFIG_LIBCAP_NG
> +static int drop_privileges(void)
> +{
> +    /* clear all capabilities */
> +    capng_clear(CAPNG_SELECT_BOTH);
> +
> +    if (capng_update(CAPNG_ADD, CAPNG_EFFECTIVE | CAPNG_PERMITTED,
> +                     CAP_SYS_RAWIO) < 0) {
> +        return -1;
> +    }
> +
> +    /*
> +     * Change user/group id, retaining the capabilities.
> +     * Because file descriptors are passed via SCM_RIGHTS,
> +     * we don't need supplementary groups (and in fact the helper
> +     * can run as "nobody").
> +     */
> +    if (capng_change_id(uid != -1 ? uid : getuid(),
> +                        gid != -1 ? gid : getgid(),
> +                        CAPNG_DROP_SUPP_GRP | CAPNG_CLEAR_BOUNDING)) {
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +#endif
> +
> +int main(int argc, char **argv)
> +{
> +    const char *sopt = "hVk:f:dT:u:g:vq";
> +    struct option lopt[] = {
> +        { "help", no_argument, NULL, 'h' },
> +        { "version", no_argument, NULL, 'V' },
> +        { "socket", required_argument, NULL, 'k' },
> +        { "pidfile", required_argument, NULL, 'f' },
> +        { "daemon", no_argument, NULL, 'd' },
> +        { "trace", required_argument, NULL, 'T' },
> +        { "user", required_argument, NULL, 'u' },
> +        { "group", required_argument, NULL, 'g' },
> +        { "verbose", no_argument, NULL, 'v' },
> +        { "quiet", no_argument, NULL, 'q' },
> +        { NULL, 0, NULL, 0 }
> +    };
> +    int opt_ind = 0;
> +    int loglevel = 1;
> +    int quiet = 0;
> +    int ch;
> +    Error *local_err = NULL;
> +    bool daemonize = false;
> +    bool pidfile_specified = false;
> +    bool socket_path_specified = false;
> +    unsigned socket_activation;
> +
> +    struct sigaction sa_sigterm;
> +    memset(&sa_sigterm, 0, sizeof(sa_sigterm));
> +    sa_sigterm.sa_handler = termsig_handler;
> +    sigaction(SIGTERM, &sa_sigterm, NULL);
> +    sigaction(SIGINT, &sa_sigterm, NULL);
> +    sigaction(SIGHUP, &sa_sigterm, NULL);
> +
> +    signal(SIGPIPE, SIG_IGN);
> +
> +    error_init(argv[0]);
> +    module_call_init(MODULE_INIT_TRACE);
> +    module_call_init(MODULE_INIT_QOM);
> +    qemu_add_opts(&qemu_trace_opts);
> +    qemu_init_exec_dir(argv[0]);
> +
> +    compute_default_paths();
> +
> +    while ((ch = getopt_long(argc, argv, sopt, lopt, &opt_ind)) != -1) {
> +        switch (ch) {
> +        case 'k':
> +            g_free(socket_path);
> +            socket_path = g_strdup(optarg);
> +            socket_path_specified = true;
> +            if (socket_path[0] != '/') {
> +                error_report("socket path must be absolute");
> +                exit(EXIT_FAILURE);
> +            }
> +            break;
> +        case 'f':
> +            g_free(pidfile);
> +            pidfile = g_strdup(optarg);
> +            pidfile_specified = true;
> +            break;
> +#ifdef CONFIG_LIBCAP_NG
> +        case 'u': {
> +            unsigned long res;
> +            struct passwd *userinfo = getpwnam(optarg);
> +            if (userinfo) {
> +                uid = userinfo->pw_uid;
> +            } else if (qemu_strtoul(optarg, NULL, 10, &res) == 0 &&
> +                       (uid_t)res == res) {
> +                uid = res;
> +            } else {
> +                error_report("invalid user '%s'", optarg);
> +                exit(EXIT_FAILURE);
> +            }
> +            break;
> +        }
> +        case 'g': {
> +            unsigned long res;
> +            struct group *groupinfo = getgrnam(optarg);
> +            if (groupinfo) {
> +                gid = groupinfo->gr_gid;
> +            } else if (qemu_strtoul(optarg, NULL, 10, &res) == 0 &&
> +                       (gid_t)res == res) {
> +                gid = res;
> +            } else {
> +                error_report("invalid group '%s'", optarg);
> +                exit(EXIT_FAILURE);
> +            }
> +            break;
> +        }
> +#else
> +        case 'u':
> +        case 'g':
> +            error_report("-%c not supported by this %s", ch, argv[0]);
> +            exit(1);
> +#endif
> +        case 'd':
> +            daemonize = true;
> +            break;
> +        case 'q':
> +            quiet = 1;
> +            break;
> +        case 'v':
> +            ++loglevel;
> +            break;
> +        case 'T':
> +            trace_opt_parse(optarg);
> +            break;
> +        case 'V':
> +            version(argv[0]);
> +            exit(EXIT_SUCCESS);
> +            break;
> +        case 'h':
> +            usage(argv[0]);
> +            exit(EXIT_SUCCESS);
> +            break;
> +        case '?':
> +            error_report("Try `%s --help' for more information.", argv[0]);
> +            exit(EXIT_FAILURE);
> +        }
> +    }
> +
> +    /* set verbosity */
> +    noisy = !quiet && (loglevel >= 3);
> +    verbose = quiet ? 0 : MIN(loglevel, 3);

AFAIK nothing ever uses the noisy or verbose flags, so please remove
them or use them.

> +
> +    if (!trace_init_backends()) {
> +        exit(EXIT_FAILURE);
> +    }
> +    trace_init_file();
> +    qemu_set_log(LOG_TRACE, &error_fatal);


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


