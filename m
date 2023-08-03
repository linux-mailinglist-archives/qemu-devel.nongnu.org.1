Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5869676ED4C
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 16:56:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRZjU-00070A-6x; Thu, 03 Aug 2023 10:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1qRZjS-0006yc-48
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 10:55:18 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1qRZjP-0002wq-8U
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 10:55:17 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 373CghSb007731; Thu, 3 Aug 2023 14:55:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=tEDrH7ON6rd0pZkfg1Y8K1zQmuNfn4h/SCqtfReKfyY=;
 b=0LtXGu2TETJrhG00Ww/A++X8oVZlL0mlFNFSXmB1aS8lEUL7nN22y+85NCnZAnzbJV/x
 eR8EvbF4ozst8UVaJsJQ1Sj8aPkSueQolCsb2X9E2abIAhs+ydLOGcpNeTpF4s+5/hWI
 KiwrzPJft82peXw7MOZ9VkAARKJHnP1+0pLy47/3tBl0ZyE88mRkXWxiWGcQtiFHpBpF
 hTnJ0IxEqsL4YWDZqMFm4rw4Mbgrm4ztunz6jCE3W1z6NaUnVnXMe8bnkb+68E8qtFEf
 F6X1ldk8K/BmGIbn+AelRwpFH58u+b9ULx/HUvTSX0osIiPaE9v7M8Ze/d7h678Ft9sC lg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4uav1sdd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 03 Aug 2023 14:55:11 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 373DxDIa015661; Thu, 3 Aug 2023 14:55:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3s4s79r6f3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 03 Aug 2023 14:55:10 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 373Et4ov035404;
 Thu, 3 Aug 2023 14:55:09 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-65-173-197.vpn.oracle.com
 [10.65.173.197])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3s4s79r659-4; Thu, 03 Aug 2023 14:55:09 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, laurent@vivier.eu, mst@redhat.com,
 boris.ostrovsky@oracle.com, alex.bennee@linaro.org,
 viresh.kumar@linaro.org, armbru@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net
Subject: [PATCH v3 3/3] vhost-user: move VhostUserProtocolFeature definition
 to header file
Date: Thu,  3 Aug 2023 10:55:00 -0400
Message-Id: <20230803145500.2108691-4-jonah.palmer@oracle.com>
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
X-Proofpoint-ORIG-GUID: Pvp_zYCwmM5DG50vP6o67GI94m15Kqrc
X-Proofpoint-GUID: Pvp_zYCwmM5DG50vP6o67GI94m15Kqrc
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
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
index a38b49af8a..69880fe7c5 100644
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


