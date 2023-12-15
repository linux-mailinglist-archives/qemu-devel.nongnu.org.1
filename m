Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 422C0814EB5
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 18:30:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEBzY-00060o-4S; Fri, 15 Dec 2023 12:28:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rEBzW-00060J-8B
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 12:28:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rEBzU-00012T-Tx
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 12:28:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702661328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A8WueJS/E1fA/bzQAcF/yF24VB8sgCLQokVl1j8eJtk=;
 b=OEZie9zeBqC5wlOi1RlqhEZ3+RadD5bUUOfpSwfG8brHMwV3+z2lsV5q7aL+HxIaZFefIn
 FG177o7hpOPvpvYIUelqJ/D+rnEScvwKiIxju0OpBDJeYAVt7Xy86TO3TZXbqapbM5TGRm
 L+cYujha9FuOux9IUHp13UMSDOa6pMU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-hbd6RSiPO66HHEHjmgzzyw-1; Fri,
 15 Dec 2023 12:28:43 -0500
X-MC-Unique: hbd6RSiPO66HHEHjmgzzyw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 32F5D3C00095;
 Fri, 15 Dec 2023 17:28:43 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.194.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8D01340C6EB9;
 Fri, 15 Dec 2023 17:28:41 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, si-wei.liu@oracle.com,
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, Parav Pandit <parav@mellanox.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH for 9.0 05/12] vdpa: factor out stop path of
 vhost_vdpa_dev_start
Date: Fri, 15 Dec 2023 18:28:23 +0100
Message-Id: <20231215172830.2540987-6-eperezma@redhat.com>
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

This makes easier to build an error path in next patches.  No functional
change.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 hw/virtio/vhost-vdpa.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 57a8043cd4..449c3794b2 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -1302,7 +1302,7 @@ static void vhost_vdpa_suspend(struct vhost_dev *dev)
 static int vhost_vdpa_dev_start(struct vhost_dev *dev, bool started)
 {
     struct vhost_vdpa *v = dev->opaque;
-    bool ok;
+    bool ok = true;
     trace_vhost_vdpa_dev_start(dev, started);
 
     if (started) {
@@ -1313,8 +1313,7 @@ static int vhost_vdpa_dev_start(struct vhost_dev *dev, bool started)
         }
     } else {
         vhost_vdpa_suspend(dev);
-        vhost_vdpa_svqs_stop(dev);
-        vhost_vdpa_host_notifiers_uninit(dev, dev->nvqs);
+        goto out_stop;
     }
 
     if (dev->vq_index + dev->nvqs != dev->vq_index_end) {
@@ -1333,6 +1332,11 @@ static int vhost_vdpa_dev_start(struct vhost_dev *dev, bool started)
     }
 
     return 0;
+
+out_stop:
+    vhost_vdpa_svqs_stop(dev);
+    vhost_vdpa_host_notifiers_uninit(dev, dev->nvqs);
+    return ok ? 0 : -1;
 }
 
 static void vhost_vdpa_reset_status(struct vhost_dev *dev)
-- 
2.39.3


