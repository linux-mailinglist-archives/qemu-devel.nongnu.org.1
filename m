Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9C78090C1
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 19:55:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBJTJ-0004A1-Hx; Thu, 07 Dec 2023 13:51:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJT5-00049I-G8
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:51:27 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJSw-0007EN-9r
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:51:27 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B7FDI5d009711; Thu, 7 Dec 2023 18:51:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=TxIsJRdr2QrceXoIu2cqfn++hSDV86DDXcv+xhCGH68=;
 b=TAh3wzB0W8Esfs+q5MF00k9wSD20joGtk6aGGJV7gXHBdOtvYYQkE7vqBFifWpdyRDNl
 t9l455BptTGl/fh03RLIyLOYB51ozOAXQZf/4VgqQ7Uv6D8SbHjL5jQ8ZOdcPGR1NSBJ
 +u9NwTQ+M0bM0y5Bwe9E/6q+eZEXYldlbYu2K/yDe1clCRGtZsPUJuu19oIO+6lyZyGy
 vNnLzuScYEwqq+EqhAd8YhW9AYxNwmbCb70e4/RSDZg7Co3MELcLYCfhmUnOxoGZ/UjH
 fOgNOUDQoGNMGNW2cqHMvxI05wEukw7sZNWVJhmeOpL2gxwqDXx/Mfxu2kAfN5Wy6tzN dg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdrvmpg9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:51:06 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B7HPF63039562; Thu, 7 Dec 2023 18:51:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3utan7vjfu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:51:05 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B7Io916008067;
 Thu, 7 Dec 2023 18:51:04 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3utan7vh2k-38; Thu, 07 Dec 2023 18:51:04 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, yin31149@gmail.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH 37/40] vdpa: add vhost_vdpa_set_dev_vring_base trace for svq
 mode
Date: Thu,  7 Dec 2023 09:39:50 -0800
Message-Id: <1701970793-6865-38-git-send-email-si-wei.liu@oracle.com>
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
X-Proofpoint-GUID: MBJN8BQ7O_2ZYw-8XBJxT6MgKCpRantJ
X-Proofpoint-ORIG-GUID: MBJN8BQ7O_2ZYw-8XBJxT6MgKCpRantJ
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

For better debuggability and observability.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 hw/virtio/trace-events | 2 +-
 hw/virtio/vhost-vdpa.c | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index a8d3321..5085607 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -57,7 +57,7 @@ vhost_vdpa_dev_start(void *dev, bool started) "dev: %p started: %d"
 vhost_vdpa_set_log_base(void *dev, uint64_t base, unsigned long long size, int refcnt, int fd, void *log) "dev: %p base: 0x%"PRIx64" size: %llu refcnt: %d fd: %d log: %p"
 vhost_vdpa_set_vring_addr(void *dev, unsigned int index, unsigned int flags, uint64_t desc_user_addr, uint64_t used_user_addr, uint64_t avail_user_addr, uint64_t log_guest_addr) "dev: %p index: %u flags: 0x%x desc_user_addr: 0x%"PRIx64" used_user_addr: 0x%"PRIx64" avail_user_addr: 0x%"PRIx64" log_guest_addr: 0x%"PRIx64
 vhost_vdpa_set_vring_num(void *dev, unsigned int index, unsigned int num) "dev: %p index: %u num: %u"
-vhost_vdpa_set_vring_base(void *dev, unsigned int index, unsigned int num) "dev: %p index: %u num: %u"
+vhost_vdpa_set_dev_vring_base(void *dev, unsigned int index, unsigned int num, bool svq) "dev: %p index: %u num: %u svq: %d"
 vhost_vdpa_get_vring_base(void *dev, unsigned int index, unsigned int num, bool svq) "dev: %p index: %u num: %u svq: %d"
 vhost_vdpa_set_vring_kick(void *dev, unsigned int index, int fd) "dev: %p index: %u fd: %d"
 vhost_vdpa_set_vring_call(void *dev, unsigned int index, int fd) "dev: %p index: %u fd: %d"
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index d66936f..ff4f218 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -1043,7 +1043,10 @@ static int vhost_vdpa_get_config(struct vhost_dev *dev, uint8_t *config,
 static int vhost_vdpa_set_dev_vring_base(struct vhost_dev *dev,
                                          struct vhost_vring_state *ring)
 {
-    trace_vhost_vdpa_set_vring_base(dev, ring->index, ring->num);
+    struct vhost_vdpa *v = dev->opaque;
+
+    trace_vhost_vdpa_set_dev_vring_base(dev, ring->index, ring->num,
+                                        v->shadow_vqs_enabled);
     return vhost_vdpa_call(dev, VHOST_SET_VRING_BASE, ring);
 }
 
-- 
1.8.3.1


