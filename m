Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FFF781182
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:20:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX38j-0003T5-Fz; Fri, 18 Aug 2023 13:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1qX38h-0003SY-7f
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:19:59 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1qX38e-0001Em-MD
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:19:58 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37IEl839002282; Fri, 18 Aug 2023 17:19:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=YVCB4+T5LusCWAtTcaQpBPNkOZSDCOklUxQOFz0LvTY=;
 b=TutesaxA8HeH1OOtP+aTd5iiRdwe8XNsjmfihWImuBtwx1JmOafq4CxQf297pP1EWFcf
 Sek8UqVRhCHsqbiW2f96Cy31ltovdKaTjBp4x3y0j/KEl6NZ8qxSo4F2GjTrm8JreiZU
 c7/Hq98oJ8nT0Iz0/NfZ9EoX98A/SLjWW71D6ics00ht1BThX4mC2AOSpXPzQGWNQpqu
 +vQz3ekv+LjQd3TtVviXK32YGGkrgr4q9DrsBGg68vnoxX5Y1712e7SLRKttzy1cm4AZ
 3Yzi4aCAsvgFAsknkZ613iO3Z4JfuLa/Jva0zUs9efDKLsvDFdr62sgp9iydTM7SJxTg Bw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se314cfxu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Aug 2023 17:19:49 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 37IFiQhZ020100; Fri, 18 Aug 2023 17:19:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3sey40pe07-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Aug 2023 17:19:37 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37IHJU23009206;
 Fri, 18 Aug 2023 17:19:35 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-65-173-148.vpn.oracle.com
 [10.65.173.148])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3sey40pds5-3; Fri, 18 Aug 2023 17:19:35 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, laurent@vivier.eu, mst@redhat.com,
 boris.ostrovsky@oracle.com, alex.bennee@linaro.org,
 viresh.kumar@linaro.org, armbru@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net
Subject: [PATCH v4 2/3] qmp: update virtio feature maps,
 vhost-user-gpio introspection
Date: Fri, 18 Aug 2023 13:19:25 -0400
Message-Id: <20230818171926.3136840-3-jonah.palmer@oracle.com>
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
X-Proofpoint-GUID: ZhdVySM8rtWNm4ovjP56l7zJRVjbTMYR
X-Proofpoint-ORIG-GUID: ZhdVySM8rtWNm4ovjP56l7zJRVjbTMYR
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add new vhost-user protocol feature to vhost-user protocol feature map
and enumeration:
 - VHOST_USER_PROTOCOL_F_STATUS

Add new virtio device features for several virtio devices to their
respective feature mappings:

virtio-blk:
 - VIRTIO_BLK_F_SECURE_ERASE

virtio-net:
 - VIRTIO_NET_F_NOTF_COAL
 - VIRTIO_NET_F_GUEST_USO4
 - VIRTIO_NET_F_GUEST_USO6
 - VIRTIO_NET_F_HOST_USO

virtio/vhost-user-gpio:
 - VIRTIO_GPIO_F_IRQ
 - VHOST_USER_F_PROTOCOL_FEATURES

Add support for introspection on vhost-user-gpio devices.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---

 Jonah: The previous version of this patch included the
 'VIRTIO_F_RING_RESET' feature being added to the virtio transport
 feature map but is no longer included here as it was added in a
 separate patch series that was recently pulled in.

 The previous version also included the 'VHOST_F_LOG_ALL' feature for
 vhost-user-gpio. However, this was removed in this version since
 it's not used for this device nor did it make sense for it.

 hw/virtio/vhost-user-gpio.c |  7 +++++++
 hw/virtio/virtio-qmp.c      | 34 +++++++++++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user-gpio.c b/hw/virtio/vhost-user-gpio.c
index 3b013f2d0f..3d7fae3984 100644
--- a/hw/virtio/vhost-user-gpio.c
+++ b/hw/virtio/vhost-user-gpio.c
@@ -205,6 +205,12 @@ static void vu_gpio_guest_notifier_mask(VirtIODevice *vdev, int idx, bool mask)
     vhost_virtqueue_mask(&gpio->vhost_dev, vdev, idx, mask);
 }
 
+static struct vhost_dev *vu_gpio_get_vhost(VirtIODevice *vdev)
+{
+    VHostUserGPIO *gpio = VHOST_USER_GPIO(vdev);
+    return &gpio->vhost_dev;
+}
+
 static void do_vhost_user_cleanup(VirtIODevice *vdev, VHostUserGPIO *gpio)
 {
     virtio_delete_queue(gpio->command_vq);
@@ -413,6 +419,7 @@ static void vu_gpio_class_init(ObjectClass *klass, void *data)
     vdc->get_config = vu_gpio_get_config;
     vdc->set_status = vu_gpio_set_status;
     vdc->guest_notifier_mask = vu_gpio_guest_notifier_mask;
+    vdc->get_vhost = vu_gpio_get_vhost;
 }
 
 static const TypeInfo vu_gpio_info = {
diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index ac5f0ee0ee..9c3284e6c3 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -30,6 +30,7 @@
 #include "standard-headers/linux/virtio_iommu.h"
 #include "standard-headers/linux/virtio_mem.h"
 #include "standard-headers/linux/virtio_vsock.h"
+#include "standard-headers/linux/virtio_gpio.h"
 
 #include CONFIG_DEVICES
 
@@ -53,6 +54,7 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_RESET_DEVICE = 13,
     VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS = 14,
     VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS = 15,
+    VHOST_USER_PROTOCOL_F_STATUS = 16,
     VHOST_USER_PROTOCOL_F_MAX
 };
 
@@ -136,6 +138,9 @@ static const qmp_virtio_feature_map_t vhost_user_protocol_map[] = {
     FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS, \
             "VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS: Configuration for "
             "memory slots supported"),
+    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_STATUS, \
+            "VHOST_USER_PROTOCOL_F_STATUS: Querying and notifying back-end "
+            "device status supported"),
     { -1, "" }
 };
 
@@ -178,6 +183,8 @@ static const qmp_virtio_feature_map_t virtio_blk_feature_map[] = {
             "VIRTIO_BLK_F_DISCARD: Discard command supported"),
     FEATURE_ENTRY(VIRTIO_BLK_F_WRITE_ZEROES, \
             "VIRTIO_BLK_F_WRITE_ZEROES: Write zeroes command supported"),
+    FEATURE_ENTRY(VIRTIO_BLK_F_SECURE_ERASE, \
+            "VIRTIO_BLK_F_SECURE_ERASE: Secure erase supported"),
     FEATURE_ENTRY(VIRTIO_BLK_F_ZONED, \
             "VIRTIO_BLK_F_ZONED: Zoned block devices"),
 #ifndef VIRTIO_BLK_NO_LEGACY
@@ -301,6 +308,14 @@ static const qmp_virtio_feature_map_t virtio_net_feature_map[] = {
     FEATURE_ENTRY(VIRTIO_NET_F_CTRL_MAC_ADDR, \
             "VIRTIO_NET_F_CTRL_MAC_ADDR: MAC address set through control "
             "channel"),
+    FEATURE_ENTRY(VIRTIO_NET_F_NOTF_COAL, \
+            "VIRTIO_NET_F_NOTF_COAL: Device supports coalescing notifications"),
+    FEATURE_ENTRY(VIRTIO_NET_F_GUEST_USO4, \
+            "VIRTIO_NET_F_GUEST_USO4: Driver can receive USOv4"),
+    FEATURE_ENTRY(VIRTIO_NET_F_GUEST_USO6, \
+            "VIRTIO_NET_F_GUEST_USO4: Driver can receive USOv6"),
+    FEATURE_ENTRY(VIRTIO_NET_F_HOST_USO, \
+            "VIRTIO_NET_F_HOST_USO: Device can receive USO"),
     FEATURE_ENTRY(VIRTIO_NET_F_HASH_REPORT, \
             "VIRTIO_NET_F_HASH_REPORT: Hash reporting supported"),
     FEATURE_ENTRY(VIRTIO_NET_F_RSS, \
@@ -471,6 +486,18 @@ static const qmp_virtio_feature_map_t virtio_rng_feature_map[] = {
 };
 #endif
 
+/* virtio/vhost-gpio features mapping */
+#ifdef CONFIG_VHOST_USER_GPIO
+static const qmp_virtio_feature_map_t virtio_gpio_feature_map[] = {
+    FEATURE_ENTRY(VIRTIO_GPIO_F_IRQ, \
+            "VIRTIO_GPIO_F_IRQ: Device supports interrupts on GPIO lines"),
+    FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
+            "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
+            "negotiation supported"),
+    { -1, "" }
+};
+#endif
+
 #define CONVERT_FEATURES(type, map, is_status, bitmap)   \
     ({                                                   \
         type *list = NULL;                               \
@@ -627,6 +654,12 @@ VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap)
         features->dev_features =
             CONVERT_FEATURES(strList, virtio_rng_feature_map, 0, bitmap);
         break;
+#endif
+#ifdef CONFIG_VHOST_USER_GPIO
+    case VIRTIO_ID_GPIO:
+        features->dev_features =
+            CONVERT_FEATURES(strList, virtio_gpio_feature_map, 0, bitmap);
+        break;
 #endif
     /* No features */
     case VIRTIO_ID_9P:
@@ -653,7 +686,6 @@ VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap)
     case VIRTIO_ID_DMABUF:
     case VIRTIO_ID_PARAM_SERV:
     case VIRTIO_ID_AUDIO_POLICY:
-    case VIRTIO_ID_GPIO:
         break;
     default:
         g_assert_not_reached();
-- 
2.39.3


