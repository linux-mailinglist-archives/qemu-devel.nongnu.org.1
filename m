Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A039BE56A
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Nov 2024 12:19:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8e4B-0002h7-29; Wed, 06 Nov 2024 06:19:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1t8e46-0002eo-Li; Wed, 06 Nov 2024 06:19:10 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1t8e42-0008FO-PD; Wed, 06 Nov 2024 06:19:10 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:94a7:0:640:198e:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 0F5B760A8E;
 Wed,  6 Nov 2024 14:19:02 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b49f::1:6])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id dIfYi50AYGk0-aHSW0wzo; Wed, 06 Nov 2024 14:19:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1730891941;
 bh=kPJONOBuupK35ix70ujuH2B0YF+8dGxRVC385QmotRc=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=LOt2M6bdOSW4ixqALugOxgVJoCWlgbaS9wPlyrCnJVIAg8bo+borDg00puzT6YG9r
 dwZlv7AnvQLMkOYxk028vvxVvGEskQXahhbkNOGLW1fIBRq+yFQmo3uUdKzy3iWOkA
 jppfAi23c0CGQxK6AtsiuND61a8QY1GSFavrHITg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org,
	raphael@enfabrica.net,
	mst@redhat.com
Cc: sgarzare@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 eblake@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v7 3/3] qapi: introduce device-sync-config
Date: Wed,  6 Nov 2024 14:18:37 +0300
Message-Id: <20241106111837.115820-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241106111837.115820-1-vsementsov@yandex-team.ru>
References: <20241106111837.115820-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add command to sync config from vhost-user backend to the device. It
may be helpful when VHOST_USER_SLAVE_CONFIG_CHANGE_MSG failed or not
triggered interrupt to the guest or just not available (not supported
by vhost-user server).

Command result is racy if allow it during migration. Let's not allow
that.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Raphael Norwitz <raphael@enfabrica.net>
---
 hw/block/vhost-user-blk.c |  1 +
 hw/virtio/virtio-pci.c    |  9 +++++++++
 include/hw/qdev-core.h    |  6 ++++++
 qapi/qdev.json            | 24 ++++++++++++++++++++++++
 system/qdev-monitor.c     | 38 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 78 insertions(+)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 48b3dabb8d..7996e49821 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -591,6 +591,7 @@ static void vhost_user_blk_class_init(ObjectClass *klass, void *data)
 
     device_class_set_props(dc, vhost_user_blk_properties);
     dc->vmsd = &vmstate_vhost_user_blk;
+    dc->sync_config = vhost_user_blk_sync_config;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
     vdc->realize = vhost_user_blk_device_realize;
     vdc->unrealize = vhost_user_blk_device_unrealize;
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 4d832fe845..c5a809b956 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2385,6 +2385,14 @@ static void virtio_pci_dc_realize(DeviceState *qdev, Error **errp)
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
@@ -2401,6 +2409,7 @@ static void virtio_pci_class_init(ObjectClass *klass, void *data)
     device_class_set_parent_realize(dc, virtio_pci_dc_realize,
                                     &vpciklass->parent_dc_realize);
     rc->phases.hold = virtio_pci_bus_reset_hold;
+    dc->sync_config = virtio_pci_sync_config;
 }
 
 static const TypeInfo virtio_pci_info = {
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index aa97c34a4b..94914858d8 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -95,6 +95,7 @@ typedef void (*DeviceUnrealize)(DeviceState *dev);
 typedef void (*DeviceReset)(DeviceState *dev);
 typedef void (*BusRealize)(BusState *bus, Error **errp);
 typedef void (*BusUnrealize)(BusState *bus);
+typedef int (*DeviceSyncConfig)(DeviceState *dev, Error **errp);
 
 /**
  * struct DeviceClass - The base class for all devices.
@@ -103,6 +104,9 @@ typedef void (*BusUnrealize)(BusState *bus);
  * property is changed to %true.
  * @unrealize: Callback function invoked when the #DeviceState:realized
  * property is changed to %false.
+ * @sync_config: Callback function invoked when QMP command device-sync-config
+ * is called. Should synchronize device configuration from host to guest part
+ * and notify the guest about the change.
  * @hotpluggable: indicates if #DeviceClass is hotpluggable, available
  * as readonly "hotpluggable" property of #DeviceState instance
  *
@@ -162,6 +166,7 @@ struct DeviceClass {
     DeviceReset legacy_reset;
     DeviceRealize realize;
     DeviceUnrealize unrealize;
+    DeviceSyncConfig sync_config;
 
     /**
      * @vmsd: device state serialisation description for
@@ -547,6 +552,7 @@ bool qdev_hotplug_allowed(DeviceState *dev, Error **errp);
  */
 HotplugHandler *qdev_get_hotplug_handler(DeviceState *dev);
 void qdev_unplug(DeviceState *dev, Error **errp);
+int qdev_sync_config(DeviceState *dev, Error **errp);
 void qdev_simple_device_unplug_cb(HotplugHandler *hotplug_dev,
                                   DeviceState *dev, Error **errp);
 void qdev_machine_creation_done(void);
diff --git a/qapi/qdev.json b/qapi/qdev.json
index 53d147c7b4..25cbcf977b 100644
--- a/qapi/qdev.json
+++ b/qapi/qdev.json
@@ -163,3 +163,27 @@
 ##
 { 'event': 'DEVICE_UNPLUG_GUEST_ERROR',
   'data': { '*device': 'str', 'path': 'str' } }
+
+##
+# @device-sync-config:
+#
+# Synchronize device configuration from host to guest part.  First,
+# copy the configuration from the host part (backend) to the guest
+# part (frontend).  Then notify guest software that device
+# configuration changed.
+#
+# The command may be used to notify the guest about block device
+# capcity change.  Currently only vhost-user-blk device supports
+# this.
+#
+# @id: the device's ID or QOM path
+#
+# Features:
+#
+# @unstable: The command is experimental.
+#
+# Since: 9.2
+##
+{ 'command': 'device-sync-config',
+  'features': [ 'unstable' ],
+  'data': {'id': 'str'} }
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 2c76cef4d8..d25325c4e3 100644
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
@@ -977,6 +978,43 @@ void qmp_device_del(const char *id, Error **errp)
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
+     * During migration there is a race between syncing`configuration
+     * and migrating it (if migrate first, that target would get
+     * outdated version), so let's just not allow it.
+     */
+
+    if (migration_is_running()) {
+        error_setg(errp, "Config synchronization is not allowed "
+                   "during migration");
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
-- 
2.34.1


