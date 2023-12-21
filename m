Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D856F81B560
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 12:55:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGHco-0008VW-19; Thu, 21 Dec 2023 06:54:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rGHck-0008NE-8N
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 06:53:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rGHci-00084G-Mc
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 06:53:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703159636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sST+tbW3FDPrDUDc3xV+1NvvJGBb56HBn5rBJaKRGNE=;
 b=g9Jzw0zyVj8EMOi2dRmgO6S8I6l2vhtk6RXQ45Kc27dh849+SQCXZL2Oe7hA/MHSQm9T6m
 X2jK+WR2LrX0SY/sBca/e/l6fAbTYxd4FEMRXBw0cj8O7+AioH6mSQEfoUeWqozucMun/O
 nlrjFy7w5TSKYGfTnIfX1/Dxkcr9AGw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-oIu6j0OVNsCMaU1igCq2aA-1; Thu,
 21 Dec 2023 06:53:52 -0500
X-MC-Unique: oIu6j0OVNsCMaU1igCq2aA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 509763C000B4;
 Thu, 21 Dec 2023 11:53:52 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.193.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 809B140C6EB9;
 Thu, 21 Dec 2023 11:53:50 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Parav Pandit <parav@mellanox.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>,
 si-wei.liu@oracle.com, Zhu Lingshan <lingshan.zhu@intel.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v3 13/14] vdpa: factor out vhost_vdpa_last_dev
Date: Thu, 21 Dec 2023 12:53:18 +0100
Message-Id: <20231221115319.3067586-14-eperezma@redhat.com>
In-Reply-To: <20231221115319.3067586-1-eperezma@redhat.com>
References: <20231221115319.3067586-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
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

From: Si-Wei Liu <si-wei.liu@oracle.com>

Generalize duplicated condition check for the last vq of vdpa
device to a common function.

This is used in next patches.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
---
v3: Cherry-picked from Si-Wei's series
---
 hw/virtio/vhost-vdpa.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 61553ad196..a846abccb0 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -557,6 +557,11 @@ static bool vhost_vdpa_first_dev(struct vhost_dev *dev)
     return v->index == 0;
 }
 
+static bool vhost_vdpa_last_dev(struct vhost_dev *dev)
+{
+    return dev->vq_index + dev->nvqs == dev->vq_index_end;
+}
+
 static int vhost_vdpa_get_dev_features(struct vhost_dev *dev,
                                        uint64_t *features)
 {
@@ -1317,7 +1322,7 @@ static int vhost_vdpa_dev_start(struct vhost_dev *dev, bool started)
         vhost_vdpa_host_notifiers_uninit(dev, dev->nvqs);
     }
 
-    if (dev->vq_index + dev->nvqs != dev->vq_index_end) {
+    if (!vhost_vdpa_last_dev(dev)) {
         return 0;
     }
 
@@ -1339,7 +1344,7 @@ static void vhost_vdpa_reset_status(struct vhost_dev *dev)
 {
     struct vhost_vdpa *v = dev->opaque;
 
-    if (dev->vq_index + dev->nvqs != dev->vq_index_end) {
+    if (!vhost_vdpa_last_dev(dev)) {
         return;
     }
 
-- 
2.39.3


