Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA690777C69
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 17:39:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU7iI-00055z-KF; Thu, 10 Aug 2023 11:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qU7iG-00055c-NK
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:36:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qU7iF-0003CQ-3h
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691681794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WNVUvpHBzotemAEuS8na0aByC9CkegdzAT8J+NHfIyQ=;
 b=IV5BC99SWXPU8LwfdIgurt+Ibz7gA9wcu90qRR2DioK2G2Qik8xN1bFrnmdzbApvHLmt+Y
 peeggniee2w6iibiAziS0Sm9OLeT8MCDLXnAKqJbZc9o79VZalvNQPtRjSmfwhIcOKQ2P4
 6bjGl/f4gcPhU5WBuG9yPpGt8u2GVo8=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-ryYJZzT8MMGrBESym-RNYA-1; Thu, 10 Aug 2023 11:36:32 -0400
X-MC-Unique: ryYJZzT8MMGrBESym-RNYA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2AF7B38012EB;
 Thu, 10 Aug 2023 15:36:32 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.194.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8C29B2166B25;
 Thu, 10 Aug 2023 15:36:29 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 si-wei.liu@oracle.com, Parav Pandit <parav@mellanox.com>,
 Gautam Dawar <gdawar@xilinx.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>,
 Harpreet Singh Anand <hanand@xilinx.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Hawkins Jiawei <yin31149@gmail.com>, Shannon Nelson <snelson@pensando.io>,
 Lei Yang <leiyang@redhat.com>
Subject: [PATCH v2 4/5] vdpa: move vhost_vdpa_set_vrings_ready to the caller
Date: Thu, 10 Aug 2023 17:36:10 +0200
Message-Id: <20230810153611.3410882-5-eperezma@redhat.com>
In-Reply-To: <20230810153611.3410882-1-eperezma@redhat.com>
References: <20230810153611.3410882-1-eperezma@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Doing that way allows CVQ to be enabled before the dataplane vqs,
restoring the state as MQ or MAC addresses properly in the case of a
migration.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 hw/virtio/vdpa-dev.c   |  3 +++
 hw/virtio/vhost-vdpa.c |  3 ---
 net/vhost-vdpa.c       | 57 +++++++++++++++++++++++++++++-------------
 3 files changed, 42 insertions(+), 21 deletions(-)

diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
index 363b625243..f22d5d5bc0 100644
--- a/hw/virtio/vdpa-dev.c
+++ b/hw/virtio/vdpa-dev.c
@@ -255,6 +255,9 @@ static int vhost_vdpa_device_start(VirtIODevice *vdev, Error **errp)
         error_setg_errno(errp, -ret, "Error starting vhost");
         goto err_guest_notifiers;
     }
+    for (i = 0; i < s->dev.nvqs; ++i) {
+        vhost_vdpa_set_vring_ready(&s->vdpa, i);
+    }
     s->started = true;
 
     /*
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 0d9975b5b5..8ca2e3800c 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -1297,9 +1297,6 @@ static int vhost_vdpa_dev_start(struct vhost_dev *dev, bool started)
         if (unlikely(!ok)) {
             return -1;
         }
-        for (int i = 0; i < dev->nvqs; ++i) {
-            vhost_vdpa_set_vring_ready(v, dev->vq_index + i);
-        }
     } else {
         vhost_vdpa_suspend(dev);
         vhost_vdpa_svqs_stop(dev);
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 9251351b4b..3bf60f9431 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -371,6 +371,22 @@ static int vhost_vdpa_net_data_start(NetClientState *nc)
     return 0;
 }
 
+static int vhost_vdpa_net_data_load(NetClientState *nc)
+{
+    VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
+    struct vhost_vdpa *v = &s->vhost_vdpa;
+    bool has_cvq = v->dev->vq_index_end % 2;
+
+    if (has_cvq) {
+        return 0;
+    }
+
+    for (int i = 0; i < v->dev->nvqs; ++i) {
+        vhost_vdpa_set_vring_ready(v, i + v->dev->vq_index);
+    }
+    return 0;
+}
+
 static void vhost_vdpa_net_client_stop(NetClientState *nc)
 {
     VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
@@ -393,6 +409,7 @@ static NetClientInfo net_vhost_vdpa_info = {
         .size = sizeof(VhostVDPAState),
         .receive = vhost_vdpa_receive,
         .start = vhost_vdpa_net_data_start,
+        .load = vhost_vdpa_net_data_load,
         .stop = vhost_vdpa_net_client_stop,
         .cleanup = vhost_vdpa_cleanup,
         .has_vnet_hdr = vhost_vdpa_has_vnet_hdr,
@@ -974,26 +991,30 @@ static int vhost_vdpa_net_cvq_load(NetClientState *nc)
 
     assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
 
-    if (!v->shadow_vqs_enabled) {
-        return 0;
-    }
+    vhost_vdpa_set_vring_ready(v, v->dev->vq_index);
 
-    n = VIRTIO_NET(v->dev->vdev);
-    r = vhost_vdpa_net_load_mac(s, n);
-    if (unlikely(r < 0)) {
-        return r;
-    }
-    r = vhost_vdpa_net_load_mq(s, n);
-    if (unlikely(r)) {
-        return r;
-    }
-    r = vhost_vdpa_net_load_offloads(s, n);
-    if (unlikely(r)) {
-        return r;
+    if (v->shadow_vqs_enabled) {
+        n = VIRTIO_NET(v->dev->vdev);
+        r = vhost_vdpa_net_load_mac(s, n);
+        if (unlikely(r < 0)) {
+            return r;
+        }
+        r = vhost_vdpa_net_load_mq(s, n);
+        if (unlikely(r)) {
+            return r;
+        }
+        r = vhost_vdpa_net_load_offloads(s, n);
+        if (unlikely(r)) {
+            return r;
+        }
+        r = vhost_vdpa_net_load_rx(s, n);
+        if (unlikely(r)) {
+            return r;
+        }
     }
-    r = vhost_vdpa_net_load_rx(s, n);
-    if (unlikely(r)) {
-        return r;
+
+    for (int i = 0; i < v->dev->vq_index; ++i) {
+        vhost_vdpa_set_vring_ready(v, i);
     }
 
     return 0;
-- 
2.39.3


