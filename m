Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59344809093
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 19:51:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBJRz-0003Ta-U5; Thu, 07 Dec 2023 13:50:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJRx-0003T8-OX
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:50:17 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJRv-0006Dv-VO
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:50:17 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B7IDQpl023130; Thu, 7 Dec 2023 18:50:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=WV4sUfF5I3w3RvpHyGhWljID/vuAV76E/h7M5U6kv78=;
 b=GlRaKOyfLefvqxkVBaT7fPwPSab9JTMhNzlZBUZHTbzT9djiYxjlAidhHryRGr6oiKVT
 MclRRAdD2dyArZ/ScTHQ9oWVka4HhMaMF8pWWbrMWAF8qxO31uCCNbV1hkt3hPP43zOo
 GJ3zqw6gSN4OvxqKChxitPwbJ2VWwFpzdBwOGTi22GCh4TPz0JgOA2s0I/JZX08NTXJf
 Z/QddeV6onWCUgN6g1XMiyWUwVzbIPV3Qpxvb7zCnMyfI2ElsJlaaRMz42Ki5645kRyF
 ccOGXiU+eVvIe+vb1UmMQ8mAGxW6Q6a+SvHvmctIJjEaZAdcyS8GMmtzyPosTbVM4ePs cw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdmbmns8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:50:12 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B7Hb9Hc039550; Thu, 7 Dec 2023 18:50:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3utan7vh4g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:50:11 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B7Io9xs008067;
 Thu, 7 Dec 2023 18:50:10 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3utan7vh2k-2; Thu, 07 Dec 2023 18:50:10 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, yin31149@gmail.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH 01/40] linux-headers: add vhost_types.h and vhost.h
Date: Thu,  7 Dec 2023 09:39:14 -0800
Message-Id: <1701970793-6865-2-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_15,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312070156
X-Proofpoint-ORIG-GUID: 15U65VgEl2kNN_4GM6IkKHJ_tpagXkKs
X-Proofpoint-GUID: 15U65VgEl2kNN_4GM6IkKHJ_tpagXkKs
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0b-00069f02.pphosted.com
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

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 include/standard-headers/linux/vhost_types.h | 13 +++++++++++++
 linux-headers/linux/vhost.h                  |  9 +++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/standard-headers/linux/vhost_types.h b/include/standard-headers/linux/vhost_types.h
index 5ad07e1..c39199b 100644
--- a/include/standard-headers/linux/vhost_types.h
+++ b/include/standard-headers/linux/vhost_types.h
@@ -185,5 +185,18 @@ struct vhost_vdpa_iova_range {
  * DRIVER_OK
  */
 #define VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK  0x6
+/* Device can be resumed */
+#define VHOST_BACKEND_F_RESUME  0x5
+/* Device supports the driver enabling virtqueues both before and after
+ * DRIVER_OK
+ */
+#define VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK  0x6
+/* Device may expose the virtqueue's descriptor area, driver area and
+ * device area to a different group for ASID binding than where its
+ * buffers may reside. Requires VHOST_BACKEND_F_IOTLB_ASID.
+ */
+#define VHOST_BACKEND_F_DESC_ASID    0x7
+/* IOTLB don't flush memory mapping across device reset */
+#define VHOST_BACKEND_F_IOTLB_PERSIST  0x8
 
 #endif
diff --git a/linux-headers/linux/vhost.h b/linux-headers/linux/vhost.h
index f5c48b6..c61c687 100644
--- a/linux-headers/linux/vhost.h
+++ b/linux-headers/linux/vhost.h
@@ -219,4 +219,13 @@
  */
 #define VHOST_VDPA_RESUME		_IO(VHOST_VIRTIO, 0x7E)
 
+/* Get the dedicated group for the descriptor table of a virtqueue:
+ * read index, write group in num.
+ * The virtqueue index is stored in the index field of vhost_vring_state.
+ * The group id for the descriptor table of this specific virtqueue
+ * is returned via num field of vhost_vring_state.
+ */
+#define VHOST_VDPA_GET_VRING_DESC_GROUP	_IOWR(VHOST_VIRTIO, 0x7F,	\
+					      struct vhost_vring_state)
+
 #endif
-- 
1.8.3.1


