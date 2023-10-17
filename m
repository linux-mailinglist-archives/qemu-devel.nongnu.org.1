Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E749B7CC20E
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 13:53:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsidF-0004BT-2B; Tue, 17 Oct 2023 07:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsidC-0004Aw-Np
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 07:53:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsidA-00051s-UI
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 07:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697543580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MF8BZ1Ml3OdkqZp1OMbtekKsgQYizUs+Hd384vpth8o=;
 b=SziBLRNiU/5AKIYrIoBDLIT5rjUsN1npGeo+s1UTjzj8+sDShdqUHHiC7ViaEdhKQ+eByo
 obqbTzcjcOA6xuWBAXa/YB44s+n9E8ESA6qvyJgXoGd87s5OoaXAMt7Ii9AQ9Jie622N/P
 2P5Xo+a78amo+yuXcSrOmyeZcldeLqI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-34-aMbrY0NwM3qijgFM6SbPSg-1; Tue, 17 Oct 2023 07:52:51 -0400
X-MC-Unique: aMbrY0NwM3qijgFM6SbPSg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB68329AB42D;
 Tue, 17 Oct 2023 11:52:50 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A2EE4492BFA;
 Tue, 17 Oct 2023 11:52:48 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Leonardo Bras <leobras@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Czenczek <hreitz@redhat.com>
Subject: [PATCH v5 4/7] migration: Deprecate block migration
Date: Tue, 17 Oct 2023 13:52:35 +0200
Message-ID: <20231017115238.18309-5-quintela@redhat.com>
In-Reply-To: <20231017115238.18309-1-quintela@redhat.com>
References: <20231017115238.18309-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
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
index 0149f040b6..5eaf096040 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -479,3 +479,13 @@ As an intermediate step the ``blk`` functionality can be achieved by
 setting the ``block`` migration capability to ``true``.
 But this capability is also deprecated.
 
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
index 59a07b50f0..c7633b22c0 100644
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
@@ -835,6 +843,9 @@
 #
 # Features:
 #
+# @deprecated: Member @block-incremental is deprecated. Use
+#     blockdev-mirror with NBD instead.
+#
 # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
 #     are experimental.
 #
@@ -850,7 +861,7 @@
            'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
            'avail-switchover-bandwidth', 'downtime-limit',
            { 'name': 'x-checkpoint-delay', 'features': [ 'unstable' ] },
-           'block-incremental',
+           { 'name': 'block-incremental', 'features': [ 'deprecated' ] },
            'multifd-channels',
            'xbzrle-cache-size', 'max-postcopy-bandwidth',
            'max-cpu-throttle', 'multifd-compression',
@@ -1011,6 +1022,9 @@
 #
 # Features:
 #
+# @deprecated: Member @block-incremental is deprecated. Use
+#     blockdev-mirror with NBD instead.
+#
 # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
 #     are experimental.
 #
@@ -1040,7 +1054,8 @@
             '*downtime-limit': 'uint64',
             '*x-checkpoint-delay': { 'type': 'uint32',
                                      'features': [ 'unstable' ] },
-            '*block-incremental': 'bool',
+            '*block-incremental': { 'type': 'bool',
+                                    'features': [ 'deprecated' ] },
             '*multifd-channels': 'uint8',
             '*xbzrle-cache-size': 'size',
             '*max-postcopy-bandwidth': 'size',
@@ -1225,6 +1240,9 @@
 #
 # Features:
 #
+# @deprecated: Member @block-incremental is deprecated. Use
+#     blockdev-mirror with NBD instead.
+#
 # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
 #     are experimental.
 #
@@ -1251,7 +1269,8 @@
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
index b60698d6e2..7682f4fbd2 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -731,6 +731,9 @@ static int block_save_setup(QEMUFile *f, void *opaque)
     trace_migration_block_save("setup", block_mig_state.submitted,
                                block_mig_state.transferred);
 
+    warn_report("block migration is deprecated.  Use blockdev-mirror with"
+                "NBD instead.");
+
     ret = init_blk_migration(f);
     if (ret < 0) {
         return ret;
diff --git a/migration/options.c b/migration/options.c
index 42fb818956..0d0a3f8edb 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -12,6 +12,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "exec/target_page.h"
 #include "qapi/clone-visitor.h"
 #include "qapi/error.h"
@@ -473,10 +474,14 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
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
@@ -1386,6 +1391,8 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     }
 
     if (params->has_block_incremental) {
+        warn_report("Block migration is deprecated. "
+                    "Use blockdev-mirror with NBD instead.");
         s->parameters.block_incremental = params->block_incremental;
     }
     if (params->has_multifd_channels) {
-- 
2.41.0


