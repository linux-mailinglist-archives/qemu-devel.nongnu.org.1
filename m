Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B93870194
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Mar 2024 13:34:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh7WQ-0005OF-LY; Mon, 04 Mar 2024 07:34:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=mkh8=KK=redhat.com=clg@ozlabs.org>)
 id 1rh7Sy-00012i-0e
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 07:30:48 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=mkh8=KK=redhat.com=clg@ozlabs.org>)
 id 1rh7SY-0004wD-BJ
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 07:30:46 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TpJ1Y31dyz4wcC;
 Mon,  4 Mar 2024 23:30:09 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TpJ1V3tsmz4x0q;
 Mon,  4 Mar 2024 23:30:06 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 20/26] vfio: Use new Error** argument in vfio_save_setup()
Date: Mon,  4 Mar 2024 13:28:38 +0100
Message-ID: <20240304122844.1888308-21-clg@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304122844.1888308-1-clg@redhat.com>
References: <20240304122844.1888308-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=mkh8=KK=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
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

Add an Error** argument to vfio_migration_set_state() and adjust
callers, including vfio_save_setup(). The error will be propagated up
to qemu_savevm_state_setup() where the save_setup() handler is
executed.

Modify vfio_vmstate_change_prepare() and vfio_vmstate_change() to
store a reported error under the migration stream if a migration is in
progress.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---

 Changes in v3:

 - Use error_setg_errno() in vfio_save_setup() 
 - Made sure an error is always set in case of failure in
   vfio_load_setup()
   
 hw/vfio/migration.c | 67 ++++++++++++++++++++++++++-------------------
 1 file changed, 39 insertions(+), 28 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 20eb7dad1a909d49a810294d87a07262ec5f1e9d..a67c3e457aa8255e7e39db5127627524d75a55dd 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -84,7 +84,8 @@ static const char *mig_state_to_str(enum vfio_device_mig_state state)
 
 static int vfio_migration_set_state(VFIODevice *vbasedev,
                                     enum vfio_device_mig_state new_state,
-                                    enum vfio_device_mig_state recover_state)
+                                    enum vfio_device_mig_state recover_state,
+                                    Error **errp)
 {
     VFIOMigration *migration = vbasedev->migration;
     uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature) +
@@ -104,15 +105,15 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
         ret = -errno;
 
         if (recover_state == VFIO_DEVICE_STATE_ERROR) {
-            error_report("%s: Failed setting device state to %s, err: %s. "
-                         "Recover state is ERROR. Resetting device",
-                         vbasedev->name, mig_state_to_str(new_state),
-                         strerror(errno));
+            error_setg(errp, "%s: Failed setting device state to %s, err: %s. "
+                       "Recover state is ERROR. Resetting device",
+                       vbasedev->name, mig_state_to_str(new_state),
+                       strerror(errno));
 
             goto reset_device;
         }
 
-        error_report(
+        error_setg(errp,
             "%s: Failed setting device state to %s, err: %s. Setting device in recover state %s",
                      vbasedev->name, mig_state_to_str(new_state),
                      strerror(errno), mig_state_to_str(recover_state));
@@ -120,7 +121,7 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
         mig_state->device_state = recover_state;
         if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
             ret = -errno;
-            error_report(
+            error_setg(errp,
                 "%s: Failed setting device in recover state, err: %s. Resetting device",
                          vbasedev->name, strerror(errno));
 
@@ -139,7 +140,7 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
              * This can happen if the device is asynchronously reset and
              * terminates a data transfer.
              */
-            error_report("%s: data_fd out of sync", vbasedev->name);
+            error_setg(errp, "%s: data_fd out of sync", vbasedev->name);
             close(mig_state->data_fd);
 
             return -EBADF;
@@ -170,10 +171,11 @@ reset_device:
  */
 static int
 vfio_migration_set_state_or_reset(VFIODevice *vbasedev,
-                                  enum vfio_device_mig_state new_state)
+                                  enum vfio_device_mig_state new_state,
+                                  Error **errp)
 {
     return vfio_migration_set_state(vbasedev, new_state,
-                                    VFIO_DEVICE_STATE_ERROR);
+                                    VFIO_DEVICE_STATE_ERROR, errp);
 }
 
 static int vfio_load_buffer(QEMUFile *f, VFIODevice *vbasedev,
@@ -401,10 +403,8 @@ static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
         switch (migration->device_state) {
         case VFIO_DEVICE_STATE_RUNNING:
             ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_PRE_COPY,
-                                           VFIO_DEVICE_STATE_RUNNING);
+                                           VFIO_DEVICE_STATE_RUNNING, errp);
             if (ret) {
-                error_setg(errp, "%s: Failed to set new RUNNING state",
-                           vbasedev->name);
                 return ret;
             }
 
@@ -437,13 +437,20 @@ static void vfio_save_cleanup(void *opaque)
 {
     VFIODevice *vbasedev = opaque;
     VFIOMigration *migration = vbasedev->migration;
+    Error *local_err = NULL;
+    int ret;
 
     /*
      * Changing device state from STOP_COPY to STOP can take time. Do it here,
      * after migration has completed, so it won't increase downtime.
      */
     if (migration->device_state == VFIO_DEVICE_STATE_STOP_COPY) {
-        vfio_migration_set_state_or_reset(vbasedev, VFIO_DEVICE_STATE_STOP);
+        ret = vfio_migration_set_state_or_reset(vbasedev,
+                                                VFIO_DEVICE_STATE_STOP,
+                                                &local_err);
+        if (ret) {
+            error_report_err(local_err);
+        }
     }
 
     g_free(migration->data_buffer);
@@ -549,11 +556,13 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
     VFIODevice *vbasedev = opaque;
     ssize_t data_size;
     int ret;
+    Error *local_err = NULL;
 
     /* We reach here with device state STOP or STOP_COPY only */
     ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP_COPY,
-                                   VFIO_DEVICE_STATE_STOP);
+                                   VFIO_DEVICE_STATE_STOP, &local_err);
     if (ret) {
+        error_report_err(local_err);
         return ret;
     }
 
@@ -591,14 +600,9 @@ static void vfio_save_state(QEMUFile *f, void *opaque)
 static int vfio_load_setup(QEMUFile *f, void *opaque, Error **errp)
 {
     VFIODevice *vbasedev = opaque;
-    int ret;
 
-    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
-                                   vbasedev->migration->device_state);
-    if (ret) {
-        error_setg(errp, "%s: Failed to set RESUMING state", vbasedev->name);
-    }
-    return ret;
+    return vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
+                                    vbasedev->migration->device_state, errp);
 }
 
 static int vfio_load_cleanup(void *opaque)
@@ -714,20 +718,22 @@ static void vfio_vmstate_change_prepare(void *opaque, bool running,
     VFIODevice *vbasedev = opaque;
     VFIOMigration *migration = vbasedev->migration;
     enum vfio_device_mig_state new_state;
+    Error *local_err = NULL;
     int ret;
 
     new_state = migration->device_state == VFIO_DEVICE_STATE_PRE_COPY ?
                     VFIO_DEVICE_STATE_PRE_COPY_P2P :
                     VFIO_DEVICE_STATE_RUNNING_P2P;
 
-    ret = vfio_migration_set_state_or_reset(vbasedev, new_state);
+    ret = vfio_migration_set_state_or_reset(vbasedev, new_state, &local_err);
     if (ret) {
         /*
          * Migration should be aborted in this case, but vm_state_notify()
          * currently does not support reporting failures.
          */
         if (migrate_get_current()->to_dst_file) {
-            qemu_file_set_error(migrate_get_current()->to_dst_file, ret);
+            qemu_file_set_error_obj(migrate_get_current()->to_dst_file, ret,
+                                    local_err);
         }
     }
 
@@ -740,6 +746,7 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
 {
     VFIODevice *vbasedev = opaque;
     enum vfio_device_mig_state new_state;
+    Error *local_err = NULL;
     int ret;
 
     if (running) {
@@ -752,14 +759,15 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
                 VFIO_DEVICE_STATE_STOP;
     }
 
-    ret = vfio_migration_set_state_or_reset(vbasedev, new_state);
+    ret = vfio_migration_set_state_or_reset(vbasedev, new_state, &local_err);
     if (ret) {
         /*
          * Migration should be aborted in this case, but vm_state_notify()
          * currently does not support reporting failures.
          */
         if (migrate_get_current()->to_dst_file) {
-            qemu_file_set_error(migrate_get_current()->to_dst_file, ret);
+            qemu_file_set_error_obj(migrate_get_current()->to_dst_file, ret,
+                                    local_err);
         }
     }
 
@@ -773,13 +781,16 @@ static int vfio_migration_state_notifier(NotifierWithReturn *notifier,
     VFIOMigration *migration = container_of(notifier, VFIOMigration,
                                             migration_state);
     VFIODevice *vbasedev = migration->vbasedev;
+    int ret = 0;
 
     trace_vfio_migration_state_notifier(vbasedev->name, e->type);
 
     if (e->type == MIG_EVENT_PRECOPY_FAILED) {
-        vfio_migration_set_state_or_reset(vbasedev, VFIO_DEVICE_STATE_RUNNING);
+        ret = vfio_migration_set_state_or_reset(vbasedev,
+                                                VFIO_DEVICE_STATE_RUNNING,
+                                                errp);
     }
-    return 0;
+    return ret;
 }
 
 static void vfio_migration_free(VFIODevice *vbasedev)
-- 
2.44.0


