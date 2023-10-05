Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6E37B9A73
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 05:49:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFMO-0007g7-Of; Wed, 04 Oct 2023 23:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFMJ-0007Ek-9X
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:49:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFMF-0001PB-1h
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:49:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696477742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QIZFTDtcHLZEWOs9w2yLpIydiDk9DmmNiU1rmzLhTo8=;
 b=Ae2JRwwZ0Sfkw/LIoZh5Ep23UKHlE/Vjp4C/CXW7Ic6HIdQnXIgCVWrCu6+/2JMuMY6flV
 EdnTYoe8TqZVKGEY4TCz/YDAxbUHU0fI4EFEro4RdA+3JL9jYVa7X7OcZb9PZNk4MA8pJU
 VKc8cG6J1fIZnFwccgUtKU/GR3JoKHQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-iSh7y2K6PdCLRuYfDPTV_g-1; Wed, 04 Oct 2023 23:45:56 -0400
X-MC-Unique: iSh7y2K6PdCLRuYfDPTV_g-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4065d52a83aso4031625e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 20:45:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696477555; x=1697082355;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QIZFTDtcHLZEWOs9w2yLpIydiDk9DmmNiU1rmzLhTo8=;
 b=E15LyR7s23pyrbLCrn8PojuBNMukka1m7v+xwD4ZETI0CJs9WG5m3TSsYdLoHaEUR4
 Jj+V5B97NE60gO9KVLjlMoUreBgUBFoIHC0CejI4rZiREraqebFHwtAqgcsld+o9CMbT
 Q3EKlgPbewfU6krDMsc1G2Q5fhlrwmRbHKgPRC/iCQDpF57jH/K9M/wfVObwAlUQDq30
 Ql+hSuYjiv9kt51m73WaMur1kh1avtB296YLhNSSvq609D9FbZx+b/k5/j5TBAgVH4Gn
 8JA5drMgNZ6hm3TxrQXIljYsC0de/yBoHLZTF3ctr/vVktClhMWMdukMMkNkMVpCnnJh
 caBw==
X-Gm-Message-State: AOJu0Yy94Lc+QRzCF0efsJ6SVnr5VJY+ITVKKMqJj0ogiXZzNTVredmm
 osHsA/Q1S0iVvOdB4XMKSKAJVVF1khyPE6LlE1o/kl2aZxpwDooOH7316Au0U5Pe7dKuYXWf3Qn
 /HXIaisJ49uGtCZi75dQr0mCYVGz2DAYGn60Iih3uaa9glcHjTAWDUpdV+klTZs0B/hEI
X-Received: by 2002:a7b:c8c8:0:b0:402:cf9f:c02d with SMTP id
 f8-20020a7bc8c8000000b00402cf9fc02dmr3860005wml.8.1696477554880; 
 Wed, 04 Oct 2023 20:45:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkE9UzdcsJeAuTLdGsomCvCfC4MhQv5x1P1+Spytkkwujow3kRdtmHB7xqCg3NglTvGmXbDw==
X-Received: by 2002:a7b:c8c8:0:b0:402:cf9f:c02d with SMTP id
 f8-20020a7bc8c8000000b00402cf9fc02dmr3859993wml.8.1696477554504; 
 Wed, 04 Oct 2023 20:45:54 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 6-20020a05600c22c600b0040303a9965asm2793292wmg.40.2023.10.04.20.45.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 20:45:53 -0700 (PDT)
Date: Wed, 4 Oct 2023 23:45:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Albert Esteve <aesteve@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 51/53] hw/display: introduce virtio-dmabuf
Message-ID: <faefdba8474fbc30427a64caa4dcd6df611f5b60.1696477105.git.mst@redhat.com>
References: <cover.1696477105.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696477105.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Albert Esteve <aesteve@redhat.com>

This API manages objects (in this iteration,
dmabuf fds) that can be shared along different
virtio devices, associated to a UUID.

The API allows the different devices to add,
remove and/or retrieve the objects by simply
invoking the public functions that reside in the
virtio-dmabuf file.

For vhost backends, the API stores the pointer
to the backend holding the object.

Suggested-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Albert Esteve <aesteve@redhat.com>
Message-Id: <20231002065706.94707-3-aesteve@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio-dmabuf.h | 100 ++++++++++++++++++++++
 hw/display/virtio-dmabuf.c        | 138 ++++++++++++++++++++++++++++++
 tests/unit/test-virtio-dmabuf.c   | 137 +++++++++++++++++++++++++++++
 MAINTAINERS                       |   7 ++
 hw/display/meson.build            |   1 +
 tests/unit/meson.build            |   1 +
 6 files changed, 384 insertions(+)
 create mode 100644 include/hw/virtio/virtio-dmabuf.h
 create mode 100644 hw/display/virtio-dmabuf.c
 create mode 100644 tests/unit/test-virtio-dmabuf.c

diff --git a/include/hw/virtio/virtio-dmabuf.h b/include/hw/virtio/virtio-dmabuf.h
new file mode 100644
index 0000000000..627c3b6db7
--- /dev/null
+++ b/include/hw/virtio/virtio-dmabuf.h
@@ -0,0 +1,100 @@
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
+#include "qemu/uuid.h"
+#include "vhost.h"
+
+typedef enum SharedObjectType {
+    TYPE_INVALID = 0,
+    TYPE_DMABUF,
+    TYPE_VHOST_DEV,
+} SharedObjectType;
+
+typedef struct VirtioSharedObject {
+    SharedObjectType type;
+    gpointer value;
+} VirtioSharedObject;
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
+ * virtio_add_vhost_device() - Add a new exporter vhost device that holds the
+ * resource with the associated UUID
+ * @uuid: new resource's UUID
+ * @dev: the pointer to the vhost device that holds the resource. The caller
+ *       retains ownership over the device struct and its lifecycle.
+ *
+ * Return: true if the UUID did not exist and the device has been tracked,
+ * false if another resource with the same UUID already existed.
+ * Note that if it finds a repeated UUID, the resource is not inserted in
+ * the lookup table.
+ */
+bool virtio_add_vhost_device(QemuUUID *uuid, struct vhost_dev *dev);
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
+ * virtio_lookup_vhost_device() - Looks for an exporter vhost device in the
+ * lookup table
+ * @uuid: resource's UUID
+ *
+ * Return: pointer to the vhost_dev struct, or NULL if the key is not found.
+ */
+struct vhost_dev *virtio_lookup_vhost_device(const QemuUUID *uuid);
+
+/**
+ * virtio_object_type() - Looks for the type of resource in the lookup table
+ * @uuid: resource's UUID
+ *
+ * Return: the type of resource associated with the UUID, or TYPE_INVALID if
+ * the key is not found.
+ */
+SharedObjectType virtio_object_type(const QemuUUID *uuid);
+
+/**
+ * virtio_free_resources() - Destroys all keys and values of the shared
+ * resources lookup table, and frees them
+ */
+void virtio_free_resources(void);
+
+#endif /* VIRTIO_DMABUF_H */
diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c
new file mode 100644
index 0000000000..4a8e430f3d
--- /dev/null
+++ b/hw/display/virtio-dmabuf.c
@@ -0,0 +1,138 @@
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
+#include "qemu/osdep.h"
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
+static bool virtio_add_resource(QemuUUID *uuid, VirtioSharedObject *value)
+{
+    bool result = false;
+
+    g_mutex_lock(&lock);
+    if (resource_uuids == NULL) {
+        resource_uuids = g_hash_table_new_full(qemu_uuid_hash,
+                                               uuid_equal_func,
+                                               NULL,
+                                               g_free);
+    }
+    if (g_hash_table_lookup(resource_uuids, uuid) == NULL) {
+        result = g_hash_table_insert(resource_uuids, uuid, value);
+    }
+    g_mutex_unlock(&lock);
+
+    return result;
+}
+
+bool virtio_add_dmabuf(QemuUUID *uuid, int udmabuf_fd)
+{
+    bool result;
+    VirtioSharedObject *vso;
+    if (udmabuf_fd < 0) {
+        return false;
+    }
+    vso = g_new(VirtioSharedObject, 1);
+    vso->type = TYPE_DMABUF;
+    vso->value = GINT_TO_POINTER(udmabuf_fd);
+    result = virtio_add_resource(uuid, vso);
+
+    return result;
+}
+
+bool virtio_add_vhost_device(QemuUUID *uuid, struct vhost_dev *dev)
+{
+    bool result;
+    VirtioSharedObject *vso;
+    if (dev == NULL) {
+        return false;
+    }
+    vso = g_new(VirtioSharedObject, 1);
+    vso->type = TYPE_VHOST_DEV;
+    vso->value = dev;
+    result = virtio_add_resource(uuid, vso);
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
+static VirtioSharedObject *get_shared_object(const QemuUUID *uuid)
+{
+    gpointer lookup_res = NULL;
+
+    g_mutex_lock(&lock);
+    if (resource_uuids != NULL) {
+        lookup_res = g_hash_table_lookup(resource_uuids, uuid);
+    }
+    g_mutex_unlock(&lock);
+
+    return (VirtioSharedObject *) lookup_res;
+}
+
+int virtio_lookup_dmabuf(const QemuUUID *uuid)
+{
+    VirtioSharedObject *vso = get_shared_object(uuid);
+    if (vso == NULL) {
+        return -1;
+    }
+    assert(vso->type == TYPE_DMABUF);
+    return GPOINTER_TO_INT(vso->value);
+}
+
+struct vhost_dev *virtio_lookup_vhost_device(const QemuUUID *uuid)
+{
+    VirtioSharedObject *vso = get_shared_object(uuid);
+    if (vso == NULL) {
+        return NULL;
+    }
+    assert(vso->type == TYPE_VHOST_DEV);
+    return (struct vhost_dev *) vso->value;
+}
+
+SharedObjectType virtio_object_type(const QemuUUID *uuid)
+{
+    VirtioSharedObject *vso = get_shared_object(uuid);
+    if (vso == NULL) {
+        return TYPE_INVALID;
+    }
+    return vso->type;
+}
+
+void virtio_free_resources(void)
+{
+    g_mutex_lock(&lock);
+    g_hash_table_destroy(resource_uuids);
+    /* Reference count shall be 0 after the implicit unref on destroy */
+    resource_uuids = NULL;
+    g_mutex_unlock(&lock);
+}
diff --git a/tests/unit/test-virtio-dmabuf.c b/tests/unit/test-virtio-dmabuf.c
new file mode 100644
index 0000000000..a45ec52f42
--- /dev/null
+++ b/tests/unit/test-virtio-dmabuf.c
@@ -0,0 +1,137 @@
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
+static void test_add_remove_dev(void)
+{
+    QemuUUID uuid;
+    struct vhost_dev *dev = g_new0(struct vhost_dev, 1);
+    int i;
+
+    for (i = 0; i < 100; ++i) {
+        qemu_uuid_generate(&uuid);
+        virtio_add_vhost_device(&uuid, dev);
+        /* vhost device is found */
+        g_assert(virtio_lookup_vhost_device(&uuid) != NULL);
+        /* Remove the vhost device */
+        g_assert(virtio_remove_resource(&uuid));
+        /* vhost device is not found anymore */
+        g_assert(virtio_lookup_vhost_device(&uuid) == NULL);
+    }
+    g_free(dev);
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
+    struct vhost_dev *dev = NULL;
+    int i, dmabuf_fd = -2, alt_dmabuf = 2;
+
+    for (i = 0; i < 20; ++i) {
+        qemu_uuid_generate(&uuid);
+        /* Add a new resource with invalid (negative) resource fd */
+        g_assert_false(virtio_add_dmabuf(&uuid, dmabuf_fd));
+        /* Resource is not found */
+        g_assert_cmpint(virtio_lookup_dmabuf(&uuid), ==, -1);
+        /* Add a new vhost device with invalid (NULL) pointer */
+        g_assert_false(virtio_add_vhost_device(&uuid, dev));
+        /* vhost device is not found */
+        g_assert(virtio_lookup_vhost_device(&uuid) == NULL);
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
+    g_test_add_func("/virtio-dmabuf/add_rm_dev", test_add_remove_dev);
+    g_test_add_func("/virtio-dmabuf/rm_invalid_res",
+                    test_remove_invalid_resource);
+    g_test_add_func("/virtio-dmabuf/add_invalid_res",
+                    test_add_invalid_resource);
+    g_test_add_func("/virtio-dmabuf/free_res", test_free_resources);
+
+    return g_test_run();
+}
diff --git a/MAINTAINERS b/MAINTAINERS
index 355b1960ce..5e27ce3ceb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2154,6 +2154,13 @@ T: git https://gitlab.com/cohuck/qemu.git s390-next
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
diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index 0299ef6906..1977b302e2 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -50,6 +50,7 @@ tests = {
   'test-qapi-util': [],
   'test-interval-tree': [],
   'test-xs-node': [qom],
+  'test-virtio-dmabuf': [meson.project_source_root() / 'hw/display/virtio-dmabuf.c'],
 }
 
 if have_system or have_tools
-- 
MST


