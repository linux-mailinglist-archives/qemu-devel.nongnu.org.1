Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 796E478C3C9
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 14:08:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaxVN-00041i-HH; Tue, 29 Aug 2023 08:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1qaxVI-0003vk-92
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 08:07:28 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1qaxVA-0004GK-M8
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 08:07:27 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37T6hwQa007774; Tue, 29 Aug 2023 12:07:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=Ati6T77JkmlMaUQWeRPqUh4vZwWGpMgdnQ8Gjl2TTtg=;
 b=RypfuMvEz+ZNNs7Kl56EeDWhOmaenZwBgxASsJq/LjlFVXYwtgEIIpWWtm1q7yWff1c3
 XyqD4RieS+QJ8WGgmJ8g1jP8Dlk7cnV+L/QbFzCSDPG/TceElXTiGp29cr/+BZ0gAoy7
 8FzE9brR/D/UJsZgGOq4vp/NRbmONGOuUzuyV0SNsmmqVUJRuotovktpxSKoyBosmjwh
 pynZL3J2RbTLuUBTg3J/o+U5/V5y18xPUS36VkcrJd68G8hn/UAyp7nwvZl/5U+fdu7D
 3Jv8B4BToTHyCpgdZ43YzqHH3bioevwmJ4Gpl2lSq2Xzpei3j3BeaBTCtfpjYdSptcqO ww== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9nyvr0s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Aug 2023 12:07:18 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 37TB205Y023385; Tue, 29 Aug 2023 12:07:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3sr6hn00dg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Aug 2023 12:07:17 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37TC7AIr030216;
 Tue, 29 Aug 2023 12:07:17 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-65-179-243.vpn.oracle.com
 [10.65.179.243])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3sr6hn008y-4; Tue, 29 Aug 2023 12:07:17 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, laurent@vivier.eu, mst@redhat.com,
 boris.ostrovsky@oracle.com, alex.bennee@linaro.org,
 viresh.kumar@linaro.org, armbru@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net
Subject: [PATCH v5 3/3] vhost-user: move VhostUserProtocolFeature definition
 to header file
Date: Tue, 29 Aug 2023 08:07:07 -0400
Message-Id: <20230829120707.1809548-4-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230829120707.1809548-1-jonah.palmer@oracle.com>
References: <20230829120707.1809548-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_09,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308290105
X-Proofpoint-ORIG-GUID: Pgoy5V1OTd3Ekd5dxsskYN3zYwHPx1Ck
X-Proofpoint-GUID: Pgoy5V1OTd3Ekd5dxsskYN3zYwHPx1Ck
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
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

Move the definition of VhostUserProtocolFeature to
include/hw/virtio/vhost-user.h.

Remove previous definitions in hw/scsi/vhost-user-scsi.c,
hw/virtio/vhost-user.c, and hw/virtio/virtio-qmp.c.

Previously there were 3 separate definitions of this over 3 different
files. Now only 1 definition of this will be present for these 3 files.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/scsi/vhost-user-scsi.c      |  4 ----
 hw/virtio/vhost-user.c         | 21 ---------------------
 hw/virtio/virtio-qmp.c         | 22 +---------------------
 include/hw/virtio/vhost-user.h | 21 +++++++++++++++++++++
 4 files changed, 22 insertions(+), 46 deletions(-)

diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index ee99b19e7a..df6b66cc1a 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -39,10 +39,6 @@ static const int user_feature_bits[] = {
     VHOST_INVALID_FEATURE_BIT
 };
 
-enum VhostUserProtocolFeature {
-    VHOST_USER_PROTOCOL_F_RESET_DEVICE = 13,
-};
-
 static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t status)
 {
     VHostUserSCSI *s = (VHostUserSCSI *)vdev;
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 8dcf049d42..a096335921 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -56,27 +56,6 @@
  */
 #define VHOST_USER_MAX_CONFIG_SIZE 256
 
-enum VhostUserProtocolFeature {
-    VHOST_USER_PROTOCOL_F_MQ = 0,
-    VHOST_USER_PROTOCOL_F_LOG_SHMFD = 1,
-    VHOST_USER_PROTOCOL_F_RARP = 2,
-    VHOST_USER_PROTOCOL_F_REPLY_ACK = 3,
-    VHOST_USER_PROTOCOL_F_NET_MTU = 4,
-    VHOST_USER_PROTOCOL_F_BACKEND_REQ = 5,
-    VHOST_USER_PROTOCOL_F_CROSS_ENDIAN = 6,
-    VHOST_USER_PROTOCOL_F_CRYPTO_SESSION = 7,
-    VHOST_USER_PROTOCOL_F_PAGEFAULT = 8,
-    VHOST_USER_PROTOCOL_F_CONFIG = 9,
-    VHOST_USER_PROTOCOL_F_BACKEND_SEND_FD = 10,
-    VHOST_USER_PROTOCOL_F_HOST_NOTIFIER = 11,
-    VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD = 12,
-    VHOST_USER_PROTOCOL_F_RESET_DEVICE = 13,
-    /* Feature 14 reserved for VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS. */
-    VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS = 15,
-    VHOST_USER_PROTOCOL_F_STATUS = 16,
-    VHOST_USER_PROTOCOL_F_MAX
-};
-
 #define VHOST_USER_PROTOCOL_FEATURE_MASK ((1 << VHOST_USER_PROTOCOL_F_MAX) - 1)
 
 typedef enum VhostUserRequest {
diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index 3431711db5..1dd96ed20f 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -17,6 +17,7 @@
 #include "qapi/qapi-commands-qom.h"
 #include "qapi/qmp/qobject.h"
 #include "qapi/qmp/qjson.h"
+#include "hw/virtio/vhost-user.h"
 
 #include "standard-headers/linux/virtio_ids.h"
 #include "standard-headers/linux/vhost_types.h"
@@ -37,27 +38,6 @@
 #define FEATURE_ENTRY(name, desc) (qmp_virtio_feature_map_t) \
     { .virtio_bit = name, .feature_desc = desc }
 
-enum VhostUserProtocolFeature {
-    VHOST_USER_PROTOCOL_F_MQ = 0,
-    VHOST_USER_PROTOCOL_F_LOG_SHMFD = 1,
-    VHOST_USER_PROTOCOL_F_RARP = 2,
-    VHOST_USER_PROTOCOL_F_REPLY_ACK = 3,
-    VHOST_USER_PROTOCOL_F_NET_MTU = 4,
-    VHOST_USER_PROTOCOL_F_BACKEND_REQ = 5,
-    VHOST_USER_PROTOCOL_F_CROSS_ENDIAN = 6,
-    VHOST_USER_PROTOCOL_F_CRYPTO_SESSION = 7,
-    VHOST_USER_PROTOCOL_F_PAGEFAULT = 8,
-    VHOST_USER_PROTOCOL_F_CONFIG = 9,
-    VHOST_USER_PROTOCOL_F_BACKEND_SEND_FD = 10,
-    VHOST_USER_PROTOCOL_F_HOST_NOTIFIER = 11,
-    VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD = 12,
-    VHOST_USER_PROTOCOL_F_RESET_DEVICE = 13,
-    VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS = 14,
-    VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS = 15,
-    VHOST_USER_PROTOCOL_F_STATUS = 16,
-    VHOST_USER_PROTOCOL_F_MAX
-};
-
 /* Virtio transport features mapping */
 static const qmp_virtio_feature_map_t virtio_transport_map[] = {
     /* Virtio device transport features */
diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
index 191216a74f..80e2b4a463 100644
--- a/include/hw/virtio/vhost-user.h
+++ b/include/hw/virtio/vhost-user.h
@@ -11,6 +11,27 @@
 #include "chardev/char-fe.h"
 #include "hw/virtio/virtio.h"
 
+enum VhostUserProtocolFeature {
+    VHOST_USER_PROTOCOL_F_MQ = 0,
+    VHOST_USER_PROTOCOL_F_LOG_SHMFD = 1,
+    VHOST_USER_PROTOCOL_F_RARP = 2,
+    VHOST_USER_PROTOCOL_F_REPLY_ACK = 3,
+    VHOST_USER_PROTOCOL_F_NET_MTU = 4,
+    VHOST_USER_PROTOCOL_F_BACKEND_REQ = 5,
+    VHOST_USER_PROTOCOL_F_CROSS_ENDIAN = 6,
+    VHOST_USER_PROTOCOL_F_CRYPTO_SESSION = 7,
+    VHOST_USER_PROTOCOL_F_PAGEFAULT = 8,
+    VHOST_USER_PROTOCOL_F_CONFIG = 9,
+    VHOST_USER_PROTOCOL_F_BACKEND_SEND_FD = 10,
+    VHOST_USER_PROTOCOL_F_HOST_NOTIFIER = 11,
+    VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD = 12,
+    VHOST_USER_PROTOCOL_F_RESET_DEVICE = 13,
+    VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS = 14,
+    VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS = 15,
+    VHOST_USER_PROTOCOL_F_STATUS = 16,
+    VHOST_USER_PROTOCOL_F_MAX
+};
+
 /**
  * VhostUserHostNotifier - notifier information for one queue
  * @rcu: rcu_head for cleanup
-- 
2.39.3


