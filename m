Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 779167AF66D
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 00:42:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlGkA-0005xz-UN; Tue, 26 Sep 2023 18:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1qlGk8-0005xJ-LY
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 18:41:24 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1qlGk7-0005UA-3b
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 18:41:24 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38QLTKM2025086; Tue, 26 Sep 2023 22:41:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=puPbkCPkmwjn8Qang7iM1mQ6NTsVvzo3LiVOXVLjxKg=;
 b=d3sFU47GVmBLglQcwZDftXoUzMxJX4Tic223fhLy8co1Okx1sOkAlgk+wS/U7Us27JRo
 j575LQXg7k8O75grNQpa0w2oD7S7i3jT7hZAzmYcEHQdm8bwkTWk4puGH5iGXBxjQd4D
 gONskN5zBvecp1LM2bUsWSHtuY7oy63dBfwf+caO7fD+Yy74dklYFJ96E9yNPJgPRuzv
 A8QmnZGeOhVuqgGPW+GdlxSBM5gmx+kM0T15oCEAneRfRU2UGS4gBvsYArfTIqKrFEr3
 MQPZ9ABCiPhuy7J/V/q3QLPRx4yDJ4Pv0mO0Zdy1u6tme6IXOnpekDRAGXgQWsGgAh8V gA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9r2dg5fc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Sep 2023 22:41:20 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38QMPShm021222; Tue, 26 Sep 2023 22:41:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3t9pf74ca3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Sep 2023 22:41:19 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38QMfBNr022981;
 Tue, 26 Sep 2023 22:41:18 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-65-186-167.vpn.oracle.com
 [10.65.186.167])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3t9pf74c6n-4; Tue, 26 Sep 2023 22:41:18 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, laurent@vivier.eu, mst@redhat.com,
 boris.ostrovsky@oracle.com, alex.bennee@linaro.org,
 viresh.kumar@linaro.org, armbru@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, jonah.palmer@oracle.com
Subject: [PATCH RESEND v5 3/3] vhost-user: move VhostUserProtocolFeature
 definition to header file
Date: Tue, 26 Sep 2023 18:41:07 -0400
Message-Id: <20230926224107.2951144-4-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230926224107.2951144-1-jonah.palmer@oracle.com>
References: <20230926224107.2951144-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_15,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309260194
X-Proofpoint-GUID: jHsim_5NbG7Z-9l9Q0zhkEYZaKTrBzbG
X-Proofpoint-ORIG-GUID: jHsim_5NbG7Z-9l9Q0zhkEYZaKTrBzbG
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
Reviewed-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
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


