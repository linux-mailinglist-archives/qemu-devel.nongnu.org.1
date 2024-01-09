Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F350382865B
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 13:57:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNBeq-00068e-Fg; Tue, 09 Jan 2024 07:56:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1rNBeb-00067F-46
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 07:56:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1rNBeY-0006ho-LC
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 07:56:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704804981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ivwDSoPbw4qfawPI/W6vN6TcIHlYNOZOOylu2WFTa6g=;
 b=Enn+6bhCG9o5fbGw2q2f5nMsiGDRSBGowhHCD+nPwtSokLZnfeyTKb4JyNDyFWEgmjHOVe
 nzX6d8hkvYF2CBYz3BUOOE81goZLxzPbOI05S7ZvIXQZUz/rOR9tKHm3h60NrugtJH10lK
 7PFCPFWC7m3No3P6DpYYBiWwji4KamU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-NHkMJMR9OYSFL--XTX5YFg-1; Tue, 09 Jan 2024 07:56:19 -0500
X-MC-Unique: NHkMJMR9OYSFL--XTX5YFg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1FEAF8314EB;
 Tue,  9 Jan 2024 12:56:19 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 736342166B33;
 Tue,  9 Jan 2024 12:56:17 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, Albert Esteve <aesteve@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, marcandre.lureau@gmail.com,
 kraxel@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v3 1/3] hw/virtio: check owner for removing objects
Date: Tue,  9 Jan 2024 13:56:12 +0100
Message-ID: <20240109125614.220293-2-aesteve@redhat.com>
In-Reply-To: <20240109125614.220293-1-aesteve@redhat.com>
References: <20240109125614.220293-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.493,
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
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 docs/interop/vhost-user.rst |  4 +++-
 hw/virtio/vhost-user.c      | 21 +++++++++++++++++++--
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 9f1103f85a..60ec2c9d48 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -1839,7 +1839,9 @@ is sent by the front-end.
   When the ``VHOST_USER_PROTOCOL_F_SHARED_OBJECT`` protocol
   feature has been successfully negotiated, this message can be submitted
   by the backend to remove themselves from to the virtio-dmabuf shared
-  table API. The shared table will remove the back-end device associated with
+  table API. Only the back-end owning the entry (i.e., the one that first added
+  it) will have permission to remove it. Otherwise, the message is ignored.
+  The shared table will remove the back-end device associated with
   the UUID. If ``VHOST_USER_PROTOCOL_F_REPLY_ACK`` is negotiated, and the
   back-end sets the ``VHOST_USER_NEED_REPLY`` flag, the front-end must respond
   with zero when operation is successfully completed, or non-zero otherwise.
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


