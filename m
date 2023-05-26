Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 148D171298F
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 17:33:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2ZQG-0003rD-LD; Fri, 26 May 2023 11:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q2ZQF-0003qY-81
 for qemu-devel@nongnu.org; Fri, 26 May 2023 11:32:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q2ZQ8-0003Ml-D7
 for qemu-devel@nongnu.org; Fri, 26 May 2023 11:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685115118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jbnYQBiFK220eRkY8qup0icET08+1wIZ3Jse7v5+QIg=;
 b=MTEvps3hlDiut9Lg9wi8d0wSIzLZlfG5AmxiXSKav9ibYrSpjGj+R1lb9OuC7wC4arPK8y
 c9aQA1i2mXJCWBOUi4Tuj6ewIOQvuCgJObXfznIp77VXDG/A0TBiuTAqz2kXXFqS1/bqvS
 NyFs7UNe5RCooGo+PG1eKp4LIU3wtQg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-184-6RYkU9viMWaV-xbN75tqcQ-1; Fri, 26 May 2023 11:31:54 -0400
X-MC-Unique: 6RYkU9viMWaV-xbN75tqcQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BEC51185A791;
 Fri, 26 May 2023 15:31:53 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.193.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 19280400E117;
 Fri, 26 May 2023 15:31:50 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Parav Pandit <parav@mellanox.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, longpeng2@huawei.com,
 Shannon Nelson <snelson@pensando.io>, Laurent Vivier <lvivier@redhat.com>,
 si-wei.liu@oracle.com, Cindy Lu <lulu@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Harpreet Singh Anand <hanand@xilinx.com>,
 Dragos Tatulea <dtatulea@nvidia.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Gautam Dawar <gdawar@xilinx.com>,
 Jason Wang <jasowang@redhat.com>, Liuxiangdong <liuxiangdong5@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, alvaro.karsz@solid-run.com,
 Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH v4 2/2] vdpa: move CVQ isolation check to net_init_vhost_vdpa
Date: Fri, 26 May 2023 17:31:43 +0200
Message-Id: <20230526153143.470745-3-eperezma@redhat.com>
In-Reply-To: <20230526153143.470745-1-eperezma@redhat.com>
References: <20230526153143.470745-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Evaluating it at start time instead of initialization time may make the
guest capable of dynamically adding or removing migration blockers.

Also, moving to initialization reduces the number of ioctls in the
migration, reducing failure possibilities.

As a drawback we need to check for CVQ isolation twice: one time with no
MQ negotiated and another one acking it, as long as the device supports
it.  This is because Vring ASID / group management is based on vq
indexes, but we don't know the index of CVQ before negotiating MQ.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
v2: Take out the reset of the device from vhost_vdpa_cvq_is_isolated
v3: Only record cvq_isolated, true if the device have cvq isolated in
    both !MQ and MQ configurations.
v4: Only probe one of MQ or !MQ.
v4: Merge vhost_vdpa_cvq_is_isolated in vhost_vdpa_probe_cvq_isolation
    as there is only one call now.
v4: Call ioctl directly instead of adding functions.
---
 net/vhost-vdpa.c | 154 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 111 insertions(+), 43 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 3fb833fe76..0cafccd334 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -43,6 +43,10 @@ typedef struct VhostVDPAState {
 
     /* The device always have SVQ enabled */
     bool always_svq;
+
+    /* The device can isolate CVQ in its own ASID */
+    bool cvq_isolated;
+
     bool started;
 } VhostVDPAState;
 
@@ -362,15 +366,8 @@ static NetClientInfo net_vhost_vdpa_info = {
         .check_peer_type = vhost_vdpa_check_peer_type,
 };
 
-/**
- * Get vring virtqueue group
- *
- * @device_fd  vdpa device fd
- * @vq_index   Virtqueue index
- *
- * Return -errno in case of error, or vq group if success.
- */
-static int64_t vhost_vdpa_get_vring_group(int device_fd, unsigned vq_index)
+static int64_t vhost_vdpa_get_vring_group(int device_fd, unsigned vq_index,
+                                          Error **errp)
 {
     struct vhost_vring_state state = {
         .index = vq_index,
@@ -379,8 +376,7 @@ static int64_t vhost_vdpa_get_vring_group(int device_fd, unsigned vq_index)
 
     if (unlikely(r < 0)) {
         r = -errno;
-        error_report("Cannot get VQ %u group: %s", vq_index,
-                     g_strerror(errno));
+        error_setg_errno(errp, errno, "Cannot get VQ %u group", vq_index);
         return r;
     }
 
@@ -480,9 +476,9 @@ static int vhost_vdpa_net_cvq_start(NetClientState *nc)
 {
     VhostVDPAState *s, *s0;
     struct vhost_vdpa *v;
-    uint64_t backend_features;
     int64_t cvq_group;
-    int cvq_index, r;
+    int r;
+    Error *err = NULL;
 
     assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
 
@@ -502,41 +498,22 @@ static int vhost_vdpa_net_cvq_start(NetClientState *nc)
     /*
      * If we early return in these cases SVQ will not be enabled. The migration
      * will be blocked as long as vhost-vdpa backends will not offer _F_LOG.
-     *
-     * Calling VHOST_GET_BACKEND_FEATURES as they are not available in v->dev
-     * yet.
      */
-    r = ioctl(v->device_fd, VHOST_GET_BACKEND_FEATURES, &backend_features);
-    if (unlikely(r < 0)) {
-        error_report("Cannot get vdpa backend_features: %s(%d)",
-            g_strerror(errno), errno);
-        return -1;
+    if (!vhost_vdpa_net_valid_svq_features(v->dev->features, NULL)) {
+        return 0;
     }
-    if (!(backend_features & BIT_ULL(VHOST_BACKEND_F_IOTLB_ASID)) ||
-        !vhost_vdpa_net_valid_svq_features(v->dev->features, NULL)) {
+
+    if (!s->cvq_isolated) {
         return 0;
     }
 
-    /*
-     * Check if all the virtqueues of the virtio device are in a different vq
-     * than the last vq. VQ group of last group passed in cvq_group.
-     */
-    cvq_index = v->dev->vq_index_end - 1;
-    cvq_group = vhost_vdpa_get_vring_group(v->device_fd, cvq_index);
+    cvq_group = vhost_vdpa_get_vring_group(v->device_fd,
+                                           v->dev->vq_index_end - 1,
+                                           &err);
     if (unlikely(cvq_group < 0)) {
+        error_report_err(err);
         return cvq_group;
     }
-    for (int i = 0; i < cvq_index; ++i) {
-        int64_t group = vhost_vdpa_get_vring_group(v->device_fd, i);
-
-        if (unlikely(group < 0)) {
-            return group;
-        }
-
-        if (group == cvq_group) {
-            return 0;
-        }
-    }
 
     r = vhost_vdpa_set_address_space_id(v, cvq_group, VHOST_VDPA_NET_CVQ_ASID);
     if (unlikely(r < 0)) {
@@ -799,6 +776,87 @@ static const VhostShadowVirtqueueOps vhost_vdpa_net_svq_ops = {
     .avail_handler = vhost_vdpa_net_handle_ctrl_avail,
 };
 
+/**
+ * Probe if CVQ is isolated
+ *
+ * @device_fd         The vdpa device fd
+ * @features          Features offered by the device.
+ * @cvq_index         The control vq pair index
+ *
+ * Returns <0 in case of failure, 0 if false and 1 if true.
+ */
+static int vhost_vdpa_probe_cvq_isolation(int device_fd, uint64_t features,
+                                          int cvq_index, Error **errp)
+{
+    uint64_t backend_features;
+    int64_t cvq_group;
+    uint8_t status = VIRTIO_CONFIG_S_ACKNOWLEDGE |
+                     VIRTIO_CONFIG_S_DRIVER |
+                     VIRTIO_CONFIG_S_FEATURES_OK;
+    int r;
+
+    ERRP_GUARD();
+
+    r = ioctl(device_fd, VHOST_GET_BACKEND_FEATURES, &backend_features);
+    if (unlikely(r < 0)) {
+        error_setg_errno(errp, errno, "Cannot get vdpa backend_features");
+        return r;
+    }
+
+    if (!(backend_features & BIT_ULL(VHOST_BACKEND_F_IOTLB_ASID))) {
+        return 0;
+    }
+
+    r = ioctl(device_fd, VHOST_SET_FEATURES, &features);
+    if (unlikely(r)) {
+        error_setg_errno(errp, errno, "Cannot set features");
+    }
+
+    r = ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);
+    if (unlikely(r)) {
+        error_setg_errno(errp, -r, "Cannot set device features");
+        goto out;
+    }
+
+    cvq_group = vhost_vdpa_get_vring_group(device_fd, cvq_index, errp);
+    if (unlikely(cvq_group < 0)) {
+        if (cvq_group != -ENOTSUP) {
+            r = cvq_group;
+            goto out;
+        }
+
+        /*
+         * The kernel report VHOST_BACKEND_F_IOTLB_ASID if the vdpa frontend
+         * support ASID even if the parent driver does not.  The CVQ cannot be
+         * isolated in this case.
+         */
+        error_free(*errp);
+        *errp = NULL;
+        r = 0;
+        goto out;
+    }
+
+    for (int i = 0; i < cvq_index; ++i) {
+        int64_t group = vhost_vdpa_get_vring_group(device_fd, i, errp);
+        if (unlikely(group < 0)) {
+            r = group;
+            goto out;
+        }
+
+        if (group == (int64_t)cvq_group) {
+            r = 0;
+            goto out;
+        }
+    }
+
+    r = 1;
+
+out:
+    status = 0;
+    ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);
+    return r;
+}
+
 static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
                                        const char *device,
                                        const char *name,
@@ -808,16 +866,25 @@ static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
                                        bool is_datapath,
                                        bool svq,
                                        struct vhost_vdpa_iova_range iova_range,
-                                       uint64_t features)
+                                       uint64_t features,
+                                       Error **errp)
 {
     NetClientState *nc = NULL;
     VhostVDPAState *s;
     int ret = 0;
     assert(name);
+    int cvq_isolated;
+
     if (is_datapath) {
         nc = qemu_new_net_client(&net_vhost_vdpa_info, peer, device,
                                  name);
     } else {
+        cvq_isolated = vhost_vdpa_probe_cvq_isolation(vdpa_device_fd, features,
+                                                      queue_pair_index * 2, errp);
+        if (unlikely(cvq_isolated < 0)) {
+            return NULL;
+        }
+
         nc = qemu_new_net_control_client(&net_vhost_vdpa_cvq_info, peer,
                                          device, name);
     }
@@ -844,6 +911,7 @@ static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
 
         s->vhost_vdpa.shadow_vq_ops = &vhost_vdpa_net_svq_ops;
         s->vhost_vdpa.shadow_vq_ops_opaque = s;
+        s->cvq_isolated = cvq_isolated;
 
         /*
          * TODO: We cannot migrate devices with CVQ as there is no way to set
@@ -972,7 +1040,7 @@ int net_init_vhost_vdpa(const Netdev *netdev, const char *name,
     for (i = 0; i < queue_pairs; i++) {
         ncs[i] = net_vhost_vdpa_init(peer, TYPE_VHOST_VDPA, name,
                                      vdpa_device_fd, i, 2, true, opts->x_svq,
-                                     iova_range, features);
+                                     iova_range, features, errp);
         if (!ncs[i])
             goto err;
     }
@@ -980,7 +1048,7 @@ int net_init_vhost_vdpa(const Netdev *netdev, const char *name,
     if (has_cvq) {
         nc = net_vhost_vdpa_init(peer, TYPE_VHOST_VDPA, name,
                                  vdpa_device_fd, i, 1, false,
-                                 opts->x_svq, iova_range, features);
+                                 opts->x_svq, iova_range, features, errp);
         if (!nc)
             goto err;
     }
-- 
2.31.1


