Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9BD7673A2
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 19:41:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPR90-0001X9-2n; Fri, 28 Jul 2023 13:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qPR8x-0001PH-Tj
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 13:20:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qPR8w-0008OU-KI
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 13:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690564846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fJnf01bbsUf53Izrt6GXdJzd9ID7pODZMAOQ02cP6nc=;
 b=RgangJO+ouG9UUZpsws2SaADqS3V2UrAPOLgGgB6ACylku+pB0qJCU6oWslbQB2CLSZdqh
 TUIThYWqe6LfKE2oZzOg71ju1JLG4BrCZnyXawPXsMYun7yf7Z7WbkMjyVy7uva9PeJRF/
 8cV74g0e5BxHL9tit1tkuolX7B23nE0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-487-qhkVz3lDO8ailwr81Z_qRQ-1; Fri, 28 Jul 2023 13:20:42 -0400
X-MC-Unique: qhkVz3lDO8ailwr81Z_qRQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 355E6805C3F;
 Fri, 28 Jul 2023 17:20:42 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.193.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4EBB11121330;
 Fri, 28 Jul 2023 17:20:38 +0000 (UTC)
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
Subject: [PATCH 3/7] vdpa: use virtio_ops->should_enable at
 vhost_vdpa_set_vrings_ready
Date: Fri, 28 Jul 2023 19:20:24 +0200
Message-Id: <20230728172028.2074052-4-eperezma@redhat.com>
In-Reply-To: <20230728172028.2074052-1-eperezma@redhat.com>
References: <20230728172028.2074052-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

This allow to skip some rings that qemu does not want to enable.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 hw/virtio/vhost-vdpa.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index bebcc9fe7c..1281502a71 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -896,6 +896,11 @@ static int vhost_vdpa_set_vrings_ready(struct vhost_dev *dev)
 
     assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_VDPA);
 
+    if (v->virtio_ops && v->virtio_ops->should_enable
+        && !(v->virtio_ops->should_enable(v))) {
+        return 0;
+    }
+
     for (i = 0; i < dev->nvqs; ++i) {
         vhost_vdpa_set_vring_ready(v, dev->vq_index + i);
     }
-- 
2.39.3


