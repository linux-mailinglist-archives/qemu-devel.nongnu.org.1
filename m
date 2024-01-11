Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EE182B506
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 20:04:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rO0KC-0001zR-RE; Thu, 11 Jan 2024 14:02:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rO0KA-0001yt-JG
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 14:02:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rO0K8-0002Od-E3
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 14:02:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704999759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FDU5bDvjCD7qy3GlwYsAJnVVq36TVzsi9e3jkYL+vdU=;
 b=B8ROowOaM7bm4kiX58rqEeJz0jVIk/8q7phttZHX4suXzw4Uaztgoa/cUMv3eiSugK1snh
 U7qopsbFiUfl8bdgIHzxT9IbOpeFwT6w9sORzfxGcWSv9tAj1m+RlM7zPMAQPMRqMhkRsY
 j/TmqW847tkxfgs1y7apCcECV3e6kq8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-Lo9MZ2fIP_KsZNuy1evwRg-1; Thu, 11 Jan 2024 14:02:37 -0500
X-MC-Unique: Lo9MZ2fIP_KsZNuy1evwRg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CEABE811E9C;
 Thu, 11 Jan 2024 19:02:36 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.194.34])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 13785492BF0;
 Thu, 11 Jan 2024 19:02:34 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: mst@redhat.com,
	qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, Jason Wang <jasowang@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 si-wei.liu@oracle.com, Stefano Garzarella <sgarzare@redhat.com>,
 Parav Pandit <parav@mellanox.com>
Subject: [PATCH 5/6] vdpa: reorder listener assignment
Date: Thu, 11 Jan 2024 20:02:21 +0100
Message-Id: <20240111190222.496695-6-eperezma@redhat.com>
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

Since commit f6fe3e333f ("vdpa: move memory listener to
vhost_vdpa_shared") this piece of code repeatedly assign
shared->listener members.  This was not a problem as it was not used
until device start.

However next patches move the listener registration to this
vhost_vdpa_init function.  When the listener is registered it is added
to an embedded linked list, so setting its members again will cause
memory corruption to the linked list node.

Do the right thing and only set it in the first vdpa device.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 hw/virtio/vhost-vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index b08349d57c..521a889104 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -619,7 +619,6 @@ static int vhost_vdpa_init(struct vhost_dev *dev, void *opaque, Error **errp)
 
     v->dev = dev;
     dev->opaque =  opaque ;
-    v->shared->listener = vhost_vdpa_memory_listener;
 
     ret = vhost_vdpa_set_backend_cap(dev);
     if (unlikely(ret != 0)) {
@@ -661,6 +660,7 @@ static int vhost_vdpa_init(struct vhost_dev *dev, void *opaque, Error **errp)
     vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE |
                                VIRTIO_CONFIG_S_DRIVER);
 
+    v->shared->listener = vhost_vdpa_memory_listener;
     return 0;
 }
 
-- 
2.39.3


