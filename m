Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F028882B505
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 20:03:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rO0KG-0001zx-KT; Thu, 11 Jan 2024 14:02:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rO0KF-0001zo-2c
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 14:02:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rO0KD-0002RC-EN
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 14:02:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704999764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xfHj4a+1kkW3IuoRJ+D3rPLEa+55ok5buRdNGYoGEhQ=;
 b=cFs5RcuGJsCXX/briUVUbYdraCV1hz6xBV5fmk/P43OxGeaC4v5OCodxCoVDXY3qt0DXjL
 X2iNn2ckNaeJu5uN+LTa4u8HQMngAoaqmJccKaRTMzBciWw6J5fcDXM+xYsCeP4Lq+6SS3
 nwdZiGHon4Yh56auIvYyEi6y0PngCr8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-RWZ7LSwLOdeF1csfGnAqog-1; Thu,
 11 Jan 2024 14:02:39 -0500
X-MC-Unique: RWZ7LSwLOdeF1csfGnAqog-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DCD422999B28;
 Thu, 11 Jan 2024 19:02:38 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.194.34])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 20559492BF0;
 Thu, 11 Jan 2024 19:02:36 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: mst@redhat.com,
	qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, Jason Wang <jasowang@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 si-wei.liu@oracle.com, Stefano Garzarella <sgarzare@redhat.com>,
 Parav Pandit <parav@mellanox.com>
Subject: [PATCH 6/6] vdpa: move memory listener register to vhost_vdpa_init
Date: Thu, 11 Jan 2024 20:02:22 +0100
Message-Id: <20240111190222.496695-7-eperezma@redhat.com>
In-Reply-To: <20240111190222.496695-1-eperezma@redhat.com>
References: <20240111190222.496695-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.467,
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

Current memory operations like pinning may take a lot of time at the
destination.  Currently they are done after the source of the migration is
stopped, and before the workload is resumed at the destination.  This is a
period where neigher traffic can flow, nor the VM workload can continue
(downtime).

We can do better as we know the memory layout of the guest RAM at the
destination from the moment that all devices are initializaed.  So
moving that operation allows QEMU to communicate the kernel the maps
while the workload is still running in the source, so Linux can start
mapping them.

As a small drawback, there is a time in the initialization where QEMU
cannot respond to QMP etc.  By some testing, this time is about
0.2seconds.  This may be further reduced (or increased) depending on the
vdpa driver and the platform hardware, and it is dominated by the cost
of memory pinning.

This matches the time that we move out of the called downtime window.
The downtime is measured as checking the trace timestamp from the moment
the source suspend the device to the moment the destination starts the
eight and last virtqueue pair.  For a 39G guest, it goes from ~2.2526
secs to 2.0949.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 hw/virtio/vhost-vdpa.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 521a889104..eae8b790dd 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -660,7 +660,13 @@ static int vhost_vdpa_init(struct vhost_dev *dev, void *opaque, Error **errp)
     vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE |
                                VIRTIO_CONFIG_S_DRIVER);
 
+    /*
+     * Being optimistic and listening address space memory. If the device
+     * uses vIOMMU, it is changed at vhost_vdpa_dev_start.
+     */
     v->shared->listener = vhost_vdpa_memory_listener;
+    memory_listener_register(&v->shared->listener, &address_space_memory);
+    v->shared->listener_registered = true;
     return 0;
 }
 
@@ -1331,6 +1337,11 @@ static int vhost_vdpa_dev_start(struct vhost_dev *dev, bool started)
                          "IOMMU and try again");
             return -1;
         }
+        if (v->shared->listener_registered &&
+            dev->vdev->dma_as != v->shared->listener.address_space) {
+            memory_listener_unregister(&v->shared->listener);
+            v->shared->listener_registered = false;
+        }
         if (!v->shared->listener_registered) {
             memory_listener_register(&v->shared->listener, dev->vdev->dma_as);
             v->shared->listener_registered = true;
-- 
2.39.3


