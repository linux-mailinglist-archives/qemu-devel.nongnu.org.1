Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3268379A50A
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 09:52:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfbgt-00042Q-6B; Mon, 11 Sep 2023 03:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=GLJ6=E3=redhat.com=clg@ozlabs.org>)
 id 1qfbgr-0003vy-4C
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 03:50:37 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=GLJ6=E3=redhat.com=clg@ozlabs.org>)
 id 1qfbgl-0008Cl-4k
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 03:50:35 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Rkf5X6wYqz4xGM;
 Mon, 11 Sep 2023 17:50:24 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rkf5W1STjz4x5q;
 Mon, 11 Sep 2023 17:50:22 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, YangHang Liu <yanghliu@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 05/13] vfio/migration: Add P2P support for VFIO migration
Date: Mon, 11 Sep 2023 09:50:00 +0200
Message-ID: <20230911075008.462712-6-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911075008.462712-1-clg@redhat.com>
References: <20230911075008.462712-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=GLJ6=E3=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

VFIO migration uAPI defines an optional intermediate P2P quiescent
state. While in the P2P quiescent state, P2P DMA transactions cannot be
initiated by the device, but the device can respond to incoming ones.
Additionally, all outstanding P2P transactions are guaranteed to have
been completed by the time the device enters this state.

The purpose of this state is to support migration of multiple devices
that might do P2P transactions between themselves.

Add support for P2P migration by transitioning all the devices to the
P2P quiescent state before stopping or starting the devices. Use the new
VMChangeStateHandler prepare_cb to achieve that behavior.

This will allow migration of multiple VFIO devices if all of them
support P2P migration.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Tested-by: YangHang Liu <yanghliu@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/devel/vfio-migration.rst | 93 +++++++++++++++++++++--------------
 hw/vfio/common.c              |  6 ++-
 hw/vfio/migration.c           | 46 +++++++++++++++--
 hw/vfio/trace-events          |  1 +
 4 files changed, 105 insertions(+), 41 deletions(-)

diff --git a/docs/devel/vfio-migration.rst b/docs/devel/vfio-migration.rst
index b433cb5bb2c8caa703c6063efeb382bebfe7aed6..605fe60e9695a50813b1294bb970ce2c39d2ba07 100644
--- a/docs/devel/vfio-migration.rst
+++ b/docs/devel/vfio-migration.rst
@@ -23,9 +23,21 @@ and recommends that the initial bytes are sent and loaded in the destination
 before stopping the source VM. Enabling this migration capability will
 guarantee that and thus, can potentially reduce downtime even further.
 
-Note that currently VFIO migration is supported only for a single device. This
-is due to VFIO migration's lack of P2P support. However, P2P support is planned
-to be added later on.
+To support migration of multiple devices that might do P2P transactions between
+themselves, VFIO migration uAPI defines an intermediate P2P quiescent state.
+While in the P2P quiescent state, P2P DMA transactions cannot be initiated by
+the device, but the device can respond to incoming ones. Additionally, all
+outstanding P2P transactions are guaranteed to have been completed by the time
+the device enters this state.
+
+All the devices that support P2P migration are first transitioned to the P2P
+quiescent state and only then are they stopped or started. This makes migration
+safe P2P-wise, since starting and stopping the devices is not done atomically
+for all the devices together.
+
+Thus, multiple VFIO devices migration is allowed only if all the devices
+support P2P migration. Single VFIO device migration is allowed regardless of
+P2P migration support.
 
 A detailed description of the UAPI for VFIO device migration can be found in
 the comment for the ``vfio_device_mig_state`` structure in the header file
@@ -132,54 +144,63 @@ will be blocked.
 Flow of state changes during Live migration
 ===========================================
 
-Below is the flow of state change during live migration.
+Below is the state change flow during live migration for a VFIO device that
+supports both precopy and P2P migration. The flow for devices that don't
+support it is similar, except that the relevant states for precopy and P2P are
+skipped.
 The values in the parentheses represent the VM state, the migration state, and
 the VFIO device state, respectively.
-The text in the square brackets represents the flow if the VFIO device supports
-pre-copy.
 
 Live migration save path
 ------------------------
 
 ::
 
-                        QEMU normal running state
-                        (RUNNING, _NONE, _RUNNING)
-                                  |
+                           QEMU normal running state
+                           (RUNNING, _NONE, _RUNNING)
+                                      |
                      migrate_init spawns migration_thread
-                Migration thread then calls each device's .save_setup()
-                  (RUNNING, _SETUP, _RUNNING [_PRE_COPY])
-                                  |
-                  (RUNNING, _ACTIVE, _RUNNING [_PRE_COPY])
-      If device is active, get pending_bytes by .state_pending_{estimate,exact}()
-          If total pending_bytes >= threshold_size, call .save_live_iterate()
-                  [Data of VFIO device for pre-copy phase is copied]
-        Iterate till total pending bytes converge and are less than threshold
-                                  |
-  On migration completion, vCPU stops and calls .save_live_complete_precopy for
-  each active device. The VFIO device is then transitioned into _STOP_COPY state
-                  (FINISH_MIGRATE, _DEVICE, _STOP_COPY)
-                                  |
-     For the VFIO device, iterate in .save_live_complete_precopy until
-                         pending data is 0
-                   (FINISH_MIGRATE, _DEVICE, _STOP)
-                                  |
-                 (FINISH_MIGRATE, _COMPLETED, _STOP)
-             Migraton thread schedules cleanup bottom half and exits
+            Migration thread then calls each device's .save_setup()
+                          (RUNNING, _SETUP, _PRE_COPY)
+                                      |
+                         (RUNNING, _ACTIVE, _PRE_COPY)
+  If device is active, get pending_bytes by .state_pending_{estimate,exact}()
+       If total pending_bytes >= threshold_size, call .save_live_iterate()
+                Data of VFIO device for pre-copy phase is copied
+      Iterate till total pending bytes converge and are less than threshold
+                                      |
+       On migration completion, the vCPUs and the VFIO device are stopped
+              The VFIO device is first put in P2P quiescent state
+                    (FINISH_MIGRATE, _ACTIVE, _PRE_COPY_P2P)
+                                      |
+                Then the VFIO device is put in _STOP_COPY state
+                     (FINISH_MIGRATE, _ACTIVE, _STOP_COPY)
+         .save_live_complete_precopy() is called for each active device
+      For the VFIO device, iterate in .save_live_complete_precopy() until
+                               pending data is 0
+                                      |
+                     (POSTMIGRATE, _COMPLETED, _STOP_COPY)
+            Migraton thread schedules cleanup bottom half and exits
+                                      |
+                           .save_cleanup() is called
+                        (POSTMIGRATE, _COMPLETED, _STOP)
 
 Live migration resume path
 --------------------------
 
 ::
 
-              Incoming migration calls .load_setup for each device
-                       (RESTORE_VM, _ACTIVE, _STOP)
-                                 |
-       For each device, .load_state is called for that device section data
-                       (RESTORE_VM, _ACTIVE, _RESUMING)
-                                 |
-    At the end, .load_cleanup is called for each device and vCPUs are started
-                       (RUNNING, _NONE, _RUNNING)
+             Incoming migration calls .load_setup() for each device
+                          (RESTORE_VM, _ACTIVE, _STOP)
+                                      |
+     For each device, .load_state() is called for that device section data
+                        (RESTORE_VM, _ACTIVE, _RESUMING)
+                                      |
+  At the end, .load_cleanup() is called for each device and vCPUs are started
+              The VFIO device is first put in P2P quiescent state
+                        (RUNNING, _ACTIVE, _RUNNING_P2P)
+                                      |
+                           (RUNNING, _NONE, _RUNNING)
 
 Postcopy
 ========
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 16cf79a76c845d8eb19498e8c6bf1f3b2b8d2fd8..7c3d636025695641299f306c2afe12fa3e990736 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -441,14 +441,16 @@ bool vfio_device_state_is_running(VFIODevice *vbasedev)
 {
     VFIOMigration *migration = vbasedev->migration;
 
-    return migration->device_state == VFIO_DEVICE_STATE_RUNNING;
+    return migration->device_state == VFIO_DEVICE_STATE_RUNNING ||
+           migration->device_state == VFIO_DEVICE_STATE_RUNNING_P2P;
 }
 
 bool vfio_device_state_is_precopy(VFIODevice *vbasedev)
 {
     VFIOMigration *migration = vbasedev->migration;
 
-    return migration->device_state == VFIO_DEVICE_STATE_PRE_COPY;
+    return migration->device_state == VFIO_DEVICE_STATE_PRE_COPY ||
+           migration->device_state == VFIO_DEVICE_STATE_PRE_COPY_P2P;
 }
 
 static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 48f9c23cbe3ac720ef252d699636e4a572bec762..71855468fe985291e2d009b81c6efd29abcbe755 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -71,8 +71,12 @@ static const char *mig_state_to_str(enum vfio_device_mig_state state)
         return "STOP_COPY";
     case VFIO_DEVICE_STATE_RESUMING:
         return "RESUMING";
+    case VFIO_DEVICE_STATE_RUNNING_P2P:
+        return "RUNNING_P2P";
     case VFIO_DEVICE_STATE_PRE_COPY:
         return "PRE_COPY";
+    case VFIO_DEVICE_STATE_PRE_COPY_P2P:
+        return "PRE_COPY_P2P";
     default:
         return "UNKNOWN STATE";
     }
@@ -652,6 +656,39 @@ static const SaveVMHandlers savevm_vfio_handlers = {
 
 /* ---------------------------------------------------------------------- */
 
+static void vfio_vmstate_change_prepare(void *opaque, bool running,
+                                        RunState state)
+{
+    VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+    enum vfio_device_mig_state new_state;
+    int ret;
+
+    new_state = migration->device_state == VFIO_DEVICE_STATE_PRE_COPY ?
+                    VFIO_DEVICE_STATE_PRE_COPY_P2P :
+                    VFIO_DEVICE_STATE_RUNNING_P2P;
+
+    /*
+     * If setting the device in new_state fails, the device should be reset.
+     * To do so, use ERROR state as a recover state.
+     */
+    ret = vfio_migration_set_state(vbasedev, new_state,
+                                   VFIO_DEVICE_STATE_ERROR);
+    if (ret) {
+        /*
+         * Migration should be aborted in this case, but vm_state_notify()
+         * currently does not support reporting failures.
+         */
+        if (migrate_get_current()->to_dst_file) {
+            qemu_file_set_error(migrate_get_current()->to_dst_file, ret);
+        }
+    }
+
+    trace_vfio_vmstate_change_prepare(vbasedev->name, running,
+                                      RunState_str(state),
+                                      mig_state_to_str(new_state));
+}
+
 static void vfio_vmstate_change(void *opaque, bool running, RunState state)
 {
     VFIODevice *vbasedev = opaque;
@@ -758,6 +795,7 @@ static int vfio_migration_init(VFIODevice *vbasedev)
     char id[256] = "";
     g_autofree char *path = NULL, *oid = NULL;
     uint64_t mig_flags = 0;
+    VMChangeStateHandler *prepare_cb;
 
     if (!vbasedev->ops->vfio_get_object) {
         return -EINVAL;
@@ -798,9 +836,11 @@ static int vfio_migration_init(VFIODevice *vbasedev)
     register_savevm_live(id, VMSTATE_INSTANCE_ID_ANY, 1, &savevm_vfio_handlers,
                          vbasedev);
 
-    migration->vm_state = qdev_add_vm_change_state_handler(vbasedev->dev,
-                                                           vfio_vmstate_change,
-                                                           vbasedev);
+    prepare_cb = migration->mig_flags & VFIO_MIGRATION_P2P ?
+                     vfio_vmstate_change_prepare :
+                     NULL;
+    migration->vm_state = qdev_add_vm_change_state_handler_full(
+        vbasedev->dev, vfio_vmstate_change, prepare_cb, vbasedev);
     migration->migration_state.notify = vfio_migration_state_notifier;
     add_migration_state_change_notifier(&migration->migration_state);
 
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index ee7509e68e4fc1953934bafa6a5c1e1981e4c6ca..329736a738d32ab006c3621cecfb704c84a513b7 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -167,3 +167,4 @@ vfio_save_setup(const char *name, uint64_t data_buffer_size) " (%s) data buffer
 vfio_state_pending_estimate(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" precopy initial size 0x%"PRIx64" precopy dirty size 0x%"PRIx64
 vfio_state_pending_exact(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" stopcopy size 0x%"PRIx64" precopy initial size 0x%"PRIx64" precopy dirty size 0x%"PRIx64
 vfio_vmstate_change(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
+vfio_vmstate_change_prepare(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
-- 
2.41.0


