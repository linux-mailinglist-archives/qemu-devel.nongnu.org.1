Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6378B7FAB9D
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 21:32:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7iCW-0003bZ-5Q; Mon, 27 Nov 2023 15:27:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r7iCU-0003Zr-6J
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:27:26 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r7iCQ-0002rR-V1
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:27:25 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C657121AF4;
 Mon, 27 Nov 2023 20:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1701116839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YUKe/pyeE4WEZaYZLpMtb5IvIFiXBFWsJ/0+/7s6ibI=;
 b=dTCzZ43rzOjvD+AWMMVdK1l/Bz0lvz4yhFatGCwqy0uD1YT2/CJCr8OJNQW8iIaCTGORid
 VdtYIF1jAn9Mye8eERik2CsRtl96eRjmv2q9LGI6EXdvecB7OPfwb6loMM+yVLR/3xj0Yv
 qSNOyzfFQREouSum/gWOx6svKQzTlJ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1701116839;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YUKe/pyeE4WEZaYZLpMtb5IvIFiXBFWsJ/0+/7s6ibI=;
 b=b3n3RaDpmbVzlC37FgBa5TFnz4HaGr7dSf7x70TAN76Raj/9b8s4u7BAfmOjylaDuv8R4H
 gN0FRozufoTsH8DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C7DB1379A;
 Mon, 27 Nov 2023 20:27:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OL/FEKX7ZGVfIQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 27 Nov 2023 20:27:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 Eric Blake <eblake@redhat.com>
Subject: [RFC PATCH v3 23/30] migration: Add direct-io parameter
Date: Mon, 27 Nov 2023 17:26:05 -0300
Message-Id: <20231127202612.23012-24-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231127202612.23012-1-farosas@suse.de>
References: <20231127202612.23012-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 0.90
X-Spamd-Result: default: False [0.90 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 BROKEN_CONTENT_TYPE(1.50)[]; RCVD_COUNT_THREE(0.00)[3];
 RCPT_COUNT_SEVEN(0.00)[8]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; BAYES_HAM(-3.00)[100.00%];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Add the direct-io migration parameter that tells the migration code to
use O_DIRECT when opening the migration stream file whenever possible.

This is currently only used with fixed-ram migration for the multifd
channels that transfer the RAM pages. Those channels only transfer the
pages and are guaranteed to perform aligned writes.

However the parameter could be made to affect other types of
file-based migrations in the future.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
- json formatting
- added checks for O_DIRECT support
---
 include/qemu/osdep.h           |  2 ++
 migration/file.c               | 22 ++++++++++++++++++++--
 migration/migration-hmp-cmds.c | 11 +++++++++++
 migration/options.c            | 30 ++++++++++++++++++++++++++++++
 migration/options.h            |  1 +
 qapi/migration.json            | 18 +++++++++++++++---
 util/osdep.c                   |  9 +++++++++
 7 files changed, 88 insertions(+), 5 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 475a1c62ff..ea5d29ab9b 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -597,6 +597,8 @@ int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive);
 bool qemu_has_ofd_lock(void);
 #endif
 
+bool qemu_has_direct_io(void);
+
 #if defined(__HAIKU__) && defined(__i386__)
 #define FMT_pid "%ld"
 #elif defined(WIN64)
diff --git a/migration/file.c b/migration/file.c
index 62ba994109..fc5c1a45f4 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -61,12 +61,30 @@ int file_send_channel_destroy(QIOChannel *ioc)
 
 void file_send_channel_create(QIOTaskFunc f, void *data)
 {
-    QIOChannelFile *ioc;
+    QIOChannelFile *ioc = NULL;
     QIOTask *task;
     Error *err = NULL;
     int flags = O_WRONLY;
 
-    ioc = qio_channel_file_new_path(outgoing_args.fname, flags, 0, &err);
+    if (migrate_direct_io()) {
+#ifdef O_DIRECT
+        /*
+         * Enable O_DIRECT for the secondary channels. These are used
+         * for sending ram pages and writes should be guaranteed to be
+         * aligned to at least page size.
+         */
+        flags |= O_DIRECT;
+#else
+        error_setg(&err, "System does not support O_DIRECT");
+        error_append_hint(&err,
+                          "Try disabling direct-io migration capability\n");
+        /* errors are propagated through the qio_task below */
+#endif
+    }
+
+    if (!err) {
+        ioc = qio_channel_file_new_path(outgoing_args.fname, flags, 0, &err);
+    }
 
     task = qio_task_new(OBJECT(ioc), f, (gpointer)data, NULL);
     if (!ioc) {
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 86ae832176..5ad6b2788d 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -392,6 +392,13 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %s\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MODE),
             qapi_enum_lookup(&MigMode_lookup, params->mode));
+
+        if (params->has_direct_io) {
+            monitor_printf(mon, "%s: %s\n",
+                           MigrationParameter_str(
+                               MIGRATION_PARAMETER_DIRECT_IO),
+                           params->direct_io ? "on" : "off");
+        }
     }
 
     qapi_free_MigrationParameters(params);
@@ -679,6 +686,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->has_mode = true;
         visit_type_MigMode(v, param, &p->mode, &err);
         break;
+    case MIGRATION_PARAMETER_DIRECT_IO:
+        p->has_direct_io = true;
+        visit_type_bool(v, param, &p->direct_io, &err);
+        break;
     default:
         assert(0);
     }
diff --git a/migration/options.c b/migration/options.c
index 7f23881f51..6c100dff7a 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -835,6 +835,22 @@ int migrate_decompress_threads(void)
     return s->parameters.decompress_threads;
 }
 
+bool migrate_direct_io(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    /* For now O_DIRECT is only supported with fixed-ram */
+    if (!s->capabilities[MIGRATION_CAPABILITY_FIXED_RAM]) {
+        return false;
+    }
+
+    if (s->parameters.has_direct_io) {
+        return s->parameters.direct_io;
+    }
+
+    return false;
+}
+
 uint64_t migrate_downtime_limit(void)
 {
     MigrationState *s = migrate_get_current();
@@ -1052,6 +1068,11 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->has_mode = true;
     params->mode = s->parameters.mode;
 
+    if (s->parameters.has_direct_io) {
+        params->has_direct_io = true;
+        params->direct_io = s->parameters.direct_io;
+    }
+
     return params;
 }
 
@@ -1087,6 +1108,7 @@ void migrate_params_init(MigrationParameters *params)
     params->has_x_vcpu_dirty_limit_period = true;
     params->has_vcpu_dirty_limit = true;
     params->has_mode = true;
+    params->has_direct_io = qemu_has_direct_io();
 }
 
 /*
@@ -1388,6 +1410,10 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_mode) {
         dest->mode = params->mode;
     }
+
+    if (params->has_direct_io) {
+        dest->direct_io = params->direct_io;
+    }
 }
 
 static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
@@ -1532,6 +1558,10 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     if (params->has_mode) {
         s->parameters.mode = params->mode;
     }
+
+    if (params->has_direct_io) {
+        s->parameters.direct_io = params->direct_io;
+    }
 }
 
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
diff --git a/migration/options.h b/migration/options.h
index 84628a76e8..9fbbf30168 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -81,6 +81,7 @@ uint8_t migrate_cpu_throttle_increment(void);
 uint8_t migrate_cpu_throttle_initial(void);
 bool migrate_cpu_throttle_tailslow(void);
 int migrate_decompress_threads(void);
+bool migrate_direct_io(void);
 uint64_t migrate_downtime_limit(void);
 uint8_t migrate_max_cpu_throttle(void);
 uint64_t migrate_max_bandwidth(void);
diff --git a/qapi/migration.json b/qapi/migration.json
index 3b93e13743..1d38619842 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -878,6 +878,9 @@
 # @mode: Migration mode. See description in @MigMode. Default is 'normal'.
 #        (Since 8.2)
 #
+# @direct-io: Open migration files with O_DIRECT when possible. This
+#     requires that the 'fixed-ram' capability is enabled. (since 9.0)
+#
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
@@ -911,7 +914,8 @@
            'block-bitmap-mapping',
            { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
            'vcpu-dirty-limit',
-           'mode'] }
+           'mode',
+           'direct-io'] }
 
 ##
 # @MigrateSetParameters:
@@ -1066,6 +1070,9 @@
 # @mode: Migration mode. See description in @MigMode. Default is 'normal'.
 #        (Since 8.2)
 #
+# @direct-io: Open migration files with O_DIRECT when possible. This
+#     requires that the 'fixed-ram' capability is enabled. (since 9.0)
+#
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
@@ -1119,7 +1126,8 @@
             '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
                                             'features': [ 'unstable' ] },
             '*vcpu-dirty-limit': 'uint64',
-            '*mode': 'MigMode'} }
+            '*mode': 'MigMode',
+            '*direct-io': 'bool' } }
 
 ##
 # @migrate-set-parameters:
@@ -1294,6 +1302,9 @@
 # @mode: Migration mode. See description in @MigMode. Default is 'normal'.
 #        (Since 8.2)
 #
+# @direct-io: Open migration files with O_DIRECT when possible. This
+#     requires that the 'fixed-ram' capability is enabled. (since 9.0)
+#
 # Features:
 #
 # @deprecated: Member @block-incremental is deprecated.  Use
@@ -1344,7 +1355,8 @@
             '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
                                             'features': [ 'unstable' ] },
             '*vcpu-dirty-limit': 'uint64',
-            '*mode': 'MigMode'} }
+            '*mode': 'MigMode',
+            '*direct-io': 'bool' } }
 
 ##
 # @query-migrate-parameters:
diff --git a/util/osdep.c b/util/osdep.c
index e996c4744a..d0227a60ab 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -277,6 +277,15 @@ int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive)
 }
 #endif
 
+bool qemu_has_direct_io(void)
+{
+#ifdef O_DIRECT
+    return true;
+#else
+    return false;
+#endif
+}
+
 static int qemu_open_cloexec(const char *name, int flags, mode_t mode)
 {
     int ret;
-- 
2.35.3


