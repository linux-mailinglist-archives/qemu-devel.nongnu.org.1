Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF9B7673A4
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 19:42:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPR8w-0001Np-Qn; Fri, 28 Jul 2023 13:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qPR8u-0001N9-BX
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 13:20:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qPR8t-0008NU-0t
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 13:20:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690564842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s1mv7uzcPXcJ81XaXK92RJXYFUYLlxlqghXDFZnxUMI=;
 b=T2hQhqckcpgHr3NWyKQsoAjXPKEOizNpivKdZRpXGAHNljmj3f32ByCrf0KG0KrSeG95ZU
 zrACnM/0lZshqF0Hls3De0uRxmu5hRlAHfqz28F75Xo84tkqr3F9ailL3FNgZI6w7TK8b6
 C/o57CEAb2Z14ffvu/ghdUQLA3yAPwY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-552-Q4i4enrrM5OeHy9A3OZL2A-1; Fri, 28 Jul 2023 13:20:38 -0400
X-MC-Unique: Q4i4enrrM5OeHy9A3OZL2A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0EA3F858EED;
 Fri, 28 Jul 2023 17:20:38 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.193.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C97DC1121330;
 Fri, 28 Jul 2023 17:20:35 +0000 (UTC)
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
Subject: [PATCH 2/7] vdpa: add should_enable op
Date: Fri, 28 Jul 2023 19:20:23 +0200
Message-Id: <20230728172028.2074052-3-eperezma@redhat.com>
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

To restore the device at the destination of a live migration we send the
commands through control virtqueue.  For a device to read CVQ it must
have received the DRIVER_OK status bit.

However this opens a window where the device could start receiving
packets in rx queue 0 before it receives the RSS configuration.  To
avoid that, we will not send vring_enable until all configuration is
used by the device.

As a first step, enable a new vitio ops per vhost_vdpa device to know if
we should enable a virtqueue or not.  This srtuct can be reused in the
future to add more actions to vhost_vdpa that depend on the virtIO kind
of device.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 include/hw/virtio/vhost-vdpa.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
index 5407d54fd7..3d330d439a 100644
--- a/include/hw/virtio/vhost-vdpa.h
+++ b/include/hw/virtio/vhost-vdpa.h
@@ -30,6 +30,13 @@ typedef struct VhostVDPAHostNotifier {
     void *addr;
 } VhostVDPAHostNotifier;
 
+struct vhost_vdpa;
+typedef bool (*vhost_vdpa_virtio_should_enable_op)(const struct vhost_vdpa *v);
+
+typedef struct VhostVDPAVirtIOOps {
+    vhost_vdpa_virtio_should_enable_op should_enable;
+} VhostVDPAVirtIOOps;
+
 typedef struct vhost_vdpa {
     int device_fd;
     int index;
@@ -48,6 +55,7 @@ typedef struct vhost_vdpa {
     VhostIOVATree *iova_tree;
     GPtrArray *shadow_vqs;
     const VhostShadowVirtqueueOps *shadow_vq_ops;
+    const VhostVDPAVirtIOOps *virtio_ops;
     void *shadow_vq_ops_opaque;
     struct vhost_dev *dev;
     Error *migration_blocker;
-- 
2.39.3


