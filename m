Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 341AC74341A
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 07:24:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF6bS-0008GA-Ee; Fri, 30 Jun 2023 01:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=mf8A=CS=redhat.com=clg@ozlabs.org>)
 id 1qF6bB-0008DK-Og
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 01:23:15 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=mf8A=CS=redhat.com=clg@ozlabs.org>)
 id 1qF6b9-00046I-5o
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 01:23:13 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QskHJ2gznz4wpF;
 Fri, 30 Jun 2023 15:23:08 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QskHG0p9Vz4wZy;
 Fri, 30 Jun 2023 15:23:05 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 YangHang Liu <yanghliu@redhat.com>
Subject: [PULL 08/16] vfio/migration: Add support for switchover ack capability
Date: Fri, 30 Jun 2023 07:22:27 +0200
Message-ID: <20230630052235.1934154-9-clg@redhat.com>
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

Loading of a VFIO device's data can take a substantial amount of time as
the device may need to allocate resources, prepare internal data
structures, etc. This can increase migration downtime, especially for
VFIO devices with a lot of resources.

To solve this, VFIO migration uAPI defines "initial bytes" as part of
its precopy data stream. Initial bytes can be used in various ways to
improve VFIO migration performance. For example, it can be used to
transfer device metadata to pre-allocate resources in the destination.
However, for this to work we need to make sure that all initial bytes
are sent and loaded in the destination before the source VM is stopped.

Use migration switchover ack capability to make sure a VFIO device's
initial bytes are sent and loaded in the destination before the source
stops the VM and attempts to complete the migration.
This can significantly reduce migration downtime for some devices.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: YangHang Liu <yanghliu@redhat.com>
Acked-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/devel/vfio-migration.rst | 10 +++++++++
 include/hw/vfio/vfio-common.h |  1 +
 hw/vfio/migration.c           | 39 ++++++++++++++++++++++++++++++++++-
 3 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/docs/devel/vfio-migration.rst b/docs/devel/vfio-migration.rst
index e896b2a6734b..b433cb5bb2c8 100644
--- a/docs/devel/vfio-migration.rst
+++ b/docs/devel/vfio-migration.rst
@@ -16,6 +16,13 @@ helps to reduce the total downtime of the VM. VFIO devices opt-in to pre-copy
 support by reporting the VFIO_MIGRATION_PRE_COPY flag in the
 VFIO_DEVICE_FEATURE_MIGRATION ioctl.
 
+When pre-copy is supported, it's possible to further reduce downtime by
+enabling "switchover-ack" migration capability.
+VFIO migration uAPI defines "initial bytes" as part of its pre-copy data stream
+and recommends that the initial bytes are sent and loaded in the destination
+before stopping the source VM. Enabling this migration capability will
+guarantee that and thus, can potentially reduce downtime even further.
+
 Note that currently VFIO migration is supported only for a single device. This
 is due to VFIO migration's lack of P2P support. However, P2P support is planned
 to be added later on.
@@ -45,6 +52,9 @@ VFIO implements the device hooks for the iterative approach as follows:
 * A ``save_live_iterate`` function that reads the VFIO device's data from the
   vendor driver during iterative pre-copy phase.
 
+* A ``switchover_ack_needed`` function that checks if the VFIO device uses
+  "switchover-ack" migration capability when this capability is enabled.
+
 * A ``save_state`` function to save the device config space if it is present.
 
 * A ``save_live_complete_precopy`` function that sets the VFIO device in
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 1db901c1941f..3dc5f2104c86 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -69,6 +69,7 @@ typedef struct VFIOMigration {
     uint64_t mig_flags;
     uint64_t precopy_init_size;
     uint64_t precopy_dirty_size;
+    bool initial_data_sent;
 } VFIOMigration;
 
 typedef struct VFIOAddressSpace {
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index d8f6a22ae14e..acbf0bb7ab3c 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -18,6 +18,8 @@
 #include "sysemu/runstate.h"
 #include "hw/vfio/vfio-common.h"
 #include "migration/migration.h"
+#include "migration/options.h"
+#include "migration/savevm.h"
 #include "migration/vmstate.h"
 #include "migration/qemu-file.h"
 #include "migration/register.h"
@@ -45,6 +47,7 @@
 #define VFIO_MIG_FLAG_DEV_CONFIG_STATE  (0xffffffffef100002ULL)
 #define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
 #define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)
+#define VFIO_MIG_FLAG_DEV_INIT_DATA_SENT (0xffffffffef100005ULL)
 
 /*
  * This is an arbitrary size based on migration of mlx5 devices, where typically
@@ -384,6 +387,7 @@ static void vfio_save_cleanup(void *opaque)
     migration->data_buffer = NULL;
     migration->precopy_init_size = 0;
     migration->precopy_dirty_size = 0;
+    migration->initial_data_sent = false;
     vfio_migration_cleanup(vbasedev);
     trace_vfio_save_cleanup(vbasedev->name);
 }
@@ -457,10 +461,17 @@ static int vfio_save_iterate(QEMUFile *f, void *opaque)
     if (data_size < 0) {
         return data_size;
     }
-    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
 
     vfio_update_estimated_pending_data(migration, data_size);
 
+    if (migrate_switchover_ack() && !migration->precopy_init_size &&
+        !migration->initial_data_sent) {
+        qemu_put_be64(f, VFIO_MIG_FLAG_DEV_INIT_DATA_SENT);
+        migration->initial_data_sent = true;
+    } else {
+        qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
+    }
+
     trace_vfio_save_iterate(vbasedev->name, migration->precopy_init_size,
                             migration->precopy_dirty_size);
 
@@ -579,6 +590,24 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
             }
             break;
         }
+        case VFIO_MIG_FLAG_DEV_INIT_DATA_SENT:
+        {
+            if (!vfio_precopy_supported(vbasedev) ||
+                !migrate_switchover_ack()) {
+                error_report("%s: Received INIT_DATA_SENT but switchover ack "
+                             "is not used", vbasedev->name);
+                return -EINVAL;
+            }
+
+            ret = qemu_loadvm_approve_switchover();
+            if (ret) {
+                error_report(
+                    "%s: qemu_loadvm_approve_switchover failed, err=%d (%s)",
+                    vbasedev->name, ret, strerror(-ret));
+            }
+
+            return ret;
+        }
         default:
             error_report("%s: Unknown tag 0x%"PRIx64, vbasedev->name, data);
             return -EINVAL;
@@ -593,6 +622,13 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
     return ret;
 }
 
+static bool vfio_switchover_ack_needed(void *opaque)
+{
+    VFIODevice *vbasedev = opaque;
+
+    return vfio_precopy_supported(vbasedev);
+}
+
 static const SaveVMHandlers savevm_vfio_handlers = {
     .save_setup = vfio_save_setup,
     .save_cleanup = vfio_save_cleanup,
@@ -605,6 +641,7 @@ static const SaveVMHandlers savevm_vfio_handlers = {
     .load_setup = vfio_load_setup,
     .load_cleanup = vfio_load_cleanup,
     .load_state = vfio_load_state,
+    .switchover_ack_needed = vfio_switchover_ack_needed,
 };
 
 /* ---------------------------------------------------------------------- */
-- 
2.41.0


