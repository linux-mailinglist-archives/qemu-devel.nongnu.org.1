Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBFD82B4FF
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 20:03:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rO0K9-0001yZ-0o; Thu, 11 Jan 2024 14:02:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rO0K7-0001y5-1D
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 14:02:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rO0K5-0002NJ-AL
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 14:02:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704999756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZNYtP0/fqUQrbz1uancjxE/XlEOpkN/LmQB3y+vqoIQ=;
 b=B2ja8fD9k4WUgXeAWGLtCskCwCzGdBFhwL0c2w+7rReH8V85WbMeXYZkQk+IppEdKzcCpG
 rodEs36IOlgBYPk0Bv1t4G//eOKWGJDtDUnSh7P9Ak4X0EUkUQw/4tUXbM8DLxraVLoG5g
 Mcd8uQcvBWGvpwoA1ZzGH/DB6j7HQNo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-AeBOwCZUP_O5KmmZjDJ-mQ-1; Thu, 11 Jan 2024 14:02:32 -0500
X-MC-Unique: AeBOwCZUP_O5KmmZjDJ-mQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 63B8C85A58A;
 Thu, 11 Jan 2024 19:02:32 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.194.34])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9BE65492C25;
 Thu, 11 Jan 2024 19:02:30 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: mst@redhat.com,
	qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, Jason Wang <jasowang@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 si-wei.liu@oracle.com, Stefano Garzarella <sgarzare@redhat.com>,
 Parav Pandit <parav@mellanox.com>
Subject: [PATCH 3/6] vdpa: set backend capabilities at vhost_vdpa_init
Date: Thu, 11 Jan 2024 20:02:19 +0100
Message-Id: <20240111190222.496695-4-eperezma@redhat.com>
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

The backend does not reset them until the vdpa file descriptor is closed
so there is no harm in doing it only once.

This allows the destination of a live migration to premap memory in
batches, using VHOST_BACKEND_F_IOTLB_BATCH.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 hw/virtio/vhost-vdpa.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 33ae285f87..bd4db7ba5f 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -620,6 +620,12 @@ static int vhost_vdpa_init(struct vhost_dev *dev, void *opaque, Error **errp)
     v->dev = dev;
     dev->opaque =  opaque ;
     v->shared->listener = vhost_vdpa_memory_listener;
+
+    ret = vhost_vdpa_set_backend_cap(dev);
+    if (unlikely(ret != 0)) {
+        return ret;
+    }
+
     vhost_vdpa_init_svq(dev, v);
 
     error_propagate(&dev->migration_blocker, v->migration_blocker);
@@ -1506,7 +1512,6 @@ const VhostOps vdpa_ops = {
         .vhost_set_vring_kick = vhost_vdpa_set_vring_kick,
         .vhost_set_vring_call = vhost_vdpa_set_vring_call,
         .vhost_get_features = vhost_vdpa_get_features,
-        .vhost_set_backend_cap = vhost_vdpa_set_backend_cap,
         .vhost_set_owner = vhost_vdpa_set_owner,
         .vhost_set_vring_endian = NULL,
         .vhost_backend_memslots_limit = vhost_vdpa_memslots_limit,
-- 
2.39.3


