Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B118090D8
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 19:57:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBJSf-0003eT-4w; Thu, 07 Dec 2023 13:51:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJSS-0003cC-9P
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:50:51 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJSM-00075M-Q1
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:50:44 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B7FbkWF000492; Thu, 7 Dec 2023 18:50:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=Ts4cQAvsSa+oeK7OSgvPKqhJMDfUGW7pypfVyDb3Mq8=;
 b=jSJQkpOwMOL28/CRMeHbfORlgHg9RV2YoM1Ep/lUs+U7KVeP1TMl4UZ7a0PrUSd8QyxA
 cVJ6OEnA0cuRuML5HtE4278ZM9GuORd9y+TE+AMSuPijwlsBhNTxoatqInydwykNuAkI
 wYIybStxMCNdkGwUb8fUc1Id9te3Cgp7553R80B3g/IjqY8hfGrJKr2WW2mBJHpgePkc
 zZLKXbU2G3+dZUVd69kKRnP8QcgnsPJAI+H5BWB6tKGNp15sP+FuChf5L11SnL/IS010
 Sii7NFCuOjVnXjPmjLV15MsfTnBXc8staCFKL0+tBjns65OoaX0oOlx5LyiBGoLJaG82 yA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdda4h9t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:50:40 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B7Hb9g1039324; Thu, 7 Dec 2023 18:50:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3utan7vhxf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:50:39 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B7Io90U008067;
 Thu, 7 Dec 2023 18:50:39 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3utan7vh2k-20; Thu, 07 Dec 2023 18:50:39 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, yin31149@gmail.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH 19/40] vdpa: should avoid map flushing with persistent iotlb
Date: Thu,  7 Dec 2023 09:39:32 -0800
Message-Id: <1701970793-6865-20-git-send-email-si-wei.liu@oracle.com>
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
X-Proofpoint-GUID: VmsbE7U-VPFNiBIeLW82-JtATxW-ibte
X-Proofpoint-ORIG-GUID: VmsbE7U-VPFNiBIeLW82-JtATxW-ibte
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0a-00069f02.pphosted.com
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

Today memory listener is unregistered in vhost_vdpa_reset_status
unconditionally, due to which all the maps will be flushed away
from the iotlb. However, map flush is not always needed, and
doing it from performance hot path may have innegligible latency
impact that affects VM reboot time or brown out period during
live migration.

Leverage the IOTLB_PERSIST backend featuae, which ensures durable
iotlb maps and not disappearing even across reset. When it is
supported, we may conditionally keep the maps for cases where the
guest memory mapping doesn't change. Prepare a function so that
the next patch will be able to use it to keep the maps.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 hw/virtio/trace-events |  1 +
 hw/virtio/vhost-vdpa.c | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 77905d1..9725d44 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -66,6 +66,7 @@ vhost_vdpa_set_owner(void *dev) "dev: %p"
 vhost_vdpa_vq_get_addr(void *dev, void *vq, uint64_t desc_user_addr, uint64_t avail_user_addr, uint64_t used_user_addr) "dev: %p vq: %p desc_user_addr: 0x%"PRIx64" avail_user_addr: 0x%"PRIx64" used_user_addr: 0x%"PRIx64
 vhost_vdpa_get_iova_range(void *dev, uint64_t first, uint64_t last) "dev: %p first: 0x%"PRIx64" last: 0x%"PRIx64
 vhost_vdpa_set_config_call(void *dev, int fd)"dev: %p fd: %d"
+vhost_vdpa_maybe_flush_map(void *dev, bool reg, bool flush, bool persist) "dev: %p registered: %d flush_map: %d iotlb_persistent: %d"
 
 # virtio.c
 virtqueue_alloc_element(void *elem, size_t sz, unsigned in_num, unsigned out_num) "elem %p size %zd in_num %u out_num %u"
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index ea2dfc8..31e0a55 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -1471,6 +1471,26 @@ out_stop:
     return ok ? 0 : -1;
 }
 
+static void vhost_vdpa_maybe_flush_map(struct vhost_dev *dev)
+{
+    struct vhost_vdpa *v = dev->opaque;
+
+    trace_vhost_vdpa_maybe_flush_map(dev, v->shared->listener_registered,
+                                     v->shared->flush_map,
+                                     !!(dev->backend_cap &
+                                     BIT_ULL(VHOST_BACKEND_F_IOTLB_PERSIST)));
+
+    if (!v->shared->listener_registered) {
+        return;
+    }
+
+    if (!(dev->backend_cap & BIT_ULL(VHOST_BACKEND_F_IOTLB_PERSIST)) ||
+        v->shared->flush_map) {
+        memory_listener_unregister(&v->shared->listener);
+        v->shared->listener_registered = false;
+    }
+}
+
 static void vhost_vdpa_reset_status(struct vhost_dev *dev)
 {
     struct vhost_vdpa *v = dev->opaque;
-- 
1.8.3.1


