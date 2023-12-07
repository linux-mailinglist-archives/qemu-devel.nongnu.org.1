Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 874C8808B31
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 15:57:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBFnE-0000QE-MX; Thu, 07 Dec 2023 09:56:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1rBFnB-0000Q2-F3
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 09:55:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1rBFn8-0003py-1z
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 09:55:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701960951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=USj2+qT/n6WeZx783xFOJ1a/OTnmQweQXultk8j1NQg=;
 b=MI3G3ppLlxmiUXB/SygGGYoq9X+E3LxMdRbo724hETMdxytZD6spY8JL5F43u3kev0o/6t
 PdkSHDw02BTWPSEzKVbvKE5ls1hFrJ6x29zkwv/u67IO6B79e3QRPxa6jEo05ZKz0Od7qG
 9EQpc0PZc88Z13zpHFli7upVIxWLg0c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-pceHpKMSPZ6fz2At2ANHrA-1; Thu, 07 Dec 2023 09:55:50 -0500
X-MC-Unique: pceHpKMSPZ6fz2At2ANHrA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF4EF85A58B;
 Thu,  7 Dec 2023 14:55:49 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.225])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 68B3C492BC6;
 Thu,  7 Dec 2023 14:55:48 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@gmail.com, kraxel@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, stefanha@gmail.com,
 Albert Esteve <aesteve@redhat.com>
Subject: [PATCH v2 1/3] hw/virtio: check owner for removing objects
Date: Thu,  7 Dec 2023 15:55:43 +0100
Message-ID: <20231207145545.783877-2-aesteve@redhat.com>
In-Reply-To: <20231207145545.783877-1-aesteve@redhat.com>
References: <20231207145545.783877-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
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
index f214df804b..1c3f2357be 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1611,11 +1611,27 @@ vhost_user_backend_handle_shared_object_add(struct vhost_dev *dev,
 }
 
 static int
-vhost_user_backend_handle_shared_object_remove(VhostUserShared *object)
+vhost_user_backend_handle_shared_object_remove(struct vhost_dev *dev,
+                                               VhostUserShared *object)
 {
     QemuUUID uuid;
 
     memcpy(uuid.data, object->uuid, sizeof(object->uuid));
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
     return virtio_remove_resource(&uuid);
 }
 
@@ -1794,7 +1810,8 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
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
2.43.0


