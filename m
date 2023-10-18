Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7F17CD949
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 12:33:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt3qv-00081E-7y; Wed, 18 Oct 2023 06:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt3qd-0007uc-Et
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:32:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt3qb-0003jj-6a
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697625136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iKrkhFguhL2dqdpmBGRgHd1D0r81yrwtKiys4zSgVTg=;
 b=M2MYJpHowAtodTHUXQhAfS9IBVP52hqYjtaQWvfGEy3JdKqVvtPpchroNzruwdpM8RZXTW
 dW+dLLOo0ukCve50hoFaiAyzNe+0+pyf/XkEHumDWMI6rwd3jy31mg18YGzJ1JnvFEpFbv
 5phe+vzruVkmy/gV/u/48d7V/405fwM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-403-zQcler9KN-mGFuRsEYQ61Q-1; Wed, 18 Oct 2023 06:32:15 -0400
X-MC-Unique: zQcler9KN-mGFuRsEYQ61Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D3FFC800CA6;
 Wed, 18 Oct 2023 10:32:14 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A6AA02026D4C;
 Wed, 18 Oct 2023 10:32:12 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>,
 Peter Xu <peterx@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Leonardo Bras <leobras@redhat.com>, Juan Quintela <quintela@redhat.com>,
 libvir-list@redhat.com, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: [PATCH v7 3/4] migration: Deprecate block migration
Date: Wed, 18 Oct 2023 12:32:03 +0200
Message-ID: <20231018103204.33444-4-quintela@redhat.com>
In-Reply-To: <20231018103204.33444-1-quintela@redhat.com>
References: <20231018103204.33444-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 docs/about/deprecated.rst  | 10 ++++++++++
 qapi/migration.json        | 29 ++++++++++++++++++++++++-----
 migration/block.c          |  3 +++
 migration/options.c        |  9 ++++++++-
 tests/qemu-iotests/183.out |  1 +
 5 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 98b0f14e69..7ae872162d 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -478,3 +478,13 @@ Use blockdev-mirror with NBD instead.
 As an intermediate step the ``blk`` functionality can be achieved by
 setting the ``block`` migration capability to ``true``.  But this
 capability is also deprecated.
+
+block migration (since 8.2)
+'''''''''''''''''''''''''''
+
+Block migration is too inflexible.  It needs to migrate all block
+devices or none.
+
+Please see "QMP invocation for live storage migration with
+``blockdev-mirror`` + NBD" in docs/interop/live-block-operations.rst
+for a detailed explanation.
diff --git a/qapi/migration.json b/qapi/migration.json
index 3765c2b662..e3b00a215b 100644
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
+# @deprecated: Member @block-incremental is deprecated.  Use
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
+# @deprecated: Member @block-incremental is deprecated.  Use
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
+# @deprecated: Member @block-incremental is deprecated.  Use
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
index b60698d6e2..acffe88f84 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -731,6 +731,9 @@ static int block_save_setup(QEMUFile *f, void *opaque)
     trace_migration_block_save("setup", block_mig_state.submitted,
                                block_mig_state.transferred);
 
+    warn_report("block migration is deprecated;"
+                " use blockdev-mirror with NBD instead");
+
     ret = init_blk_migration(f);
     if (ret < 0) {
         return ret;
diff --git a/migration/options.c b/migration/options.c
index 42fb818956..a753eae438 100644
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
+        warn_report("block migration is deprecated;"
+                    " use blockdev-mirror with NBD instead");
+    }
 
 #ifndef CONFIG_REPLICATION
     if (new_caps[MIGRATION_CAPABILITY_X_COLO]) {
@@ -1386,6 +1391,8 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     }
 
     if (params->has_block_incremental) {
+        warn_report("block migration is deprecated;"
+                    " use blockdev-mirror with NBD instead");
         s->parameters.block_incremental = params->block_incremental;
     }
     if (params->has_multifd_channels) {
diff --git a/tests/qemu-iotests/183.out b/tests/qemu-iotests/183.out
index b49f491854..8618726f2b 100644
--- a/tests/qemu-iotests/183.out
+++ b/tests/qemu-iotests/183.out
@@ -29,6 +29,7 @@ read 65536/65536 bytes at offset 0
 { 'execute': 'migrate',
        'arguments': { 'uri': 'unix:SOCK_DIR/migrate', 'blk': true } }
 warning: parameter 'blk' is deprecated; use blockdev-mirror with NBD instead
+warning: block migration is deprecated; use blockdev-mirror with NBD instead
 {"return": {}}
 { 'execute': 'query-status' }
 {"return": {"status": "postmigrate", "singlestep": false, "running": false}}
-- 
2.41.0


