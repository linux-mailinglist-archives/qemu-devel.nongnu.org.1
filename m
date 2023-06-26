Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E779A73D89C
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 09:36:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDgkJ-0003G9-Bc; Mon, 26 Jun 2023 03:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qDgkH-0003Fj-3G
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 03:34:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qDgkE-0007Am-85
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 03:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687764881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qUVZqN80+uECwYZquPFyG49VK4RilhUaiN+F35Ht5RQ=;
 b=LS/VViUCCxl4mOQDtpFpxK6kAfoNejfpAWiFjl/en+4P2nbnIOKakaMwUXaku2Wus2AFUT
 EfG//Ryr+J1S8oKswa4Ah2zX5p9ScuThwgBxvT0LIyYJmT3CjaM6qOnKBChJDIxcZPMeTQ
 SFFcN7izRh6PDCa/vqUeIBkrSz9/mWY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-303-OozcnTnXOuihb6acLKrtxw-1; Mon, 26 Jun 2023 03:34:39 -0400
X-MC-Unique: OozcnTnXOuihb6acLKrtxw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 23AA88CC201;
 Mon, 26 Jun 2023 07:34:39 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.225.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AA18C492B03;
 Mon, 26 Jun 2023 07:34:37 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@gmail.com, "Michael S. Tsirkin" <mst@redhat.com>,
 cohuck@redhat.com, Albert Esteve <aesteve@redhat.com>,
 Fam Zheng <fam@euphon.net>, kraxel@redhat.com
Subject: [PATCH v4 2/4] virtio-dmabuf: introduce virtio-dmabuf
Date: Mon, 26 Jun 2023 09:34:24 +0200
Message-Id: <20230626073426.285659-3-aesteve@redhat.com>
In-Reply-To: <20230626073426.285659-1-aesteve@redhat.com>
References: <20230626073426.285659-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

This API manages objects (in this iteration,
dmabuf fds) that can be shared along different
virtio devices.

The API allows the different devices to add,
remove and/or retrieve the objects by simply
invoking the public functions that reside in the
virtio-dmabuf file.

Suggested-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 MAINTAINERS                       |   7 ++
 hw/display/meson.build            |   1 +
 hw/display/virtio-dmabuf.c        |  90 ++++++++++++++++++++++++
 include/hw/virtio/virtio-dmabuf.h |  59 ++++++++++++++++
 tests/unit/meson.build            |   1 +
 tests/unit/test-virtio-dmabuf.c   | 112 ++++++++++++++++++++++++++++++
 6 files changed, 270 insertions(+)
 create mode 100644 hw/display/virtio-dmabuf.c
 create mode 100644 include/hw/virtio/virtio-dmabuf.h
 create mode 100644 tests/unit/test-virtio-dmabuf.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7f323cd2eb..ce77a691a1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2150,6 +2150,13 @@ T: git https://gitlab.com/cohuck/qemu.git s390-next
 T: git https://github.com/borntraeger/qemu.git s390-next
 L: qemu-s390x@nongnu.org
 
+virtio-dmabuf
+M: Albert Esteve <aesteve@redhat.com>
+S: Supported
+F: hw/display/virtio-dmabuf.c
+F: include/hw/virtio/virtio-dmabuf.h
+F: tests/unit/test-virtio-dmabuf.c
+
 virtiofs
 M: Stefan Hajnoczi <stefanha@redhat.com>
 S: Supported
diff --git a/hw/display/meson.build b/hw/display/meson.build
index 413ba4ab24..05619c6968 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -37,6 +37,7 @@ system_ss.add(when: 'CONFIG_MACFB', if_true: files('macfb.c'))
 system_ss.add(when: 'CONFIG_NEXTCUBE', if_true: files('next-fb.c'))
 
 system_ss.add(when: 'CONFIG_VGA', if_true: files('vga.c'))
+system_ss.add(when: 'CONFIG_VIRTIO', if_true: files('virtio-dmabuf.c'))
 
 if (config_all_devices.has_key('CONFIG_VGA_CIRRUS') or
     config_all_devices.has_key('CONFIG_VGA_PCI') or
diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c
new file mode 100644
index 0000000000..7dba0b2c71
--- /dev/null
+++ b/hw/display/virtio-dmabuf.c
@@ -0,0 +1,90 @@
+/*
+ * Virtio Shared dma-buf
+ *
+ * Copyright Red Hat, Inc. 2023
+ *
+ * Authors:
+ *     Albert Esteve <aesteve@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "hw/virtio/virtio-dmabuf.h"
+
+
+static GMutex lock;
+static GHashTable *resource_uuids;
+
+/*
+ * uuid_equal_func: wrapper for UUID is_equal function to
+ * satisfy g_hash_table_new expected parameters signatures.
+ */
+static int uuid_equal_func(const void *lhv, const void *rhv)
+{
+    return qemu_uuid_is_equal(lhv, rhv);
+}
+
+static bool virtio_add_resource(QemuUUID *uuid, gpointer value)
+{
+    assert(resource_uuids != NULL);
+    if (g_hash_table_lookup(resource_uuids, uuid) != NULL) {
+        return false;
+    }
+
+    return g_hash_table_insert(resource_uuids, uuid, value);
+}
+
+static gpointer virtio_lookup_resource(const QemuUUID *uuid)
+{
+    if (resource_uuids == NULL) {
+        return NULL;
+    }
+
+    return g_hash_table_lookup(resource_uuids, uuid);
+}
+
+bool virtio_add_dmabuf(QemuUUID *uuid, int udmabuf_fd)
+{
+    bool result;
+    if (udmabuf_fd < 0) {
+        return false;
+    }
+    g_mutex_lock(&lock);
+    if (resource_uuids == NULL) {
+        resource_uuids = g_hash_table_new(qemu_uuid_hash, uuid_equal_func);
+    }
+    result = virtio_add_resource(uuid, GINT_TO_POINTER(udmabuf_fd));
+    g_mutex_unlock(&lock);
+
+    return result;
+}
+
+bool virtio_remove_resource(const QemuUUID *uuid)
+{
+    bool result;
+    g_mutex_lock(&lock);
+    result = g_hash_table_remove(resource_uuids, uuid);
+    g_mutex_unlock(&lock);
+
+    return result;
+}
+
+int virtio_lookup_dmabuf(const QemuUUID *uuid)
+{
+    g_mutex_lock(&lock);
+    gpointer lookup_res = virtio_lookup_resource(uuid);
+    g_mutex_unlock(&lock);
+    if (lookup_res == NULL) {
+        return -1;
+    }
+
+    return GPOINTER_TO_INT(lookup_res);
+}
+
+void virtio_free_resources(void)
+{
+    g_hash_table_destroy(resource_uuids);
+    /* Reference count shall be 0 after the implicit unref on destroy */
+    resource_uuids = NULL;
+}
diff --git a/include/hw/virtio/virtio-dmabuf.h b/include/hw/virtio/virtio-dmabuf.h
new file mode 100644
index 0000000000..4fdd394c4b
--- /dev/null
+++ b/include/hw/virtio/virtio-dmabuf.h
@@ -0,0 +1,59 @@
+/*
+ * Virtio Shared dma-buf
+ *
+ * Copyright Red Hat, Inc. 2023
+ *
+ * Authors:
+ *     Albert Esteve <aesteve@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef VIRTIO_DMABUF_H
+#define VIRTIO_DMABUF_H
+
+#include "qemu/osdep.h"
+
+#include <glib.h>
+#include "qemu/uuid.h"
+
+/**
+ * virtio_add_dmabuf() - Add a new dma-buf resource to the lookup table
+ * @uuid: new resource's UUID
+ * @dmabuf_fd: the dma-buf descriptor that will be stored and shared with
+ *             other virtio devices. The caller retains ownership over the
+ *             descriptor and its lifecycle.
+ *
+ * Note: @dmabuf_fd must be a valid (non-negative) file descriptor.
+ *
+ * Return: true if the UUID did not exist and the resource has been added,
+ * false if another resource with the same UUID already existed.
+ * Note that if it finds a repeated UUID, the resource is not inserted in
+ * the lookup table.
+ */
+bool virtio_add_dmabuf(QemuUUID *uuid, int dmabuf_fd);
+
+/**
+ * virtio_remove_resource() - Removes a resource from the lookup table
+ * @uuid: resource's UUID
+ *
+ * Return: true if the UUID has been found and removed from the lookup table.
+ */
+bool virtio_remove_resource(const QemuUUID *uuid);
+
+/**
+ * virtio_lookup_dmabuf() - Looks for a dma-buf resource in the lookup table
+ * @uuid: resource's UUID
+ *
+ * Return: the dma-buf file descriptor integer, or -1 if the key is not found.
+ */
+int virtio_lookup_dmabuf(const QemuUUID *uuid);
+
+/**
+ * virtio_free_resources() - Destroys all keys and values of the shared
+ * resources lookup table, and frees them
+ */
+void virtio_free_resources(void);
+
+#endif /* VIRTIO_DMABUF_H */
diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index 93977cc32d..425ecc30fb 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -50,6 +50,7 @@ tests = {
   'test-qapi-util': [],
   'test-interval-tree': [],
   'test-xs-node': [qom],
+  'test-virtio-dmabuf': [meson.project_source_root() / 'hw/display/virtio-dmabuf.c'],
 }
 
 if have_system or have_tools
diff --git a/tests/unit/test-virtio-dmabuf.c b/tests/unit/test-virtio-dmabuf.c
new file mode 100644
index 0000000000..53436aa93d
--- /dev/null
+++ b/tests/unit/test-virtio-dmabuf.c
@@ -0,0 +1,112 @@
+/*
+ * QEMU tests for shared dma-buf API
+ *
+ * Copyright (c) 2023 Red Hat, Inc.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "hw/virtio/virtio-dmabuf.h"
+
+
+static void test_add_remove_resources(void)
+{
+    QemuUUID uuid;
+    int i, dmabuf_fd;
+
+    for (i = 0; i < 100; ++i) {
+        qemu_uuid_generate(&uuid);
+        dmabuf_fd = g_random_int_range(3, 500);
+        /* Add a new resource */
+        g_assert(virtio_add_dmabuf(&uuid, dmabuf_fd));
+        g_assert_cmpint(virtio_lookup_dmabuf(&uuid), ==, dmabuf_fd);
+        /* Remove the resource */
+        g_assert(virtio_remove_resource(&uuid));
+        /* Resource is not found anymore */
+        g_assert_cmpint(virtio_lookup_dmabuf(&uuid), ==, -1);
+    }
+}
+
+static void test_remove_invalid_resource(void)
+{
+    QemuUUID uuid;
+    int i;
+
+    for (i = 0; i < 20; ++i) {
+        qemu_uuid_generate(&uuid);
+        g_assert_cmpint(virtio_lookup_dmabuf(&uuid), ==, -1);
+        /* Removing a resource that does not exist returns false */
+        g_assert_false(virtio_remove_resource(&uuid));
+    }
+}
+
+static void test_add_invalid_resource(void)
+{
+    QemuUUID uuid;
+    int i, dmabuf_fd = -2, alt_dmabuf = 2;
+
+    for (i = 0; i < 20; ++i) {
+        qemu_uuid_generate(&uuid);
+        /* Add a new resource with invalid (negative) resource fd */
+        g_assert_false(virtio_add_dmabuf(&uuid, dmabuf_fd));
+        /* Resource is not found */
+        g_assert_cmpint(virtio_lookup_dmabuf(&uuid), ==, -1);
+    }
+
+    for (i = 0; i < 20; ++i) {
+        /* Add a valid resource */
+        qemu_uuid_generate(&uuid);
+        dmabuf_fd = g_random_int_range(3, 500);
+        g_assert(virtio_add_dmabuf(&uuid, dmabuf_fd));
+        g_assert_cmpint(virtio_lookup_dmabuf(&uuid), ==, dmabuf_fd);
+        /* Add a new resource with repeated uuid returns false */
+        g_assert_false(virtio_add_dmabuf(&uuid, alt_dmabuf));
+        /* The value for the uuid key is not replaced */
+        g_assert_cmpint(virtio_lookup_dmabuf(&uuid), ==, dmabuf_fd);
+    }
+}
+
+static void test_free_resources(void)
+{
+    QemuUUID uuids[20];
+    int i, dmabuf_fd;
+
+    for (i = 0; i < ARRAY_SIZE(uuids); ++i) {
+        qemu_uuid_generate(&uuids[i]);
+        dmabuf_fd = g_random_int_range(3, 500);
+        g_assert(virtio_add_dmabuf(&uuids[i], dmabuf_fd));
+        g_assert_cmpint(virtio_lookup_dmabuf(&uuids[i]), ==, dmabuf_fd);
+    }
+    virtio_free_resources();
+    for (i = 0; i < ARRAY_SIZE(uuids); ++i) {
+        /* None of the resources is found after free'd */
+        g_assert_cmpint(virtio_lookup_dmabuf(&uuids[i]), ==, -1);
+    }
+
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    g_test_add_func("/virtio-dmabuf/add_rm_res", test_add_remove_resources);
+    g_test_add_func("/virtio-dmabuf/rm_invalid_res",
+                    test_remove_invalid_resource);
+    g_test_add_func("/virtio-dmabuf/add_invalid_res",
+                    test_add_invalid_resource);
+    g_test_add_func("/virtio-dmabuf/free_res", test_free_resources);
+
+    return g_test_run();
+}
-- 
2.40.0


