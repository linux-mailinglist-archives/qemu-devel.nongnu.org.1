Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC547D4112
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 22:40:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv1gL-0004hQ-Mj; Mon, 23 Oct 2023 16:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qv1g3-0004IL-Vd
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 16:37:31 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qv1g0-0001v2-PA
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 16:37:31 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 40DC61FE32;
 Mon, 23 Oct 2023 20:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698093446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vn5D4xMrx6L+YOzdic/8lubsQz9ayHBY+jnjMPqEryM=;
 b=me8vNr6MxTr0LuxKNH/7TYLYcOZiJMP03HBqzimnqqHEnSUfbPE2hsRzazt0jlBH7wbjI5
 mMi/TSwjlJAmchYcVl7GloUJQ86St0et3c2YdEA7MglPVunC1r+Y0jtCwBCxQ53a7XqCdJ
 HSRis9j/bLj2jIFzngVO6uW0EyJQyXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698093446;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vn5D4xMrx6L+YOzdic/8lubsQz9ayHBY+jnjMPqEryM=;
 b=2gcc/fNsj0de8CuKrsn7OC7gVoXf6PUVvYywQXynBApPbG3ShT/KJMTtCWvZZkU7uMS5lX
 bp+62G1Ux6P0zbBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1DF0C132FD;
 Mon, 23 Oct 2023 20:37:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8IF/NoPZNmV1JQAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 23 Oct 2023 20:37:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH v2 28/29] migration: Add direct-io parameter
Date: Mon, 23 Oct 2023 17:36:07 -0300
Message-Id: <20231023203608.26370-29-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231023203608.26370-1-farosas@suse.de>
References: <20231023203608.26370-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -2.10
X-Spamd-Result: default: False [-2.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[8];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is currently only used for the secondary channels of fixed-ram
migration, which can guarantee that writes are page aligned.

However the parameter could be made to affect other types of
file-based migrations in the future.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/qemu/osdep.h           |  2 ++
 migration/file.c               | 15 ++++++++++++---
 migration/migration-hmp-cmds.c | 10 ++++++++++
 migration/options.c            | 30 ++++++++++++++++++++++++++++++
 migration/options.h            |  1 +
 qapi/migration.json            | 17 ++++++++++++++---
 util/osdep.c                   |  9 +++++++++
 7 files changed, 78 insertions(+), 6 deletions(-)

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
index ad75225f43..3d3c58ecad 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -11,9 +11,9 @@
 #include "qemu/error-report.h"
 #include "channel.h"
 #include "file.h"
-#include "migration.h"
 #include "io/channel-file.h"
 #include "io/channel-util.h"
+#include "migration.h"
 #include "options.h"
 #include "trace.h"
 
@@ -77,9 +77,18 @@ void file_send_channel_create(QIOTaskFunc f, void *data)
     QIOChannelFile *ioc;
     QIOTask *task;
     Error *errp = NULL;
+    int flags = outgoing_args.flags;
 
-    ioc = qio_channel_file_new_path(outgoing_args.fname,
-                                    outgoing_args.flags,
+    if (migrate_direct_io() && qemu_has_direct_io()) {
+        /*
+         * Enable O_DIRECT for the secondary channels. These are used
+         * for sending ram pages and writes should be guaranteed to be
+         * aligned to at least page size.
+         */
+        flags |= O_DIRECT;
+    }
+
+    ioc = qio_channel_file_new_path(outgoing_args.fname, flags,
                                     outgoing_args.mode, &errp);
     if (!ioc) {
         file_migration_cancel(errp);
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index a82597f18e..eab5ac3588 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -387,6 +387,12 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %" PRIu64 " MB/s\n",
             MigrationParameter_str(MIGRATION_PARAMETER_VCPU_DIRTY_LIMIT),
             params->vcpu_dirty_limit);
+
+        if (params->has_direct_io) {
+            monitor_printf(mon, "%s: %s\n",
+                           MigrationParameter_str(MIGRATION_PARAMETER_DIRECT_IO),
+                           params->direct_io ? "on" : "off");
+        }
     }
 
     qapi_free_MigrationParameters(params);
@@ -661,6 +667,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->has_vcpu_dirty_limit = true;
         visit_type_size(v, param, &p->vcpu_dirty_limit, &err);
         break;
+    case MIGRATION_PARAMETER_DIRECT_IO:
+        p->has_direct_io = true;
+        visit_type_bool(v, param, &p->direct_io, &err);
+        break;
     default:
         assert(0);
     }
diff --git a/migration/options.c b/migration/options.c
index 2193d69e71..6d0e3c26ae 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -817,6 +817,22 @@ int migrate_decompress_threads(void)
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
@@ -1025,6 +1041,11 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->has_vcpu_dirty_limit = true;
     params->vcpu_dirty_limit = s->parameters.vcpu_dirty_limit;
 
+    if (s->parameters.has_direct_io) {
+        params->has_direct_io = true;
+        params->direct_io = s->parameters.direct_io;
+    }
+
     return params;
 }
 
@@ -1059,6 +1080,7 @@ void migrate_params_init(MigrationParameters *params)
     params->has_announce_step = true;
     params->has_x_vcpu_dirty_limit_period = true;
     params->has_vcpu_dirty_limit = true;
+    params->has_direct_io = qemu_has_direct_io();
 }
 
 /*
@@ -1356,6 +1378,10 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_vcpu_dirty_limit) {
         dest->vcpu_dirty_limit = params->vcpu_dirty_limit;
     }
+
+    if (params->has_direct_io) {
+        dest->direct_io = params->direct_io;
+    }
 }
 
 static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
@@ -1486,6 +1512,10 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     if (params->has_vcpu_dirty_limit) {
         s->parameters.vcpu_dirty_limit = params->vcpu_dirty_limit;
     }
+
+    if (params->has_direct_io) {
+        s->parameters.direct_io = params->direct_io;
+    }
 }
 
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
diff --git a/migration/options.h b/migration/options.h
index 01bba5b928..280f86bed1 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -82,6 +82,7 @@ uint8_t migrate_cpu_throttle_increment(void);
 uint8_t migrate_cpu_throttle_initial(void);
 bool migrate_cpu_throttle_tailslow(void);
 int migrate_decompress_threads(void);
+bool migrate_direct_io(void);
 uint64_t migrate_downtime_limit(void);
 uint8_t migrate_max_cpu_throttle(void);
 uint64_t migrate_max_bandwidth(void);
diff --git a/qapi/migration.json b/qapi/migration.json
index 1317dd32ab..3eb9e2c9b5 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -840,6 +840,9 @@
 # @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
 #     Defaults to 1.  (Since 8.1)
 #
+# @direct-io: Open migration files with O_DIRECT when possible. Not
+#             all migration transports support this. (since 8.1)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
@@ -864,7 +867,7 @@
            'multifd-zlib-level', 'multifd-zstd-level',
            'block-bitmap-mapping',
            { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
-           'vcpu-dirty-limit'] }
+           'vcpu-dirty-limit', 'direct-io'] }
 
 ##
 # @MigrateSetParameters:
@@ -1016,6 +1019,9 @@
 # @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
 #     Defaults to 1.  (Since 8.1)
 #
+# @direct-io: Open migration files with O_DIRECT when possible. Not
+#             all migration transports support this. (since 8.1)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
@@ -1058,7 +1064,8 @@
             '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
             '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
                                             'features': [ 'unstable' ] },
-            '*vcpu-dirty-limit': 'uint64'} }
+            '*vcpu-dirty-limit': 'uint64',
+            '*direct-io': 'bool' } }
 
 ##
 # @migrate-set-parameters:
@@ -1230,6 +1237,9 @@
 # @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
 #     Defaults to 1.  (Since 8.1)
 #
+# @direct-io: Open migration files with O_DIRECT when possible. Not
+#             all migration transports support this. (since 8.1)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
@@ -1269,7 +1279,8 @@
             '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
             '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
                                             'features': [ 'unstable' ] },
-            '*vcpu-dirty-limit': 'uint64'} }
+            '*vcpu-dirty-limit': 'uint64',
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


