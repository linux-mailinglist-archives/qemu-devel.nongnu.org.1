Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FC3BDF3DD
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Oct 2025 17:04:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v92xb-0007jd-GF; Wed, 15 Oct 2025 10:58:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v92xW-0007iE-UE
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:58:34 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v92xK-0000bN-4K
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:58:34 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 0D7A5C0688;
 Wed, 15 Oct 2025 17:58:19 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a94::1:15])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id AwRFIp2FFSw0-Wza5RtZQ; Wed, 15 Oct 2025 17:58:18 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760540298;
 bh=uJsVeXl+pVtxv1CsC7v1nVVbb3oRH5lkHyewMQwnhsY=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=f7gRLewX+erAIIL8FUTnLRA0NTYYIJvMCW6BvAZZGPiIalDSVfSkjMtXm5MSRbYay
 l92uzMAdAB57rDkC0zY1Gkhn1wc7L7hePw6H2fAZ6aZu61wuyaHgLBB2SFZyRHGtVq
 c68mbkOG6MClH2F7vfYqpfhwzSRAol8RG/T2nqT8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru
Subject: [PATCH v3 07/23] virtio: move common part of _set_guest_notifier to
 generic code
Date: Wed, 15 Oct 2025 17:57:51 +0300
Message-ID: <20251015145808.1112843-8-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251015145808.1112843-1-vsementsov@yandex-team.ru>
References: <20251015145808.1112843-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

virtio-pci and virtio-mmio handle config notifier equally but
with different code (mmio adds a separate function, when pci
use common function). Let's chose the more compact way (pci)
and reuse it for mmio.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
---
 hw/virtio/virtio-mmio.c        | 41 +++++------------------------
 hw/virtio/virtio-pci.c         | 34 +++---------------------
 hw/virtio/virtio.c             | 48 +++++++++++++++++++++++++++++++---
 include/hw/virtio/virtio-pci.h |  3 ---
 include/hw/virtio/virtio.h     | 16 +++++++++---
 5 files changed, 67 insertions(+), 75 deletions(-)

diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index fb58c36452..1f1d96129b 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -659,18 +659,11 @@ static int virtio_mmio_set_guest_notifier(DeviceState *d, int n, bool assign,
     VirtIOMMIOProxy *proxy = VIRTIO_MMIO(d);
     VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
-    VirtQueue *vq = virtio_get_queue(vdev, n);
-    EventNotifier *notifier = virtio_queue_get_guest_notifier(vq);
+    int r;
 
-    if (assign) {
-        int r = event_notifier_init(notifier, 0);
-        if (r < 0) {
-            return r;
-        }
-        virtio_queue_set_guest_notifier_fd_handler(vq, true, with_irqfd);
-    } else {
-        virtio_queue_set_guest_notifier_fd_handler(vq, false, with_irqfd);
-        event_notifier_cleanup(notifier);
+    r = virtio_queue_set_guest_notifier(vdev, n, assign, with_irqfd);
+    if (r < 0) {
+        return r;
     }
 
     if (vdc->guest_notifier_mask && vdev->use_guest_notifier_mask) {
@@ -679,30 +672,7 @@ static int virtio_mmio_set_guest_notifier(DeviceState *d, int n, bool assign,
 
     return 0;
 }
-static int virtio_mmio_set_config_guest_notifier(DeviceState *d, bool assign,
-                                                 bool with_irqfd)
-{
-    VirtIOMMIOProxy *proxy = VIRTIO_MMIO(d);
-    VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
-    VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
-    EventNotifier *notifier = virtio_config_get_guest_notifier(vdev);
-    int r = 0;
 
-    if (assign) {
-        r = event_notifier_init(notifier, 0);
-        if (r < 0) {
-            return r;
-        }
-        virtio_config_set_guest_notifier_fd_handler(vdev, assign, with_irqfd);
-    } else {
-        virtio_config_set_guest_notifier_fd_handler(vdev, assign, with_irqfd);
-        event_notifier_cleanup(notifier);
-    }
-    if (vdc->guest_notifier_mask && vdev->use_guest_notifier_mask) {
-        vdc->guest_notifier_mask(vdev, VIRTIO_CONFIG_IRQ_IDX, !assign);
-    }
-    return r;
-}
 static int virtio_mmio_set_guest_notifiers(DeviceState *d, int nvqs,
                                            bool assign)
 {
@@ -724,7 +694,8 @@ static int virtio_mmio_set_guest_notifiers(DeviceState *d, int nvqs,
             goto assign_error;
         }
     }
-    r = virtio_mmio_set_config_guest_notifier(d, assign, with_irqfd);
+    r = virtio_mmio_set_guest_notifier(d, VIRTIO_CONFIG_IRQ_IDX, assign,
+                                       with_irqfd);
     if (r < 0) {
         goto assign_error;
     }
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 937e22f08a..6c4576a17f 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1197,43 +1197,17 @@ static void virtio_pci_vector_poll(PCIDevice *dev,
     }
 }
 
-void virtio_pci_set_guest_notifier_fd_handler(VirtIODevice *vdev, VirtQueue *vq,
-                                              int n, bool assign,
-                                              bool with_irqfd)
-{
-    if (n == VIRTIO_CONFIG_IRQ_IDX) {
-        virtio_config_set_guest_notifier_fd_handler(vdev, assign, with_irqfd);
-    } else {
-        virtio_queue_set_guest_notifier_fd_handler(vq, assign, with_irqfd);
-    }
-}
-
 static int virtio_pci_set_guest_notifier(DeviceState *d, int n, bool assign,
                                          bool with_irqfd)
 {
     VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
     VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
-    VirtQueue *vq = NULL;
-    EventNotifier *notifier = NULL;
+    int r;
 
-    if (n == VIRTIO_CONFIG_IRQ_IDX) {
-        notifier = virtio_config_get_guest_notifier(vdev);
-    } else {
-        vq = virtio_get_queue(vdev, n);
-        notifier = virtio_queue_get_guest_notifier(vq);
-    }
-
-    if (assign) {
-        int r = event_notifier_init(notifier, 0);
-        if (r < 0) {
-            return r;
-        }
-        virtio_pci_set_guest_notifier_fd_handler(vdev, vq, n, true, with_irqfd);
-    } else {
-        virtio_pci_set_guest_notifier_fd_handler(vdev, vq, n, false,
-                                                 with_irqfd);
-        event_notifier_cleanup(notifier);
+    r = virtio_queue_set_guest_notifier(vdev, n, assign, with_irqfd);
+    if (r < 0) {
+        return r;
     }
 
     if (!msix_enabled(&proxy->pci_dev) &&
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 153ee0a0cf..704bc7943f 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3803,8 +3803,10 @@ static void virtio_config_guest_notifier_read(EventNotifier *n)
         virtio_notify_config(vdev);
     }
 }
-void virtio_queue_set_guest_notifier_fd_handler(VirtQueue *vq, bool assign,
-                                                bool with_irqfd)
+
+static void virtio_queue_set_guest_notifier_fd_handler(VirtQueue *vq,
+                                                       bool assign,
+                                                       bool with_irqfd)
 {
     if (assign && !with_irqfd) {
         event_notifier_set_handler(&vq->guest_notifier,
@@ -3819,7 +3821,7 @@ void virtio_queue_set_guest_notifier_fd_handler(VirtQueue *vq, bool assign,
     }
 }
 
-void virtio_config_set_guest_notifier_fd_handler(VirtIODevice *vdev,
+static void virtio_config_set_guest_notifier_fd_handler(VirtIODevice *vdev,
                                                  bool assign, bool with_irqfd)
 {
     EventNotifier *n;
@@ -3836,6 +3838,46 @@ void virtio_config_set_guest_notifier_fd_handler(VirtIODevice *vdev,
     }
 }
 
+static void virtio_pci_set_guest_notifier_fd_handler(VirtIODevice *vdev,
+                                                     VirtQueue *vq,
+                                                     int n, bool assign,
+                                                     bool with_irqfd)
+{
+    if (n == VIRTIO_CONFIG_IRQ_IDX) {
+        virtio_config_set_guest_notifier_fd_handler(vdev, assign, with_irqfd);
+    } else {
+        virtio_queue_set_guest_notifier_fd_handler(vq, assign, with_irqfd);
+    }
+}
+
+int virtio_queue_set_guest_notifier(VirtIODevice *vdev, int n, bool assign,
+                                    bool with_irqfd)
+{
+    VirtQueue *vq = NULL;
+    EventNotifier *notifier = NULL;
+
+    if (n == VIRTIO_CONFIG_IRQ_IDX) {
+        notifier = virtio_config_get_guest_notifier(vdev);
+    } else {
+        vq = virtio_get_queue(vdev, n);
+        notifier = virtio_queue_get_guest_notifier(vq);
+    }
+
+    if (assign) {
+        int r = event_notifier_init(notifier, 0);
+        if (r < 0) {
+            return r;
+        }
+        virtio_pci_set_guest_notifier_fd_handler(vdev, vq, n, true, with_irqfd);
+    } else {
+        virtio_pci_set_guest_notifier_fd_handler(vdev, vq, n, false,
+                                                 with_irqfd);
+        event_notifier_cleanup(notifier);
+    }
+
+    return 0;
+}
+
 EventNotifier *virtio_queue_get_guest_notifier(VirtQueue *vq)
 {
     return &vq->guest_notifier;
diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index 639752977e..2a5b65f374 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -263,9 +263,6 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t);
  * @fixed_queues.
  */
 unsigned virtio_pci_optimal_num_queues(unsigned fixed_queues);
-void virtio_pci_set_guest_notifier_fd_handler(VirtIODevice *vdev, VirtQueue *vq,
-                                              int n, bool assign,
-                                              bool with_irqfd);
 
 int virtio_pci_add_shm_cap(VirtIOPCIProxy *proxy, uint8_t bar, uint64_t offset,
                            uint64_t length, uint8_t id);
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index d97529c3f1..7db8046766 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -420,8 +420,6 @@ void virtio_queue_update_used_idx(VirtIODevice *vdev, int n);
 VirtQueue *virtio_get_queue(VirtIODevice *vdev, int n);
 uint16_t virtio_get_queue_index(VirtQueue *vq);
 EventNotifier *virtio_queue_get_guest_notifier(VirtQueue *vq);
-void virtio_queue_set_guest_notifier_fd_handler(VirtQueue *vq, bool assign,
-                                                bool with_irqfd);
 int virtio_device_start_ioeventfd(VirtIODevice *vdev);
 int virtio_device_grab_ioeventfd(VirtIODevice *vdev);
 void virtio_device_release_ioeventfd(VirtIODevice *vdev);
@@ -435,8 +433,18 @@ void virtio_queue_aio_detach_host_notifier(VirtQueue *vq, AioContext *ctx);
 VirtQueue *virtio_vector_first_queue(VirtIODevice *vdev, uint16_t vector);
 VirtQueue *virtio_vector_next_queue(VirtQueue *vq);
 EventNotifier *virtio_config_get_guest_notifier(VirtIODevice *vdev);
-void virtio_config_set_guest_notifier_fd_handler(VirtIODevice *vdev,
-                                                 bool assign, bool with_irqfd);
+
+/**
+ * virtio_queue_set_guest_notifier - set/unset queue or config guest
+ *     notifier
+ *
+ * @vdev: the VirtIO device
+ * @n: queue number, or VIRTIO_CONFIG_IRQ_IDX to set config notifer
+ * @assign: true to set notifier, false to unset
+ * @with_irqfd: irqfd enabled
+ */
+int virtio_queue_set_guest_notifier(VirtIODevice *vdev, int n, bool assign,
+                                    bool with_irqfd);
 
 static inline void virtio_add_feature(uint64_t *features, unsigned int fbit)
 {
-- 
2.48.1


