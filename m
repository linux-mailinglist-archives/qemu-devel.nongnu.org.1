Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1CA72078D
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 18:29:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q57dC-00012J-5G; Fri, 02 Jun 2023 12:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1q57dA-00012B-FV
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 12:28:00 -0400
Received: from mout.kundenserver.de ([212.227.17.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1q57d7-0001Z4-14
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 12:28:00 -0400
Received: from lenovo-t14s.redhat.com ([82.142.8.70]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MdNLi-1qeSRY14lM-00ZOuy; Fri, 02 Jun 2023 18:27:40 +0200
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 longpeng2@huawei.com
Subject: [PATCH] vhost: fix vhost_dev_enable_notifiers() error case
Date: Fri,  2 Jun 2023 18:27:35 +0200
Message-Id: <20230602162735.3670785-1-lvivier@redhat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:4QAYYiyXoiKNeJpOlNPKnXfYG5mVFa0PrGf/a1yxM3yP7zjErIO
 OgzIdEpoVs9qwClcSah48WZHEl8MAZd/lp/3raC9zXWUMfGmAikxipvx717Sil5rAw5+8RS
 7RNGb2R+0Y5s0E2CxUiXNKYgNYpNkdWO6jxT+5rExNK/y/ahn5EikhrVKFPQ0UfGWbFdE31
 Iyr1AI0ifslbwtdHzSMiA==
UI-OutboundReport: notjunk:1;M01:P0:5NImwKpBuXU=;x6pykS/M4l+sTFPTFDd5ACSPMWx
 hFt14BRG5ukpeL5oTkzae7RlTdCKroV/VWc1M6qMVZiUX65xcC/If0grT/SOIAdXrAPFQCms8
 0hI/znCzPXpCgoCU06FXhT95ciRvxVufpeg4qBuoQZPe1MR7KHmGFOWfkfZWZRVwP7BveMQ1w
 zK6k7sWEMuvwdgAONHwFrfWF9k5BNbQDccjY8l8y9G7bzyXID5tV3pwZzDcc8Y6XJ5qev74Ve
 TilhVnceVwxwokr5eW5RBMoG4xAbrFYKCTPcd1M0bqSA6Q/8Ud8k28ZQOEt3lG40nz8+6BZy2
 /uQDt+fsxK3KsGi8jMuQ43TuMm8fRZabQqnNVN1ufZY2Jmt18cs7zCmTH3IsGY1KVef8rrtDc
 yxRuqyh8Aa8HXFAR52BQk+zuxRlTMF9q0T5OQNH0NGU8+Gdsd7JneYuUKi2fs8Go3T4hMI6YH
 YMxc6H3v5BQxkFcYCtx1MIwgQ3STaOAWOiVKOyMspwhuGR5SlBXRc+S4hdB3jciNRrlWj6Bvu
 s69TAXhflJsHxnKWzOXQ5fQcKTr0lQBwANUWegsGttWmbJ4q7WzWceigqljcs7Ln7/UEz3/M2
 gPb6xykm/Kdu4SQ5F5nxpRy9a8vsD09X9hbVzFXTyyWIIdZkhepJ4Y1FPQg2Mcb4D6UasVFa5
 6SoKtp6bENtODdr22UC05Eqbxrwc8iKLLWq1Y3VKrQ==
Received-SPF: permerror client-ip=212.227.17.10;
 envelope-from=lvivier@redhat.com; helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_FAIL=0.001, SPF_HELO_NONE=0.001,
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

in vhost_dev_enable_notifiers(), if virtio_bus_set_host_notifier(true)
fails, we call vhost_dev_disable_notifiers() that executes
virtio_bus_set_host_notifier(false) on all queues, even on queues that
have failed to be initialized.

This triggers a core dump in memory_region_del_eventfd():

 virtio_bus_set_host_notifier: unable to init event notifier: Too many open files (-24)
 vhost VQ 1 notifier binding failed: 24
 .../softmmu/memory.c:2611: memory_region_del_eventfd: Assertion `i != mr->ioeventfd_nb' failed.

Fix the problem by providing to vhost_dev_disable_notifiers() the
number of queues to disable.

Fixes: 8771589b6f81 ("vhost: simplify vhost_dev_enable_notifiers")
Cc: longpeng2@huawei.com
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/virtio/vhost.c | 65 ++++++++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 29 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 746d130c7406..02ac68a21f54 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1531,6 +1531,40 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
     memset(hdev, 0, sizeof(struct vhost_dev));
 }
 
+static void vhost_dev_disable_notifiers_nvqs(struct vhost_dev *hdev,
+                                             VirtIODevice *vdev,
+                                             unsigned int nvqs)
+{
+    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
+    int i, r;
+
+    /*
+     * Batch all the host notifiers in a single transaction to avoid
+     * quadratic time complexity in address_space_update_ioeventfds().
+     */
+    memory_region_transaction_begin();
+
+    for (i = 0; i < nvqs; ++i) {
+        r = virtio_bus_set_host_notifier(VIRTIO_BUS(qbus), hdev->vq_index + i,
+                                         false);
+        if (r < 0) {
+            error_report("vhost VQ %d notifier cleanup failed: %d", i, -r);
+        }
+        assert(r >= 0);
+    }
+
+    /*
+     * The transaction expects the ioeventfds to be open when it
+     * commits. Do it now, before the cleanup loop.
+     */
+    memory_region_transaction_commit();
+
+    for (i = 0; i < nvqs; ++i) {
+        virtio_bus_cleanup_host_notifier(VIRTIO_BUS(qbus), hdev->vq_index + i);
+    }
+    virtio_device_release_ioeventfd(vdev);
+}
+
 /* Stop processing guest IO notifications in qemu.
  * Start processing them in vhost in kernel.
  */
@@ -1560,7 +1594,7 @@ int vhost_dev_enable_notifiers(struct vhost_dev *hdev, VirtIODevice *vdev)
         if (r < 0) {
             error_report("vhost VQ %d notifier binding failed: %d", i, -r);
             memory_region_transaction_commit();
-            vhost_dev_disable_notifiers(hdev, vdev);
+            vhost_dev_disable_notifiers_nvqs(hdev, vdev, i);
             return r;
         }
     }
@@ -1577,34 +1611,7 @@ int vhost_dev_enable_notifiers(struct vhost_dev *hdev, VirtIODevice *vdev)
  */
 void vhost_dev_disable_notifiers(struct vhost_dev *hdev, VirtIODevice *vdev)
 {
-    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
-    int i, r;
-
-    /*
-     * Batch all the host notifiers in a single transaction to avoid
-     * quadratic time complexity in address_space_update_ioeventfds().
-     */
-    memory_region_transaction_begin();
-
-    for (i = 0; i < hdev->nvqs; ++i) {
-        r = virtio_bus_set_host_notifier(VIRTIO_BUS(qbus), hdev->vq_index + i,
-                                         false);
-        if (r < 0) {
-            error_report("vhost VQ %d notifier cleanup failed: %d", i, -r);
-        }
-        assert (r >= 0);
-    }
-
-    /*
-     * The transaction expects the ioeventfds to be open when it
-     * commits. Do it now, before the cleanup loop.
-     */
-    memory_region_transaction_commit();
-
-    for (i = 0; i < hdev->nvqs; ++i) {
-        virtio_bus_cleanup_host_notifier(VIRTIO_BUS(qbus), hdev->vq_index + i);
-    }
-    virtio_device_release_ioeventfd(vdev);
+    vhost_dev_disable_notifiers_nvqs(hdev, vdev, hdev->nvqs);
 }
 
 /* Test and clear event pending status.
-- 
2.39.2


