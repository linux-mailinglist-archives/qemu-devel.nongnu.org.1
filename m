Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 104DF7B62D3
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 09:53:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnaCD-0003Ex-Oh; Tue, 03 Oct 2023 03:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qnaCC-0003Eo-Nh
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 03:51:56 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qnaCA-00019n-3L
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 03:51:56 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c18:d11:0:640:6943:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTP id 843B75FDB3;
 Tue,  3 Oct 2023 10:51:48 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b52d::1:13])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id VpQXBa0OjmI0-ckkpnEBc; Tue, 03 Oct 2023 10:51:47 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1696319507;
 bh=Fkbi+wNQnwK3AN/eUec82YS4Rb1p0kz+NR6miw9eUe0=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=eXE4haEH5i5iqzQ6KEeb/u6E1lM9TpL8xSn5aVGWofzIcU7jcjwxe4Pa7yzqDi5fO
 VnjevABgbPzWhVka4tv29YQla9EWdg1fAf5JYVb+Jhx38qfudDP3dBEUcBfCS5bqS/
 qFkbjoG9C8drukZjdXof4pHpudZI6AiU250eO3S0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, eduardo@habkost.net, berrange@redhat.com,
 pbonzini@redhat.com, armbru@redhat.com, dave@treblig.org, mst@redhat.com,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 den-plotnikov@yandex-team.ru
Subject: [PATCH v3] virtio: add VIRTQUEUE_ERROR QAPI event
Date: Tue,  3 Oct 2023 10:51:29 +0300
Message-Id: <20231003075129.27440-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

For now we only log the vhost device error, when virtqueue is actually
stopped. Let's add a QAPI event, which makes possible:

 - collect statistics of such errors
 - make immediate actions: take core dumps or do some other debugging
 - inform the user through a management API or UI, so that (s)he can
  react somehow, e.g. reset the device driver in the guest or even
  build up some automation to do so

Note that basically every inconsistency discovered during virtqueue
processing results in a silent virtqueue stop.  The guest then just
sees the requests getting stuck somewhere in the device for no visible
reason.  This event provides a means to inform the management layer of
this situation in a timely fashion.

The event could be reused for some other virtqueue problems (not only
for vhost devices) in future. For this it gets a generic name and
structure.

We keep original VHOST_OPS_DEBUG(), to keep original debug output as is
here, it's not the only call to VHOST_OPS_DEBUG in the file.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Denis Plotnikov <den-plotnikov@yandex-team.ru>
---

v3: add r-b by Den
    s/err/error/ in qapi
    add host-vring-err description in qapi

 hw/virtio/vhost.c | 12 +++++++++---
 monitor/monitor.c | 10 ++++++++++
 qapi/qdev.json    | 28 ++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index e2f6ffb446..43b7caaff3 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -15,6 +15,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-events-qdev.h"
 #include "hw/virtio/vhost.h"
 #include "qemu/atomic.h"
 #include "qemu/range.h"
@@ -1332,11 +1333,16 @@ static void vhost_virtqueue_error_notifier(EventNotifier *n)
     struct vhost_virtqueue *vq = container_of(n, struct vhost_virtqueue,
                                               error_notifier);
     struct vhost_dev *dev = vq->dev;
-    int index = vq - dev->vqs;
 
     if (event_notifier_test_and_clear(n) && dev->vdev) {
-        VHOST_OPS_DEBUG(-EINVAL,  "vhost vring error in virtqueue %d",
-                        dev->vq_index + index);
+        int ind = vq - dev->vqs + dev->vq_index;
+        DeviceState *ds = &dev->vdev->parent_obj;
+
+        VHOST_OPS_DEBUG(-EINVAL,  "vhost vring error in virtqueue %d", ind);
+        qapi_event_send_virtqueue_error(ds->id, ds->canonical_path, ind,
+                                        VIRTQUEUE_ERROR_VHOST_VRING_ERROR,
+                                        "vhost reported failure through vring "
+                                        "error fd");
     }
 }
 
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 941f87815a..cb1ee31156 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -313,6 +313,7 @@ static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
     [QAPI_EVENT_BALLOON_CHANGE]    = { 1000 * SCALE_MS },
     [QAPI_EVENT_QUORUM_REPORT_BAD] = { 1000 * SCALE_MS },
     [QAPI_EVENT_QUORUM_FAILURE]    = { 1000 * SCALE_MS },
+    [QAPI_EVENT_VIRTQUEUE_ERROR]   = { 1000 * SCALE_MS },
     [QAPI_EVENT_VSERPORT_CHANGE]   = { 1000 * SCALE_MS },
     [QAPI_EVENT_MEMORY_DEVICE_SIZE_CHANGE] = { 1000 * SCALE_MS },
 };
@@ -497,6 +498,10 @@ static unsigned int qapi_event_throttle_hash(const void *key)
         hash += g_str_hash(qdict_get_str(evstate->data, "qom-path"));
     }
 
+    if (evstate->event == QAPI_EVENT_VIRTQUEUE_ERROR) {
+        hash += g_str_hash(qdict_get_str(evstate->data, "device"));
+    }
+
     return hash;
 }
 
@@ -524,6 +529,11 @@ static gboolean qapi_event_throttle_equal(const void *a, const void *b)
                        qdict_get_str(evb->data, "qom-path"));
     }
 
+    if (eva->event == QAPI_EVENT_VIRTQUEUE_ERROR) {
+        return !strcmp(qdict_get_str(eva->data, "device"),
+                       qdict_get_str(evb->data, "device"));
+    }
+
     return TRUE;
 }
 
diff --git a/qapi/qdev.json b/qapi/qdev.json
index 6bc5a733b8..55d6c9018e 100644
--- a/qapi/qdev.json
+++ b/qapi/qdev.json
@@ -161,3 +161,31 @@
 ##
 { 'event': 'DEVICE_UNPLUG_GUEST_ERROR',
   'data': { '*device': 'str', 'path': 'str' } }
+
+##
+# @VirtqueueError:
+#
+# @vhost-vring-error: Vhost device reported failure through
+#     through vring error fd.
+#
+# Since: 8.2
+##
+{ 'enum': 'VirtqueueError',
+  'data': [ 'vhost-vring-error' ] }
+
+##
+# @VIRTQUEUE_ERROR:
+#
+# Emitted when a device virtqueue fails in runtime.
+#
+# @device: the device's ID if it has one
+# @path: the device's QOM path
+# @virtqueue: virtqueue index
+# @error: error identifier
+# @description: human readable description
+#
+# Since: 8.2
+##
+{ 'event': 'VIRTQUEUE_ERROR',
+ 'data': { '*device': 'str', 'path': 'str', 'virtqueue': 'int',
+            'error': 'VirtqueueError', 'description': 'str'} }
-- 
2.34.1


