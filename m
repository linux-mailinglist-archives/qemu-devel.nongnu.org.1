Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFBD74341B
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 07:24:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF6bQ-0008E0-Tt; Fri, 30 Jun 2023 01:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=mf8A=CS=redhat.com=clg@ozlabs.org>)
 id 1qF6b1-0008Ah-QU
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 01:23:04 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=mf8A=CS=redhat.com=clg@ozlabs.org>)
 id 1qF6at-0003Ha-FY
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 01:22:58 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QskGt6NQRz4wgk;
 Fri, 30 Jun 2023 15:22:46 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QskGr0T6Nz4wZy;
 Fri, 30 Jun 2023 15:22:43 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, YangHang Liu <yanghliu@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 01/16] migration: Add switchover ack capability
Date: Fri, 30 Jun 2023 07:22:20 +0200
Message-ID: <20230630052235.1934154-2-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630052235.1934154-1-clg@redhat.com>
References: <20230630052235.1934154-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=mf8A=CS=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

From: Avihai Horon <avihaih@nvidia.com>

Migration downtime estimation is calculated based on bandwidth and
remaining migration data. This assumes that loading of migration data in
the destination takes a negligible amount of time and that downtime
depends only on network speed.

While this may be true for RAM, it's not necessarily true for other
migrated devices. For example, loading the data of a VFIO device in the
destination might require from the device to allocate resources, prepare
internal data structures and so on. These operations can take a
significant amount of time which can increase migration downtime.

This patch adds a new capability "switchover ack" that prevents the
source from stopping the VM and completing the migration until an ACK
is received from the destination that it's OK to do so.

This can be used by migrated devices in various ways to reduce downtime.
For example, a device can send initial precopy metadata to pre-allocate
resources in the destination and use this capability to make sure that
the pre-allocation is completed before the source VM is stopped, so it
will have full effect.

This new capability relies on the return path capability to communicate
from the destination back to the source.

The actual implementation of the capability will be added in the
following patches.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Tested-by: YangHang Liu <yanghliu@redhat.com>
Acked-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 qapi/migration.json | 12 +++++++++++-
 migration/options.h |  1 +
 migration/options.c | 21 +++++++++++++++++++++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 5bb5ab82a0cf..47dfef02780f 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -487,6 +487,16 @@
 #     and should not affect the correctness of postcopy migration.
 #     (since 7.1)
 #
+# @switchover-ack: If enabled, migration will not stop the source VM
+#     and complete the migration until an ACK is received from the
+#     destination that it's OK to do so.  Exactly when this ACK is
+#     sent depends on the migrated devices that use this feature.
+#     For example, a device can use it to make sure some of its data
+#     is sent and loaded in the destination before doing switchover.
+#     This can reduce downtime if devices that support this capability
+#     are present.  'return-path' capability must be enabled to use
+#     it.  (since 8.1)
+#
 # Features:
 #
 # @unstable: Members @x-colo and @x-ignore-shared are experimental.
@@ -502,7 +512,7 @@
            'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate',
            { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
            'validate-uuid', 'background-snapshot',
-           'zero-copy-send', 'postcopy-preempt'] }
+           'zero-copy-send', 'postcopy-preempt', 'switchover-ack'] }
 
 ##
 # @MigrationCapabilityStatus:
diff --git a/migration/options.h b/migration/options.h
index 45991af3c208..9aaf363322b4 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -40,6 +40,7 @@ bool migrate_postcopy_ram(void);
 bool migrate_rdma_pin_all(void);
 bool migrate_release_ram(void);
 bool migrate_return_path(void);
+bool migrate_switchover_ack(void);
 bool migrate_validate_uuid(void);
 bool migrate_xbzrle(void);
 bool migrate_zero_blocks(void);
diff --git a/migration/options.c b/migration/options.c
index b62ab30cd585..16007afca662 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -185,6 +185,8 @@ Property migration_properties[] = {
     DEFINE_PROP_MIG_CAP("x-zero-copy-send",
             MIGRATION_CAPABILITY_ZERO_COPY_SEND),
 #endif
+    DEFINE_PROP_MIG_CAP("x-switchover-ack",
+                        MIGRATION_CAPABILITY_SWITCHOVER_ACK),
 
     DEFINE_PROP_END_OF_LIST(),
 };
@@ -308,6 +310,13 @@ bool migrate_return_path(void)
     return s->capabilities[MIGRATION_CAPABILITY_RETURN_PATH];
 }
 
+bool migrate_switchover_ack(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->capabilities[MIGRATION_CAPABILITY_SWITCHOVER_ACK];
+}
+
 bool migrate_validate_uuid(void)
 {
     MigrationState *s = migrate_get_current();
@@ -547,6 +556,18 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
         }
     }
 
+    if (new_caps[MIGRATION_CAPABILITY_SWITCHOVER_ACK]) {
+        if (!new_caps[MIGRATION_CAPABILITY_RETURN_PATH]) {
+            error_setg(errp, "Capability 'switchover-ack' requires capability "
+                             "'return-path'");
+            return false;
+        }
+
+        /* Disable this capability until it's implemented */
+        error_setg(errp, "'switchover-ack' is not implemented yet");
+        return false;
+    }
+
     return true;
 }
 
-- 
2.41.0


