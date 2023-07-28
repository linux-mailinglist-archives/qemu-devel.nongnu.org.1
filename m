Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AB1767566
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 20:27:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPR95-0001aY-6P; Fri, 28 Jul 2023 13:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qPR93-0001Ze-4W
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 13:20:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qPR91-00009U-MG
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 13:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690564851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SsZLuDbr8hKAlocP8fEDhU4P8chzoS8FDIBSDERk4N8=;
 b=dac8VJlrCwZPS1g2SY79U7+haZQPUl8zntI62oEK5ECEkomiQHZu7hGBLwWUH725qgrH8d
 vozb0jHmygZVaM0GfLJEdsgN8EWnHz1DoRrzt8dwcGv5JBbBGj+3kvamivktMIRN8R97Mt
 LRnaVR4XpixXz5F3lBlaVSavwthAo2A=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-682-VWUAtlpeMwq7sv7Ct-ub3Q-1; Fri, 28 Jul 2023 13:20:47 -0400
X-MC-Unique: VWUAtlpeMwq7sv7Ct-ub3Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 302543C0D84C;
 Fri, 28 Jul 2023 17:20:47 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.193.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ED9741121330;
 Fri, 28 Jul 2023 17:20:44 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Gautam Dawar <gdawar@xilinx.com>,
 si-wei.liu@oracle.com, Zhu Lingshan <lingshan.zhu@intel.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Parav Pandit <parav@mellanox.com>, Cindy Lu <lulu@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Harpreet Singh Anand <hanand@xilinx.com>,
 Laurent Vivier <lvivier@redhat.com>, Shannon Nelson <snelson@pensando.io>,
 Lei Yang <leiyang@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH 5/7] vdpa: delay enable of data vqs
Date: Fri, 28 Jul 2023 19:20:26 +0200
Message-Id: <20230728172028.2074052-6-eperezma@redhat.com>
In-Reply-To: <20230728172028.2074052-1-eperezma@redhat.com>
References: <20230728172028.2074052-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
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

To restore the device at the destination of a live migration we send
the commands through control virtqueue.  For a device to read CVQ it
must have received the DRIVER_OK status bit.

However this opens a window where the device could start receiving
packets in rx queue 0 before it receives the RSS configuration.  To
avoid that, we do not send vring_enable until all configuration is used
by the device.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
v2: Enable the dataplane vqs if cannot shadow CVQ because of device
features or ASID.
---
 net/vhost-vdpa.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 3d7dc3e5c0..2c1cfda657 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -283,6 +283,15 @@ static VhostVDPAState *vhost_vdpa_net_first_nc_vdpa(VhostVDPAState *s)
     return DO_UPCAST(VhostVDPAState, nc, nc0);
 }
 
+/** From any vdpa net client, get the netclient of the last queue pair */
+static VhostVDPAState *vhost_vdpa_net_last_nc_vdpa(VhostVDPAState *s)
+{
+    VirtIONet *n = qemu_get_nic_opaque(s->nc.peer);
+    NetClientState *nc = qemu_get_peer(n->nic->ncs, n->max_ncs - 1);
+
+    return DO_UPCAST(VhostVDPAState, nc, nc);
+}
+
 static void vhost_vdpa_net_log_global_enable(VhostVDPAState *s, bool enable)
 {
     struct vhost_vdpa *v = &s->vhost_vdpa;
@@ -996,6 +1005,13 @@ static int vhost_vdpa_net_load(NetClientState *nc)
         return r;
     }
 
+    for (int i = 0; i < v->dev->vq_index; ++i) {
+        r = vhost_vdpa_set_vring_ready(v, i);
+        if (unlikely(r)) {
+            return r;
+        }
+    }
+
     return 0;
 }
 
@@ -1255,9 +1271,35 @@ static const VhostShadowVirtqueueOps vhost_vdpa_net_svq_ops = {
     .avail_handler = vhost_vdpa_net_handle_ctrl_avail,
 };
 
+/**
+ * Check if a vhost_vdpa device should enable before DRIVER_OK
+ *
+ * CVQ must always start first if we want to restore the state safely. Do not
+ * start data vqs if the device has CVQ.
+ */
 static bool vhost_vdpa_should_enable(const struct vhost_vdpa *v)
 {
-    return true;
+    struct vhost_dev *dev = v->dev;
+    VhostVDPAState *s = container_of(v, VhostVDPAState, vhost_vdpa);
+    VhostVDPAState *cvq_s = vhost_vdpa_net_last_nc_vdpa(s);
+
+    if (!(dev->vq_index_end % 2)) {
+        /* vDPA device does not have CVQ */
+        return true;
+    }
+
+    if (dev->vq_index + 1 == dev->vq_index_end) {
+        /* We're evaluating CVQ, that must always enable first */
+        return true;
+    }
+
+    if (!vhost_vdpa_net_valid_svq_features(v->dev->features, NULL) ||
+        !cvq_s->cvq_isolated) {
+        /* CVQ is not isolated, so let's enable as usual */
+        return true;
+    }
+
+    return false;
 }
 
 static const VhostVDPAVirtIOOps vhost_vdpa_virtio_net_ops = {
-- 
2.39.3


