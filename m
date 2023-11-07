Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5336D7E37F9
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 10:38:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0IX3-00038r-9y; Tue, 07 Nov 2023 04:38:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1r0IX0-00038Y-J6
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 04:37:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1r0IWy-0004Vf-Hj
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 04:37:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699349876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tT8jayzW3ogOJjjkCamjJ1rHm9fpmeIWVf+g0YM9Cqc=;
 b=CQer4qma1xV5FBEy+JqMjyclydRMhMjL7aai16yvYnxZdRXMSG+6flSODJUFEBcAUJiqCJ
 HENXGOGEdcwDiVIztq0g9DNIKo9WaQh3pNAMSPi2PW2OO6Gvp/pTzSSSkLDgwbSckyxW4p
 vTMVj+DD5qNzosw0aabJGc1Qg3PuLz8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-QV6e-wzXMda-b5dCzBcWlQ-1; Tue,
 07 Nov 2023 04:37:52 -0500
X-MC-Unique: QV6e-wzXMda-b5dCzBcWlQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4AF2C3C100A8;
 Tue,  7 Nov 2023 09:37:52 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.243])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B0E701C060AE;
 Tue,  7 Nov 2023 09:37:50 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, kraxel@redhat.com,
 stefanha@gmail.com, Albert Esteve <aesteve@redhat.com>,
 marcandre.lureau@gmail.com
Subject: [PATCH 3/3] hw/virtio: rename virtio dmabuf API
Date: Tue,  7 Nov 2023 10:37:44 +0100
Message-ID: <20231107093744.388099-4-aesteve@redhat.com>
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

Functions in the virtio-dmabuf module
start with 'virtio_*', which is too
generic and may not correctly identify
them as part of the virtio dmabuf API.

Rename all functions to 'virtio_dmabuf_*'
instead to avoid confusion.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 hw/display/virtio-dmabuf.c        | 14 +++++-----
 hw/virtio/vhost-user.c            | 14 +++++-----
 hw/virtio/vhost.c                 |  3 ++-
 include/hw/virtio/virtio-dmabuf.h | 33 ++++++++++++-----------
 tests/unit/test-virtio-dmabuf.c   | 44 +++++++++++++++----------------
 5 files changed, 55 insertions(+), 53 deletions(-)

diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c
index 3dba4577ca..40ee046e76 100644
--- a/hw/display/virtio-dmabuf.c
+++ b/hw/display/virtio-dmabuf.c
@@ -48,7 +48,7 @@ static bool virtio_add_resource(QemuUUID *uuid, VirtioSharedObject *value)
     return result;
 }
 
-bool virtio_add_dmabuf(QemuUUID *uuid, int udmabuf_fd)
+bool virtio_dmabuf_add(QemuUUID *uuid, int udmabuf_fd)
 {
     bool result;
     VirtioSharedObject *vso;
@@ -66,7 +66,7 @@ bool virtio_add_dmabuf(QemuUUID *uuid, int udmabuf_fd)
     return result;
 }
 
-bool virtio_add_vhost_device(QemuUUID *uuid, struct vhost_dev *dev)
+bool virtio_dmabuf_add_vhost_device(QemuUUID *uuid, struct vhost_dev *dev)
 {
     bool result;
     VirtioSharedObject *vso;
@@ -84,7 +84,7 @@ bool virtio_add_vhost_device(QemuUUID *uuid, struct vhost_dev *dev)
     return result;
 }
 
-bool virtio_remove_resource(const QemuUUID *uuid)
+bool virtio_dmabuf_remove_resource(const QemuUUID *uuid)
 {
     bool result;
     g_mutex_lock(&lock);
@@ -107,7 +107,7 @@ static VirtioSharedObject *get_shared_object(const QemuUUID *uuid)
     return (VirtioSharedObject *) lookup_res;
 }
 
-int virtio_lookup_dmabuf(const QemuUUID *uuid)
+int virtio_dmabuf_lookup(const QemuUUID *uuid)
 {
     VirtioSharedObject *vso = get_shared_object(uuid);
     if (vso == NULL) {
@@ -117,7 +117,7 @@ int virtio_lookup_dmabuf(const QemuUUID *uuid)
     return GPOINTER_TO_INT(vso->value);
 }
 
-struct vhost_dev *virtio_lookup_vhost_device(const QemuUUID *uuid)
+struct vhost_dev *virtio_dmabuf_lookup_vhost_device(const QemuUUID *uuid)
 {
     VirtioSharedObject *vso = get_shared_object(uuid);
     if (vso == NULL) {
@@ -127,7 +127,7 @@ struct vhost_dev *virtio_lookup_vhost_device(const QemuUUID *uuid)
     return (struct vhost_dev *) vso->value;
 }
 
-SharedObjectType virtio_object_type(const QemuUUID *uuid)
+SharedObjectType virtio_dmabuf_object_type(const QemuUUID *uuid)
 {
     VirtioSharedObject *vso = get_shared_object(uuid);
     if (vso == NULL) {
@@ -136,7 +136,7 @@ SharedObjectType virtio_object_type(const QemuUUID *uuid)
     return vso->type;
 }
 
-void virtio_free_resources(void)
+void virtio_dmabuf_free_resources(void)
 {
     g_mutex_lock(&lock);
     g_hash_table_destroy(resource_uuids);
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 04848d1fa0..47c2465081 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1599,7 +1599,7 @@ vhost_user_backend_handle_shared_object_add(struct vhost_dev *dev,
 
     memcpy(uuid.data, object->uuid, sizeof(object->uuid));
     dev->shared_uuids = g_slist_append(dev->shared_uuids, &uuid);
-    return virtio_add_vhost_device(&uuid, dev);
+    return virtio_dmabuf_add_vhost_device(&uuid, dev);
 }
 
 static int
@@ -1608,10 +1608,10 @@ vhost_user_backend_handle_shared_object_remove(struct vhost_dev *dev,
 {
     QemuUUID uuid;
 
-    switch (virtio_object_type(&uuid)) {
+    switch (virtio_dmabuf_object_type(&uuid)) {
     case TYPE_VHOST_DEV:
     {
-        struct vhost_dev *owner = virtio_lookup_vhost_device(&uuid);
+        struct vhost_dev *owner = virtio_dmabuf_lookup_vhost_device(&uuid);
         if (owner == NULL || dev != owner) {
             /* Not allowed to remove non-owned entries */
             return 0;
@@ -1625,7 +1625,7 @@ vhost_user_backend_handle_shared_object_remove(struct vhost_dev *dev,
 
     memcpy(uuid.data, object->uuid, sizeof(object->uuid));
     dev->shared_uuids = g_slist_remove_all(dev->shared_uuids, &uuid);
-    return virtio_remove_resource(&uuid);
+    return virtio_dmabuf_remove_resource(&uuid);
 }
 
 static bool vhost_user_send_resp(QIOChannel *ioc, VhostUserHeader *hdr,
@@ -1703,13 +1703,13 @@ vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
     memcpy(uuid.data, payload->object.uuid, sizeof(payload->object.uuid));
 
     payload->u64 = 0;
-    switch (virtio_object_type(&uuid)) {
+    switch (virtio_dmabuf_object_type(&uuid)) {
     case TYPE_DMABUF:
-        dmabuf_fd = virtio_lookup_dmabuf(&uuid);
+        dmabuf_fd = virtio_dmabuf_lookup(&uuid);
         break;
     case TYPE_VHOST_DEV:
     {
-        struct vhost_dev *dev = virtio_lookup_vhost_device(&uuid);
+        struct vhost_dev *dev = virtio_dmabuf_lookup_vhost_device(&uuid);
         if (dev == NULL) {
             payload->u64 = -EINVAL;
             break;
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 3aff94664b..9ca2bf9889 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1601,7 +1601,8 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
     g_free(hdev->mem);
     g_free(hdev->mem_sections);
     /* free virtio shared objects */
-    g_slist_foreach(hdev->shared_uuids, (GFunc)virtio_remove_resource, NULL);
+    g_slist_foreach(hdev->shared_uuids, (GFunc)virtio_dmabuf_remove_resource,
+                    NULL);
     g_slist_free_full(g_steal_pointer(&hdev->shared_uuids), g_free);
     if (hdev->vhost_ops) {
         hdev->vhost_ops->vhost_backend_cleanup(hdev);
diff --git a/include/hw/virtio/virtio-dmabuf.h b/include/hw/virtio/virtio-dmabuf.h
index 627c3b6db7..9bcd44119c 100644
--- a/include/hw/virtio/virtio-dmabuf.h
+++ b/include/hw/virtio/virtio-dmabuf.h
@@ -28,7 +28,7 @@ typedef struct VirtioSharedObject {
 } VirtioSharedObject;
 
 /**
- * virtio_add_dmabuf() - Add a new dma-buf resource to the lookup table
+ * virtio_dmabuf_add() - Add a new dma-buf resource to the lookup table
  * @uuid: new resource's UUID
  * @dmabuf_fd: the dma-buf descriptor that will be stored and shared with
  *             other virtio devices. The caller retains ownership over the
@@ -41,11 +41,11 @@ typedef struct VirtioSharedObject {
  * Note that if it finds a repeated UUID, the resource is not inserted in
  * the lookup table.
  */
-bool virtio_add_dmabuf(QemuUUID *uuid, int dmabuf_fd);
+bool virtio_dmabuf_add(QemuUUID *uuid, int dmabuf_fd);
 
 /**
- * virtio_add_vhost_device() - Add a new exporter vhost device that holds the
- * resource with the associated UUID
+ * virtio_dmabuf_add_vhost_device() - Add a new exporter vhost device that
+ * holds the resource with the associated UUID
  * @uuid: new resource's UUID
  * @dev: the pointer to the vhost device that holds the resource. The caller
  *       retains ownership over the device struct and its lifecycle.
@@ -55,46 +55,47 @@ bool virtio_add_dmabuf(QemuUUID *uuid, int dmabuf_fd);
  * Note that if it finds a repeated UUID, the resource is not inserted in
  * the lookup table.
  */
-bool virtio_add_vhost_device(QemuUUID *uuid, struct vhost_dev *dev);
+bool virtio_dmabuf_add_vhost_device(QemuUUID *uuid, struct vhost_dev *dev);
 
 /**
- * virtio_remove_resource() - Removes a resource from the lookup table
+ * virtio_dmabuf_remove_resource() - Removes a resource from the lookup table
  * @uuid: resource's UUID
  *
  * Return: true if the UUID has been found and removed from the lookup table.
  */
-bool virtio_remove_resource(const QemuUUID *uuid);
+bool virtio_dmabuf_remove_resource(const QemuUUID *uuid);
 
 /**
- * virtio_lookup_dmabuf() - Looks for a dma-buf resource in the lookup table
+ * virtio_dmabuf_lookup() - Looks for a dma-buf resource in the lookup table
  * @uuid: resource's UUID
  *
  * Return: the dma-buf file descriptor integer, or -1 if the key is not found.
  */
-int virtio_lookup_dmabuf(const QemuUUID *uuid);
+int virtio_dmabuf_lookup(const QemuUUID *uuid);
 
 /**
- * virtio_lookup_vhost_device() - Looks for an exporter vhost device in the
- * lookup table
+ * virtio_dmabuf_lookup_vhost_device() - Looks for an exporter vhost device
+ * in the lookup table
  * @uuid: resource's UUID
  *
  * Return: pointer to the vhost_dev struct, or NULL if the key is not found.
  */
-struct vhost_dev *virtio_lookup_vhost_device(const QemuUUID *uuid);
+struct vhost_dev *virtio_dmabuf_lookup_vhost_device(const QemuUUID *uuid);
 
 /**
- * virtio_object_type() - Looks for the type of resource in the lookup table
+ * virtio_dmabuf_object_type() - Looks for the type of resource in the
+ * lookup table
  * @uuid: resource's UUID
  *
  * Return: the type of resource associated with the UUID, or TYPE_INVALID if
  * the key is not found.
  */
-SharedObjectType virtio_object_type(const QemuUUID *uuid);
+SharedObjectType virtio_dmabuf_object_type(const QemuUUID *uuid);
 
 /**
- * virtio_free_resources() - Destroys all keys and values of the shared
+ * virtio_dmabuf_free_resources() - Destroys all keys and values of the shared
  * resources lookup table, and frees them
  */
-void virtio_free_resources(void);
+void virtio_dmabuf_free_resources(void);
 
 #endif /* VIRTIO_DMABUF_H */
diff --git a/tests/unit/test-virtio-dmabuf.c b/tests/unit/test-virtio-dmabuf.c
index a45ec52f42..fe805836a4 100644
--- a/tests/unit/test-virtio-dmabuf.c
+++ b/tests/unit/test-virtio-dmabuf.c
@@ -31,12 +31,12 @@ static void test_add_remove_resources(void)
         qemu_uuid_generate(&uuid);
         dmabuf_fd = g_random_int_range(3, 500);
         /* Add a new resource */
-        g_assert(virtio_add_dmabuf(&uuid, dmabuf_fd));
-        g_assert_cmpint(virtio_lookup_dmabuf(&uuid), ==, dmabuf_fd);
+        g_assert(virtio_dmabuf_add(&uuid, dmabuf_fd));
+        g_assert_cmpint(virtio_dmabuf_lookup(&uuid), ==, dmabuf_fd);
         /* Remove the resource */
-        g_assert(virtio_remove_resource(&uuid));
+        g_assert(virtio_dmabuf_remove_resource(&uuid));
         /* Resource is not found anymore */
-        g_assert_cmpint(virtio_lookup_dmabuf(&uuid), ==, -1);
+        g_assert_cmpint(virtio_dmabuf_lookup(&uuid), ==, -1);
     }
 }
 
@@ -48,13 +48,13 @@ static void test_add_remove_dev(void)
 
     for (i = 0; i < 100; ++i) {
         qemu_uuid_generate(&uuid);
-        virtio_add_vhost_device(&uuid, dev);
+        virtio_dmabuf_add_vhost_device(&uuid, dev);
         /* vhost device is found */
-        g_assert(virtio_lookup_vhost_device(&uuid) != NULL);
+        g_assert(virtio_dmabuf_lookup_vhost_device(&uuid) != NULL);
         /* Remove the vhost device */
-        g_assert(virtio_remove_resource(&uuid));
+        g_assert(virtio_dmabuf_remove_resource(&uuid));
         /* vhost device is not found anymore */
-        g_assert(virtio_lookup_vhost_device(&uuid) == NULL);
+        g_assert(virtio_dmabuf_lookup_vhost_device(&uuid) == NULL);
     }
     g_free(dev);
 }
@@ -66,9 +66,9 @@ static void test_remove_invalid_resource(void)
 
     for (i = 0; i < 20; ++i) {
         qemu_uuid_generate(&uuid);
-        g_assert_cmpint(virtio_lookup_dmabuf(&uuid), ==, -1);
+        g_assert_cmpint(virtio_dmabuf_lookup(&uuid), ==, -1);
         /* Removing a resource that does not exist returns false */
-        g_assert_false(virtio_remove_resource(&uuid));
+        g_assert_false(virtio_dmabuf_remove_resource(&uuid));
     }
 }
 
@@ -81,25 +81,25 @@ static void test_add_invalid_resource(void)
     for (i = 0; i < 20; ++i) {
         qemu_uuid_generate(&uuid);
         /* Add a new resource with invalid (negative) resource fd */
-        g_assert_false(virtio_add_dmabuf(&uuid, dmabuf_fd));
+        g_assert_false(virtio_dmabuf_add(&uuid, dmabuf_fd));
         /* Resource is not found */
-        g_assert_cmpint(virtio_lookup_dmabuf(&uuid), ==, -1);
+        g_assert_cmpint(virtio_dmabuf_lookup(&uuid), ==, -1);
         /* Add a new vhost device with invalid (NULL) pointer */
-        g_assert_false(virtio_add_vhost_device(&uuid, dev));
+        g_assert_false(virtio_dmabuf_add_vhost_device(&uuid, dev));
         /* vhost device is not found */
-        g_assert(virtio_lookup_vhost_device(&uuid) == NULL);
+        g_assert(virtio_dmabuf_lookup_vhost_device(&uuid) == NULL);
     }
 
     for (i = 0; i < 20; ++i) {
         /* Add a valid resource */
         qemu_uuid_generate(&uuid);
         dmabuf_fd = g_random_int_range(3, 500);
-        g_assert(virtio_add_dmabuf(&uuid, dmabuf_fd));
-        g_assert_cmpint(virtio_lookup_dmabuf(&uuid), ==, dmabuf_fd);
+        g_assert(virtio_dmabuf_add(&uuid, dmabuf_fd));
+        g_assert_cmpint(virtio_dmabuf_lookup(&uuid), ==, dmabuf_fd);
         /* Add a new resource with repeated uuid returns false */
-        g_assert_false(virtio_add_dmabuf(&uuid, alt_dmabuf));
+        g_assert_false(virtio_dmabuf_add(&uuid, alt_dmabuf));
         /* The value for the uuid key is not replaced */
-        g_assert_cmpint(virtio_lookup_dmabuf(&uuid), ==, dmabuf_fd);
+        g_assert_cmpint(virtio_dmabuf_lookup(&uuid), ==, dmabuf_fd);
     }
 }
 
@@ -111,13 +111,13 @@ static void test_free_resources(void)
     for (i = 0; i < ARRAY_SIZE(uuids); ++i) {
         qemu_uuid_generate(&uuids[i]);
         dmabuf_fd = g_random_int_range(3, 500);
-        g_assert(virtio_add_dmabuf(&uuids[i], dmabuf_fd));
-        g_assert_cmpint(virtio_lookup_dmabuf(&uuids[i]), ==, dmabuf_fd);
+        g_assert(virtio_dmabuf_add(&uuids[i], dmabuf_fd));
+        g_assert_cmpint(virtio_dmabuf_lookup(&uuids[i]), ==, dmabuf_fd);
     }
-    virtio_free_resources();
+    virtio_dmabuf_free_resources();
     for (i = 0; i < ARRAY_SIZE(uuids); ++i) {
         /* None of the resources is found after free'd */
-        g_assert_cmpint(virtio_lookup_dmabuf(&uuids[i]), ==, -1);
+        g_assert_cmpint(virtio_dmabuf_lookup(&uuids[i]), ==, -1);
     }
 
 }
-- 
2.41.0


