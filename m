Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B203744F9B
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 20:07:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qG1SE-0000gC-Aw; Sun, 02 Jul 2023 14:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qG1Rl-0000bJ-CG; Sun, 02 Jul 2023 14:05:22 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qG1Rf-0005HU-M0; Sun, 02 Jul 2023 14:05:15 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 490C810DEF;
 Sun,  2 Jul 2023 21:04:54 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 73AC411203;
 Sun,  2 Jul 2023 21:04:52 +0300 (MSK)
Received: (nullmailer pid 2122369 invoked by uid 1000);
 Sun, 02 Jul 2023 18:04:51 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, longpeng2@huawei.com,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.3 60/65] vhost: fix vhost_dev_enable_notifiers() error
 case
Date: Sun,  2 Jul 2023 21:04:33 +0300
Message-Id: <20230702180439.2122316-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.3-20230702210422@cover.tls.msk.ru>
References: <qemu-stable-8.0.3-20230702210422@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Laurent Vivier <lvivier@redhat.com>

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
Message-Id: <20230602162735.3670785-1-lvivier@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 92099aa4e9a3bb6856c290afaf41c76f9e3dd9fd)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 58bd9ab82a..69a7b5592a 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1545,6 +1545,40 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
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
@@ -1574,7 +1608,7 @@ int vhost_dev_enable_notifiers(struct vhost_dev *hdev, VirtIODevice *vdev)
         if (r < 0) {
             error_report("vhost VQ %d notifier binding failed: %d", i, -r);
             memory_region_transaction_commit();
-            vhost_dev_disable_notifiers(hdev, vdev);
+            vhost_dev_disable_notifiers_nvqs(hdev, vdev, i);
             return r;
         }
     }
@@ -1591,34 +1625,7 @@ int vhost_dev_enable_notifiers(struct vhost_dev *hdev, VirtIODevice *vdev)
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


