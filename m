Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBBF7E37F7
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 10:38:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0IX0-00038H-73; Tue, 07 Nov 2023 04:37:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1r0IWx-00037U-HZ
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 04:37:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1r0IWv-0004VA-Gz
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 04:37:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699349872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z99vVTfPw7k6XBeUSE9yrh9VsYv9cbdkI19EpgickbA=;
 b=JZoYaZWRm3bnQ8qnA2itHkkVYne411VeMTu/ObRswGxjp0NPP4BPHwaq1h2pf2xHJcyrLq
 0qY7ycYv0JMmk8bkn92giml33wnr6/TmUPRh1Vxuzi1fexTWPjh5O85H1aY0CAoAxJZQSb
 Zk2I+XVP1KNqvpLcqpxhlnVz4VSsgrE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-lmChmzUlOeyjo1jewODmtA-1; Tue, 07 Nov 2023 04:37:49 -0500
X-MC-Unique: lmChmzUlOeyjo1jewODmtA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CBB40852AC8;
 Tue,  7 Nov 2023 09:37:48 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.243])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5B7D21C060AE;
 Tue,  7 Nov 2023 09:37:47 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, kraxel@redhat.com,
 stefanha@gmail.com, Albert Esteve <aesteve@redhat.com>,
 marcandre.lureau@gmail.com
Subject: [PATCH 1/3] hw/virtio: check owner for removing objects
Date: Tue,  7 Nov 2023 10:37:42 +0100
Message-ID: <20231107093744.388099-2-aesteve@redhat.com>
In-Reply-To: <20231107093744.388099-1-aesteve@redhat.com>
References: <20231107093744.388099-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Shared objects lack spoofing protection.
For VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE messages
received by the vhost-user interface, any backend was
allowed to remove entries from the shared table just
by knowing the UUID. Only the owner of the entry
shall be allowed to removed their resources
from the table.

To fix that, add a check for all
*SHARED_OBJECT_REMOVE messages received.
A vhost device can only remove TYPE_VHOST_DEV
entries that are owned by them, otherwise skip
the removal, and inform the device that the entry
has not been removed in the answer.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 hw/virtio/vhost-user.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 7b42ae8aae..5fdff0241f 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1602,10 +1602,26 @@ vhost_user_backend_handle_shared_object_add(struct vhost_dev *dev,
 }
 
 static int
-vhost_user_backend_handle_shared_object_remove(VhostUserShared *object)
+vhost_user_backend_handle_shared_object_remove(struct vhost_dev *dev,
+                                               VhostUserShared *object)
 {
     QemuUUID uuid;
 
+    switch (virtio_object_type(&uuid)) {
+    case TYPE_VHOST_DEV:
+    {
+        struct vhost_dev *owner = virtio_lookup_vhost_device(&uuid);
+        if (owner == NULL || dev != owner) {
+            /* Not allowed to remove non-owned entries */
+            return 0;
+        }
+        break;
+    }
+    default:
+        /* Not allowed to remove non-owned entries */
+        return 0;
+    }
+
     memcpy(uuid.data, object->uuid, sizeof(object->uuid));
     return virtio_remove_resource(&uuid);
 }
@@ -1785,7 +1801,8 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
         ret = vhost_user_backend_handle_shared_object_add(dev, &payload.object);
         break;
     case VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE:
-        ret = vhost_user_backend_handle_shared_object_remove(&payload.object);
+        ret = vhost_user_backend_handle_shared_object_remove(dev,
+                                                             &payload.object);
         break;
     case VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP:
         ret = vhost_user_backend_handle_shared_object_lookup(dev->opaque, ioc,
-- 
2.41.0


