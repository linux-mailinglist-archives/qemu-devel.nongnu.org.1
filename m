Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB776828658
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 13:57:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNBeo-00068C-2S; Tue, 09 Jan 2024 07:56:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1rNBec-00067L-Rh
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 07:56:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1rNBea-0006iN-Sj
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 07:56:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704804982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wIn18bdB196CmcKnWWByvKyvKoQr67WRQlJjw+lMrYY=;
 b=KNjITzgx9eTVS1kaRPZLj52fecSTYGIW8C+iVZ/IBO4XcnZ6tv60DN7b05iz8cIGQ51qJy
 4R5vJDqb8i8qWLVdWpSqOyG6PWoTBXkaskMt/QUIw1ezbsdgviOyD0C/F1He+DXzd+LgrW
 UgLjKmyGSqeW0nfjWvDDSpEBowuoRDI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-U5KlTBD0MYeyCwS-oPS14Q-1; Tue, 09 Jan 2024 07:56:21 -0500
X-MC-Unique: U5KlTBD0MYeyCwS-oPS14Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1ED1B836F23;
 Tue,  9 Jan 2024 12:56:21 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7F09F2166B33;
 Tue,  9 Jan 2024 12:56:19 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, Albert Esteve <aesteve@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, marcandre.lureau@gmail.com,
 kraxel@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v3 2/3] hw/virtio: cleanup shared resources
Date: Tue,  9 Jan 2024 13:56:13 +0100
Message-ID: <20240109125614.220293-3-aesteve@redhat.com>
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

Ensure that we cleanup all virtio shared
resources when the vhost devices is cleaned
up (after a hot unplug, or a crash).

To do so, we add a new function to the virtio_dmabuf
API called `virtio_dmabuf_vhost_cleanup`, which
loop through the table and removes all
resources owned by the vhost device parameter.

Also, add a test to verify that the new
function in the API behaves as expected.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/display/virtio-dmabuf.c        | 22 +++++++++++++++++++++
 hw/virtio/vhost.c                 |  3 +++
 include/hw/virtio/virtio-dmabuf.h | 10 ++++++++++
 tests/unit/test-virtio-dmabuf.c   | 33 +++++++++++++++++++++++++++++++
 4 files changed, 68 insertions(+)

diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c
index 3dba4577ca..6688809777 100644
--- a/hw/display/virtio-dmabuf.c
+++ b/hw/display/virtio-dmabuf.c
@@ -136,6 +136,28 @@ SharedObjectType virtio_object_type(const QemuUUID *uuid)
     return vso->type;
 }
 
+static bool virtio_dmabuf_resource_is_owned(gpointer key,
+                                            gpointer value,
+                                            gpointer dev)
+{
+    VirtioSharedObject *vso;
+
+    vso = (VirtioSharedObject *) value;
+    return vso->type == TYPE_VHOST_DEV && vso->value == dev;
+}
+
+int virtio_dmabuf_vhost_cleanup(struct vhost_dev *dev)
+{
+    int num_removed;
+
+    g_mutex_lock(&lock);
+    num_removed = g_hash_table_foreach_remove(
+        resource_uuids, (GHRFunc) virtio_dmabuf_resource_is_owned, dev);
+    g_mutex_unlock(&lock);
+
+    return num_removed;
+}
+
 void virtio_free_resources(void)
 {
     g_mutex_lock(&lock);
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 2c9ac79468..c5622eac14 100644
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
@@ -1599,6 +1600,8 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
     migrate_del_blocker(&hdev->migration_blocker);
     g_free(hdev->mem);
     g_free(hdev->mem_sections);
+    /* free virtio shared objects */
+    virtio_dmabuf_vhost_cleanup(hdev);
     if (hdev->vhost_ops) {
         hdev->vhost_ops->vhost_backend_cleanup(hdev);
     }
diff --git a/include/hw/virtio/virtio-dmabuf.h b/include/hw/virtio/virtio-dmabuf.h
index 627c3b6db7..73f70fb482 100644
--- a/include/hw/virtio/virtio-dmabuf.h
+++ b/include/hw/virtio/virtio-dmabuf.h
@@ -91,6 +91,16 @@ struct vhost_dev *virtio_lookup_vhost_device(const QemuUUID *uuid);
  */
 SharedObjectType virtio_object_type(const QemuUUID *uuid);
 
+/**
+ * virtio_dmabuf_vhost_cleanup() - Destroys all entries of the shared
+ * resources lookup table that are owned by the vhost backend
+ * @dev: the pointer to the vhost device that owns the entries. Data is owned
+ *       by the called of the function.
+ * 
+ * Return: the number of resource entries removed.
+ */
+int virtio_dmabuf_vhost_cleanup(struct vhost_dev *dev);
+
 /**
  * virtio_free_resources() - Destroys all keys and values of the shared
  * resources lookup table, and frees them
diff --git a/tests/unit/test-virtio-dmabuf.c b/tests/unit/test-virtio-dmabuf.c
index a45ec52f42..1c8123c2d2 100644
--- a/tests/unit/test-virtio-dmabuf.c
+++ b/tests/unit/test-virtio-dmabuf.c
@@ -103,6 +103,38 @@ static void test_add_invalid_resource(void)
     }
 }
 
+static void test_cleanup_res(void)
+{
+    QemuUUID uuids[20], uuid_alt;
+    struct vhost_dev *dev = g_new0(struct vhost_dev, 1);
+    struct vhost_dev *dev_alt = g_new0(struct vhost_dev, 1);
+    int i, num_removed;
+
+    for (i = 0; i < ARRAY_SIZE(uuids); ++i) {
+        qemu_uuid_generate(&uuids[i]);
+        virtio_add_vhost_device(&uuids[i], dev);
+        /* vhost device is found */
+        g_assert(virtio_lookup_vhost_device(&uuids[i]) != NULL);
+    }
+    qemu_uuid_generate(&uuid_alt);
+    virtio_add_vhost_device(&uuid_alt, dev_alt);
+    /* vhost device is found */
+    g_assert(virtio_lookup_vhost_device(&uuid_alt) != NULL);
+    /* cleanup all dev resources */
+    num_removed = virtio_dmabuf_vhost_cleanup(dev);
+    g_assert_cmpint(num_removed, ==, ARRAY_SIZE(uuids));
+    for (i = 0; i < ARRAY_SIZE(uuids); ++i) {
+        /* None of the dev resources is found after free'd */
+        g_assert_cmpint(virtio_lookup_dmabuf(&uuids[i]), ==, -1);
+    }
+    /* uuid_alt is still in the hash table */
+    g_assert(virtio_lookup_vhost_device(&uuid_alt) != NULL);
+
+    virtio_free_resources();
+    g_free(dev);
+    g_free(dev_alt);
+}
+
 static void test_free_resources(void)
 {
     QemuUUID uuids[20];
@@ -131,6 +163,7 @@ int main(int argc, char **argv)
                     test_remove_invalid_resource);
     g_test_add_func("/virtio-dmabuf/add_invalid_res",
                     test_add_invalid_resource);
+    g_test_add_func("/virtio-dmabuf/cleanup_dev", test_cleanup_res);
     g_test_add_func("/virtio-dmabuf/free_res", test_free_resources);
 
     return g_test_run();
-- 
2.43.0


