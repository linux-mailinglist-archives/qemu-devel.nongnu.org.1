Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A0E73A926
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 21:52:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCQKo-0004Et-6g; Thu, 22 Jun 2023 15:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCQKR-0004Bp-IL
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 15:50:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCQKN-0002re-UC
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 15:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687463447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wd9gQX3xT46jkB3DvMY7w/wI+JD70INi2OM0Nj+ylog=;
 b=TTlYm2Eg4nVjCRtilF2pwIChv6TR5zbiz4Wvy1B+Gm7+trynY+mM8zXETfwwSppHRf/1f2
 ILzlvhSISksGF8SbgbdIi0OvI1ObTMqQa0FM+7einoYsKDq5XupG2XhZ9WWo/Cgmfqb1LI
 L5VQNRCuz9iFZfvB/uYUFxvSfOITUIA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-448-D8VouvcLNQawVVaDS4rlcw-1; Thu, 22 Jun 2023 15:50:45 -0400
X-MC-Unique: D8VouvcLNQawVVaDS4rlcw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A2D6990ED20;
 Thu, 22 Jun 2023 19:50:35 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DFB04C00049;
 Thu, 22 Jun 2023 19:50:32 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 libvir-list@redhat.com, Peter Xu <peterx@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Czenczek <hreitz@redhat.com>
Subject: [PATCH v2 4/5] migration: Deprecate block migration
Date: Thu, 22 Jun 2023 21:50:18 +0200
Message-Id: <20230622195019.4396-5-quintela@redhat.com>
In-Reply-To: <20230622195019.4396-1-quintela@redhat.com>
References: <20230622195019.4396-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

It is obsolete.  It is better to use driver-mirror with NBD instead.

CC: Kevin Wolf <kwolf@redhat.com>
CC: Eric Blake <eblake@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
CC: Hanna Czenczek <hreitz@redhat.com>

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 docs/about/deprecated.rst | 10 ++++++++++
 qapi/migration.json       | 30 +++++++++++++++++++++++++-----
 migration/block.c         |  3 +++
 migration/options.c       |  9 ++++++++-
 4 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index f727db958e..2d7c48185e 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -447,3 +447,13 @@ The new way to modify migration is using migration parameters.
 ``blk`` functionality can be achieved by setting the
 ``block`` migration capability to ``true``.
 
+block migration (since 8.1)
+'''''''''''''''''''''''''''
+
+Block migration is too inflexible.  It needs to migrate all block
+devices or none.
+
+Please see "QMP invocation for live storage migration with
+``driver-mirror`` + NBD" in docs/interop/live-block-operations.rst for
+a detailed explanation.
+
diff --git a/qapi/migration.json b/qapi/migration.json
index 291af9407e..08dee855cb 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -270,11 +270,16 @@
 #     average memory load of virtual CPU indirectly. Note that zero
 #     means guest doesn't dirty memory (since 8.1)
 #
+# Features:
+#
+# @deprecated: @disk migration is deprecated.  Use driver-mirror
+#     with NBD instead.
+#
 # Since: 0.14
 ##
 { 'struct': 'MigrationInfo',
   'data': {'*status': 'MigrationStatus', '*ram': 'MigrationStats',
-           '*disk': 'MigrationStats',
+           '*disk': { 'type': 'MigrationStats', 'features': ['deprecated'] },
            '*vfio': 'VfioStats',
            '*xbzrle-cache': 'XBZRLECacheStats',
            '*total-time': 'int',
@@ -520,6 +525,9 @@
 #
 # Features:
 #
+# @deprecated: @block migration is deprecated.  Use driver-mirror
+#     with NBD instead.
+#
 # @unstable: Members @x-colo and @x-ignore-shared are experimental.
 #
 # Since: 1.2
@@ -529,7 +537,8 @@
            'compress', 'events', 'postcopy-ram',
            { 'name': 'x-colo', 'features': [ 'unstable' ] },
            'release-ram',
-           'block', 'return-path', 'pause-before-switchover', 'multifd',
+           { 'name': 'block', 'features': [ 'deprecated' ] },
+           'return-path', 'pause-before-switchover', 'multifd',
            'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate',
            { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
            'validate-uuid', 'background-snapshot',
@@ -819,6 +828,9 @@
 #
 # Features:
 #
+# @deprecated: Member @block-incremental is obsolete. Use
+#     driver-mirror with NBD instead.
+#
 # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
 #     are experimental.
 #
@@ -834,7 +846,7 @@
            'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
            'downtime-limit',
            { 'name': 'x-checkpoint-delay', 'features': [ 'unstable' ] },
-           'block-incremental',
+           { 'name': 'block-incremental', 'features': [ 'deprecated' ] },
            'multifd-channels',
            'xbzrle-cache-size', 'max-postcopy-bandwidth',
            'max-cpu-throttle', 'multifd-compression',
@@ -985,6 +997,9 @@
 #
 # Features:
 #
+# @deprecated: Member @block-incremental is obsolete. Use
+#     driver-mirror with NBD instead.
+#
 # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
 #     are experimental.
 #
@@ -1013,7 +1028,8 @@
             '*downtime-limit': 'uint64',
             '*x-checkpoint-delay': { 'type': 'uint32',
                                      'features': [ 'unstable' ] },
-            '*block-incremental': 'bool',
+            '*block-incremental': { 'type': 'bool',
+                                    'features': [ 'deprecated' ] },
             '*multifd-channels': 'uint8',
             '*xbzrle-cache-size': 'size',
             '*max-postcopy-bandwidth': 'size',
@@ -1188,6 +1204,9 @@
 #
 # Features:
 #
+# @deprecated: Member @block-incremental is obsolete. Use
+#     driver-mirror with NBD instead.
+#
 # @unstable: Members @x-checkpoint-delay and
 #     @x-vcpu-dirty-limit-period are experimental.
 #
@@ -1213,7 +1232,8 @@
             '*downtime-limit': 'uint64',
             '*x-checkpoint-delay': { 'type': 'uint32',
                                      'features': [ 'unstable' ] },
-            '*block-incremental': 'bool',
+            '*block-incremental': { 'type': 'bool',
+                                    'features': [ 'deprecated' ] },
             '*multifd-channels': 'uint8',
             '*xbzrle-cache-size': 'size',
             '*max-postcopy-bandwidth': 'size',
diff --git a/migration/block.c b/migration/block.c
index b29e80bdc4..a095024108 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -722,6 +722,9 @@ static int block_save_setup(QEMUFile *f, void *opaque)
     trace_migration_block_save("setup", block_mig_state.submitted,
                                block_mig_state.transferred);
 
+    warn_report("block migration is deprecated.  Use driver-mirror with"
+                "NBD instead.");
+
     qemu_mutex_lock_iothread();
     ret = init_blk_migration(f);
     if (ret < 0) {
diff --git a/migration/options.c b/migration/options.c
index c072c2fab7..24c883696f 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -12,6 +12,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "exec/target_page.h"
 #include "qapi/clone-visitor.h"
 #include "qapi/error.h"
@@ -456,10 +457,14 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
     if (new_caps[MIGRATION_CAPABILITY_BLOCK]) {
         error_setg(errp, "QEMU compiled without old-style (blk/-b, inc/-i) "
                    "block migration");
-        error_append_hint(errp, "Use drive_mirror+NBD instead.\n");
+        error_append_hint(errp, "Use driver-mirror with NBD instead.\n");
         return false;
     }
 #endif
+    if (new_caps[MIGRATION_CAPABILITY_BLOCK]) {
+        warn_report("Block migration is deprecated. "
+                    "Use driver-mirror with NBD instead.");
+    }
 
 #ifndef CONFIG_REPLICATION
     if (new_caps[MIGRATION_CAPABILITY_X_COLO]) {
@@ -1336,6 +1341,8 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     }
 
     if (params->has_block_incremental) {
+        warn_report("Block migration is deprecated. "
+                    "Use driver-mirror with NBD instead.");
         s->parameters.block_incremental = params->block_incremental;
     }
     if (params->has_multifd_channels) {
-- 
2.40.1


