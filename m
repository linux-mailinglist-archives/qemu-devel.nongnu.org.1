Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3AD729EFF
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 17:46:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7c32-000710-Ff; Fri, 09 Jun 2023 09:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1q7c2z-00070l-Ld
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 09:20:57 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1q7c2w-0000TI-87
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 09:20:57 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3598fxVY019336; Fri, 9 Jun 2023 13:20:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=pRXS0BcpRehLbDUJyCMToWY2XLYbJiIzTEj6CAUITaU=;
 b=4NLi9AtGtXAIr5yOPBKICrssxKRP9bMivA58MfoJBnWMuTMYpKZt5abtpsuBSfw1LbfR
 fwqE5yMqD+j41V91B4NFf2Krp2s5GEMUiqAJNY/xpExlQf0mF0DZrzFb/4U2RDzvKdCP
 HnW6P7xRkmjyi1huuoieeX+0/jyqyztiFHLWccdUqeGPXRFhEqG+8XrRGuOEWr9bH+R9
 U9nro8NmJ4tqkrZfIyEUiYSzgC+33tvaekbNKJr5pSieTij0dmNuhXts7vZMGRRkcdCj
 MRkchC3MRSiIOMbFei5y24XTshvxaPBcohZ+qMlafSnYoA05N4iOJFx99/mwGVTo+y1J qg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6refxt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 09 Jun 2023 13:20:50 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 359DBA99015974; Fri, 9 Jun 2023 13:20:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r2a6pdhbr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 09 Jun 2023 13:20:48 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 359DK5YB035303;
 Fri, 9 Jun 2023 13:20:48 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-39-219-26.vpn.oracle.com
 [10.39.219.26])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3r2a6pdh62-3; Fri, 09 Jun 2023 13:20:48 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, laurent@vivier.eu, mst@redhat.com,
 boris.ostrovsky@oracle.com, alex.bennee@linaro.org,
 viresh.kumar@linaro.org, armbru@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net
Subject: [PATCH v2 2/2] qmp: update virtio feature maps,
 vhost-user-gpio instrospection
Date: Fri,  9 Jun 2023 09:20:40 -0400
Message-Id: <20230609132040.2180710-3-jonah.palmer@oracle.com>
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
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306090113
X-Proofpoint-ORIG-GUID: kLF_8rod1E32o3Sgp_1zuENfIQnOFzv9
X-Proofpoint-GUID: kLF_8rod1E32o3Sgp_1zuENfIQnOFzv9
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

Add new virtio transport feature to transport feature map:
 - VIRTIO_F_RING_RESET

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
 - VHOST_F_LOG_ALL
 - VHOST_USER_F_PROTOCOL_FEATURES

virtio-bt:
 - VIRTIO_BT_F_VND_HCI
 - VIRTIO_BT_F_MSFT_EXT
 - VIRTIO_BT_F_AOSP_EXT
 - VIRTIO_BT_F_CONFIG_V2

virtio-scmi:
 - VIRTIO_SCMI_F_P2A_CHANNELS
 - VIRTIO_SCMI_F_SHARED_MEMORY

Add support for introspection on vhost-user-gpio devices.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/virtio/vhost-user-gpio.c |  7 ++++
 hw/virtio/virtio-qmp.c      | 79 +++++++++++++++++++++++++++++++++++--
 2 files changed, 83 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/vhost-user-gpio.c b/hw/virtio/vhost-user-gpio.c
index d6927b610a..e88ca5370f 100644
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
index e936cc8ce5..140c420d87 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -53,6 +53,7 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_RESET_DEVICE = 13,
     VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS = 14,
     VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS = 15,
+    VHOST_USER_PROTOCOL_F_STATUS = 16,
     VHOST_USER_PROTOCOL_F_MAX
 };
 
@@ -79,6 +80,8 @@ static const qmp_virtio_feature_map_t virtio_transport_map[] = {
             "VIRTIO_F_ORDER_PLATFORM: Memory accesses ordered by platform"),
     FEATURE_ENTRY(VIRTIO_F_SR_IOV, \
             "VIRTIO_F_SR_IOV: Device supports single root I/O virtualization"),
+    FEATURE_ENTRY(VIRTIO_F_RING_RESET, \
+            "VIRTIO_F_RING_RESET: Driver can reset individual VQs"),
     /* Virtio ring transport features */
     FEATURE_ENTRY(VIRTIO_RING_F_INDIRECT_DESC, \
             "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported"),
@@ -134,6 +137,9 @@ static const qmp_virtio_feature_map_t vhost_user_protocol_map[] = {
     FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS, \
             "VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS: Configuration for "
             "memory slots supported"),
+    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_STATUS, \
+            "VHOST_USER_PROTOCOL_F_STATUS: Querying and notifying back-end "
+            "device statuses supported"),
     { -1, "" }
 };
 
@@ -176,6 +182,8 @@ static const qmp_virtio_feature_map_t virtio_blk_feature_map[] = {
             "VIRTIO_BLK_F_DISCARD: Discard command supported"),
     FEATURE_ENTRY(VIRTIO_BLK_F_WRITE_ZEROES, \
             "VIRTIO_BLK_F_WRITE_ZEROES: Write zeroes command supported"),
+    FEATURE_ENTRY(VIRTIO_BLK_F_SECURE_ERASE, \
+            "VIRTIO_BLK_F_SECURE_ERASE: Secure erase supported"),
     FEATURE_ENTRY(VIRTIO_BLK_F_ZONED, \
             "VIRTIO_BLK_F_ZONED: Zoned block devices"),
 #ifndef VIRTIO_BLK_NO_LEGACY
@@ -299,6 +307,14 @@ static const qmp_virtio_feature_map_t virtio_net_feature_map[] = {
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
@@ -469,6 +485,48 @@ static const qmp_virtio_feature_map_t virtio_rng_feature_map[] = {
 };
 #endif
 
+/* virtio/vhost-gpio features mapping */
+#ifdef CONFIG_VIRTIO_GPIO
+static const qmp_virtio_feature_map_t virtio_gpio_feature_map[] = {
+    FEATURE_ENTRY(VIRTIO_GPIO_F_IRQ, \
+            "VIRTIO_GPIO_F_IRQ: Device supports interrupts on GPIO lines"),
+    FEATURE_ENTRY(VHOST_F_LOG_ALL, \
+            "VHOST_F_LOG_ALL: Logging write descriptors supported"),
+    FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
+            "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
+            "negotiation supported"),
+    { -1, "" }
+};
+#endif
+
+/* virtio-bluetooth features mapping */
+#ifdef CONFIG_VIRTIO_BT
+static const qmp_virtio_feature_map_t virtio_bt_feature_map[] = {
+    FEATURE_ENTRY(VIRTIO_BT_F_VND_HCI, \
+            "VIRTIO_BT_F_VND_HCI: Vendor command supported"),
+    FEATURE_ENTRY(VIRTIO_BT_F_MSFT_EXT, \
+            "VIRTIO_BT_F_MSFT_EXT: MSFT vendor supported"),
+    FEATURE_ENTRY(VIRTIO_BT_F_AOSP_EXT, \
+            "VIRTIO_BT_F_AOSP_EXT: AOSP vendor supported"),
+    FEATURE_ENTRY(VIRTIO_BT_F_CONFIG_V2, \
+            "VIRTIO_BT_F_CONFIG_V2: Using v2 configuration"),
+    { -1, "" }
+};
+#endif
+
+/* virtio-scmi features mapping */
+#ifdef CONFIG_VIRTIO_SCMI
+static const qmp_virtio_feature_map_t virtio_scmi_feature_map[] = {
+    FEATURE_ENTRY(VIRTIO_SCMI_F_P2A_CHANNELS, \
+            "VIRTIO_SCMI_F_P2A_CHANNELS: SCMI notifications or delayed "
+            "responses implemented"),
+    FEATURE_ENTRY(VIRTIO_SCMI_F_SHARED_MEMORY, \
+            "VIRTIO_SCMI_F_SHARED_MEMORY: SCMI shared memory region statistics "
+            "implemented"),
+    { -1, "" }
+};
+#endif
+
 #define CONVERT_FEATURES(type, map, is_status, bitmap)   \
     ({                                                   \
         type *list = NULL;                               \
@@ -625,6 +683,24 @@ VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap)
         features->dev_features =
             CONVERT_FEATURES(strList, virtio_rng_feature_map, 0, bitmap);
         break;
+#endif
+#ifdef CONFIG_VIRTIO_GPIO
+    case VIRTIO_ID_GPIO:
+        features->dev_features =
+            CONVERT_FEATURES(strList, virtio_gpio_feature_map, 0, bitmap);
+        break;
+#endif
+#ifdef CONFIG_VIRTIO_BT
+    case VIRTIO_ID_BT:
+        features->dev_features =
+            CONVERT_FEATURES(strList, virtio_bt_feature_map, 0, bitmap);
+        break;
+#endif
+#ifdef CONFIG_VIRTIO_SCMI
+    case VIRTIO_ID_SCMI:
+        features->dev_features =
+            CONVERT_FEATURES(strList, virtio_scmi_feature_map, 0, bitmap);
+        break;
 #endif
     /* No features */
     case VIRTIO_ID_9P:
@@ -640,18 +716,15 @@ VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap)
     case VIRTIO_ID_SIGNAL_DIST:
     case VIRTIO_ID_PSTORE:
     case VIRTIO_ID_SOUND:
-    case VIRTIO_ID_BT:
     case VIRTIO_ID_RPMB:
     case VIRTIO_ID_VIDEO_ENCODER:
     case VIRTIO_ID_VIDEO_DECODER:
-    case VIRTIO_ID_SCMI:
     case VIRTIO_ID_NITRO_SEC_MOD:
     case VIRTIO_ID_WATCHDOG:
     case VIRTIO_ID_CAN:
     case VIRTIO_ID_DMABUF:
     case VIRTIO_ID_PARAM_SERV:
     case VIRTIO_ID_AUDIO_POLICY:
-    case VIRTIO_ID_GPIO:
         break;
     default:
         g_assert_not_reached();
-- 
2.39.3


