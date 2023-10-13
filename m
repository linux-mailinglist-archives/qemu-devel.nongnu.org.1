Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACBF7C83A8
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 12:49:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrFiQ-0004CU-Ex; Fri, 13 Oct 2023 06:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qrFiN-00047S-Eq
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 06:48:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qrFiL-0007Ac-2w
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 06:48:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697194096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s+IFTgtyvhujqabpgzLRkC5LuVVx1OY/3JUnv9v1DvQ=;
 b=OwG+9Cho+0gtFcV404WNDMWoyGE9PIas0m6V0Q8+/i2bpW+ME8JeHFF8D1zO8cXwcy2nu0
 4lqPAmTxscudnCUBAm/g+j5ZjkYBb5QncAJ7fIBYiZCTTwLFkAW+xhj9/eCDtcqW2VBkt4
 iqFkRpbc1HlTlck6r6099eYHGLb50ZU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-452-fVjH-wnPNO6TqmprKuao3A-1; Fri, 13 Oct 2023 06:48:10 -0400
X-MC-Unique: fVjH-wnPNO6TqmprKuao3A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B0F3F2810D45;
 Fri, 13 Oct 2023 10:48:09 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD4C42157F5A;
 Fri, 13 Oct 2023 10:48:06 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fam Zheng <fam@euphon.net>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eric Blake <eblake@redhat.com>, libvir-list@redhat.com,
 Fabiano Rosas <farosas@suse.de>, qemu-block@nongnu.org,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>
Subject: [PATCH v4 09/10] [RFC] migration: Remove support for block_incremental
Date: Fri, 13 Oct 2023 12:47:35 +0200
Message-ID: <20231013104736.31722-10-quintela@redhat.com>
In-Reply-To: <20231013104736.31722-1-quintela@redhat.com>
References: <20231013104736.31722-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

[DON'T MERGE]

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 docs/about/deprecated.rst      |  7 -----
 qapi/migration.json            | 55 +++++++---------------------------
 migration/options.h            |  1 -
 migration/block.c              |  2 +-
 migration/migration-hmp-cmds.c | 18 +----------
 migration/migration.c          | 13 ++------
 migration/options.c            | 18 -----------
 hmp-commands.hx                | 13 +++-----
 8 files changed, 20 insertions(+), 107 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index a6da0df8e1..6bc41a430a 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -452,13 +452,6 @@ Migration
 ``skipped`` field in Migration stats has been deprecated.  It hasn't
 been used for more than 10 years.
 
-``inc`` migrate command option (since 8.2)
-''''''''''''''''''''''''''''''''''''''''''
-
-The new way to modify migration is using migration parameters.
-``inc`` functionality can be achieved by setting the
-``block-incremental`` migration parameter to ``true``.
-
 ``blk`` migrate command option (since 8.2)
 ''''''''''''''''''''''''''''''''''''''''''
 
diff --git a/qapi/migration.json b/qapi/migration.json
index e599062f7d..545da4e257 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -779,13 +779,6 @@
 # @x-checkpoint-delay: The delay time (in ms) between two COLO
 #     checkpoints in periodic mode.  (Since 2.8)
 #
-# @block-incremental: Affects how much storage is migrated when the
-#     block migration capability is enabled.  When false, the entire
-#     storage backing chain is migrated into a flattened image at the
-#     destination; when true, only the active qcow2 layer is migrated
-#     and the destination must already have access to the same backing
-#     chain as was used on the source.  (since 2.10)
-#
 # @multifd-channels: Number of channels used to migrate data in
 #     parallel.  This is the same number that the number of sockets
 #     used for migration.  The default value is 2 (since 4.0)
@@ -841,10 +834,9 @@
 #
 # Features:
 #
-# @deprecated: Member @block-incremental is deprecated. Use
-#     blockdev-mirror with NBD instead. Members @compress-level,
-#     @compress-threads, @decompress-threads and @compress-wait-thread
-#     are deprecated because @compression is deprecated.
+# @deprecated: Members @compress-level, @compress-threads,
+#     @decompress-threads and @compress-wait-thread are deprecated
+#     because @compression is deprecated.
 #
 # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
 #     are experimental.
@@ -864,7 +856,6 @@
            'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
            'downtime-limit',
            { 'name': 'x-checkpoint-delay', 'features': [ 'unstable' ] },
-           { 'name': 'block-incremental', 'features': [ 'deprecated' ] },
            'multifd-channels',
            'xbzrle-cache-size', 'max-postcopy-bandwidth',
            'max-cpu-throttle', 'multifd-compression',
@@ -953,13 +944,6 @@
 # @x-checkpoint-delay: the delay time between two COLO checkpoints.
 #     (Since 2.8)
 #
-# @block-incremental: Affects how much storage is migrated when the
-#     block migration capability is enabled.  When false, the entire
-#     storage backing chain is migrated into a flattened image at the
-#     destination; when true, only the active qcow2 layer is migrated
-#     and the destination must already have access to the same backing
-#     chain as was used on the source.  (since 2.10)
-#
 # @multifd-channels: Number of channels used to migrate data in
 #     parallel.  This is the same number that the number of sockets
 #     used for migration.  The default value is 2 (since 4.0)
@@ -1015,10 +999,9 @@
 #
 # Features:
 #
-# @deprecated: Member @block-incremental is deprecated. Use
-#     blockdev-mirror with NBD instead. Members @compress-level,
-#     @compress-threads, @decompress-threads and @compress-wait-thread
-#     are deprecated because @compression is deprecated.
+# @deprecated: Members @compress-level, @compress-threads,
+#     @decompress-threads and @compress-wait-thread are deprecated
+#     because @compression is deprecated.
 #
 # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
 #     are experimental.
@@ -1052,8 +1035,6 @@
             '*downtime-limit': 'uint64',
             '*x-checkpoint-delay': { 'type': 'uint32',
                                      'features': [ 'unstable' ] },
-            '*block-incremental': { 'type': 'bool',
-                                    'features': [ 'deprecated' ] },
             '*multifd-channels': 'uint8',
             '*xbzrle-cache-size': 'size',
             '*max-postcopy-bandwidth': 'size',
@@ -1166,13 +1147,6 @@
 # @x-checkpoint-delay: the delay time between two COLO checkpoints.
 #     (Since 2.8)
 #
-# @block-incremental: Affects how much storage is migrated when the
-#     block migration capability is enabled.  When false, the entire
-#     storage backing chain is migrated into a flattened image at the
-#     destination; when true, only the active qcow2 layer is migrated
-#     and the destination must already have access to the same backing
-#     chain as was used on the source.  (since 2.10)
-#
 # @multifd-channels: Number of channels used to migrate data in
 #     parallel.  This is the same number that the number of sockets
 #     used for migration.  The default value is 2 (since 4.0)
@@ -1228,10 +1202,9 @@
 #
 # Features:
 #
-# @deprecated: Member @block-incremental is deprecated. Use
-#     blockdev-mirror with NBD instead. Members @compress-level,
-#     @compress-threads, @decompress-threads and @compress-wait-thread
-#     are deprecated because @compression is deprecated.
+# @deprecated: Members @compress-level, @compress-threads,
+#     @decompress-threads and @compress-wait-thread are deprecated
+#     because @compression is deprecated.
 #
 # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
 #     are experimental.
@@ -1262,8 +1235,6 @@
             '*downtime-limit': 'uint64',
             '*x-checkpoint-delay': { 'type': 'uint32',
                                      'features': [ 'unstable' ] },
-            '*block-incremental': { 'type': 'bool',
-                                    'features': [ 'deprecated' ] },
             '*multifd-channels': 'uint8',
             '*xbzrle-cache-size': 'size',
             '*max-postcopy-bandwidth': 'size',
@@ -1527,8 +1498,6 @@
 #
 # @blk: do block migration (full disk copy)
 #
-# @inc: incremental disk copy migration
-#
 # @detach: this argument exists only for compatibility reasons and is
 #     ignored by QEMU
 #
@@ -1536,9 +1505,8 @@
 #
 # Features:
 #
-# @deprecated: Member @inc is deprecated.  Use migration parameter
-#     @block-incremental instead. Member @blk is deprecated. Set
-#     migration capability 'block' to 'true' instead.
+# @deprecated: Member @blk is deprecated. Set migration capability
+#     'block' to 'true' instead.
 #
 # Returns: nothing on success
 #
@@ -1563,7 +1531,6 @@
 { 'command': 'migrate',
   'data': {'uri': 'str',
            '*blk': { 'type': 'bool', 'features': [ 'deprecated' ] },
-           '*inc': { 'type': 'bool', 'features': [ 'deprecated' ] },
            '*detach': 'bool', '*resume': 'bool' } }
 
 ##
diff --git a/migration/options.h b/migration/options.h
index 4e8c0b9223..237e4c75d4 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -67,7 +67,6 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp);
 const BitmapMigrationNodeAliasList *migrate_block_bitmap_mapping(void);
 bool migrate_has_block_bitmap_mapping(void);
 
-bool migrate_block_incremental(void);
 uint32_t migrate_checkpoint_delay(void);
 int migrate_compress_level(void);
 int migrate_compress_threads(void);
diff --git a/migration/block.c b/migration/block.c
index 7f563c70f6..fadf96f668 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -420,7 +420,7 @@ static int init_blk_migration(QEMUFile *f)
         bmds->bulk_completed = 0;
         bmds->total_sectors = sectors;
         bmds->completed_sectors = 0;
-        bmds->shared_base = migrate_block_incremental();
+        bmds->shared_base = false;
 
         assert(i < num_bs);
         bmds_bs[i].bmds = bmds;
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 582368926a..e6f6785ad3 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -330,10 +330,6 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %u ms\n",
             MigrationParameter_str(MIGRATION_PARAMETER_X_CHECKPOINT_DELAY),
             params->x_checkpoint_delay);
-        assert(params->has_block_incremental);
-        monitor_printf(mon, "%s: %s\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_BLOCK_INCREMENTAL),
-            params->block_incremental ? "on" : "off");
         monitor_printf(mon, "%s: %u\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_CHANNELS),
             params->multifd_channels);
@@ -583,10 +579,6 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->has_x_checkpoint_delay = true;
         visit_type_uint32(v, param, &p->x_checkpoint_delay, &err);
         break;
-    case MIGRATION_PARAMETER_BLOCK_INCREMENTAL:
-        p->has_block_incremental = true;
-        visit_type_bool(v, param, &p->block_incremental, &err);
-        break;
     case MIGRATION_PARAMETER_MULTIFD_CHANNELS:
         p->has_multifd_channels = true;
         visit_type_uint8(v, param, &p->multifd_channels, &err);
@@ -726,25 +718,17 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
 {
     bool detach = qdict_get_try_bool(qdict, "detach", false);
     bool blk = qdict_get_try_bool(qdict, "blk", false);
-    bool inc = qdict_get_try_bool(qdict, "inc", false);
     bool resume = qdict_get_try_bool(qdict, "resume", false);
     const char *uri = qdict_get_str(qdict, "uri");
     Error *err = NULL;
 
-    if (inc) {
-        monitor_printf(mon, "-i migrate option is deprecated, set the"
-                       "'block-incremental' migration parameter to 'true'"
-                       " instead.\n");
-        return;
-    }
-
     if (blk) {
         monitor_printf(mon, "-b migrate option is deprecated, set the "
                        "'block' capability to 'true' instead.\n");
         return;
     }
 
-    qmp_migrate(uri, false, false, false, false,
+    qmp_migrate(uri, false, false,
                 false, false, true, resume, &err);
     if (hmp_handle_error(mon, err)) {
         return;
diff --git a/migration/migration.c b/migration/migration.c
index ceeb2e6cb2..d587c8f5b8 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1595,16 +1595,9 @@ bool migration_is_blocked(Error **errp)
 }
 
 /* Returns true if continue to migrate, or false if error detected */
-static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
+static bool migrate_prepare(MigrationState *s, bool blk,
                             bool resume, Error **errp)
 {
-    if (blk_inc) {
-        error_setg(errp, "@inc migrate option is deprecated, set the"
-                   "'block-incremental' migration parameter to 'true'"
-                   " instead.");
-        return false;
-    }
-
     if (blk) {
         error_setg(errp, "@blk/-i migrate option is deprecated, set the "
                    "'block' capability to 'true' instead.");
@@ -1668,7 +1661,7 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
 }
 
 void qmp_migrate(const char *uri, bool has_blk, bool blk,
-                 bool has_inc, bool inc, bool has_detach, bool detach,
+                 bool has_detach, bool detach,
                  bool has_resume, bool resume, Error **errp)
 {
     bool resume_requested;
@@ -1682,7 +1675,7 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
     }
 
     resume_requested = has_resume && resume;
-    if (!migrate_prepare(s, has_blk && blk, has_inc && inc,
+    if (!migrate_prepare(s, has_blk && blk,
                          resume_requested, errp)) {
         /* Error detected, put into errp */
         return;
diff --git a/migration/options.c b/migration/options.c
index ecb34a3bbd..a4defb4e63 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -686,13 +686,6 @@ bool migrate_has_block_bitmap_mapping(void)
     return s->parameters.has_block_bitmap_mapping;
 }
 
-bool migrate_block_incremental(void)
-{
-    MigrationState *s = migrate_get_current();
-
-    return s->parameters.block_incremental;
-}
-
 uint32_t migrate_checkpoint_delay(void)
 {
     MigrationState *s = migrate_get_current();
@@ -890,8 +883,6 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->downtime_limit = s->parameters.downtime_limit;
     params->has_x_checkpoint_delay = true;
     params->x_checkpoint_delay = s->parameters.x_checkpoint_delay;
-    params->has_block_incremental = true;
-    params->block_incremental = s->parameters.block_incremental;
     params->has_multifd_channels = true;
     params->multifd_channels = s->parameters.multifd_channels;
     params->has_multifd_compression = true;
@@ -947,7 +938,6 @@ void migrate_params_init(MigrationParameters *params)
     params->has_max_bandwidth = true;
     params->has_downtime_limit = true;
     params->has_x_checkpoint_delay = true;
-    params->has_block_incremental = true;
     params->has_multifd_channels = true;
     params->has_multifd_compression = true;
     params->has_multifd_zlib_level = true;
@@ -1202,9 +1192,6 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
         dest->x_checkpoint_delay = params->x_checkpoint_delay;
     }
 
-    if (params->has_block_incremental) {
-        dest->block_incremental = params->block_incremental;
-    }
     if (params->has_multifd_channels) {
         dest->multifd_channels = params->multifd_channels;
     }
@@ -1327,11 +1314,6 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
         colo_checkpoint_delay_set();
     }
 
-    if (params->has_block_incremental) {
-        warn_report("Block migration is deprecated. "
-                    "Use blockdev-mirror with NBD instead.");
-        s->parameters.block_incremental = params->block_incremental;
-    }
     if (params->has_multifd_channels) {
         s->parameters.multifd_channels = params->multifd_channels;
     }
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 63eac22734..ce26057e85 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -920,26 +920,21 @@ ERST
 
     {
         .name       = "migrate",
-        .args_type  = "detach:-d,blk:-b,inc:-i,resume:-r,uri:s",
-        .params     = "[-d] [-b] [-i] [-r] uri",
+        .args_type  = "detach:-d,blk:-b,resume:-r,uri:s",
+        .params     = "[-d] [-b] [-r] uri",
         .help       = "migrate to URI (using -d to not wait for completion)"
 		      "\n\t\t\t -b for migration without shared storage with"
-		      " full copy of disk\n\t\t\t -i for migration without "
-		      "shared storage with incremental copy of disk "
-		      "(base image shared between src and destination)"
-                      "\n\t\t\t -r to resume a paused migration",
+		      " full copy of disk\n\t\t\t -r to resume a paused migration",
         .cmd        = hmp_migrate,
     },
 
 
 SRST
-``migrate [-d] [-b] [-i]`` *uri*
+``migrate [-d] [-b]`` *uri*
   Migrate to *uri* (using -d to not wait for completion).
 
   ``-b``
     for migration with full copy of disk
-  ``-i``
-    for migration with incremental copy of disk (base image is shared)
 ERST
 
     {
-- 
2.41.0


