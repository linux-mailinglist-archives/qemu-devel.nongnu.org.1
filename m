Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54750BCFDC1
	for <lists+qemu-devel@lfdr.de>; Sun, 12 Oct 2025 01:27:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7iwo-0006Bu-LK; Sat, 11 Oct 2025 19:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7iwj-00068q-A7
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 19:24:17 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7iwg-0000rc-Ag
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 19:24:17 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 09939C01DD;
 Sun, 12 Oct 2025 02:24:13 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a4b::1:3c])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 6OWMXt1FjqM0-9p0QMlHa; Sun, 12 Oct 2025 02:24:12 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760225052;
 bh=03IuelRDIS50tGxI+U6wAMi9oT18Y8qRE+dfG16mOKs=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=FGCXcutK//xjpmSncpM9FhMDDz3AKdIMuGcNZ548or3b71Pwm8EGGtUvhicT7dPZl
 jg5l79AxamAj1Iyu6OESCwnevnWA8RupLBKaW4LoRkEdnYVtOQ7zy7WeZgCIaJM3/s
 N+yK+U0P/yHDJDU0Y0rzqg+bhMB/oxkc8hf3VPcE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 raphael.s.norwitz@gmail.com, vsementsov@yandex-team.ru,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 04/23] vhost: move protocol_features to vhost_user
Date: Sun, 12 Oct 2025 02:23:43 +0300
Message-ID: <20251011232404.561024-5-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251011232404.561024-1-vsementsov@yandex-team.ru>
References: <20251011232404.561024-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

As comment says: it's only for vhost-user. So, let's move it
to corresponding vhost backend realization.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 backends/cryptodev-vhost.c     |  1 -
 hw/net/vhost_net.c             |  2 --
 hw/virtio/vhost-user.c         | 26 +++++++++++++++++++++++---
 hw/virtio/virtio-qmp.c         |  6 ++++--
 include/hw/virtio/vhost-user.h |  3 +++
 include/hw/virtio/vhost.h      |  8 --------
 6 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/backends/cryptodev-vhost.c b/backends/cryptodev-vhost.c
index abdfce33af..c6069f4e5b 100644
--- a/backends/cryptodev-vhost.c
+++ b/backends/cryptodev-vhost.c
@@ -60,7 +60,6 @@ cryptodev_vhost_init(
 
     crypto->cc = options->cc;
 
-    crypto->dev.protocol_features = 0;
     crypto->backend = -1;
 
     /* vhost-user needs vq_index to initiate a specific queue pair */
diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index fda90e231e..ca19983126 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -265,9 +265,7 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
             goto fail;
         }
         net->backend = r;
-        net->dev.protocol_features = 0;
     } else {
-        net->dev.protocol_features = 0;
         net->backend = -1;
 
         /* vhost-user needs vq_index to initiate a specific queue pair */
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index b8231dcbcf..3fd11a3b57 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -11,6 +11,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/virtio/virtio-dmabuf.h"
+#include "hw/virtio/virtio-qmp.h"
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/virtio-crypto.h"
 #include "hw/virtio/vhost-user.h"
@@ -264,6 +265,14 @@ struct vhost_user {
     /* Our current regions */
     int num_shadow_regions;
     struct vhost_memory_region shadow_regions[VHOST_USER_MAX_RAM_SLOTS];
+
+    /**
+     * @protocol_features: the vhost-user protocol feature set by
+     * VHOST_USER_SET_PROTOCOL_FEATURES. Protocol features are only
+     * negotiated if VHOST_USER_F_PROTOCOL_FEATURES has been offered
+     * by the backend (see @features).
+     */
+    uint64_t protocol_features;
 };
 
 struct scrub_regions {
@@ -275,7 +284,8 @@ struct scrub_regions {
 static bool vhost_user_has_protocol_feature(struct vhost_dev *dev,
                                             uint64_t feature)
 {
-    return virtio_has_feature(dev->protocol_features, feature);
+    struct vhost_user *u = dev->opaque;
+    return virtio_has_feature(u->protocol_features, feature);
 }
 
 static int vhost_user_read_header(struct vhost_dev *dev, VhostUserMsg *msg)
@@ -2229,8 +2239,8 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
         }
 
         /* final set of protocol features */
-        dev->protocol_features = protocol_features;
-        err = vhost_user_set_protocol_features(dev, dev->protocol_features);
+        u->protocol_features = protocol_features;
+        err = vhost_user_set_protocol_features(dev, u->protocol_features);
         if (err < 0) {
             error_setg_errno(errp, EPROTO, "vhost_backend_init failed");
             return -EPROTO;
@@ -3021,6 +3031,16 @@ static int vhost_user_check_device_state(struct vhost_dev *dev, Error **errp)
     return 0;
 }
 
+void vhost_user_qmp_status(struct vhost_dev *dev, VirtioStatus *status)
+{
+    struct vhost_user *u = dev->opaque;
+
+    assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER);
+
+    status->vhost_dev->protocol_features =
+        qmp_decode_protocols(u->protocol_features);
+}
+
 const VhostOps user_ops = {
         .backend_type = VHOST_BACKEND_TYPE_USER,
         .vhost_backend_init = vhost_user_backend_init,
diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index dd1a38e792..82acb6d232 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -821,12 +821,14 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
         status->vhost_dev->acked_features =
             qmp_decode_features(vdev->device_id, hdev->acked_features_ex);
 
-        status->vhost_dev->protocol_features =
-            qmp_decode_protocols(hdev->protocol_features);
         status->vhost_dev->max_queues = hdev->max_queues;
         status->vhost_dev->backend_cap = hdev->backend_cap;
         status->vhost_dev->log_enabled = hdev->log_enabled;
         status->vhost_dev->log_size = hdev->log_size;
+
+        if (hdev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER) {
+            vhost_user_qmp_status(hdev, status);
+        }
     }
 
     return status;
diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
index 9a3f238b43..36d96296a3 100644
--- a/include/hw/virtio/vhost-user.h
+++ b/include/hw/virtio/vhost-user.h
@@ -10,6 +10,7 @@
 
 #include "chardev/char-fe.h"
 #include "hw/virtio/virtio.h"
+#include "qapi/qapi-types-virtio.h"
 
 enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_MQ = 0,
@@ -111,4 +112,6 @@ void vhost_user_async_close(DeviceState *d,
                             CharBackend *chardev, struct vhost_dev *vhost,
                             vu_async_close_fn cb);
 
+void vhost_user_qmp_status(struct vhost_dev *dev, VirtioStatus *status);
+
 #endif
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 3e69e47833..e308bc4556 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -104,14 +104,6 @@ struct vhost_dev {
     VIRTIO_DECLARE_FEATURES(features);
     VIRTIO_DECLARE_FEATURES(acked_features);
 
-    /**
-     * @protocol_features: is the vhost-user only feature set by
-     * VHOST_USER_SET_PROTOCOL_FEATURES. Protocol features are only
-     * negotiated if VHOST_USER_F_PROTOCOL_FEATURES has been offered
-     * by the backend (see @features).
-     */
-    uint64_t protocol_features;
-
     uint64_t max_queues;
     uint64_t backend_cap;
     /* @started: is the vhost device started? */
-- 
2.48.1


