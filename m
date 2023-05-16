Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52348705713
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:27:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0Jo-0001qC-JS; Tue, 16 May 2023 15:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1pz0Jk-0001pQ-8q
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:26:40 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1pz0Jh-0007XN-EY
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:26:40 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34GG48uX028683; Tue, 16 May 2023 19:26:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=0N1wpmnGkjO01hKP4/jacatNMAygpObxunOk5qEayNQ=;
 b=0Z8TbJMkK4j3nS52QLSJAaGfBJ86lo4KZWyRhrj6xJgpGv3kjKmpnnrbozM3Cp2OK02C
 j1E30W77CtuLw8ro4fm9L4yo1jTcVW8lpxy7O5GWI8kkVYHWvdA7t+BMLp96eHg4jyUU
 bvOUBlGTVNgJHemOVxFpSjov8USBELiOxRwK6/fYj4gQCAQ8NiKYkZxLziywfPinYThS
 wwzNIsQ8L9X3s5hr+EA+NFsb1WxlvVimzOpxt2fmGqwZ0Wd0BAPgVLbuhQa6btAwxcot
 zrwvmUqk+QeJK1RiTsNjdGXftEHEvypPLQJfN/7yg7by5ZBBDCotFgtjb9dJexZybx92 Kw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2kdm45b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 May 2023 19:26:31 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34GIgkrC025066; Tue, 16 May 2023 19:26:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3qj104gdfc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 May 2023 19:26:30 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34GJQT6E032785;
 Tue, 16 May 2023 19:26:29 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-65-174-59.vpn.oracle.com
 [10.65.174.59])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3qj104gddw-1; Tue, 16 May 2023 19:26:29 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, laurent@vivier.eu, mst@redhat.com,
 boris.ostrovsky@oracle.com, alex.bennee@linaro.org,
 viresh.kumar@linaro.org, armbru@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net
Subject: [PATCH v1 1/2] qmp: remove virtio_list, search QOM tree instead
Date: Tue, 16 May 2023 15:26:25 -0400
Message-Id: <20230516192626.3521630-1-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_11,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305160163
X-Proofpoint-GUID: PxGMKlZ0jZQhkgbRIyHmfnqLqJcz7ovU
X-Proofpoint-ORIG-GUID: PxGMKlZ0jZQhkgbRIyHmfnqLqJcz7ovU
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

A device is found to be a valid virtio device if (1) it has a canonical
path ending with 'virtio-backend' and (2) the device has been realized.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/virtio/virtio-qmp.c | 121 ++++++++++++++++++++++++++---------------
 hw/virtio/virtio-qmp.h |   8 +--
 hw/virtio/virtio.c     |   6 --
 3 files changed, 77 insertions(+), 58 deletions(-)

diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index b70148aba9..3afc3a8ece 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -666,68 +666,99 @@ VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap)
 VirtioInfoList *qmp_x_query_virtio(Error **errp)
 {
     VirtioInfoList *list = NULL;
-    VirtioInfoList *node;
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
                 node = g_new0(VirtioInfoList, 1);
                 node->value = g_new(VirtioInfo, 1);
-                node->value->path = g_strdup(dev->canonical_path);
+                node->value->path = g_strdup(path->str);
                 node->value->name = g_strdup(vdev->name);
-                QAPI_LIST_PREPEND(list, node->value);
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
+    }
+    qobject_unref(qobj);
+
+    /* Get VirtIODevice object */
+    Object *obj = object_resolve_path(path, NULL);
+    if (!obj) {
+        object_unref(obj);
+        return NULL;
     }
-    return NULL;
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
index 272d930721..a7fa807464 100644
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
@@ -3619,7 +3617,6 @@ static void virtio_device_realize(DeviceState *dev, Error **errp)
     vdev->listener.commit = virtio_memory_listener_commit;
     vdev->listener.name = "virtio";
     memory_listener_register(&vdev->listener, vdev->dma_as);
-    QTAILQ_INSERT_TAIL(&virtio_list, vdev, next);
 }
 
 static void virtio_device_unrealize(DeviceState *dev)
@@ -3634,7 +3631,6 @@ static void virtio_device_unrealize(DeviceState *dev)
         vdc->unrealize(dev);
     }
 
-    QTAILQ_REMOVE(&virtio_list, vdev, next);
     g_free(vdev->bus_name);
     vdev->bus_name = NULL;
 }
@@ -3808,8 +3804,6 @@ static void virtio_device_class_init(ObjectClass *klass, void *data)
     vdc->stop_ioeventfd = virtio_device_stop_ioeventfd_impl;
 
     vdc->legacy_features |= VIRTIO_LEGACY_FEATURES;
-
-    QTAILQ_INIT(&virtio_list);
 }
 
 bool virtio_device_ioeventfd_enabled(VirtIODevice *vdev)
-- 
2.31.1


