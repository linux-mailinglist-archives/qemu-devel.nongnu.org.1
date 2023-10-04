Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5727B7B3E
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 11:09:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxV0-00066w-60; Wed, 04 Oct 2023 04:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxUV-0004Yk-SV
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:44:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxUS-0001MK-UC
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:44:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Ins0qLJ2S+b0ktKmityoiu5P8h7JluJ1ZGdKo7qxL0=;
 b=CCOFkcsC3lFDe02/HR6qRHu0Lju3sXm5TR0m9AtR6C1Q+rGaXA5mumE+84L8vCKmAhcyTH
 bAQqjvdcvIzRvzE52IQoeLOE8oCqxWYvDqRZIqlsxJiAOQ3R+yAh1YjiPoT9bsHs2OMxif
 tMWwZ538RdbZWn3Y2k3bDoKfC2E3C20=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-mAt8l8exPWSGfrnROx6PTQ-1; Wed, 04 Oct 2023 04:44:18 -0400
X-MC-Unique: mAt8l8exPWSGfrnROx6PTQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4053a5c6a59so12802105e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:44:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409056; x=1697013856;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6Ins0qLJ2S+b0ktKmityoiu5P8h7JluJ1ZGdKo7qxL0=;
 b=wlotJ8jijFJfmobMuabudEVViaIqZ4OQjqmmW7/hSfJFsHQ4Ui5OsNb/he+areQsa1
 wZDEiiszy1ckfeuTUUzw+6IGd8VtWSHj2Z3iQRXmyDY4AemWKG885Lfqr23obY6u0zRx
 Vkbh+QdoSxuapr8oXndws0ySMlIb9od6uT/zWIF7v00Sqmy4EDp6KDksC5BkhWbl2ZkB
 ITYsEt8TXlxufcDdUE00EbkIpa9gGgYO6NJ9mP+Ch3qSeEBBcqc1T8Q+b9RPRRSQkudd
 39FnXU2vYknz4s6vmOen3i5ExhEMPFvSTQ+Uzx6VEmazuGeWFLjbetrO1FBaF1SJayDW
 QfOA==
X-Gm-Message-State: AOJu0YzHae2LU5YIWeHoKGfgGsi5Ba21GUwtsIZoLeGoSbXAahTp/dBc
 Szj9QBN44wNRCXsmypDKnjNWSmZibQAwlrgX9LhPaJ3ET6vu/oTPs7NUKDPKLFHsTG8wrO2M8/m
 VPPwJFQ+xyh/TdRp6Jx8XWtZvx2+TMY3efNaTrTcC255fKb4CigIUBcGRAIFaba4pyJlL
X-Received: by 2002:a5d:444b:0:b0:319:52da:8f0b with SMTP id
 x11-20020a5d444b000000b0031952da8f0bmr1369990wrr.17.1696409056558; 
 Wed, 04 Oct 2023 01:44:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJncpQhP0fvLNf1Qexgz8XXftTAlG4EIu3RHtJYYxbZsB5m5XF52OIppzQ4oE7hThDYblerg==
X-Received: by 2002:a5d:444b:0:b0:319:52da:8f0b with SMTP id
 x11-20020a5d444b000000b0031952da8f0bmr1369973wrr.17.1696409056196; 
 Wed, 04 Oct 2023 01:44:16 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 g2-20020adff3c2000000b0031984b370f2sm3481759wrp.47.2023.10.04.01.44.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:44:15 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:44:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonah Palmer <jonah.palmer@oracle.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: [PULL 21/63] qmp: remove virtio_list, search QOM tree instead
Message-ID: <fec8248007374610b19a2de3dc74975666a54f57.1696408966.git.mst@redhat.com>
References: <cover.1696408966.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696408966.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

From: Jonah Palmer <jonah.palmer@oracle.com>

The virtio_list duplicates information about virtio devices that already
exist in the QOM composition tree. Instead of creating this list of
realized virtio devices, search the QOM composition tree instead.

This patch modifies the QMP command qmp_x_query_virtio to instead
recursively search the QOM composition tree for devices of type
'TYPE_VIRTIO_DEVICE'. The device is also checked to ensure it's
realized.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20230926224107.2951144-2-jonah.palmer@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-qmp.h |  7 ----
 hw/virtio/virtio-qmp.c | 85 ++++++++++++++----------------------------
 hw/virtio/virtio.c     |  6 ---
 3 files changed, 29 insertions(+), 69 deletions(-)

diff --git a/hw/virtio/virtio-qmp.h b/hw/virtio/virtio-qmp.h
index 8af5f5e65a..245a446a56 100644
--- a/hw/virtio/virtio-qmp.h
+++ b/hw/virtio/virtio-qmp.h
@@ -15,13 +15,6 @@
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/vhost.h"
 
-#include "qemu/queue.h"
-
-typedef QTAILQ_HEAD(QmpVirtIODeviceList, VirtIODevice) QmpVirtIODeviceList;
-
-/* QAPI list of realized VirtIODevices */
-extern QmpVirtIODeviceList virtio_list;
-
 VirtIODevice *qmp_find_virtio_device(const char *path);
 VirtioDeviceStatus *qmp_decode_status(uint8_t bitmap);
 VhostDeviceProtocols *qmp_decode_protocols(uint64_t bitmap);
diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index 7515b0947b..adebf87e9b 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -667,70 +667,43 @@ VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap)
     return features;
 }
 
+static int query_dev_child(Object *child, void *opaque)
+{
+    VirtioInfoList **vdevs = opaque;
+    Object *dev = object_dynamic_cast(child, TYPE_VIRTIO_DEVICE);
+    if (dev != NULL && DEVICE(dev)->realized) {
+        VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+        VirtioInfo *info = g_new(VirtioInfo, 1);
+
+        /* Get canonical path & name of device */
+        info->path = object_get_canonical_path(dev);
+        info->name = g_strdup(vdev->name);
+        QAPI_LIST_PREPEND(*vdevs, info);
+    }
+    return 0;
+}
+
 VirtioInfoList *qmp_x_query_virtio(Error **errp)
 {
-    VirtioInfoList *list = NULL;
-    VirtioInfo *node;
-    VirtIODevice *vdev;
+    VirtioInfoList *vdevs = NULL;
 
-    QTAILQ_FOREACH(vdev, &virtio_list, next) {
-        DeviceState *dev = DEVICE(vdev);
-        Error *err = NULL;
-        QObject *obj = qmp_qom_get(dev->canonical_path, "realized", &err);
-
-        if (err == NULL) {
-            GString *is_realized = qobject_to_json_pretty(obj, true);
-            /* virtio device is NOT realized, remove it from list */
-            if (!strncmp(is_realized->str, "false", 4)) {
-                QTAILQ_REMOVE(&virtio_list, vdev, next);
-            } else {
-                node = g_new(VirtioInfo, 1);
-                node->path = g_strdup(dev->canonical_path);
-                node->name = g_strdup(vdev->name);
-                QAPI_LIST_PREPEND(list, node);
-            }
-           g_string_free(is_realized, true);
-        }
-        qobject_unref(obj);
+    /* Query the QOM composition tree recursively for virtio devices */
+    object_child_foreach_recursive(object_get_root(), query_dev_child, &vdevs);
+    if (vdevs == NULL) {
+        error_setg(errp, "No virtio devices found");
     }
-
-    return list;
+    return vdevs;
 }
 
 VirtIODevice *qmp_find_virtio_device(const char *path)
 {
-    VirtIODevice *vdev;
-
-    QTAILQ_FOREACH(vdev, &virtio_list, next) {
-        DeviceState *dev = DEVICE(vdev);
-
-        if (strcmp(dev->canonical_path, path) != 0) {
-            continue;
-        }
-
-        Error *err = NULL;
-        QObject *obj = qmp_qom_get(dev->canonical_path, "realized", &err);
-        if (err == NULL) {
-            GString *is_realized = qobject_to_json_pretty(obj, true);
-            /* virtio device is NOT realized, remove it from list */
-            if (!strncmp(is_realized->str, "false", 4)) {
-                g_string_free(is_realized, true);
-                qobject_unref(obj);
-                QTAILQ_REMOVE(&virtio_list, vdev, next);
-                return NULL;
-            }
-            g_string_free(is_realized, true);
-        } else {
-            /* virtio device doesn't exist in QOM tree */
-            QTAILQ_REMOVE(&virtio_list, vdev, next);
-            qobject_unref(obj);
-            return NULL;
-        }
-        /* device exists in QOM tree & is realized */
-        qobject_unref(obj);
-        return vdev;
+    /* Verify the canonical path is a realized virtio device */
+    Object *dev = object_dynamic_cast(object_resolve_path(path, NULL),
+                                      TYPE_VIRTIO_DEVICE);
+    if (!dev || !DEVICE(dev)->realized) {
+        return NULL;
     }
-    return NULL;
+    return VIRTIO_DEVICE(dev);
 }
 
 VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
@@ -740,7 +713,7 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
 
     vdev = qmp_find_virtio_device(path);
     if (vdev == NULL) {
-        error_setg(errp, "Path %s is not a VirtIODevice", path);
+        error_setg(errp, "Path %s is not a realized VirtIODevice", path);
         return NULL;
     }
 
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index d3a22e3d36..c727e9201b 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -45,8 +45,6 @@
 #include "standard-headers/linux/virtio_mem.h"
 #include "standard-headers/linux/virtio_vsock.h"
 
-QmpVirtIODeviceList virtio_list;
-
 /*
  * Maximum size of virtio device config space
  */
@@ -3659,7 +3657,6 @@ static void virtio_device_realize(DeviceState *dev, Error **errp)
     vdev->listener.commit = virtio_memory_listener_commit;
     vdev->listener.name = "virtio";
     memory_listener_register(&vdev->listener, vdev->dma_as);
-    QTAILQ_INSERT_TAIL(&virtio_list, vdev, next);
 }
 
 static void virtio_device_unrealize(DeviceState *dev)
@@ -3674,7 +3671,6 @@ static void virtio_device_unrealize(DeviceState *dev)
         vdc->unrealize(dev);
     }
 
-    QTAILQ_REMOVE(&virtio_list, vdev, next);
     g_free(vdev->bus_name);
     vdev->bus_name = NULL;
 }
@@ -3848,8 +3844,6 @@ static void virtio_device_class_init(ObjectClass *klass, void *data)
     vdc->stop_ioeventfd = virtio_device_stop_ioeventfd_impl;
 
     vdc->legacy_features |= VIRTIO_LEGACY_FEATURES;
-
-    QTAILQ_INIT(&virtio_list);
 }
 
 bool virtio_device_ioeventfd_enabled(VirtIODevice *vdev)
-- 
MST


