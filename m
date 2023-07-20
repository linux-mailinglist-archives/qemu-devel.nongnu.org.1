Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 715E475B65F
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 20:16:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMYBl-00059Q-KP; Thu, 20 Jul 2023 14:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qMYBR-0004L8-UT
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 14:15:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qMYBQ-0003Lx-JC
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 14:15:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689876923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+ytfb3HXV+wFwSIUmTNAnsUHTHuXBYfLCvZ0GHbLF5w=;
 b=ijUGZ9Pc19Q8ABUrYNU8psEVXzZzCJI7ZvSdO1AgtBZ1VpIoxiptJb14x2/waq4NazacCB
 MDPmrojVfJLSC2i2ALiW9kpyBgGrtlQdmXhoZFTckl6ytzxEjgeNfWwuZaE+Ofjx1DGdE+
 warKu/aCorz4gJRKepCgBi7aG0Zgmy8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-372-di8aBrTNMa6DgL5B80uODA-1; Thu, 20 Jul 2023 14:15:18 -0400
X-MC-Unique: di8aBrTNMa6DgL5B80uODA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8CFAC88D196;
 Thu, 20 Jul 2023 18:15:17 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.193.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3A7222166B25;
 Thu, 20 Jul 2023 18:15:16 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: yvugenfi@redhat.com,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 si-wei.liu@oracle.com, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Shannon Nelson <snelson@pensando.io>
Subject: [RFC PATCH 09/12] vdpa: add vhost_vdpa_restart_queue
Date: Thu, 20 Jul 2023 20:14:56 +0200
Message-Id: <20230720181459.607008-10-eperezma@redhat.com>
In-Reply-To: <20230720181459.607008-1-eperezma@redhat.com>
References: <20230720181459.607008-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

Split out vq restart operation in its own function, as it may be called
with ring reset.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 hw/virtio/vhost-vdpa.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 7248072989..7b24fa3e12 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -562,6 +562,29 @@ static void vhost_vdpa_reset_queue(struct vhost_dev *dev, int idx)
     }
 }
 
+/* TODO: Properly reorder static functions */
+static bool vhost_vdpa_svq_start(struct vhost_dev *dev, unsigned i,
+                                 Error **errp);
+static int vhost_vdpa_restart_queue(struct vhost_dev *dev, int idx)
+{
+    struct vhost_vdpa *v = dev->opaque;
+
+    if (v->shadow_vqs_enabled) {
+        Error *err = NULL;
+        bool ok = vhost_vdpa_svq_start(dev, idx, &err);
+        if (unlikely(!ok)) {
+            error_report_err(err);
+            return -1;
+        }
+    }
+
+    if (dev->features & VIRTIO_F_RING_RESET) {
+        return vhost_vdpa_set_vring_ready_internal(v, idx, true);
+    }
+
+    return 0;
+}
+
 /*
  * The use of this function is for requests that only need to be
  * applied once. Typically such request occurs at the beginning
@@ -1574,4 +1597,5 @@ const VhostOps vdpa_ops = {
         .vhost_set_config_call = vhost_vdpa_set_config_call,
         .vhost_reset_status = vhost_vdpa_reset_status,
         .vhost_reset_queue = vhost_vdpa_reset_queue,
+        .vhost_restart_queue = vhost_vdpa_restart_queue,
 };
-- 
2.39.3


