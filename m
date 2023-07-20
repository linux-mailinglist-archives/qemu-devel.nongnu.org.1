Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A0175B667
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 20:17:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMYBj-0004pV-CQ; Thu, 20 Jul 2023 14:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qMYBN-0004F2-SE
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 14:15:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qMYBM-0003LK-E2
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 14:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689876919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ojGrOHq8nhRb5TNbtbaXmRffqo/08cKoEX9WwfmfcUE=;
 b=LwxFFWI/gPstGvbyClDPgreBl3s+XWIwXBRatvtwSH/N3IwtjFIFCRSxv7vqvTm5rHchcx
 J5Z5BhMr1LxZ5IKa2EhAb2gNZ4OvfGzFbcClPvT3aOWoJayg4PUHQ3yGHHNAlD3RYp4C3H
 7lsLM3Bsf1573+Ze/TSO9l/BCnLy9GQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-615-9ICOeEUwMuqzd8UeYcsh0Q-1; Thu, 20 Jul 2023 14:15:16 -0400
X-MC-Unique: 9ICOeEUwMuqzd8UeYcsh0Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F19EC800C7F;
 Thu, 20 Jul 2023 18:15:15 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.193.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A081E2166B26;
 Thu, 20 Jul 2023 18:15:14 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: yvugenfi@redhat.com,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 si-wei.liu@oracle.com, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Shannon Nelson <snelson@pensando.io>
Subject: [RFC PATCH 08/12] vdpa: add vhost_vdpa_svq_start
Date: Thu, 20 Jul 2023 20:14:55 +0200
Message-Id: <20230720181459.607008-9-eperezma@redhat.com>
In-Reply-To: <20230720181459.607008-1-eperezma@redhat.com>
References: <20230720181459.607008-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

To split each SVQ in its own initialization routine let's us to restart
a VQ individually, and to keep future vhost_vdpa_restart_queue
symmetrical with vhost_vdpa_reset_queue.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 hw/virtio/vhost-vdpa.c | 67 ++++++++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 26 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index df2515a247..7248072989 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -1223,6 +1223,46 @@ static bool vhost_vdpa_svq_setup(struct vhost_dev *dev,
     return r == 0;
 }
 
+static bool vhost_vdpa_svq_start(struct vhost_dev *dev, unsigned i,
+                                 Error **errp)
+{
+    struct vhost_vdpa *v = dev->opaque;
+    VirtQueue *vq = virtio_get_queue(dev->vdev, dev->vq_index + i);
+    VhostShadowVirtqueue *svq = g_ptr_array_index(v->shadow_vqs, i);
+    struct vhost_vring_addr addr = {
+        .index = dev->vq_index + i,
+    };
+    int r;
+    bool ok = vhost_vdpa_svq_setup(dev, svq, i, errp);
+    if (unlikely(!ok)) {
+        goto err;
+    }
+
+    vhost_svq_start(svq, dev->vdev, vq, v->iova_tree);
+    ok = vhost_vdpa_svq_map_rings(dev, svq, &addr, errp);
+    if (unlikely(!ok)) {
+        goto err_map;
+    }
+
+    /* Override vring GPA set by vhost subsystem */
+    r = vhost_vdpa_set_vring_dev_addr(dev, &addr);
+    if (unlikely(r != 0)) {
+        error_setg_errno(errp, -r, "Cannot set device address");
+        goto err_set_addr;
+    }
+
+    return true;
+
+err_set_addr:
+    vhost_vdpa_svq_unmap_rings(dev, g_ptr_array_index(v->shadow_vqs, i));
+
+err_map:
+    vhost_svq_stop(g_ptr_array_index(v->shadow_vqs, i));
+
+err:
+    return false;
+}
+
 static bool vhost_vdpa_svqs_start(struct vhost_dev *dev)
 {
     struct vhost_vdpa *v = dev->opaque;
@@ -1234,39 +1274,14 @@ static bool vhost_vdpa_svqs_start(struct vhost_dev *dev)
     }
 
     for (i = 0; i < v->shadow_vqs->len; ++i) {
-        VirtQueue *vq = virtio_get_queue(dev->vdev, dev->vq_index + i);
-        VhostShadowVirtqueue *svq = g_ptr_array_index(v->shadow_vqs, i);
-        struct vhost_vring_addr addr = {
-            .index = dev->vq_index + i,
-        };
-        int r;
-        bool ok = vhost_vdpa_svq_setup(dev, svq, i, &err);
+        bool ok = vhost_vdpa_svq_start(dev, i, &err);
         if (unlikely(!ok)) {
             goto err;
         }
-
-        vhost_svq_start(svq, dev->vdev, vq, v->iova_tree);
-        ok = vhost_vdpa_svq_map_rings(dev, svq, &addr, &err);
-        if (unlikely(!ok)) {
-            goto err_map;
-        }
-
-        /* Override vring GPA set by vhost subsystem */
-        r = vhost_vdpa_set_vring_dev_addr(dev, &addr);
-        if (unlikely(r != 0)) {
-            error_setg_errno(&err, -r, "Cannot set device address");
-            goto err_set_addr;
-        }
     }
 
     return true;
 
-err_set_addr:
-    vhost_vdpa_svq_unmap_rings(dev, g_ptr_array_index(v->shadow_vqs, i));
-
-err_map:
-    vhost_svq_stop(g_ptr_array_index(v->shadow_vqs, i));
-
 err:
     error_reportf_err(err, "Cannot setup SVQ %u: ", i);
     for (unsigned j = 0; j < i; ++j) {
-- 
2.39.3


