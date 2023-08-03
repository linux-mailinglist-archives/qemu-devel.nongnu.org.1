Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1A076ED48
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 16:56:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRZjS-0006yL-4d; Thu, 03 Aug 2023 10:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1qRZjP-0006xn-GY
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 10:55:15 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1qRZjN-0002wF-CE
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 10:55:15 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 373CgPwf015334; Thu, 3 Aug 2023 14:55:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=Ox7EAy0yI4TrTgZBaSyco6Pi84xIeTgUiUnXzgBh/qs=;
 b=XpIBaIPFfHVDRY2FhAfLrUvxTrRvogVQKesM6JKd+/YDFyypqdDd5y5kDSq0PB95WqxX
 WE73O1qGWODJVS0JtYouPtNH0grT5vF2NVtcRXsn/PQ73DTvTjsoN7EZ6vJdiayke4UV
 tRe8wOR5K/Qr+Qr4NZePG8LOs3i/s+0sVm2t68R2RQMXVR81CkpEQGKkYORI6k6Y1DLW
 8cLJYxDtN78SRdHZygyHGst9XiC3RmSgk0+hKqQD2En59Ye5XdtPJiDzV84iMGDBCDe5
 c1NBHgTAber9bCpW26Q6N0MtJQKhv1MHjGqFHIV4mg15xcm82iOj9N0JfdyVArNuH0t2 DA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4tcu1rcp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 03 Aug 2023 14:55:07 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 373DmDkI015665; Thu, 3 Aug 2023 14:55:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3s4s79r6bb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 03 Aug 2023 14:55:07 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 373Et4or035404;
 Thu, 3 Aug 2023 14:55:06 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-65-173-197.vpn.oracle.com
 [10.65.173.197])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3s4s79r659-2; Thu, 03 Aug 2023 14:55:06 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, laurent@vivier.eu, mst@redhat.com,
 boris.ostrovsky@oracle.com, alex.bennee@linaro.org,
 viresh.kumar@linaro.org, armbru@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net
Subject: [PATCH v3 1/3] qmp: remove virtio_list, search QOM tree instead
Date: Thu,  3 Aug 2023 10:54:58 -0400
Message-Id: <20230803145500.2108691-2-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230803145500.2108691-1-jonah.palmer@oracle.com>
References: <20230803145500.2108691-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_14,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308030134
X-Proofpoint-GUID: dzVVXqX7lpUg74rWfzkViBOxnXN0Jhot
X-Proofpoint-ORIG-GUID: dzVVXqX7lpUg74rWfzkViBOxnXN0Jhot
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
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

The virtio_list duplicates information about virtio devices that already
exist in the QOM composition tree. Instead of creating this list of
realized virtio devices, search the QOM composition tree instead.

This patch modifies the QMP command qmp_x_query_virtio to instead
recursively search the QOM composition tree for devices of type
'TYPE_VIRTIO_DEVICE'. The device is also checked to ensure it's
realized.

[Jonah: In the previous commit the qmp_x_query_virtio function was
 iterating through devices found via. qmp_qom_list and appending
 "/virtio-backend" to devices' paths to check if they were a virtio
 device.

 This method was messy and involved unneeded string manipulation.

 Instead, we can use recursion with object_get_root to iterate through
 all parent and child device paths to find virtio devices.

 The qmp_find_virtio_device function was also updated to simplify the
 method of determining if a path is to a valid and realized virtio
 device.]

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/virtio/virtio-qmp.c | 96 ++++++++++++++++++------------------------
 hw/virtio/virtio-qmp.h |  7 ---
 hw/virtio/virtio.c     |  6 ---
 3 files changed, 40 insertions(+), 69 deletions(-)

diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index 3d32dbec8d..baec351c4f 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -665,70 +665,54 @@ VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap)
     return features;
 }
 
-VirtioInfoList *qmp_x_query_virtio(Error **errp)
+static int query_dev_child(Object *child, void *opaque)
 {
-    VirtioInfoList *list = NULL;
-    VirtioInfo *node;
-    VirtIODevice *vdev;
+    VirtioInfoList **vdevs = opaque;
+    Object *dev = object_dynamic_cast(child, TYPE_VIRTIO_DEVICE);
+    if (dev != NULL && DEVICE(dev)->realized) {
+        VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+
+        VirtioInfo *info = g_new(VirtioInfo, 1);
+
+        /* Get canonical path of device */
+        gchar *path = object_get_canonical_path(dev);
+
+        info->path = g_strdup(path);
+        info->name = g_strdup(vdev->name);
+        QAPI_LIST_PREPEND(*vdevs, info);
 
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
+        g_free(path);
+    } else {
+        object_unref(dev);
     }
 
-    return list;
+    return 0;
 }
 
-VirtIODevice *qmp_find_virtio_device(const char *path)
+VirtioInfoList *qmp_x_query_virtio(Error **errp)
 {
-    VirtIODevice *vdev;
+    VirtioInfoList *vdevs = NULL;
 
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
+    /* Query the QOM composition tree recursively for virtio devices */
+    object_child_foreach_recursive(object_get_root(), query_dev_child, &vdevs);
+    if (vdevs == NULL) {
+        error_setg(errp, "No virtio devices found");
+        return NULL;
     }
-    return NULL;
+    return vdevs;
+}
+
+VirtIODevice *qmp_find_virtio_device(const char *path)
+{
+    /* Verify the canonical path is a realized virtio device */
+    Object *dev = object_dynamic_cast(object_resolve_path(path, NULL),
+                                      TYPE_VIRTIO_DEVICE);
+    if (!dev || !DEVICE(dev)->realized) {
+        object_unref(dev);
+        return NULL;
+    }
+
+    return VIRTIO_DEVICE(dev);
 }
 
 VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
@@ -738,7 +722,7 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
 
     vdev = qmp_find_virtio_device(path);
     if (vdev == NULL) {
-        error_setg(errp, "Path %s is not a VirtIODevice", path);
+        error_setg(errp, "Path %s is not a realized VirtIODevice", path);
         return NULL;
     }
 
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
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 295a603e58..83c5db3d26 100644
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
@@ -3616,7 +3614,6 @@ static void virtio_device_realize(DeviceState *dev, Error **errp)
     vdev->listener.commit = virtio_memory_listener_commit;
     vdev->listener.name = "virtio";
     memory_listener_register(&vdev->listener, vdev->dma_as);
-    QTAILQ_INSERT_TAIL(&virtio_list, vdev, next);
 }
 
 static void virtio_device_unrealize(DeviceState *dev)
@@ -3631,7 +3628,6 @@ static void virtio_device_unrealize(DeviceState *dev)
         vdc->unrealize(dev);
     }
 
-    QTAILQ_REMOVE(&virtio_list, vdev, next);
     g_free(vdev->bus_name);
     vdev->bus_name = NULL;
 }
@@ -3805,8 +3801,6 @@ static void virtio_device_class_init(ObjectClass *klass, void *data)
     vdc->stop_ioeventfd = virtio_device_stop_ioeventfd_impl;
 
     vdc->legacy_features |= VIRTIO_LEGACY_FEATURES;
-
-    QTAILQ_INIT(&virtio_list);
 }
 
 bool virtio_device_ioeventfd_enabled(VirtIODevice *vdev)
-- 
2.39.3


