Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 375008090A8
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 19:52:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBJSt-0003xI-HT; Thu, 07 Dec 2023 13:51:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJSW-0003cS-3y
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:50:52 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJSO-00075p-Pr
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:50:48 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B7HVdNu010826; Thu, 7 Dec 2023 18:50:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=EthSTSZAGUdFGpGUUgIS40/qu5PWf2EuzefpgEB0S8Y=;
 b=fiNpDcI7jkLvuU7c9McRT5f3QPpsAqnKiiZtWmucBPbpUonY3I53aERnM+56LaofjjDn
 rWsHB5eW2auOaBt55IpF5JNnCwXCTCCnCfHeOQcS8vCtw5sBW3wb63gktQG9hEPfDxpP
 wKhOC/f84hDWkLyXSW5ULbqIcm/DNnI9vw1XPJKdGADXDTzRJY+xyDyW5f9eaIHhNNqT
 ysoVQN0Lrn5RWJxTLNQbCqm9i8/UFtiB8stZ3DFwg1CveT4sktaAJZmtKgNbiA/mfUrM
 5S0/VWIjL4w8gdQLNd5d94GSxRvc/ABOf0MDMrP6EWyfDUgFeTfJrNJed4X5472sDcmx AQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdc1cg00-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:50:41 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B7HOJfY039780; Thu, 7 Dec 2023 18:50:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3utan7vhyn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:50:41 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B7Io90W008067;
 Thu, 7 Dec 2023 18:50:40 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3utan7vh2k-21; Thu, 07 Dec 2023 18:50:40 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, yin31149@gmail.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH 20/40] vdpa: avoid mapping flush across reset
Date: Thu,  7 Dec 2023 09:39:33 -0800
Message-Id: <1701970793-6865-21-git-send-email-si-wei.liu@oracle.com>
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
X-Proofpoint-GUID: W5odj9H8iuFszJ3247q5atcCldSAVR7C
X-Proofpoint-ORIG-GUID: W5odj9H8iuFszJ3247q5atcCldSAVR7C
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

Leverage the IOTLB_PERSIST and DESC_ASID features to achieve
a slightly light weight reset path, without resorting to
suspend and resume. Not as best but it offers significant
time saving too, which should somehow play its role in live
migration down time reduction by large.

It benefits two cases:
  - normal virtio reset in the VM, e.g. guest reboot, don't
    have to tear down all iotlb mapping and set up again.
  - SVQ switching, in which data vq's descriptor table and
    vrings are moved to a different ASID than where its
    buffers reside. Along with the use of persistent iotlb,
    it would save substantial time from pinning and mapping
    unneccessarily when moving descriptors on to or out of
    shadow mode.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 hw/virtio/vhost-vdpa.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 31e0a55..47c764b 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -633,6 +633,7 @@ static int vhost_vdpa_init(struct vhost_dev *dev, void *opaque, Error **errp)
                                      0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH |
                                      0x1ULL << VHOST_BACKEND_F_IOTLB_ASID |
                                      0x1ULL << VHOST_BACKEND_F_DESC_ASID |
+                                     0x1ULL << VHOST_BACKEND_F_IOTLB_PERSIST |
                                      0x1ULL << VHOST_BACKEND_F_SUSPEND;
     int ret;
 
@@ -1493,8 +1494,6 @@ static void vhost_vdpa_maybe_flush_map(struct vhost_dev *dev)
 
 static void vhost_vdpa_reset_status(struct vhost_dev *dev)
 {
-    struct vhost_vdpa *v = dev->opaque;
-
     if (!vhost_vdpa_last_dev(dev)) {
         return;
     }
@@ -1502,9 +1501,7 @@ static void vhost_vdpa_reset_status(struct vhost_dev *dev)
     vhost_vdpa_reset_device(dev);
     vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE |
                                VIRTIO_CONFIG_S_DRIVER);
-    memory_listener_unregister(&v->shared->listener);
-    v->shared->listener_registered = false;
-
+    vhost_vdpa_maybe_flush_map(dev);
 }
 
 static int vhost_vdpa_set_log_base(struct vhost_dev *dev, uint64_t base,
-- 
1.8.3.1


