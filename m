Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEAD82B507
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 20:04:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rO0K8-0001yR-7t; Thu, 11 Jan 2024 14:02:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rO0K6-0001xh-1K
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 14:02:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rO0K4-0002Ml-I3
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 14:02:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704999755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7hLfAp79U1FIsM1rjGCyedJBUUbAxAWLgcvsVFhJeTs=;
 b=Ejj5VXwibYOPozO5J494SntUAroVEZds5VepwVthsTk3cHkr9euHR+E7AXPegH34dVrbbX
 ZMdhuHgT1DNrH5sxV37EUeNSTX+lJ3Xp/OSO8icvmgJoffusRkuV32NnwMGnkeZRvyi1lQ
 bHIXyqtiT/Hv3owLP7v4tRd7w6Z68AE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-Vv7gGK6dNamWkiOyyqEWBg-1; Thu, 11 Jan 2024 14:02:31 -0500
X-MC-Unique: Vv7gGK6dNamWkiOyyqEWBg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 584FE185A782;
 Thu, 11 Jan 2024 19:02:30 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.194.34])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8ECE6492BF0;
 Thu, 11 Jan 2024 19:02:28 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: mst@redhat.com,
	qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, Jason Wang <jasowang@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 si-wei.liu@oracle.com, Stefano Garzarella <sgarzare@redhat.com>,
 Parav Pandit <parav@mellanox.com>
Subject: [PATCH 2/6] vdpa: reorder vhost_vdpa_set_backend_cap
Date: Thu, 11 Jan 2024 20:02:18 +0100
Message-Id: <20240111190222.496695-3-eperezma@redhat.com>
In-Reply-To: <20240111190222.496695-1-eperezma@redhat.com>
References: <20240111190222.496695-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

It will be used directly by vhost_vdpa_init.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 hw/virtio/vhost-vdpa.c | 60 +++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index ddae494ca8..33ae285f87 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -580,6 +580,36 @@ static void vhost_vdpa_init_svq(struct vhost_dev *hdev, struct vhost_vdpa *v)
     v->shadow_vqs = g_steal_pointer(&shadow_vqs);
 }
 
+static int vhost_vdpa_set_backend_cap(struct vhost_dev *dev)
+{
+    struct vhost_vdpa *v = dev->opaque;
+
+    uint64_t features;
+    uint64_t f = 0x1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2 |
+        0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH |
+        0x1ULL << VHOST_BACKEND_F_IOTLB_ASID |
+        0x1ULL << VHOST_BACKEND_F_SUSPEND;
+    int r;
+
+    if (vhost_vdpa_call(dev, VHOST_GET_BACKEND_FEATURES, &features)) {
+        return -EFAULT;
+    }
+
+    features &= f;
+
+    if (vhost_vdpa_first_dev(dev)) {
+        r = vhost_vdpa_call(dev, VHOST_SET_BACKEND_FEATURES, &features);
+        if (r) {
+            return -EFAULT;
+        }
+    }
+
+    dev->backend_cap = features;
+    v->shared->backend_cap = features;
+
+    return 0;
+}
+
 static int vhost_vdpa_init(struct vhost_dev *dev, void *opaque, Error **errp)
 {
     struct vhost_vdpa *v = opaque;
@@ -827,36 +857,6 @@ static int vhost_vdpa_set_features(struct vhost_dev *dev,
     return vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_FEATURES_OK);
 }
 
-static int vhost_vdpa_set_backend_cap(struct vhost_dev *dev)
-{
-    struct vhost_vdpa *v = dev->opaque;
-
-    uint64_t features;
-    uint64_t f = 0x1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2 |
-        0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH |
-        0x1ULL << VHOST_BACKEND_F_IOTLB_ASID |
-        0x1ULL << VHOST_BACKEND_F_SUSPEND;
-    int r;
-
-    if (vhost_vdpa_call(dev, VHOST_GET_BACKEND_FEATURES, &features)) {
-        return -EFAULT;
-    }
-
-    features &= f;
-
-    if (vhost_vdpa_first_dev(dev)) {
-        r = vhost_vdpa_call(dev, VHOST_SET_BACKEND_FEATURES, &features);
-        if (r) {
-            return -EFAULT;
-        }
-    }
-
-    dev->backend_cap = features;
-    v->shared->backend_cap = features;
-
-    return 0;
-}
-
 static int vhost_vdpa_get_device_id(struct vhost_dev *dev,
                                     uint32_t *device_id)
 {
-- 
2.39.3


