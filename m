Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 313857E37FB
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 10:39:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0IXI-0003Cc-Rj; Tue, 07 Nov 2023 04:38:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1r0IXF-0003BB-Fk
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 04:38:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1r0IX2-0004WA-1S
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 04:38:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699349879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zjjdcY7o9oUZiTA07ZAlqUDuFqG/gJlydaXulzx4iKc=;
 b=JobXN7lT+7xjD2+/n4hFd3jl+5BifB4oO3aoGJ1Sf+Db8yqBffKdLj/l+XrKtgecpV9sYu
 8ZnVY0C8C3w4E5/MwwNwNwNMYgMqnhQlRE3o4ziuLUyNULN+DoHODcilvXG4AUmCZEOENv
 lecY0jXuGqqhLNEjWbYWJYfkOAKfVV4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-399-Xdt1SzM9PnG72RJou8Iapw-1; Tue,
 07 Nov 2023 04:37:50 -0500
X-MC-Unique: Xdt1SzM9PnG72RJou8Iapw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B0972823815;
 Tue,  7 Nov 2023 09:37:50 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.243])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2805B1C060AE;
 Tue,  7 Nov 2023 09:37:49 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, kraxel@redhat.com,
 stefanha@gmail.com, Albert Esteve <aesteve@redhat.com>,
 marcandre.lureau@gmail.com
Subject: [PATCH 2/3] hw/virtio: cleanup shared resources
Date: Tue,  7 Nov 2023 10:37:43 +0100
Message-ID: <20231107093744.388099-3-aesteve@redhat.com>
In-Reply-To: <20231107093744.388099-1-aesteve@redhat.com>
References: <20231107093744.388099-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Ensure that we cleanup all virtio shared
resources when the vhost devices is cleaned
up (after a hot unplug, or a crash).

To track all owned uuids of a device, add
a GSList to the vhost_dev struct. This way
we can avoid traversing the full table
for every cleanup, whether they actually
own any shared resource or not.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 hw/virtio/vhost-user.c    | 2 ++
 hw/virtio/vhost.c         | 4 ++++
 include/hw/virtio/vhost.h | 6 ++++++
 3 files changed, 12 insertions(+)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 5fdff0241f..04848d1fa0 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1598,6 +1598,7 @@ vhost_user_backend_handle_shared_object_add(struct vhost_dev *dev,
     QemuUUID uuid;
 
     memcpy(uuid.data, object->uuid, sizeof(object->uuid));
+    dev->shared_uuids = g_slist_append(dev->shared_uuids, &uuid);
     return virtio_add_vhost_device(&uuid, dev);
 }
 
@@ -1623,6 +1624,7 @@ vhost_user_backend_handle_shared_object_remove(struct vhost_dev *dev,
     }
 
     memcpy(uuid.data, object->uuid, sizeof(object->uuid));
+    dev->shared_uuids = g_slist_remove_all(dev->shared_uuids, &uuid);
     return virtio_remove_resource(&uuid);
 }
 
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 9c9ae7109e..3aff94664b 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -16,6 +16,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/virtio/vhost.h"
+#include "hw/virtio/virtio-dmabuf.h"
 #include "qemu/atomic.h"
 #include "qemu/range.h"
 #include "qemu/error-report.h"
@@ -1599,6 +1600,9 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
     migrate_del_blocker(&hdev->migration_blocker);
     g_free(hdev->mem);
     g_free(hdev->mem_sections);
+    /* free virtio shared objects */
+    g_slist_foreach(hdev->shared_uuids, (GFunc)virtio_remove_resource, NULL);
+    g_slist_free_full(g_steal_pointer(&hdev->shared_uuids), g_free);
     if (hdev->vhost_ops) {
         hdev->vhost_ops->vhost_backend_cleanup(hdev);
     }
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 5e8183f64a..376bc8446d 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -118,6 +118,12 @@ struct vhost_dev {
      */
     uint64_t protocol_features;
 
+    /**
+     * @shared_uuids: contains the UUIDs of all the exported
+     * virtio objects owned by the vhost device.
+     */
+    GSList *shared_uuids;
+
     uint64_t max_queues;
     uint64_t backend_cap;
     /* @started: is the vhost device started? */
-- 
2.41.0


