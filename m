Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F369974A448
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 21:14:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHUPN-00066B-L7; Thu, 06 Jul 2023 15:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qHUPL-00065N-GN
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 15:12:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qHUPJ-0003it-Uf
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 15:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688670769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WZ0T9Bj7ivsWGJG0O+gF5mf9U2T53/pSkGsxT8Ys2kQ=;
 b=TggXe6CH34RnY5r0I2YYqSWprQIS0XT8fb8BlLPRnebO4aJeLFX3UhYiOw+Ph+ZZkwgL7H
 OPdtaWTRLZKl2/xSxWXydnFuM/+29AoMS8iSP+QUjlr8xXp9dHlUIzdH845Y2kqF3yau+w
 7+aqdmODwG8PMNfH5mB0XHJsr7TRPzg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-250-9lz0WDnDNWq3RbPewj_Wkw-1; Thu, 06 Jul 2023 15:12:43 -0400
X-MC-Unique: 9lz0WDnDNWq3RbPewj_Wkw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 43FF7104458E;
 Thu,  6 Jul 2023 19:12:43 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.194.147])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2789D4087C6A;
 Thu,  6 Jul 2023 19:12:41 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cindy Lu <lulu@redhat.com>, si-wei.liu@oracle.com,
 Stefano Garzarella <sgarzare@redhat.com>,
 Shannon Nelson <snelson@pensando.io>, Gautam Dawar <gdawar@xilinx.com>,
 Jason Wang <jasowang@redhat.com>, Harpreet Singh Anand <hanand@xilinx.com>,
 Parav Pandit <parav@mellanox.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, Lei Yang <leiyang@redhat.com>
Subject: [RFC PATCH 5/6] vdpa: delay enable of data vqs
Date: Thu,  6 Jul 2023 21:12:26 +0200
Message-Id: <20230706191227.835526-6-eperezma@redhat.com>
In-Reply-To: <20230706191227.835526-1-eperezma@redhat.com>
References: <20230706191227.835526-1-eperezma@redhat.com>
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
 net/vhost-vdpa.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 536bab8613..d5970e9f06 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -739,6 +739,13 @@ static int vhost_vdpa_net_load(NetClientState *nc)
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
 
@@ -826,9 +833,25 @@ static const VhostShadowVirtqueueOps vhost_vdpa_net_svq_ops = {
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
+
+    if (!dev->vq_index_end % 2) {
+        /* vDPA device does not have CVQ */
+        return true;
+    }
+
+    /*
+     * We're evaluating CVQ, enable to send control cmds to load device state.
+     */
+    return dev->vq_index + 1 == dev->vq_index_end;
 }
 
 static const VhostVDPAVirtIOOps vhost_vdpa_virtio_net_ops = {
-- 
2.39.3


