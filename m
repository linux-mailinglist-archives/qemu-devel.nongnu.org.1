Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1885B2503D
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Aug 2025 18:55:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umEfv-0002wT-EF; Wed, 13 Aug 2025 12:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1umEfH-0002de-4b; Wed, 13 Aug 2025 12:49:28 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1umEf5-0007n3-US; Wed, 13 Aug 2025 12:49:25 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id E224A807AC;
 Wed, 13 Aug 2025 19:49:05 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:167::1:21])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id wmOQI00FoSw0-lGZn6UT8; Wed, 13 Aug 2025 19:49:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755103745;
 bh=6y3hwaG28K0NcdouNlUVjGJba0PpSLLa4p9W0yA2JNo=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=jGhiuUTObn3D7JwS1wUWRk4bgrhvkvnYMCjvDIBXptboGeJWxYdcHMfbtgLCseRUL
 XRLceVtdxYQsJqXmtTEcRfboo4Gl1ilNJaCAuBIxpaiCElGj4kPiU36vAwUcJ/4dun
 00jk44Dg9BYvLFRtY662C+8EtbAnR6saEO7mq8c4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net
Cc: sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 eblake@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, steven.sistare@oracle.com,
 den-plotnikov@yandex-team.ru, vsementsov@yandex-team.ru,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH 04/33] vhost: move protocol_features to vhost_user
Date: Wed, 13 Aug 2025 19:48:25 +0300
Message-ID: <20250813164856.950363-5-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250813164856.950363-1-vsementsov@yandex-team.ru>
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

As comment says: it's only for vhost-user. So, let's move it
to corresponding vhost backend realization.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 backends/cryptodev-vhost.c        |  1 -
 hw/net/vhost_net.c                |  2 --
 hw/virtio/vhost-user.c            | 23 ++++++++++++++++++++---
 hw/virtio/virtio-qmp.c            |  6 ++++--
 include/hw/virtio/vhost-backend.h |  3 +++
 include/hw/virtio/vhost.h         |  8 --------
 6 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/backends/cryptodev-vhost.c b/backends/cryptodev-vhost.c
index 943680a23a..3bcdc494d8 100644
--- a/backends/cryptodev-vhost.c
+++ b/backends/cryptodev-vhost.c
@@ -60,7 +60,6 @@ cryptodev_vhost_init(
 
     crypto->cc = options->cc;
 
-    crypto->dev.protocol_features = 0;
     crypto->backend = -1;
 
     /* vhost-user needs vq_index to initiate a specific queue pair */
diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index fcee279f0b..ce30b6e197 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -260,9 +260,7 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
             goto fail;
         }
         net->backend = r;
-        net->dev.protocol_features = 0;
     } else {
-        net->dev.protocol_features = 0;
         net->backend = -1;
 
         /* vhost-user needs vq_index to initiate a specific queue pair */
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 6fa5b8a8bd..abdf47ee7b 100644
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
@@ -274,7 +283,8 @@ struct scrub_regions {
 
 static bool vhost_user_has_prot(struct vhost_dev *dev, uint64_t feature)
 {
-    return virtio_has_feature(dev->protocol_features, feature);
+    struct vhost_user *u = dev->opaque;
+    return virtio_has_feature(u->protocol_features, feature);
 }
 
 static int vhost_user_read_header(struct vhost_dev *dev, VhostUserMsg *msg)
@@ -2218,8 +2228,8 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
         }
 
         /* final set of protocol features */
-        dev->protocol_features = protocol_features;
-        err = vhost_user_set_protocol_features(dev, dev->protocol_features);
+        u->protocol_features = protocol_features;
+        err = vhost_user_set_protocol_features(dev, u->protocol_features);
         if (err < 0) {
             error_setg_errno(errp, EPROTO, "vhost_backend_init failed");
             return -EPROTO;
@@ -3001,6 +3011,12 @@ static int vhost_user_check_device_state(struct vhost_dev *dev, Error **errp)
     return 0;
 }
 
+static void vhost_user_qmp_status(struct vhost_dev *dev, VhostStatus *status)
+{
+    struct vhost_user *u = dev->opaque;
+    status->protocol_features = qmp_decode_protocols(u->protocol_features);
+}
+
 const VhostOps user_ops = {
         .backend_type = VHOST_BACKEND_TYPE_USER,
         .vhost_backend_init = vhost_user_backend_init,
@@ -3041,4 +3057,5 @@ const VhostOps user_ops = {
         .vhost_supports_device_state = vhost_user_supports_device_state,
         .vhost_set_device_state_fd = vhost_user_set_device_state_fd,
         .vhost_check_device_state = vhost_user_check_device_state,
+        .vhost_qmp_status = vhost_user_qmp_status,
 };
diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index e514a4797e..d55b12f9f3 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -788,12 +788,14 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
             qmp_decode_features(vdev->device_id, hdev->features);
         status->vhost_dev->acked_features =
             qmp_decode_features(vdev->device_id, hdev->acked_features);
-        status->vhost_dev->protocol_features =
-            qmp_decode_protocols(hdev->protocol_features);
         status->vhost_dev->max_queues = hdev->max_queues;
         status->vhost_dev->backend_cap = hdev->backend_cap;
         status->vhost_dev->log_enabled = hdev->log_enabled;
         status->vhost_dev->log_size = hdev->log_size;
+
+        if (hdev->vhost_ops->vhost_qmp_status) {
+            hdev->vhost_ops->vhost_qmp_status(hdev, status->vhost_dev);
+        }
     }
 
     return status;
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index f65fa26298..0785fc764d 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -12,6 +12,7 @@
 #define VHOST_BACKEND_H
 
 #include "system/memory.h"
+#include "qapi/qapi-commands-virtio.h"
 
 typedef enum VhostBackendType {
     VHOST_BACKEND_TYPE_NONE = 0,
@@ -160,6 +161,7 @@ typedef int (*vhost_set_device_state_fd_op)(struct vhost_dev *dev,
                                             int *reply_fd,
                                             Error **errp);
 typedef int (*vhost_check_device_state_op)(struct vhost_dev *dev, Error **errp);
+typedef void (*vhost_qmp_status_op)(struct vhost_dev *dev, VhostStatus *status);
 
 typedef struct VhostOps {
     VhostBackendType backend_type;
@@ -216,6 +218,7 @@ typedef struct VhostOps {
     vhost_supports_device_state_op vhost_supports_device_state;
     vhost_set_device_state_fd_op vhost_set_device_state_fd;
     vhost_check_device_state_op vhost_check_device_state;
+    vhost_qmp_status_op vhost_qmp_status;
 } VhostOps;
 
 int vhost_backend_update_device_iotlb(struct vhost_dev *dev,
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 9f9dd2d46d..15bc287a9d 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -104,14 +104,6 @@ struct vhost_dev {
     uint64_t features;
     uint64_t acked_features;
 
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


