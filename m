Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5AEB25021
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Aug 2025 18:52:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umEfk-0002mF-7k; Wed, 13 Aug 2025 12:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1umEfI-0002dk-U9; Wed, 13 Aug 2025 12:49:32 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1umEf4-0007nW-2C; Wed, 13 Aug 2025 12:49:26 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 84A6880AA7;
 Wed, 13 Aug 2025 19:49:08 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:167::1:21])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id wmOQI00FoSw0-JpK3xgI4; Wed, 13 Aug 2025 19:49:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755103748;
 bh=KVnjEs242mxf0oDV8dheNJ6G8NvptyrhWPMrmMFU1v8=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=cZ+T3zxjDwXc91G9hPMg/JJPtRLn80PYhqjxXRuy/IE5O/v4ey8PBexDNxjn2O313
 A/Z5+PInFeMW+YSLOEuZOd1nhIulyIHZlrRy08Z3yD2afd0j9wVphyRVSDesc09Aix
 Xfg21+f59Hatp6byfAYkmSZtKQ07MlI3Qgbb95Nk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net
Cc: sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 eblake@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, steven.sistare@oracle.com,
 den-plotnikov@yandex-team.ru, vsementsov@yandex-team.ru,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 06/33] vhost: make vhost_dev.features private
Date: Wed, 13 Aug 2025 19:48:27 +0300
Message-ID: <20250813164856.950363-7-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250813164856.950363-1-vsementsov@yandex-team.ru>
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

It's hard to control where and how do we use this field. Let's
cover all usages by getters/setters, and keep direct access to the
field only in vhost.c. It will help to control migration of this
field in further commits.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/display/vhost-user-gpu.c |  7 +++----
 hw/net/vhost_net.c          | 17 +++++++++--------
 hw/virtio/vdpa-dev.c        |  2 +-
 hw/virtio/vhost-user-base.c |  8 ++++++--
 hw/virtio/vhost-user.c      |  7 +++----
 hw/virtio/vhost.c           | 21 ++++++++++++++++++---
 hw/virtio/virtio-qmp.c      |  2 +-
 include/hw/virtio/vhost.h   | 21 +++++++++++++++++++--
 net/vhost-vdpa.c            |  7 +++----
 9 files changed, 63 insertions(+), 29 deletions(-)

diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index 79ea64b12c..146620e0a3 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -631,17 +631,16 @@ vhost_user_gpu_device_realize(DeviceState *qdev, Error **errp)
 
     /* existing backend may send DMABUF, so let's add that requirement */
     g->parent_obj.conf.flags |= 1 << VIRTIO_GPU_FLAG_DMABUF_ENABLED;
-    if (virtio_has_feature(g->vhost->dev.features, VIRTIO_GPU_F_VIRGL)) {
+    if (vhost_dev_has_feature(&g->vhost->dev, VIRTIO_GPU_F_VIRGL)) {
         g->parent_obj.conf.flags |= 1 << VIRTIO_GPU_FLAG_VIRGL_ENABLED;
     }
-    if (virtio_has_feature(g->vhost->dev.features, VIRTIO_GPU_F_EDID)) {
+    if (vhost_dev_has_feature(&g->vhost->dev, VIRTIO_GPU_F_EDID)) {
         g->parent_obj.conf.flags |= 1 << VIRTIO_GPU_FLAG_EDID_ENABLED;
     } else {
         error_report("EDID requested but the backend doesn't support it.");
         g->parent_obj.conf.flags &= ~(1 << VIRTIO_GPU_FLAG_EDID_ENABLED);
     }
-    if (virtio_has_feature(g->vhost->dev.features,
-        VIRTIO_GPU_F_RESOURCE_UUID)) {
+    if (vhost_dev_has_feature(&g->vhost->dev, VIRTIO_GPU_F_RESOURCE_UUID)) {
         g->parent_obj.conf.flags |= 1 << VIRTIO_GPU_FLAG_RESOURCE_UUID_ENABLED;
     }
 
diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index ce30b6e197..5269533864 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -55,7 +55,8 @@ void vhost_net_ack_features(struct vhost_net *net, uint64_t features)
 {
     net->dev.acked_features =
         (qemu_has_vnet_hdr(net->nc) ? 0 : (1ULL << VHOST_NET_F_VIRTIO_NET_HDR))
-         | (net->dev.features & (1ULL << VHOST_USER_F_PROTOCOL_FEATURES));
+         | (vhost_dev_features(&net->dev) &
+            (1ULL << VHOST_USER_F_PROTOCOL_FEATURES));
 
     vhost_ack_features(&net->dev, net->feature_bits, features);
 }
@@ -277,23 +278,23 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
     if (backend_kernel) {
         if (!qemu_has_vnet_hdr_len(options->net_backend,
                                sizeof(struct virtio_net_hdr_mrg_rxbuf))) {
-            net->dev.features &= ~(1ULL << VIRTIO_NET_F_MRG_RXBUF);
+            vhost_dev_clear_feature(&net->dev, VIRTIO_NET_F_MRG_RXBUF);
         }
         if (!qemu_has_vnet_hdr(options->net_backend) &&
-            (~net->dev.features & (1ULL << VHOST_NET_F_VIRTIO_NET_HDR))) {
-            fprintf(stderr, "vhost lacks feature mask 0x%llx for backend\n",
-                    ~net->dev.features & (1ULL << VHOST_NET_F_VIRTIO_NET_HDR));
+            !vhost_dev_has_feature(&net->dev, VHOST_NET_F_VIRTIO_NET_HDR)) {
+            fprintf(stderr, "vhost lacks VHOST_NET_F_VIRTIO_NET_HDR "
+                    "feature for backend\n");
             goto fail;
         }
     }
 
     /* Set sane init value. Override when guest acks. */
     if (options->get_acked_features) {
+        uint64_t backend_features = vhost_dev_features(&net->dev);
         features = options->get_acked_features(net->nc);
-        if (~net->dev.features & features) {
+        if (~backend_features & features) {
             fprintf(stderr, "vhost lacks feature mask 0x%" PRIx64
-                    " for backend\n",
-                    (uint64_t)(~net->dev.features & features));
+                    " for backend\n", ~backend_features & features);
             goto fail;
         }
     }
diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
index 3c0eed3e8e..4dfb03aaa7 100644
--- a/hw/virtio/vdpa-dev.c
+++ b/hw/virtio/vdpa-dev.c
@@ -224,7 +224,7 @@ static uint64_t vhost_vdpa_device_get_features(VirtIODevice *vdev,
                                                Error **errp)
 {
     VhostVdpaDevice *s = VHOST_VDPA_DEVICE(vdev);
-    uint64_t backend_features = s->dev.features;
+    uint64_t backend_features = vhost_dev_features(&s->dev);
 
     if (!virtio_has_feature(features, VIRTIO_F_IOMMU_PLATFORM)) {
         virtio_clear_feature(&backend_features, VIRTIO_F_IOMMU_PLATFORM);
diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
index ff67a020b4..cf311c3bfc 100644
--- a/hw/virtio/vhost-user-base.c
+++ b/hw/virtio/vhost-user-base.c
@@ -118,9 +118,13 @@ static uint64_t vub_get_features(VirtIODevice *vdev,
                                  uint64_t requested_features, Error **errp)
 {
     VHostUserBase *vub = VHOST_USER_BASE(vdev);
+    uint64_t backend_features = vhost_dev_features(&vub->vhost_dev);
+
     /* This should be set when the vhost connection initialises */
-    g_assert(vub->vhost_dev.features);
-    return vub->vhost_dev.features & ~(1ULL << VHOST_USER_F_PROTOCOL_FEATURES);
+    g_assert(backend_features);
+    virtio_clear_feature(&backend_features, VHOST_USER_F_PROTOCOL_FEATURES);
+
+    return backend_features;
 }
 
 /*
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index abdf47ee7b..46f09f5988 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1245,15 +1245,14 @@ static int vhost_user_set_vring_base(struct vhost_dev *dev,
 
 static bool vhost_user_set_vring_enable_supported(struct vhost_dev *dev)
 {
-    return virtio_has_feature(dev->features,
-                              VHOST_USER_F_PROTOCOL_FEATURES);
+    return vhost_dev_has_feature(dev, VHOST_USER_F_PROTOCOL_FEATURES);
 }
 
 static int vhost_user_set_vring_enable(struct vhost_dev *dev, int enable)
 {
     int i;
 
-    if (!virtio_has_feature(dev->features, VHOST_USER_F_PROTOCOL_FEATURES)) {
+    if (!vhost_dev_has_feature(dev, VHOST_USER_F_PROTOCOL_FEATURES)) {
         return -EINVAL;
     }
 
@@ -1465,7 +1464,7 @@ static int vhost_user_set_features(struct vhost_dev *dev,
      * Don't lose VHOST_USER_F_PROTOCOL_FEATURES, which is vhost-user
      * specific.
      */
-    if (virtio_has_feature(dev->features, VHOST_USER_F_PROTOCOL_FEATURES)) {
+    if (vhost_dev_has_feature(dev, VHOST_USER_F_PROTOCOL_FEATURES)) {
         features |= 1ULL << VHOST_USER_F_PROTOCOL_FEATURES;
     }
 
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index c33dad4acd..2631bbabcf 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -50,6 +50,21 @@ static QLIST_HEAD(, vhost_dev) vhost_log_devs[VHOST_BACKEND_TYPE_MAX];
 static QLIST_HEAD(, vhost_dev) vhost_devices =
     QLIST_HEAD_INITIALIZER(vhost_devices);
 
+bool vhost_dev_has_feature(struct vhost_dev *dev, uint64_t feature)
+{
+    return virtio_has_feature(dev->_features, feature);
+}
+
+uint64_t vhost_dev_features(struct vhost_dev *dev)
+{
+    return dev->_features;
+}
+
+void vhost_dev_clear_feature(struct vhost_dev *dev, uint64_t feature)
+{
+    virtio_clear_feature(&dev->_features, feature);
+}
+
 unsigned int vhost_get_max_memslots(void)
 {
     unsigned int max = UINT_MAX;
@@ -1571,7 +1586,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         }
     }
 
-    hdev->features = features;
+    hdev->_features = features;
 
     hdev->memory_listener = (MemoryListener) {
         .name = "vhost",
@@ -1594,7 +1609,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     };
 
     if (hdev->migration_blocker == NULL) {
-        if (!(hdev->features & (0x1ULL << VHOST_F_LOG_ALL))) {
+        if (!vhost_dev_has_feature(hdev, VHOST_F_LOG_ALL)) {
             error_setg(&hdev->migration_blocker,
                        "Migration disabled: vhost lacks VHOST_F_LOG_ALL feature.");
         } else if (vhost_dev_log_is_shared(hdev) && !qemu_memfd_alloc_check()) {
@@ -1865,7 +1880,7 @@ uint64_t vhost_get_features(struct vhost_dev *hdev, const int *feature_bits,
     const int *bit = feature_bits;
     while (*bit != VHOST_INVALID_FEATURE_BIT) {
         uint64_t bit_mask = (1ULL << *bit);
-        if (!(hdev->features & bit_mask)) {
+        if (!vhost_dev_has_feature(hdev, *bit)) {
             features &= ~bit_mask;
         }
         bit++;
diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index d55b12f9f3..4bd23c015e 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -785,7 +785,7 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
         status->vhost_dev->nvqs = hdev->nvqs;
         status->vhost_dev->vq_index = hdev->vq_index;
         status->vhost_dev->features =
-            qmp_decode_features(vdev->device_id, hdev->features);
+            qmp_decode_features(vdev->device_id, vhost_dev_features(hdev));
         status->vhost_dev->acked_features =
             qmp_decode_features(vdev->device_id, hdev->acked_features);
         status->vhost_dev->max_queues = hdev->max_queues;
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 15bc287a9d..8a4c8c3502 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -98,10 +98,11 @@ struct vhost_dev {
      * offered by a backend which may be a subset of the total
      * features eventually offered to the guest.
      *
-     * @features: available features provided by the backend
+     * @_features: available features provided by the backend, private,
+     *             direct access only in vhost.c
      * @acked_features: final negotiated features with front-end driver
      */
-    uint64_t features;
+    uint64_t _features;
     uint64_t acked_features;
 
     uint64_t max_queues;
@@ -352,6 +353,22 @@ int vhost_dev_get_inflight(struct vhost_dev *dev, uint16_t queue_size,
                            struct vhost_inflight *inflight);
 bool vhost_dev_has_iommu(struct vhost_dev *dev);
 
+/**
+ * vhost_dev_has_feature() - check if vhost device has a specific feature
+ * @dev: common vhost_dev structure
+ * @feature: feature bit to check
+ *
+ * Return: true if the feature is supported, false otherwise
+ */
+bool vhost_dev_has_feature(struct vhost_dev *dev, uint64_t feature);
+
+/**
+ * vhost_dev_features() - simple getter for dev->features
+ */
+uint64_t vhost_dev_features(struct vhost_dev *dev);
+
+void vhost_dev_clear_feature(struct vhost_dev *dev, uint64_t feature);
+
 #ifdef CONFIG_VHOST
 int vhost_reset_device(struct vhost_dev *hdev);
 #else
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 74d26a9497..0af0d3bdd3 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -256,15 +256,14 @@ static bool vhost_vdpa_get_vnet_hash_supported_types(NetClientState *nc,
 {
     assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
     VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
-    uint64_t features = s->vhost_vdpa.dev->features;
     int fd = s->vhost_vdpa.shared->device_fd;
     struct {
         struct vhost_vdpa_config hdr;
         uint32_t supported_hash_types;
     } config;
 
-    if (!virtio_has_feature(features, VIRTIO_NET_F_HASH_REPORT) &&
-        !virtio_has_feature(features, VIRTIO_NET_F_RSS)) {
+    if (!vhost_dev_has_feature(s->vhost_vdpa.dev, VIRTIO_NET_F_HASH_REPORT) &&
+        !vhost_dev_has_feature(s->vhost_vdpa.dev, VIRTIO_NET_F_RSS)) {
         return false;
     }
 
@@ -585,7 +584,7 @@ static int vhost_vdpa_net_cvq_start(NetClientState *nc)
      * If we early return in these cases SVQ will not be enabled. The migration
      * will be blocked as long as vhost-vdpa backends will not offer _F_LOG.
      */
-    if (!vhost_vdpa_net_valid_svq_features(v->dev->features, NULL)) {
+    if (!vhost_vdpa_net_valid_svq_features(vhost_dev_features(v->dev), NULL)) {
         return 0;
     }
 
-- 
2.48.1


