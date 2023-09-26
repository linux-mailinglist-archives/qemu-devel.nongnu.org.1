Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 602227AF66B
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 00:42:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlGk9-0005xQ-Bq; Tue, 26 Sep 2023 18:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1qlGk8-0005xB-5J
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 18:41:24 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1qlGk6-0005Tw-5i
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 18:41:23 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38QLTIi7011161; Tue, 26 Sep 2023 22:41:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=w5etLEMISJG2qsLVhiZMoZtWwzuiDUc38taoQ2VP56Q=;
 b=kvd71qoBiTf2qw1+icOSq469R8SGmwEZwvBQJBhklUrcF+6qPJJBQjpnpOqZPq8oVDWX
 yXRN6sWXXnGh5A8ArAynAVAxeGGSLY0HyxUMHiJCjBhzj5GYqhez7uVa5AwSk5L7kvHO
 umS2lfYCKsAImkgV/jj6sGnX+Xsey+vIV305cuLneT5sPEGvw0929eEMC08xsIOum7DD
 0ozIpFFys3jw/iCaNDAVHh+FRnhNY9ORA6RuoBDvggfaW84Kpp4RoPBfIGJvgGIxGj3G
 sL7YNYCTx4vNcMPEw+oy9HyPcg0Kja0/IDzIyseUiiJ8PSN/+jPLt06+g/9IeZk9J2ag OA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9rjug2cj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Sep 2023 22:41:15 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38QKvGu9003238; Tue, 26 Sep 2023 22:41:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3t9pf74c8c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Sep 2023 22:41:14 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38QMfBNn022981;
 Tue, 26 Sep 2023 22:41:14 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-65-186-167.vpn.oracle.com
 [10.65.186.167])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3t9pf74c6n-2; Tue, 26 Sep 2023 22:41:13 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, laurent@vivier.eu, mst@redhat.com,
 boris.ostrovsky@oracle.com, alex.bennee@linaro.org,
 viresh.kumar@linaro.org, armbru@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, jonah.palmer@oracle.com
Subject: [PATCH RESEND v5 1/3] qmp: remove virtio_list, search QOM tree instead
Date: Tue, 26 Sep 2023 18:41:05 -0400
Message-Id: <20230926224107.2951144-2-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230926224107.2951144-1-jonah.palmer@oracle.com>
References: <20230926224107.2951144-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_15,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309260194
X-Proofpoint-ORIG-GUID: pA8a2dpM6e2C6hJH1zzBNef-vd5KUDuc
X-Proofpoint-GUID: pA8a2dpM6e2C6hJH1zzBNef-vd5KUDuc
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
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/virtio/virtio-qmp.c | 85 ++++++++++++++----------------------------
 hw/virtio/virtio-qmp.h |  7 ----
 hw/virtio/virtio.c     |  6 ---
 3 files changed, 29 insertions(+), 69 deletions(-)

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
index 4577f3f5b3..6df5d9bec6 100644
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
@@ -3651,7 +3649,6 @@ static void virtio_device_realize(DeviceState *dev, Error **errp)
     vdev->listener.commit = virtio_memory_listener_commit;
     vdev->listener.name = "virtio";
     memory_listener_register(&vdev->listener, vdev->dma_as);
-    QTAILQ_INSERT_TAIL(&virtio_list, vdev, next);
 }
 
 static void virtio_device_unrealize(DeviceState *dev)
@@ -3666,7 +3663,6 @@ static void virtio_device_unrealize(DeviceState *dev)
         vdc->unrealize(dev);
     }
 
-    QTAILQ_REMOVE(&virtio_list, vdev, next);
     g_free(vdev->bus_name);
     vdev->bus_name = NULL;
 }
@@ -3840,8 +3836,6 @@ static void virtio_device_class_init(ObjectClass *klass, void *data)
     vdc->stop_ioeventfd = virtio_device_stop_ioeventfd_impl;
 
     vdc->legacy_features |= VIRTIO_LEGACY_FEATURES;
-
-    QTAILQ_INIT(&virtio_list);
 }
 
 bool virtio_device_ioeventfd_enabled(VirtIODevice *vdev)
-- 
2.39.3


