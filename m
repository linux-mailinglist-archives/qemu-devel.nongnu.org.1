Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2279B72CFA0
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 21:34:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8nIq-0004QK-8S; Mon, 12 Jun 2023 15:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q8nIk-0004Ox-MD
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 15:34:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q8nIj-0006E5-38
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 15:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686598444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TsG0ULPROPJHJvum3v/paBKuGm0ocJHoqJw2De/kGRc=;
 b=NDvqSNwHduNaB2e4IoUHOtuv2HfRmwAr28uNk8u3QYFjgWCG2JKd43JzkMXWAuskpKdEw0
 XKTy/hJeDc2xs96FTveGeQHI5MpmrqhMEiWkG37Y9Ijef4arTPupYzFvTR9ebfIZVxba2g
 Y6+L5eBgiHxgBIv1hPOSrJWf72qF3eo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-360-nBWgWAtTP_epjHDLNV2j7w-1; Mon, 12 Jun 2023 15:34:01 -0400
X-MC-Unique: nBWgWAtTP_epjHDLNV2j7w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB66E1C02D2B;
 Mon, 12 Jun 2023 19:34:00 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F03E9141511A;
 Mon, 12 Jun 2023 19:33:57 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Peter Xu <peterx@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>,
 Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 libvir-list@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>
Subject: [RFC 5/6] migration: Deprecate block migration
Date: Mon, 12 Jun 2023 21:33:43 +0200
Message-Id: <20230612193344.3796-6-quintela@redhat.com>
In-Reply-To: <20230612193344.3796-1-quintela@redhat.com>
References: <20230612193344.3796-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

It is obsolete.  It is better to use driver_mirror+NBD instead.

CC: Kevin Wolf <kwolf@redhat.com>
CC: Eric Blake <eblake@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
CC: Hanna Czenczek <hreitz@redhat.com>

Signed-off-by: Juan Quintela <quintela@redhat.com>

---

Can any of you give one example of how to use driver_mirror+NBD for
deprecated.rst?

Thanks, Juan.
---
 docs/about/deprecated.rst |  6 ++++++
 qapi/migration.json       | 29 +++++++++++++++++++++++++----
 migration/block.c         |  2 ++
 migration/options.c       |  7 +++++++
 4 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 518672722d..173c5ba5cb 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -454,3 +454,9 @@ Everything except ``-incoming defer`` are deprecated.  This allows to
 setup parameters before launching the proper migration with
 ``migrate-incoming uri``.
 
+block migration (since 8.1)
+'''''''''''''''''''''''''''
+
+Block migration is too inflexible.  It needs to migrate all block
+devices or none.  Use driver_mirror+NBD instead.
+
diff --git a/qapi/migration.json b/qapi/migration.json
index b71e00737e..a8497de48d 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -258,11 +258,16 @@
 #     blocked.  Present and non-empty when migration is blocked.
 #     (since 6.0)
 #
+# Features:
+#
+# @deprecated: @disk migration is deprecated.  Use driver_mirror+NBD
+#     instead.
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
@@ -497,6 +502,9 @@
 #
 # Features:
 #
+# @deprecated: @block migration is deprecated.  Use driver_mirror+NBD
+#     instead.
+#
 # @unstable: Members @x-colo and @x-ignore-shared are experimental.
 #
 # Since: 1.2
@@ -506,7 +514,8 @@
            'compress', 'events', 'postcopy-ram',
            { 'name': 'x-colo', 'features': [ 'unstable' ] },
            'release-ram',
-           'block', 'return-path', 'pause-before-switchover', 'multifd',
+           { 'name': 'block', 'features': [ 'deprecated' ] },
+           'return-path', 'pause-before-switchover', 'multifd',
            'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate',
            { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
            'validate-uuid', 'background-snapshot',
@@ -789,6 +798,9 @@
 #
 # Features:
 #
+# @deprecated: Member @block-incremental is obsolete. Use
+#     driver_mirror+NBD instead.
+#
 # @unstable: Member @x-checkpoint-delay is experimental.
 #
 # Since: 2.4
@@ -803,7 +815,7 @@
            'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
            'downtime-limit',
            { 'name': 'x-checkpoint-delay', 'features': [ 'unstable' ] },
-           'block-incremental',
+           { 'name': 'block-incremental', 'features': [ 'deprecated' ] },
            'multifd-channels',
            'xbzrle-cache-size', 'max-postcopy-bandwidth',
            'max-cpu-throttle', 'multifd-compression',
@@ -945,6 +957,9 @@
 #
 # Features:
 #
+# @deprecated: Member @block-incremental is obsolete. Use
+#     driver_mirror+NBD instead.
+#
 # @unstable: Member @x-checkpoint-delay is experimental.
 #
 # TODO: either fuse back into MigrationParameters, or make
@@ -972,7 +987,8 @@
             '*downtime-limit': 'uint64',
             '*x-checkpoint-delay': { 'type': 'uint32',
                                      'features': [ 'unstable' ] },
-            '*block-incremental': 'bool',
+            '*block-incremental': { 'type': 'bool',
+                                    'features': [ 'deprecated' ] },
             '*multifd-channels': 'uint8',
             '*xbzrle-cache-size': 'size',
             '*max-postcopy-bandwidth': 'size',
@@ -1137,6 +1153,9 @@
 #
 # Features:
 #
+# @deprecated: Member @block-incremental is obsolete. Use
+#     driver_mirror+NBD instead.
+#
 # @unstable: Member @x-checkpoint-delay is experimental.
 #
 # Since: 2.4
@@ -1161,6 +1180,8 @@
             '*downtime-limit': 'uint64',
             '*x-checkpoint-delay': { 'type': 'uint32',
                                      'features': [ 'unstable' ] },
+            '*block-incremental': { 'type': 'bool',
+                                    'features': [ 'deprecated' ] },
             '*block-incremental': 'bool',
             '*multifd-channels': 'uint8',
             '*xbzrle-cache-size': 'size',
diff --git a/migration/block.c b/migration/block.c
index b9580a6c7e..2521a22269 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -722,6 +722,8 @@ static int block_save_setup(QEMUFile *f, void *opaque)
     trace_migration_block_save("setup", block_mig_state.submitted,
                                block_mig_state.transferred);
 
+    warn_report("block migration is deprecated.  Use mirror jobs instead.");
+
     qemu_mutex_lock_iothread();
     ret = init_blk_migration(f);
     if (ret < 0) {
diff --git a/migration/options.c b/migration/options.c
index b62ab30cd5..374dc0767e 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -12,6 +12,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "exec/target_page.h"
 #include "qapi/clone-visitor.h"
 #include "qapi/error.h"
@@ -437,6 +438,10 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
         return false;
     }
 #endif
+    if (new_caps[MIGRATION_CAPABILITY_BLOCK]) {
+        warn_report("Block migration is deprecated. "
+                    "Use driver_mirror+NBD instead.");
+    }
 
 #ifndef CONFIG_REPLICATION
     if (new_caps[MIGRATION_CAPABILITY_X_COLO]) {
@@ -1257,6 +1262,8 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     }
 
     if (params->has_block_incremental) {
+        warn_report("Block migration is deprecated. "
+                    "Use driver_mirror+NBD instead.");
         s->parameters.block_incremental = params->block_incremental;
     }
     if (params->has_multifd_channels) {
-- 
2.40.1


