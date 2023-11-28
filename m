Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E50EE7FB854
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 11:45:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7vYt-0006lu-6d; Tue, 28 Nov 2023 05:43:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1r7vYr-0006l5-8B
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 05:43:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1r7vYo-0005f0-SQ
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 05:43:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701168201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6D5rlfw7G1yLNiSv7CgLqkOdOD7ElVEtb3VUVH2sVwA=;
 b=WPc2DBjcBiSxkjeqmQYOikD9HP/JXaCm0D9UMdy8HnU76QyH88RJebhQU2eiCjpLB2A88t
 B57waV/18TUVmf/26Ka4pok08CehDd9E+4/qjJlKZBgzlJwVF7KYNWNZurBRm0r8iEDO3t
 6V19Rqe+mJ0yNajDn65eH7b3z6wX/5g=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-y85cGbMBN0CnvmCWgQlIUA-1; Tue,
 28 Nov 2023 05:43:15 -0500
X-MC-Unique: y85cGbMBN0CnvmCWgQlIUA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5F54B1C0512B;
 Tue, 28 Nov 2023 10:43:15 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.193.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1DCD320268D7;
 Tue, 28 Nov 2023 10:43:12 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gautam Dawar <gdawar@xilinx.com>, Jason Wang <jasowang@redhat.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, yin31149@gmail.com,
 Shannon Nelson <shannon.nelson@amd.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Yajun Wu <yajunw@nvidia.com>,
 Juan Quintela <quintela@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Parav Pandit <parav@mellanox.com>, Lei Yang <leiyang@redhat.com>,
 si-wei.liu@oracle.com
Subject: [RFC PATCH v2 03/10] vdpa: merge _begin_batch into _batch_begin_once
Date: Tue, 28 Nov 2023 11:42:56 +0100
Message-Id: <20231128104303.3314000-4-eperezma@redhat.com>
In-Reply-To: <20231128104303.3314000-1-eperezma@redhat.com>
References: <20231128104303.3314000-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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

There was only one call.  This way we can make the begin and end of the
batch symmetrical.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 hw/virtio/vhost-vdpa.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index bf9771870a..a533fc5bc7 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -143,7 +143,7 @@ int vhost_vdpa_dma_unmap(VhostVDPAShared *s, uint32_t asid, hwaddr iova,
     return ret;
 }
 
-static void vhost_vdpa_listener_begin_batch(VhostVDPAShared *s)
+static void vhost_vdpa_iotlb_batch_begin_once(VhostVDPAShared *s)
 {
     int fd = s->device_fd;
     struct vhost_msg_v2 msg = {
@@ -151,21 +151,16 @@ static void vhost_vdpa_listener_begin_batch(VhostVDPAShared *s)
         .iotlb.type = VHOST_IOTLB_BATCH_BEGIN,
     };
 
-    trace_vhost_vdpa_listener_begin_batch(s, fd, msg.type, msg.iotlb.type);
-    if (write(fd, &msg, sizeof(msg)) != sizeof(msg)) {
-        error_report("failed to write, fd=%d, errno=%d (%s)",
-                     fd, errno, strerror(errno));
-    }
-}
-
-static void vhost_vdpa_iotlb_batch_begin_once(VhostVDPAShared *s)
-{
     if (!(s->backend_cap & (0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH)) ||
         s->iotlb_batch_begin_sent) {
         return;
     }
 
-    vhost_vdpa_listener_begin_batch(s);
+    trace_vhost_vdpa_listener_begin_batch(s, fd, msg.type, msg.iotlb.type);
+    if (write(fd, &msg, sizeof(msg)) != sizeof(msg)) {
+        error_report("failed to write, fd=%d, errno=%d (%s)",
+                     fd, errno, strerror(errno));
+    }
     s->iotlb_batch_begin_sent = true;
 }
 
-- 
2.39.3


