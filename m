Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31193892376
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Mar 2024 19:39:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqH7g-0002oj-1Q; Fri, 29 Mar 2024 14:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rqH7d-0002nM-Eq; Fri, 29 Mar 2024 14:38:37 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rqH7Z-0007XL-Aj; Fri, 29 Mar 2024 14:38:37 -0400
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:5428:0:640:7351:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 9742E608F2;
 Fri, 29 Mar 2024 21:38:30 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:6509::1:4])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 2cTaY94Id8c0-2BqLNsDV; Fri, 29 Mar 2024 21:38:29 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1711737509;
 bh=YrCNM/esx2ItwVi57BFApSXbvJb7UknYXWMFwczrP7Q=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=p0epRlRHnCIAi0nuXYEdOuirOaw49nYHLoT+RPIndEjpPZBr88JPQliRYmpEw2Qyl
 HevxrZMnPYjXtoywguWX8WVdze3ePfsCvhgj+HesPOorfHOboDURU1IAmpbF5w+UrY
 YafUmI7di/fKWg8BHn3zlVc2rs8qP1BQH20uRf/w=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org,
	raphael@enfabrica.net,
	mst@redhat.com
Cc: kwolf@redhat.com, hreitz@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, armbru@redhat.com,
 dave@treblig.org, eblake@redhat.com, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru
Subject: [PATCH v3 4/5] qapi: introduce device-sync-config
Date: Fri, 29 Mar 2024 21:37:57 +0300
Message-Id: <20240329183758.3360733-5-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329183758.3360733-1-vsementsov@yandex-team.ru>
References: <20240329183758.3360733-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Add command to sync config from vhost-user backend to the device. It
may be helpful when VHOST_USER_SLAVE_CONFIG_CHANGE_MSG failed or not
triggered interrupt to the guest or just not available (not supported
by vhost-user server).

Command result is racy if allow it during migration. Let's allow the
sync only in RUNNING state.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/block/vhost-user-blk.c | 27 ++++++++++++++++------
 hw/virtio/virtio-pci.c    |  9 ++++++++
 include/hw/qdev-core.h    |  3 +++
 include/sysemu/runstate.h |  1 +
 qapi/qdev.json            | 21 +++++++++++++++++
 system/qdev-monitor.c     | 47 +++++++++++++++++++++++++++++++++++++++
 system/runstate.c         |  5 +++++
 7 files changed, 106 insertions(+), 7 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 9e6bbc6950..2f301f380c 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -88,27 +88,39 @@ static void vhost_user_blk_set_config(VirtIODevice *vdev, const uint8_t *config)
     s->blkcfg.wce = blkcfg->wce;
 }
 
+static int vhost_user_blk_sync_config(DeviceState *dev, Error **errp)
+{
+    int ret;
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserBlk *s = VHOST_USER_BLK(vdev);
+
+    ret = vhost_dev_get_config(&s->dev, (uint8_t *)&s->blkcfg,
+                               vdev->config_len, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    memcpy(vdev->config, &s->blkcfg, vdev->config_len);
+    virtio_notify_config(vdev);
+
+    return 0;
+}
+
 static int vhost_user_blk_handle_config_change(struct vhost_dev *dev)
 {
     int ret;
-    VirtIODevice *vdev = dev->vdev;
-    VHostUserBlk *s = VHOST_USER_BLK(dev->vdev);
     Error *local_err = NULL;
 
     if (!dev->started) {
         return 0;
     }
 
-    ret = vhost_dev_get_config(dev, (uint8_t *)&s->blkcfg,
-                               vdev->config_len, &local_err);
+    ret = vhost_user_blk_sync_config(DEVICE(dev->vdev), &local_err);
     if (ret < 0) {
         error_report_err(local_err);
         return ret;
     }
 
-    memcpy(dev->vdev->config, &s->blkcfg, vdev->config_len);
-    virtio_notify_config(dev->vdev);
-
     return 0;
 }
 
@@ -576,6 +588,7 @@ static void vhost_user_blk_class_init(ObjectClass *klass, void *data)
 
     device_class_set_props(dc, vhost_user_blk_properties);
     dc->vmsd = &vmstate_vhost_user_blk;
+    dc->sync_config = vhost_user_blk_sync_config;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
     vdc->realize = vhost_user_blk_device_realize;
     vdc->unrealize = vhost_user_blk_device_unrealize;
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index eaaf86402c..92afbae71c 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2501,6 +2501,14 @@ static void virtio_pci_dc_realize(DeviceState *qdev, Error **errp)
     vpciklass->parent_dc_realize(qdev, errp);
 }
 
+static int virtio_pci_sync_config(DeviceState *dev, Error **errp)
+{
+    VirtIOPCIProxy *proxy = VIRTIO_PCI(dev);
+    VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
+
+    return qdev_sync_config(DEVICE(vdev), errp);
+}
+
 static void virtio_pci_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -2517,6 +2525,7 @@ static void virtio_pci_class_init(ObjectClass *klass, void *data)
     device_class_set_parent_realize(dc, virtio_pci_dc_realize,
                                     &vpciklass->parent_dc_realize);
     rc->phases.hold = virtio_pci_bus_reset_hold;
+    dc->sync_config = virtio_pci_sync_config;
 }
 
 static const TypeInfo virtio_pci_info = {
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 9228e96c87..87135bdcdf 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -95,6 +95,7 @@ typedef void (*DeviceUnrealize)(DeviceState *dev);
 typedef void (*DeviceReset)(DeviceState *dev);
 typedef void (*BusRealize)(BusState *bus, Error **errp);
 typedef void (*BusUnrealize)(BusState *bus);
+typedef int (*DeviceSyncConfig)(DeviceState *dev, Error **errp);
 
 /**
  * struct DeviceClass - The base class for all devices.
@@ -162,6 +163,7 @@ struct DeviceClass {
     DeviceReset reset;
     DeviceRealize realize;
     DeviceUnrealize unrealize;
+    DeviceSyncConfig sync_config;
 
     /**
      * @vmsd: device state serialisation description for
@@ -546,6 +548,7 @@ bool qdev_hotplug_allowed(DeviceState *dev, Error **errp);
  */
 HotplugHandler *qdev_get_hotplug_handler(DeviceState *dev);
 void qdev_unplug(DeviceState *dev, Error **errp);
+int qdev_sync_config(DeviceState *dev, Error **errp);
 void qdev_simple_device_unplug_cb(HotplugHandler *hotplug_dev,
                                   DeviceState *dev, Error **errp);
 void qdev_machine_creation_done(void);
diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
index 0117d243c4..296af52322 100644
--- a/include/sysemu/runstate.h
+++ b/include/sysemu/runstate.h
@@ -5,6 +5,7 @@
 #include "qemu/notify.h"
 
 bool runstate_check(RunState state);
+const char *current_run_state_str(void);
 void runstate_set(RunState new_state);
 RunState runstate_get(void);
 bool runstate_is_running(void);
diff --git a/qapi/qdev.json b/qapi/qdev.json
index facaa0bc6a..e8be79c3d5 100644
--- a/qapi/qdev.json
+++ b/qapi/qdev.json
@@ -161,3 +161,24 @@
 ##
 { 'event': 'DEVICE_UNPLUG_GUEST_ERROR',
   'data': { '*device': 'str', 'path': 'str' } }
+
+##
+# @device-sync-config:
+#
+# Synchronize config from backend to the guest. The command notifies
+# re-read the device config from the backend and notifies the guest
+# to re-read the config. The command may be used to notify the guest
+# about block device capcity change. Currently only vhost-user-blk
+# device supports this.
+#
+# @id: the device's ID or QOM path
+#
+# Features:
+#
+# @unstable: The command is experimental.
+#
+# Since: 9.1
+##
+{ 'command': 'device-sync-config',
+  'features': [ 'unstable' ],
+  'data': {'id': 'str'} }
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 7e075d91c1..cb35ea0b86 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -23,6 +23,7 @@
 #include "monitor/monitor.h"
 #include "monitor/qdev.h"
 #include "sysemu/arch_init.h"
+#include "sysemu/runstate.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-qdev.h"
 #include "qapi/qmp/dispatch.h"
@@ -969,6 +970,52 @@ void qmp_device_del(const char *id, Error **errp)
     }
 }
 
+int qdev_sync_config(DeviceState *dev, Error **errp)
+{
+    DeviceClass *dc = DEVICE_GET_CLASS(dev);
+
+    if (!dc->sync_config) {
+        error_setg(errp, "device-sync-config is not supported for '%s'",
+                   object_get_typename(OBJECT(dev)));
+        return -ENOTSUP;
+    }
+
+    return dc->sync_config(dev, errp);
+}
+
+void qmp_device_sync_config(const char *id, Error **errp)
+{
+    DeviceState *dev;
+
+    /*
+     * During migration there is a race between syncing`config and
+     * migrating it, so let's just not allow it.
+     *
+     * Moreover, let's not rely on setting up interrupts in paused
+     * state, which may be a part of migration process.
+     */
+
+    if (migration_is_running()) {
+        error_setg(errp, "Config synchronization is not allowed "
+                   "during migration.");
+        return;
+    }
+
+    if (!runstate_is_running()) {
+        error_setg(errp, "Config synchronization allowed only in '%s' state, "
+                   "current state is '%s'", RunState_str(RUN_STATE_RUNNING),
+                   current_run_state_str());
+        return;
+    }
+
+    dev = find_device_state(id, true, errp);
+    if (!dev) {
+        return;
+    }
+
+    qdev_sync_config(dev, errp);
+}
+
 void hmp_device_add(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
diff --git a/system/runstate.c b/system/runstate.c
index d6ab860eca..8fd89172ae 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -189,6 +189,11 @@ bool runstate_check(RunState state)
     return current_run_state == state;
 }
 
+const char *current_run_state_str(void)
+{
+    return RunState_str(current_run_state);
+}
+
 static void runstate_init(void)
 {
     const RunStateTransition *p;
-- 
2.34.1


