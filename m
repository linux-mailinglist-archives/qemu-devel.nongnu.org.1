Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EEA9CDA2F
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Nov 2024 09:05:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBrIz-0006cV-IN; Fri, 15 Nov 2024 03:03:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zuoboqun@baidu.com>)
 id 1tBrIs-0006c7-VP
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 03:03:43 -0500
Received: from mx24.baidu.com ([111.206.215.185] helo=baidu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zuoboqun@baidu.com>)
 id 1tBrIn-0005ZE-IO
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 03:03:41 -0500
To: qemu-devel <qemu-devel@nongnu.org>
CC: "Michael S . Tsirkin" <mst@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>, zuoboqun
 <zuoboqun@baidu.com>, Gao Shiyuan <gaoshiyuan@baidu.com>
Subject: [PATCH v2] vhost_net: fix assertion triggered by batch of host
 notifiers processing
Date: Fri, 15 Nov 2024 16:03:12 +0800
Message-ID: <20241115080312.3184-1-zuoboqun@baidu.com>
X-Mailer: git-send-email 2.42.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.127.72.17]
X-ClientProxiedBy: BJHW-Mail-Ex06.internal.baidu.com (10.127.64.16) To
 BJHW-MAIL-EX26.internal.baidu.com (10.127.64.41)
X-FEAS-Client-IP: 172.31.51.48
X-FE-Policy-ID: 52:10:53:SYSTEM
Received-SPF: pass client-ip=111.206.215.185; envelope-from=zuoboqun@baidu.com;
 helo=baidu.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Zuo boqun <zuoboqun@baidu.com>
From:  Zuo boqun via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: zuoboqun <zuoboqun@baidu.com>

When the backend of vhost_net restarts during the vm is running, vhost_net
is stopped and started. The virtio_device_grab_ioeventfd() fucntion in
vhost_net_enable_notifiers() will result in a call to
virtio_bus_set_host_notifier()(assign=false).

And now virtio_device_grab_ioeventfd() is batched in a single transaction
with virtio_bus_set_host_notifier()(assign=true).

This triggers the following assertion:

kvm_mem_ioeventfd_del: error deleting ioeventfd: Bad file descriptor

This patch moves virtio_device_grab_ioeventfd() out of the batch to fix
this problem.

To be noted that the for loop to release ioeventfd should start from i+1,
not i, because the i-th ioeventfd has already been released in
vhost_dev_disable_notifiers_nvqs().

Fixes: 6166799f6 ("vhost_net: configure all host notifiers in a single MR transaction")
Signed-off-by: Zuo Boqun <zuoboqun@baidu.com>
Reported-by: Gao Shiyuan <gaoshiyuan@baidu.com>

---

v1->v2:
    *To explain why the for loop to release ioeventfd starts from i+1:
      1) add a comment in the code
      2) describe it in the commit message
---
 hw/net/vhost_net.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 997aab0557..891f235a0a 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -229,9 +229,24 @@ static int vhost_net_enable_notifiers(VirtIODevice *dev,
     int nvhosts = data_queue_pairs + cvq;
     struct vhost_net *net;
     struct vhost_dev *hdev;
-    int r, i, j;
+    int r, i, j, k;
     NetClientState *peer;
 
+    /*
+     * We will pass the notifiers to the kernel, make sure that QEMU
+     * doesn't interfere.
+     */
+    for (i = 0; i < nvhosts; i++) {
+        r = virtio_device_grab_ioeventfd(dev);
+        if (r < 0) {
+            error_report("vhost %d binding does not support host notifiers", i);
+            for (k = 0; k < i; k++) {
+                virtio_device_release_ioeventfd(dev);
+            }
+            return r;
+        }
+    }
+
     /*
      * Batch all the host notifiers in a single transaction to avoid
      * quadratic time complexity in address_space_update_ioeventfds().
@@ -247,16 +262,6 @@ static int vhost_net_enable_notifiers(VirtIODevice *dev,
 
         net = get_vhost_net(peer);
         hdev = &net->dev;
-        /*
-         * We will pass the notifiers to the kernel, make sure that QEMU
-         * doesn't interfere.
-         */
-        r = virtio_device_grab_ioeventfd(dev);
-        if (r < 0) {
-            error_report("binding does not support host notifiers");
-            memory_region_transaction_commit();
-            goto fail_nvhosts;
-        }
 
         for (j = 0; j < hdev->nvqs; j++) {
             r = virtio_bus_set_host_notifier(VIRTIO_BUS(qbus),
@@ -277,6 +282,14 @@ static int vhost_net_enable_notifiers(VirtIODevice *dev,
     return 0;
 fail_nvhosts:
     vhost_net_disable_notifiers_nvhosts(dev, ncs, data_queue_pairs, i);
+    /*
+     * This for loop starts from i+1, not i, because the i-th ioeventfd
+     * has already been released in vhost_dev_disable_notifiers_nvqs().
+     */
+    for (k = i + 1; k < nvhosts; k++) {
+        virtio_device_release_ioeventfd(dev);
+    }
+
     return r;
 }
 
-- 
2.42.0.windows.2


