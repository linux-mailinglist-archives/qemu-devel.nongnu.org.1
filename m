Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20ACC729EEA
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 17:44:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7c30-00070p-Bm; Fri, 09 Jun 2023 09:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1q7c2y-00070N-8O
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 09:20:56 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1q7c2w-0000TC-81
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 09:20:55 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3598aPYc014732; Fri, 9 Jun 2023 13:20:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=hjtSKzz7O6A6lV+1ELfYKO6t/rtB8xNG5bvjFTu6Fgo=;
 b=Ra8FzzvLkQfYjKPukF/zU7gnbNerLmVh1HMifJUWReRk0wYhATu4FHryTK6fs3L73wxG
 SXEZEY0rD8x0pKnnwlyqjmGEpRZKgcY5AL1ys70lONZUkbRS4HbmWtDWeaWr8jGeZZfn
 VEwglRyP0uysJeMdFeC+lE8tXUhCGWKPxvKKgI1nbZ4QCBOtu4uQa0pTFbhTvw7J+6Pv
 FhnAbVwuRqHDlu8zNqhsbmyhqY5SQ6oIpfUwbwUNp7tptwNd+M9JOJUb7QG8ClhX5jSr
 BucD15vkszvF6MMGHbDAqZE5mlEGqMou+kmy8pfB4FoX32LEZSSnEGk0r0Xj/KmjZc2s Yw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6ppk3t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 09 Jun 2023 13:20:48 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 359DFlBY015682; Fri, 9 Jun 2023 13:20:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r2a6pdh9s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 09 Jun 2023 13:20:47 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 359DK5Y9035303;
 Fri, 9 Jun 2023 13:20:46 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-39-219-26.vpn.oracle.com
 [10.39.219.26])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3r2a6pdh62-2; Fri, 09 Jun 2023 13:20:46 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, laurent@vivier.eu, mst@redhat.com,
 boris.ostrovsky@oracle.com, alex.bennee@linaro.org,
 viresh.kumar@linaro.org, armbru@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net
Subject: [PATCH v2 1/2] qmp: remove virtio_list, search QOM tree instead
Date: Fri,  9 Jun 2023 09:20:39 -0400
Message-Id: <20230609132040.2180710-2-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230609132040.2180710-1-jonah.palmer@oracle.com>
References: <20230609132040.2180710-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_09,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0 bulkscore=0
 spamscore=0 mlxlogscore=948 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306090113
X-Proofpoint-ORIG-GUID: E78P75EXr7JqbhHiPIUS3BZlup1XivXf
X-Proofpoint-GUID: E78P75EXr7JqbhHiPIUS3BZlup1XivXf
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The virtio_list duplicates information about virtio devices that already
exist in the QOM composition tree. Instead of creating this list of
realized virtio devices, search the QOM composition tree instead.

This patch modifies the QMP command qmp_x_query_virtio to instead search
the partial paths of '/machine/peripheral/' &
'/machine/peripheral-anon/' in the QOM composition tree for virtio
devices.

A device is found to be a valid virtio device if (1) its canonical path
is of 'TYPE_VIRTIO_DEVICE' and (2) the device has been realized.

[Jonah: In the previous commit I had written that a device is found to
 be a valid virtio device if (1) it has a canonical path ending with
 'virtio-backend'.

 The code now determines if it's a virtio device by appending
 'virtio-backend' (if needed) to a given canonical path and then
 checking that path to see if the device is of type
'TYPE_VIRTIO_DEVICE'.

 The patch also instead now checks to make sure it's a virtio device
 before attempting to check whether the device is realized or not.]

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/virtio/virtio-qmp.c | 128 ++++++++++++++++++++++++++---------------
 hw/virtio/virtio-qmp.h |   8 +--
 hw/virtio/virtio.c     |   6 --
 3 files changed, 82 insertions(+), 60 deletions(-)

diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index b5e1835299..e936cc8ce5 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -668,67 +668,101 @@ VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap)
 VirtioInfoList *qmp_x_query_virtio(Error **errp)
 {
     VirtioInfoList *list = NULL;
-    VirtioInfo *node;
-    VirtIODevice *vdev;
 
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
+    /* Query the QOM composition tree for virtio devices */
+    qmp_set_virtio_device_list("/machine/peripheral/", &list);
+    qmp_set_virtio_device_list("/machine/peripheral-anon/", &list);
+    if (list == NULL) {
+        error_setg(errp, "No virtio devices found");
+        return NULL;
+    }
+    return list;
+}
+
+/* qmp_set_virtio_device_list:
+ * @ppath: An incomplete peripheral path to search from.
+ * @list: A list of realized virtio devices.
+ * Searches a given incomplete peripheral path (e.g. '/machine/peripheral/'
+ * or '/machine/peripheral-anon/') for realized virtio devices and adds them
+ * to a given list of virtio devices.
+ */
+void qmp_set_virtio_device_list(const char *ppath, VirtioInfoList **list)
+{
+    ObjectPropertyInfoList *plist;
+    VirtioInfoList *node;
+    Error *err = NULL;
+
+    /* Search an incomplete path for virtio devices */
+    plist = qmp_qom_list(ppath, &err);
+    if (err == NULL) {
+        ObjectPropertyInfoList *start = plist;
+        while (plist != NULL) {
+            ObjectPropertyInfo *value = plist->value;
+            GString *path = g_string_new(ppath);
+            g_string_append(path, value->name);
+            g_string_append(path, "/virtio-backend");
+
+            /* Determine if full path is a realized virtio device */
+            VirtIODevice *vdev = qmp_find_virtio_device(path->str);
+            if (vdev != NULL) {
+                node = g_new0(VirtioInfoList, 1);
+                node->value = g_new(VirtioInfo, 1);
+                node->value->path = g_strdup(path->str);
+                node->value->name = g_strdup(vdev->name);
+                QAPI_LIST_PREPEND(*list, node->value);
             }
-           g_string_free(is_realized, true);
+            g_string_free(path, true);
+            plist = plist->next;
         }
-        qobject_unref(obj);
+        qapi_free_ObjectPropertyInfoList(start);
     }
-
-    return list;
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
+    Error *err = NULL;
+    char *basename;
+
+    /* Append 'virtio-backend' to path if needed */
+    basename = g_path_get_basename(path);
+    if (strcmp(basename, "virtio-backend")) {
+        GString *temp = g_string_new(path);
+        char *last = strrchr(path, '/');
+        if (g_strcmp0(last, "/")) {
+            g_string_append(temp, "/virtio-backend");
+        } else {
+            g_string_append(temp, "virtio-backend");
         }
+        path = g_strdup(temp->str);
+        g_string_free(temp, true);
+    }
 
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
+    /* Verify the canonical path is a virtio device */
+    Object *obj = object_resolve_path(path, NULL);
+    if (!obj || !object_dynamic_cast(obj, TYPE_VIRTIO_DEVICE)) {
+        object_unref(obj);
+        return NULL;
+    }
+
+    /* Verify the virtio device is realized */
+    QObject *qobj = qmp_qom_get(path, "realized", &err);
+    if (err == NULL) {
+        GString *is_realized = qobject_to_json_pretty(qobj, true);
+        if (!strncmp(is_realized->str, "false", 4)) {
             g_string_free(is_realized, true);
-        } else {
-            /* virtio device doesn't exist in QOM tree */
-            QTAILQ_REMOVE(&virtio_list, vdev, next);
-            qobject_unref(obj);
+            qobject_unref(qobj);
             return NULL;
         }
-        /* device exists in QOM tree & is realized */
-        qobject_unref(obj);
-        return vdev;
+        g_string_free(is_realized, true);
+    } else {
+        qobject_unref(qobj);
+        return NULL;
     }
-    return NULL;
+    qobject_unref(qobj);
+
+    /* Get VirtIODevice object */
+    VirtIODevice *vdev = VIRTIO_DEVICE(obj);
+    return vdev;
 }
 
 VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
diff --git a/hw/virtio/virtio-qmp.h b/hw/virtio/virtio-qmp.h
index 8af5f5e65a..4b2b7875b4 100644
--- a/hw/virtio/virtio-qmp.h
+++ b/hw/virtio/virtio-qmp.h
@@ -15,13 +15,7 @@
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/vhost.h"
 
-#include "qemu/queue.h"
-
-typedef QTAILQ_HEAD(QmpVirtIODeviceList, VirtIODevice) QmpVirtIODeviceList;
-
-/* QAPI list of realized VirtIODevices */
-extern QmpVirtIODeviceList virtio_list;
-
+void qmp_set_virtio_device_list(const char *ppath, VirtioInfoList **list);
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


