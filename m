Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7743478117F
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:20:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX38c-0003Rn-7O; Fri, 18 Aug 2023 13:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1qX38Z-0003R3-J8
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:19:51 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1qX38X-00017v-33
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:19:51 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37IEl3si024661; Fri, 18 Aug 2023 17:19:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=jfPGMiDWdJ3EEBqBE+k1S2uNwnAyyWKQLQCrRNAXtbY=;
 b=3J/LbmmIxOm1kJWVeWz58yH/ElPej1rz/RfBzNuUie7698HYELVa0zC0n1Kw8Zbqyhdr
 WfmoTub1Jp0xMImWWt7rvhDiNup/3IB3qPkYRfKJUGdxwPJLtiM9eTzK7j3AY55PnI5u
 qT/U6qLnK+xJvaMumKldcnWV0r7xiy4U3zlgwCpp4fiNc6OD4V3IfHUu2Jj0Dz1iErsM
 4yEgAh0Dry2jE/k9QdSs9KybxoPgYJsVLR6hdKxvtavHXnWESCOkJm5xFv84xcX+Qe41
 hCojqSND5h2jx/vnyLgGHqBNux230k+R3nupTQtP+7kvH19BH66xo11XAS9nl6ZOGuky TQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2w64eee-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Aug 2023 17:19:42 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 37IGm4Tr019863; Fri, 18 Aug 2023 17:19:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3sey40pdwp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Aug 2023 17:19:33 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37IHJU21009206;
 Fri, 18 Aug 2023 17:19:33 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-65-173-148.vpn.oracle.com
 [10.65.173.148])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3sey40pds5-2; Fri, 18 Aug 2023 17:19:32 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, laurent@vivier.eu, mst@redhat.com,
 boris.ostrovsky@oracle.com, alex.bennee@linaro.org,
 viresh.kumar@linaro.org, armbru@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net
Subject: [PATCH v4 1/3] qmp: remove virtio_list, search QOM tree instead
Date: Fri, 18 Aug 2023 13:19:24 -0400
Message-Id: <20230818171926.3136840-2-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230818171926.3136840-1-jonah.palmer@oracle.com>
References: <20230818171926.3136840-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_21,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308180159
X-Proofpoint-ORIG-GUID: JfrV-mHxfqjdAE4cwt5FOgsLrAFqwx8C
X-Proofpoint-GUID: JfrV-mHxfqjdAE4cwt5FOgsLrAFqwx8C
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The virtio_list duplicates information about virtio devices that already
exist in the QOM composition tree. Instead of creating this list of
realized virtio devices, search the QOM composition tree instead.

This patch modifies the QMP command qmp_x_query_virtio to instead
recursively search the QOM composition tree for devices of type
'TYPE_VIRTIO_DEVICE'. The device is also checked to ensure it's
realized.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---

 Jonah: In the v2 patches, the qmp_x_query_virtio function was
 iterating through devices found via. qmp_qom_list and appending
 "/virtio-backend" to devices' paths to check if they were a virtio
 device.

 This method was messy and involved unneeded string manipulation.

 Instead, we can use recursion with object_get_root to iterate through
 all parent and child device paths to find virtio devices.

 The qmp_find_virtio_device function was also updated to simplify the
 method of determining if a path is to a valid and realized virtio
 device.

 hw/virtio/virtio-qmp.c | 88 +++++++++++++++---------------------------
 hw/virtio/virtio-qmp.h |  7 ----
 hw/virtio/virtio.c     |  6 ---
 3 files changed, 32 insertions(+), 69 deletions(-)

diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index 7515b0947b..ac5f0ee0ee 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -667,70 +667,46 @@ VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap)
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
+        g_autofree char *path = object_get_canonical_path(dev);
 
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
+        info->path = g_strdup(path);
+        info->name = g_strdup(vdev->name);
+        QAPI_LIST_PREPEND(*vdevs, info);
     }
+    return 0;
+}
 
-    return list;
+VirtioInfoList *qmp_x_query_virtio(Error **errp)
+{
+    VirtioInfoList *vdevs = NULL;
+
+    /* Query the QOM composition tree recursively for virtio devices */
+    object_child_foreach_recursive(object_get_root(), query_dev_child, &vdevs);
+    if (vdevs == NULL) {
+        error_setg(errp, "No virtio devices found");
+    }
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
@@ -740,7 +716,7 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
 
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
index 309038fd46..6cca41ff4f 100644
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


