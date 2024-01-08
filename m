Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C20E8268A6
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 08:34:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMk8b-0003YA-AZ; Mon, 08 Jan 2024 02:33:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=P3fH=IS=redhat.com=clg@ozlabs.org>)
 id 1rMk8R-0003Qx-KP
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 02:33:23 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=P3fH=IS=redhat.com=clg@ozlabs.org>)
 id 1rMk8N-0004gd-Ru
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 02:33:23 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4T7m4s5mVGz4x3D;
 Mon,  8 Jan 2024 18:33:17 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4T7m4q59DWz4wyS;
 Mon,  8 Jan 2024 18:33:15 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 15/17] vfio/migration: Add helper function to set state or
 reset device
Date: Mon,  8 Jan 2024 08:32:30 +0100
Message-ID: <20240108073232.118228-16-clg@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108073232.118228-1-clg@redhat.com>
References: <20240108073232.118228-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=P3fH=IS=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

There are several places where failure in setting the device state leads
to a device reset, which is done by setting ERROR as the recover state.

Add a helper function that sets the device state and resets the device
in case of failure. This will make the code cleaner and remove duplicate
comments.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/vfio/migration.c | 41 +++++++++++++++++------------------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 28d422b39f9f70e94a2f396b0fb064c5de17dc28..70e6b1a709f9b67e4c9eb41033d76347275cac42 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -163,6 +163,19 @@ reset_device:
     return ret;
 }
 
+/*
+ * Some device state transitions require resetting the device if they fail.
+ * This function sets the device in new_state and resets the device if that
+ * fails. Reset is done by using ERROR as the recover state.
+ */
+static int
+vfio_migration_set_state_or_reset(VFIODevice *vbasedev,
+                                  enum vfio_device_mig_state new_state)
+{
+    return vfio_migration_set_state(vbasedev, new_state,
+                                    VFIO_DEVICE_STATE_ERROR);
+}
+
 static int vfio_load_buffer(QEMUFile *f, VFIODevice *vbasedev,
                             uint64_t data_size)
 {
@@ -422,12 +435,7 @@ static void vfio_save_cleanup(void *opaque)
      * after migration has completed, so it won't increase downtime.
      */
     if (migration->device_state == VFIO_DEVICE_STATE_STOP_COPY) {
-        /*
-         * If setting the device in STOP state fails, the device should be
-         * reset. To do so, use ERROR state as a recover state.
-         */
-        vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP,
-                                 VFIO_DEVICE_STATE_ERROR);
+        vfio_migration_set_state_or_reset(vbasedev, VFIO_DEVICE_STATE_STOP);
     }
 
     g_free(migration->data_buffer);
@@ -699,12 +707,7 @@ static void vfio_vmstate_change_prepare(void *opaque, bool running,
                     VFIO_DEVICE_STATE_PRE_COPY_P2P :
                     VFIO_DEVICE_STATE_RUNNING_P2P;
 
-    /*
-     * If setting the device in new_state fails, the device should be reset.
-     * To do so, use ERROR state as a recover state.
-     */
-    ret = vfio_migration_set_state(vbasedev, new_state,
-                                   VFIO_DEVICE_STATE_ERROR);
+    ret = vfio_migration_set_state_or_reset(vbasedev, new_state);
     if (ret) {
         /*
          * Migration should be aborted in this case, but vm_state_notify()
@@ -736,12 +739,7 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
                 VFIO_DEVICE_STATE_STOP;
     }
 
-    /*
-     * If setting the device in new_state fails, the device should be reset.
-     * To do so, use ERROR state as a recover state.
-     */
-    ret = vfio_migration_set_state(vbasedev, new_state,
-                                   VFIO_DEVICE_STATE_ERROR);
+    ret = vfio_migration_set_state_or_reset(vbasedev, new_state);
     if (ret) {
         /*
          * Migration should be aborted in this case, but vm_state_notify()
@@ -770,12 +768,7 @@ static void vfio_migration_state_notifier(Notifier *notifier, void *data)
     case MIGRATION_STATUS_CANCELLING:
     case MIGRATION_STATUS_CANCELLED:
     case MIGRATION_STATUS_FAILED:
-        /*
-         * If setting the device in RUNNING state fails, the device should
-         * be reset. To do so, use ERROR state as a recover state.
-         */
-        vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RUNNING,
-                                 VFIO_DEVICE_STATE_ERROR);
+        vfio_migration_set_state_or_reset(vbasedev, VFIO_DEVICE_STATE_RUNNING);
     }
 }
 
-- 
2.43.0


