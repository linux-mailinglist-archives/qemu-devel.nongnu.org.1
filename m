Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB3989237B
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Mar 2024 19:39:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqH7f-0002oW-Tk; Fri, 29 Mar 2024 14:38:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rqH7c-0002mB-43; Fri, 29 Mar 2024 14:38:36 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rqH7Z-0007XQ-44; Fri, 29 Mar 2024 14:38:35 -0400
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:5428:0:640:7351:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 858D760A0A;
 Fri, 29 Mar 2024 21:38:31 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:6509::1:4])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 2cTaY94Id8c0-N12gIxfX; Fri, 29 Mar 2024 21:38:30 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1711737510;
 bh=rodd4cQDXNKTVi2PJTr9ctB4hME9Du9Rm9xT/9Dmhc8=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=H9zqhEeeukl+8mM0lSHxakJzRp67Hd2Ln9KE9ivlqqY1ftA9UCMTnc6WrvSrNR08o
 EQpOSq0dZOJthH8jbzTL86Wf3co5ttp8g1WdFmEaSFsmy0EP40tA8LiZEiWTWJVGnC
 Ely50HS2jC9C751XU1fdxY9ssJ9BgADKEb8hJdSo=
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
Subject: [PATCH v3 5/5] qapi: introduce CONFIG_READ event
Date: Fri, 29 Mar 2024 21:37:58 +0300
Message-Id: <20240329183758.3360733-6-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329183758.3360733-1-vsementsov@yandex-team.ru>
References: <20240329183758.3360733-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Send a new event when guest reads virtio-pci config after
virtio_notify_config() call.

That's useful to check that guest fetched modified config, for example
after resizing disk backend.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/virtio-pci.c |  9 +++++++++
 include/monitor/qdev.h |  2 ++
 monitor/monitor.c      |  1 +
 qapi/qdev.json         | 33 +++++++++++++++++++++++++++++++++
 stubs/qdev.c           |  6 ++++++
 system/qdev-monitor.c  |  6 ++++++
 6 files changed, 57 insertions(+)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 92afbae71c..c0c158dae2 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -23,6 +23,7 @@
 #include "hw/boards.h"
 #include "hw/virtio/virtio.h"
 #include "migration/qemu-file-types.h"
+#include "monitor/qdev.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/qdev-properties.h"
@@ -530,6 +531,10 @@ static uint64_t virtio_pci_config_read(void *opaque, hwaddr addr,
     }
     addr -= config;
 
+    if (vdev->generation > 0) {
+        qdev_virtio_config_read_event(DEVICE(proxy));
+    }
+
     switch (size) {
     case 1:
         val = virtio_config_readb(vdev, addr);
@@ -1884,6 +1889,10 @@ static uint64_t virtio_pci_device_read(void *opaque, hwaddr addr,
         return UINT64_MAX;
     }
 
+    if (vdev->generation > 0) {
+        qdev_virtio_config_read_event(DEVICE(proxy));
+    }
+
     switch (size) {
     case 1:
         val = virtio_config_modern_readb(vdev, addr);
diff --git a/include/monitor/qdev.h b/include/monitor/qdev.h
index 1d57bf6577..fc9a834dca 100644
--- a/include/monitor/qdev.h
+++ b/include/monitor/qdev.h
@@ -36,4 +36,6 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
  */
 const char *qdev_set_id(DeviceState *dev, char *id, Error **errp);
 
+void qdev_virtio_config_read_event(DeviceState *dev);
+
 #endif
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 01ede1babd..5b06146503 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -316,6 +316,7 @@ static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
     [QAPI_EVENT_VSERPORT_CHANGE]   = { 1000 * SCALE_MS },
     [QAPI_EVENT_MEMORY_DEVICE_SIZE_CHANGE] = { 1000 * SCALE_MS },
     [QAPI_EVENT_HV_BALLOON_STATUS_REPORT] = { 1000 * SCALE_MS },
+    [QAPI_EVENT_VIRTIO_CONFIG_READ] = { 300 * SCALE_MS },
 };
 
 /*
diff --git a/qapi/qdev.json b/qapi/qdev.json
index e8be79c3d5..29a4f47360 100644
--- a/qapi/qdev.json
+++ b/qapi/qdev.json
@@ -182,3 +182,36 @@
 { 'command': 'device-sync-config',
   'features': [ 'unstable' ],
   'data': {'id': 'str'} }
+
+##
+# @VIRTIO_CONFIG_READ:
+#
+# Emitted whenever guest reads virtio device configuration after
+# configuration change.
+#
+# The event may be used in pair with device-sync-config. It shows
+# that guest has re-read updated configuration. It doesn't
+# guarantee that guest successfully handled it and updated the
+# view of the device for the user, but still it's a kind of
+# success indicator.
+#
+# @device: device name
+#
+# @path: device path
+#
+# Features:
+#
+# @unstable: The event is experimental.
+#
+# Since: 9.1
+#
+# Example:
+#
+#     <- { "event": "VIRTIO_CONFIG_READ",
+#          "data": { "device": "virtio-net-pci-0",
+#                    "path": "/machine/peripheral/virtio-net-pci-0" },
+#          "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+##
+{ 'event': 'VIRTIO_CONFIG_READ',
+  'features': [ 'unstable' ],
+  'data': { '*device': 'str', 'path': 'str' } }
diff --git a/stubs/qdev.c b/stubs/qdev.c
index 6869f6f90a..ab6c4afe0b 100644
--- a/stubs/qdev.c
+++ b/stubs/qdev.c
@@ -26,3 +26,9 @@ void qapi_event_send_device_unplug_guest_error(const char *device,
 {
     /* Nothing to do. */
 }
+
+void qapi_event_send_virtio_config_read(const char *device,
+                                        const char *path)
+{
+    /* Nothing to do. */
+}
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index cb35ea0b86..8a2ca77fde 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -26,6 +26,7 @@
 #include "sysemu/runstate.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-qdev.h"
+#include "qapi/qapi-events-qdev.h"
 #include "qapi/qmp/dispatch.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
@@ -1206,3 +1207,8 @@ bool qmp_command_available(const QmpCommand *cmd, Error **errp)
     }
     return true;
 }
+
+void qdev_virtio_config_read_event(DeviceState *dev)
+{
+    qapi_event_send_virtio_config_read(dev->id, dev->canonical_path);
+}
-- 
2.34.1


