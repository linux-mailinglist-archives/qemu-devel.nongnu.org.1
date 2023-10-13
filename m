Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EDB7C83AA
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 12:49:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrFjE-0006Ye-8g; Fri, 13 Oct 2023 06:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qrFjC-0006Pq-6s
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 06:49:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qrFjA-0007Nf-9V
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 06:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697194147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VzdRJx5JZT4ZldUPEy6NAzPBmz6Sjor+sLnlxTw9/GQ=;
 b=hmFDG9waZNTruP7Su0rkBkfXcxm/KS2b99m9s9Pn3dXWNpCl1rWxoES65B/Mfih4tIUNUZ
 NyRJfKKc6bFGGkh9KkofkwHXOCYvzA6h1Z9vG5mDD1IWB0kI5BgzjA/Mqmv030AOBloFGR
 6OS2w0+pAKFEYCmRDZOGgqfYDE7ZNgg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-690-G-MdzQ4TOE-WxsyCpeqCbg-1; Fri, 13 Oct 2023 06:47:57 -0400
X-MC-Unique: G-MdzQ4TOE-WxsyCpeqCbg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EEF8F81DA88;
 Fri, 13 Oct 2023 10:47:56 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BFC102156701;
 Fri, 13 Oct 2023 10:47:53 +0000 (UTC)
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
 Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Czenczek <hreitz@redhat.com>
Subject: [PATCH v4 05/10] migration: Deprecate block migration
Date: Fri, 13 Oct 2023 12:47:31 +0200
Message-ID: <20231013104736.31722-6-quintela@redhat.com>
In-Reply-To: <20231013104736.31722-1-quintela@redhat.com>
References: <20231013104736.31722-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

It is obsolete.  It is better to use driver-mirror with NBD instead.

CC: Kevin Wolf <kwolf@redhat.com>
CC: Eric Blake <eblake@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
CC: Hanna Czenczek <hreitz@redhat.com>

Signed-off-by: Juan Quintela <quintela@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 docs/about/deprecated.rst | 10 ++++++++++
 qapi/migration.json       | 29 ++++++++++++++++++++++++-----
 migration/block.c         |  3 +++
 migration/options.c       |  9 ++++++++-
 4 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index e6928b96cf..6490925cdc 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -466,3 +466,13 @@ The new way to modify migration is using migration parameters.
 ``blk`` functionality can be achieved by setting the
 ``block`` migration capability to ``true``.
 
+block migration (since 8.2)
+'''''''''''''''''''''''''''
+
+Block migration is too inflexible.  It needs to migrate all block
+devices or none.
+
+Please see "QMP invocation for live storage migration with
+``blockdev-mirror`` + NBD" in docs/interop/live-block-operations.rst
+for a detailed explanation.
+
diff --git a/qapi/migration.json b/qapi/migration.json
index 64ebced761..5e545d10c0 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -269,11 +269,15 @@
 #     average memory load of the virtual CPU indirectly.  Note that
 #     zero means guest doesn't dirty memory.  (Since 8.1)
 #
+# Features:
+#
+# @deprecated: Member @disk is deprecated because block migration is.
+#
 # Since: 0.14
 ##
 { 'struct': 'MigrationInfo',
   'data': {'*status': 'MigrationStatus', '*ram': 'MigrationStats',
-           '*disk': 'MigrationStats',
+           '*disk': { 'type': 'MigrationStats', 'features': [ 'deprecated' ] },
            '*vfio': 'VfioStats',
            '*xbzrle-cache': 'XBZRLECacheStats',
            '*total-time': 'int',
@@ -525,6 +529,9 @@
 #
 # Features:
 #
+# @deprecated: Member @block is deprecated.  Use blockdev-mirror with
+#     NBD instead.
+#
 # @unstable: Members @x-colo and @x-ignore-shared are experimental.
 #
 # Since: 1.2
@@ -534,7 +541,8 @@
            'compress', 'events', 'postcopy-ram',
            { 'name': 'x-colo', 'features': [ 'unstable' ] },
            'release-ram',
-           'block', 'return-path', 'pause-before-switchover', 'multifd',
+           { 'name': 'block', 'features': [ 'deprecated' ] },
+           'return-path', 'pause-before-switchover', 'multifd',
            'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate',
            { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
            'validate-uuid', 'background-snapshot',
@@ -825,6 +833,9 @@
 #
 # Features:
 #
+# @deprecated: Member @block-incremental is deprecated. Use
+#     blockdev-mirror with NBD instead.
+#
 # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
 #     are experimental.
 #
@@ -840,7 +851,7 @@
            'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
            'downtime-limit',
            { 'name': 'x-checkpoint-delay', 'features': [ 'unstable' ] },
-           'block-incremental',
+           { 'name': 'block-incremental', 'features': [ 'deprecated' ] },
            'multifd-channels',
            'xbzrle-cache-size', 'max-postcopy-bandwidth',
            'max-cpu-throttle', 'multifd-compression',
@@ -991,6 +1002,9 @@
 #
 # Features:
 #
+# @deprecated: Member @block-incremental is deprecated. Use
+#     blockdev-mirror with NBD instead.
+#
 # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
 #     are experimental.
 #
@@ -1019,7 +1033,8 @@
             '*downtime-limit': 'uint64',
             '*x-checkpoint-delay': { 'type': 'uint32',
                                      'features': [ 'unstable' ] },
-            '*block-incremental': 'bool',
+            '*block-incremental': { 'type': 'bool',
+                                    'features': [ 'deprecated' ] },
             '*multifd-channels': 'uint8',
             '*xbzrle-cache-size': 'size',
             '*max-postcopy-bandwidth': 'size',
@@ -1194,6 +1209,9 @@
 #
 # Features:
 #
+# @deprecated: Member @block-incremental is deprecated. Use
+#     blockdev-mirror with NBD instead.
+#
 # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
 #     are experimental.
 #
@@ -1219,7 +1237,8 @@
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
index 5f930870a5..7f563c70f6 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -729,6 +729,9 @@ static int block_save_setup(QEMUFile *f, void *opaque)
     trace_migration_block_save("setup", block_mig_state.submitted,
                                block_mig_state.transferred);
 
+    warn_report("block migration is deprecated.  Use blockdev-mirror with"
+                "NBD instead.");
+
     qemu_mutex_lock_iothread();
     ret = init_blk_migration(f);
     if (ret < 0) {
diff --git a/migration/options.c b/migration/options.c
index 6bbfd4853d..bb6005052f 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -12,6 +12,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "exec/target_page.h"
 #include "qapi/clone-visitor.h"
 #include "qapi/error.h"
@@ -464,10 +465,14 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
     if (new_caps[MIGRATION_CAPABILITY_BLOCK]) {
         error_setg(errp, "QEMU compiled without old-style (blk/-b, inc/-i) "
                    "block migration");
-        error_append_hint(errp, "Use drive_mirror+NBD instead.\n");
+        error_append_hint(errp, "Use blockdev-mirror with NBD instead.\n");
         return false;
     }
 #endif
+    if (new_caps[MIGRATION_CAPABILITY_BLOCK]) {
+        warn_report("Block migration is deprecated. "
+                    "Use blockdev-mirror with NBD instead.");
+    }
 
 #ifndef CONFIG_REPLICATION
     if (new_caps[MIGRATION_CAPABILITY_X_COLO]) {
@@ -1351,6 +1356,8 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     }
 
     if (params->has_block_incremental) {
+        warn_report("Block migration is deprecated. "
+                    "Use blockdev-mirror with NBD instead.");
         s->parameters.block_incremental = params->block_incremental;
     }
     if (params->has_multifd_channels) {
-- 
2.41.0


