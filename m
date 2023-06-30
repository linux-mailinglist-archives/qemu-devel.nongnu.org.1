Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8576F743436
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 07:28:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF6bT-0008Hi-R5; Fri, 30 Jun 2023 01:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=mf8A=CS=redhat.com=clg@ozlabs.org>)
 id 1qF6b9-0008DJ-Db
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 01:23:15 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=mf8A=CS=redhat.com=clg@ozlabs.org>)
 id 1qF6b6-0003yQ-0G
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 01:23:10 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QskHF3xH8z4wpD;
 Fri, 30 Jun 2023 15:23:05 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QskHC23xrz4wZy;
 Fri, 30 Jun 2023 15:23:03 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 YangHang Liu <yanghliu@redhat.com>
Subject: [PULL 07/16] vfio/migration: Add VFIO migration pre-copy support
Date: Fri, 30 Jun 2023 07:22:26 +0200
Message-ID: <20230630052235.1934154-8-clg@redhat.com>
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

Pre-copy support allows the VFIO device data to be transferred while the
VM is running. This helps to accommodate VFIO devices that have a large
amount of data that needs to be transferred, and it can reduce migration
downtime.

Pre-copy support is optional in VFIO migration protocol v2.
Implement pre-copy of VFIO migration protocol v2 and use it for devices
that support it. Full description of it can be found in the following
Linux commit: 4db52602a607 ("vfio: Extend the device migration protocol
with PRE_COPY").

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: YangHang Liu <yanghliu@redhat.com>
Acked-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/devel/vfio-migration.rst |  35 +++++---
 include/hw/vfio/vfio-common.h |   2 +
 hw/vfio/common.c              |   6 +-
 hw/vfio/migration.c           | 165 ++++++++++++++++++++++++++++++++--
 hw/vfio/trace-events          |   4 +-
 5 files changed, 190 insertions(+), 22 deletions(-)

diff --git a/docs/devel/vfio-migration.rst b/docs/devel/vfio-migration.rst
index 1b68ccf11529..e896b2a6734b 100644
--- a/docs/devel/vfio-migration.rst
+++ b/docs/devel/vfio-migration.rst
@@ -7,12 +7,14 @@ the guest is running on source host and restoring this saved state on the
 destination host. This document details how saving and restoring of VFIO
 devices is done in QEMU.
 
-Migration of VFIO devices currently consists of a single stop-and-copy phase.
-During the stop-and-copy phase the guest is stopped and the entire VFIO device
-data is transferred to the destination.
-
-The pre-copy phase of migration is currently not supported for VFIO devices.
-Support for VFIO pre-copy will be added later on.
+Migration of VFIO devices consists of two phases: the optional pre-copy phase,
+and the stop-and-copy phase. The pre-copy phase is iterative and allows to
+accommodate VFIO devices that have a large amount of data that needs to be
+transferred. The iterative pre-copy phase of migration allows for the guest to
+continue whilst the VFIO device state is transferred to the destination, this
+helps to reduce the total downtime of the VM. VFIO devices opt-in to pre-copy
+support by reporting the VFIO_MIGRATION_PRE_COPY flag in the
+VFIO_DEVICE_FEATURE_MIGRATION ioctl.
 
 Note that currently VFIO migration is supported only for a single device. This
 is due to VFIO migration's lack of P2P support. However, P2P support is planned
@@ -29,10 +31,20 @@ VFIO implements the device hooks for the iterative approach as follows:
 * A ``load_setup`` function that sets the VFIO device on the destination in
   _RESUMING state.
 
+* A ``state_pending_estimate`` function that reports an estimate of the
+  remaining pre-copy data that the vendor driver has yet to save for the VFIO
+  device.
+
 * A ``state_pending_exact`` function that reads pending_bytes from the vendor
   driver, which indicates the amount of data that the vendor driver has yet to
   save for the VFIO device.
 
+* An ``is_active_iterate`` function that indicates ``save_live_iterate`` is
+  active only when the VFIO device is in pre-copy states.
+
+* A ``save_live_iterate`` function that reads the VFIO device's data from the
+  vendor driver during iterative pre-copy phase.
+
 * A ``save_state`` function to save the device config space if it is present.
 
 * A ``save_live_complete_precopy`` function that sets the VFIO device in
@@ -111,8 +123,10 @@ Flow of state changes during Live migration
 ===========================================
 
 Below is the flow of state change during live migration.
-The values in the brackets represent the VM state, the migration state, and
+The values in the parentheses represent the VM state, the migration state, and
 the VFIO device state, respectively.
+The text in the square brackets represents the flow if the VFIO device supports
+pre-copy.
 
 Live migration save path
 ------------------------
@@ -124,11 +138,12 @@ Live migration save path
                                   |
                      migrate_init spawns migration_thread
                 Migration thread then calls each device's .save_setup()
-                       (RUNNING, _SETUP, _RUNNING)
+                  (RUNNING, _SETUP, _RUNNING [_PRE_COPY])
                                   |
-                      (RUNNING, _ACTIVE, _RUNNING)
-             If device is active, get pending_bytes by .state_pending_exact()
+                  (RUNNING, _ACTIVE, _RUNNING [_PRE_COPY])
+      If device is active, get pending_bytes by .state_pending_{estimate,exact}()
           If total pending_bytes >= threshold_size, call .save_live_iterate()
+                  [Data of VFIO device for pre-copy phase is copied]
         Iterate till total pending bytes converge and are less than threshold
                                   |
   On migration completion, vCPU stops and calls .save_live_complete_precopy for
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 5f29dab83913..1db901c1941f 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -67,6 +67,8 @@ typedef struct VFIOMigration {
     void *data_buffer;
     size_t data_buffer_size;
     uint64_t mig_flags;
+    uint64_t precopy_init_size;
+    uint64_t precopy_dirty_size;
 } VFIOMigration;
 
 typedef struct VFIOAddressSpace {
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index fa8fd949b1cf..25801de173c4 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -492,7 +492,8 @@ static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
             }
 
             if (vbasedev->pre_copy_dirty_page_tracking == ON_OFF_AUTO_OFF &&
-                migration->device_state == VFIO_DEVICE_STATE_RUNNING) {
+                (migration->device_state == VFIO_DEVICE_STATE_RUNNING ||
+                 migration->device_state == VFIO_DEVICE_STATE_PRE_COPY)) {
                 return false;
             }
         }
@@ -537,7 +538,8 @@ static bool vfio_devices_all_running_and_mig_active(VFIOContainer *container)
                 return false;
             }
 
-            if (migration->device_state == VFIO_DEVICE_STATE_RUNNING) {
+            if (migration->device_state == VFIO_DEVICE_STATE_RUNNING ||
+                migration->device_state == VFIO_DEVICE_STATE_PRE_COPY) {
                 continue;
             } else {
                 return false;
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 8d3341437926..d8f6a22ae14e 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -68,6 +68,8 @@ static const char *mig_state_to_str(enum vfio_device_mig_state state)
         return "STOP_COPY";
     case VFIO_DEVICE_STATE_RESUMING:
         return "RESUMING";
+    case VFIO_DEVICE_STATE_PRE_COPY:
+        return "PRE_COPY";
     default:
         return "UNKNOWN STATE";
     }
@@ -241,6 +243,25 @@ static int vfio_query_stop_copy_size(VFIODevice *vbasedev,
     return 0;
 }
 
+static int vfio_query_precopy_size(VFIOMigration *migration)
+{
+    struct vfio_precopy_info precopy = {
+        .argsz = sizeof(precopy),
+    };
+
+    migration->precopy_init_size = 0;
+    migration->precopy_dirty_size = 0;
+
+    if (ioctl(migration->data_fd, VFIO_MIG_GET_PRECOPY_INFO, &precopy)) {
+        return -errno;
+    }
+
+    migration->precopy_init_size = precopy.initial_bytes;
+    migration->precopy_dirty_size = precopy.dirty_bytes;
+
+    return 0;
+}
+
 /* Returns the size of saved data on success and -errno on error */
 static ssize_t vfio_save_block(QEMUFile *f, VFIOMigration *migration)
 {
@@ -249,6 +270,14 @@ static ssize_t vfio_save_block(QEMUFile *f, VFIOMigration *migration)
     data_size = read(migration->data_fd, migration->data_buffer,
                      migration->data_buffer_size);
     if (data_size < 0) {
+        /*
+         * Pre-copy emptied all the device state for now. For more information,
+         * please refer to the Linux kernel VFIO uAPI.
+         */
+        if (errno == ENOMSG) {
+            return 0;
+        }
+
         return -errno;
     }
     if (data_size == 0) {
@@ -265,6 +294,38 @@ static ssize_t vfio_save_block(QEMUFile *f, VFIOMigration *migration)
     return qemu_file_get_error(f) ?: data_size;
 }
 
+static void vfio_update_estimated_pending_data(VFIOMigration *migration,
+                                               uint64_t data_size)
+{
+    if (!data_size) {
+        /*
+         * Pre-copy emptied all the device state for now, update estimated sizes
+         * accordingly.
+         */
+        migration->precopy_init_size = 0;
+        migration->precopy_dirty_size = 0;
+
+        return;
+    }
+
+    if (migration->precopy_init_size) {
+        uint64_t init_size = MIN(migration->precopy_init_size, data_size);
+
+        migration->precopy_init_size -= init_size;
+        data_size -= init_size;
+    }
+
+    migration->precopy_dirty_size -= MIN(migration->precopy_dirty_size,
+                                         data_size);
+}
+
+static bool vfio_precopy_supported(VFIODevice *vbasedev)
+{
+    VFIOMigration *migration = vbasedev->migration;
+
+    return migration->mig_flags & VFIO_MIGRATION_PRE_COPY;
+}
+
 /* ---------------------------------------------------------------------- */
 
 static int vfio_save_setup(QEMUFile *f, void *opaque)
@@ -285,6 +346,28 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
         return -ENOMEM;
     }
 
+    if (vfio_precopy_supported(vbasedev)) {
+        int ret;
+
+        switch (migration->device_state) {
+        case VFIO_DEVICE_STATE_RUNNING:
+            ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_PRE_COPY,
+                                           VFIO_DEVICE_STATE_RUNNING);
+            if (ret) {
+                return ret;
+            }
+
+            vfio_query_precopy_size(migration);
+
+            break;
+        case VFIO_DEVICE_STATE_STOP:
+            /* vfio_save_complete_precopy() will go to STOP_COPY */
+            break;
+        default:
+            return -EINVAL;
+        }
+    }
+
     trace_vfio_save_setup(vbasedev->name, migration->data_buffer_size);
 
     qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
@@ -299,26 +382,42 @@ static void vfio_save_cleanup(void *opaque)
 
     g_free(migration->data_buffer);
     migration->data_buffer = NULL;
+    migration->precopy_init_size = 0;
+    migration->precopy_dirty_size = 0;
     vfio_migration_cleanup(vbasedev);
     trace_vfio_save_cleanup(vbasedev->name);
 }
 
+static void vfio_state_pending_estimate(void *opaque, uint64_t *must_precopy,
+                                        uint64_t *can_postcopy)
+{
+    VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+
+    if (migration->device_state != VFIO_DEVICE_STATE_PRE_COPY) {
+        return;
+    }
+
+    *must_precopy +=
+        migration->precopy_init_size + migration->precopy_dirty_size;
+
+    trace_vfio_state_pending_estimate(vbasedev->name, *must_precopy,
+                                      *can_postcopy,
+                                      migration->precopy_init_size,
+                                      migration->precopy_dirty_size);
+}
+
 /*
  * Migration size of VFIO devices can be as little as a few KBs or as big as
  * many GBs. This value should be big enough to cover the worst case.
  */
 #define VFIO_MIG_STOP_COPY_SIZE (100 * GiB)
 
-/*
- * Only exact function is implemented and not estimate function. The reason is
- * that during pre-copy phase of migration the estimate function is called
- * repeatedly while pending RAM size is over the threshold, thus migration
- * can't converge and querying the VFIO device pending data size is useless.
- */
 static void vfio_state_pending_exact(void *opaque, uint64_t *must_precopy,
                                      uint64_t *can_postcopy)
 {
     VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
     uint64_t stop_copy_size = VFIO_MIG_STOP_COPY_SIZE;
 
     /*
@@ -328,8 +427,48 @@ static void vfio_state_pending_exact(void *opaque, uint64_t *must_precopy,
     vfio_query_stop_copy_size(vbasedev, &stop_copy_size);
     *must_precopy += stop_copy_size;
 
+    if (migration->device_state == VFIO_DEVICE_STATE_PRE_COPY) {
+        vfio_query_precopy_size(migration);
+
+        *must_precopy +=
+            migration->precopy_init_size + migration->precopy_dirty_size;
+    }
+
     trace_vfio_state_pending_exact(vbasedev->name, *must_precopy, *can_postcopy,
-                                   stop_copy_size);
+                                   stop_copy_size, migration->precopy_init_size,
+                                   migration->precopy_dirty_size);
+}
+
+static bool vfio_is_active_iterate(void *opaque)
+{
+    VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+
+    return migration->device_state == VFIO_DEVICE_STATE_PRE_COPY;
+}
+
+static int vfio_save_iterate(QEMUFile *f, void *opaque)
+{
+    VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+    ssize_t data_size;
+
+    data_size = vfio_save_block(f, migration);
+    if (data_size < 0) {
+        return data_size;
+    }
+    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
+
+    vfio_update_estimated_pending_data(migration, data_size);
+
+    trace_vfio_save_iterate(vbasedev->name, migration->precopy_init_size,
+                            migration->precopy_dirty_size);
+
+    /*
+     * A VFIO device's pre-copy dirty_bytes is not guaranteed to reach zero.
+     * Return 1 so following handlers will not be potentially blocked.
+     */
+    return 1;
 }
 
 static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
@@ -338,7 +477,7 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
     ssize_t data_size;
     int ret;
 
-    /* We reach here with device state STOP only */
+    /* We reach here with device state STOP or STOP_COPY only */
     ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP_COPY,
                                    VFIO_DEVICE_STATE_STOP);
     if (ret) {
@@ -457,7 +596,10 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
 static const SaveVMHandlers savevm_vfio_handlers = {
     .save_setup = vfio_save_setup,
     .save_cleanup = vfio_save_cleanup,
+    .state_pending_estimate = vfio_state_pending_estimate,
     .state_pending_exact = vfio_state_pending_exact,
+    .is_active_iterate = vfio_is_active_iterate,
+    .save_live_iterate = vfio_save_iterate,
     .save_live_complete_precopy = vfio_save_complete_precopy,
     .save_state = vfio_save_state,
     .load_setup = vfio_load_setup,
@@ -470,13 +612,18 @@ static const SaveVMHandlers savevm_vfio_handlers = {
 static void vfio_vmstate_change(void *opaque, bool running, RunState state)
 {
     VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
     enum vfio_device_mig_state new_state;
     int ret;
 
     if (running) {
         new_state = VFIO_DEVICE_STATE_RUNNING;
     } else {
-        new_state = VFIO_DEVICE_STATE_STOP;
+        new_state =
+            (migration->device_state == VFIO_DEVICE_STATE_PRE_COPY &&
+             (state == RUN_STATE_FINISH_MIGRATE || state == RUN_STATE_PAUSED)) ?
+                VFIO_DEVICE_STATE_STOP_COPY :
+                VFIO_DEVICE_STATE_STOP;
     }
 
     /*
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index cfb60c354de3..e328d644d289 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -162,6 +162,8 @@ vfio_save_block(const char *name, int data_size) " (%s) data_size %d"
 vfio_save_cleanup(const char *name) " (%s)"
 vfio_save_complete_precopy(const char *name, int ret) " (%s) ret %d"
 vfio_save_device_config_state(const char *name) " (%s)"
+vfio_save_iterate(const char *name, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy initial size 0x%"PRIx64" precopy dirty size 0x%"PRIx64
 vfio_save_setup(const char *name, uint64_t data_buffer_size) " (%s) data buffer size 0x%"PRIx64
-vfio_state_pending_exact(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t stopcopy_size) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" stopcopy size 0x%"PRIx64
+vfio_state_pending_estimate(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" precopy initial size 0x%"PRIx64" precopy dirty size 0x%"PRIx64
+vfio_state_pending_exact(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" stopcopy size 0x%"PRIx64" precopy initial size 0x%"PRIx64" precopy dirty size 0x%"PRIx64
 vfio_vmstate_change(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
-- 
2.41.0


