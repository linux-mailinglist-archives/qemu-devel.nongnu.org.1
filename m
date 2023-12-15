Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C450C814EB2
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 18:30:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEBzS-0005y4-TR; Fri, 15 Dec 2023 12:28:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rEBzR-0005xc-Fo
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 12:28:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rEBzQ-00011x-25
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 12:28:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702661323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=czRuS48Nn1k6ylS+U5+ONFWw9urqtIfLEQqVSIBrLjc=;
 b=PqpsDcIROmIdTyroSfjrmekUYxBpL/mwCFafdI1UNV8cvYRHnLPg+fzrGbMhtP8YN7cI0e
 poWyCGaxxIIEv5wGD/SbnF8ZZpG7MbtPaV1VteGywq7HOrqW4NhmCPgzO9qWckkuDvBC59
 PRq++iVgFhlklzf8RMkaAwUY0SBn/00=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-PVbof7ltPvGRCHTPRctmxA-1; Fri, 15 Dec 2023 12:28:41 -0500
X-MC-Unique: PVbof7ltPvGRCHTPRctmxA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F55286EB20;
 Fri, 15 Dec 2023 17:28:41 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.194.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A7C3440C6EB9;
 Fri, 15 Dec 2023 17:28:39 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, si-wei.liu@oracle.com,
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, Parav Pandit <parav@mellanox.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH for 9.0 04/12] vdpa: extract out _dma_end_batch from
 _listener_commit
Date: Fri, 15 Dec 2023 18:28:22 +0100
Message-Id: <20231215172830.2540987-5-eperezma@redhat.com>
In-Reply-To: <20231215172830.2540987-1-eperezma@redhat.com>
References: <20231215172830.2540987-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
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

So we can call out vhost_vdpa_dma_end_batch out of the listener
callbacks.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 hw/virtio/vhost-vdpa.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index a533fc5bc7..57a8043cd4 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -164,9 +164,8 @@ static void vhost_vdpa_iotlb_batch_begin_once(VhostVDPAShared *s)
     s->iotlb_batch_begin_sent = true;
 }
 
-static void vhost_vdpa_listener_commit(MemoryListener *listener)
+static void vhost_vdpa_dma_end_batch(VhostVDPAShared *s)
 {
-    VhostVDPAShared *s = container_of(listener, VhostVDPAShared, listener);
     struct vhost_msg_v2 msg = {};
     int fd = s->device_fd;
 
@@ -190,6 +189,13 @@ static void vhost_vdpa_listener_commit(MemoryListener *listener)
     s->iotlb_batch_begin_sent = false;
 }
 
+static void vhost_vdpa_listener_commit(MemoryListener *listener)
+{
+    VhostVDPAShared *s = container_of(listener, VhostVDPAShared, listener);
+
+    vhost_vdpa_dma_end_batch(s);
+}
+
 static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
 {
     struct vdpa_iommu *iommu = container_of(n, struct vdpa_iommu, n);
-- 
2.39.3


