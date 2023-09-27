Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 944D67B0294
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 13:16:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlSVC-00041v-HW; Wed, 27 Sep 2023 07:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qlSV9-00041d-4z
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 07:14:43 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qlSV7-0005yt-A5
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 07:14:42 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38R9NpxX015081; Wed, 27 Sep 2023 11:14:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=vHEb9TfhFUmx2u9sq1ks/833Oa3P9Ixt6VS7Cb/EHIs=;
 b=zUCb9pyAWQUH8EAn8cEGWSUR1qZMzHHIkNg3Wmec4XMl6b2On2IU+Z1b/9FXFJ80o4EC
 wq4yADqGGEm4+fsDcpULAOjmt2Akhr5VIbFm5fk9yQZp8W3qK3VG5FANN4IHNjwoPiz/
 CFh91tz4D7sJdijpzxoMdcGNtc1o3s5j0GnryFVNEfKJowSF/4h303PRSTqpYj0xLzGM
 dSgoHvUYxqGb5LZ45+1HsiEbgirnVGgroSAz7j6hx7Uo1AEvDXF3W346GLk35dozio17
 ezIyNgsenZI/LAFxROdI38Beff7vfr+Elcse7i8wmrRAcaNmzqf5sN+9o96FQC/dQ1FD bQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pt3s9bh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Sep 2023 11:14:39 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38RAGVBQ017992; Wed, 27 Sep 2023 11:14:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3t9pfdpcgr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Sep 2023 11:14:38 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38RBEcDN036082;
 Wed, 27 Sep 2023 11:14:38 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-168-87.vpn.oracle.com
 [10.175.168.87])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3t9pfdpcfe-1; Wed, 27 Sep 2023 11:14:37 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Si-Wei Liu <si-wei.liu@oracle.com>,
 Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH] vhost: Perform memory section dirty scans once per iteration
Date: Wed, 27 Sep 2023 12:14:28 +0100
Message-Id: <20230927111428.15982-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_06,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309270093
X-Proofpoint-ORIG-GUID: oCme-YYNxu6bduWydWNRjb9Dv4gTznMD
X-Proofpoint-GUID: oCme-YYNxu6bduWydWNRjb9Dv4gTznMD
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On setups with one or more virtio-net devices with vhost on,
dirty tracking iteration increases cost the bigger the number
amount of queues are set up e.g. on idle guests migration the
following is observed with virtio-net with vhost=on:

48 queues -> 78.11%  [.] vhost_dev_sync_region.isra.13
8 queues -> 40.50%   [.] vhost_dev_sync_region.isra.13
1 queue -> 6.89%     [.] vhost_dev_sync_region.isra.13
2 devices, 1 queue -> 18.60%  [.] vhost_dev_sync_region.isra.14

With high memory rates the symptom is lack of convergence as soon
as it has a vhost device with a sufficiently high number of queues,
the sufficient number of vhost devices.

On every migration iteration (every 100msecs) it will redundantly
query the *shared log* the number of queues configured with vhost
that exist in the guest. For the virtqueue data, this is necessary,
but not for the memory sections which are the same. So
essentially we end up scanning the dirty log too often.

To fix that, select a vhost device responsible for scanning the
log with regards to memory sections dirty tracking. It is selected
when we enable the logger (during migration) and cleared when we
disable the logger.

The real problem, however, is exactly that: a device per vhost worker/qp,
when there should be a device representing a netdev (for N vhost workers).
Given this problem exists for any Qemu these days, figured a simpler
solution is better to increase stable tree's coverage; thus don't
change the device model of sw vhost to fix this "over log scan" issue.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
I am not fully sure the heuristic captures the myriad of different vhost
devices -- I think so. IIUC, the log is always shared, it's just whether
it's qemu head memory or via /dev/shm when other processes want to
access it.
---
 hw/virtio/vhost.c | 44 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index e2f6ffb446b7..70646c2b533c 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -44,6 +44,7 @@
 
 static struct vhost_log *vhost_log;
 static struct vhost_log *vhost_log_shm;
+static struct vhost_dev *vhost_log_dev;
 
 static unsigned int used_memslots;
 static QLIST_HEAD(, vhost_dev) vhost_devices =
@@ -124,6 +125,21 @@ bool vhost_dev_has_iommu(struct vhost_dev *dev)
     }
 }
 
+static bool vhost_log_dev_enabled(struct vhost_dev *dev)
+{
+    return dev == vhost_log_dev;
+}
+
+static void vhost_log_set_dev(struct vhost_dev *dev)
+{
+    vhost_log_dev = dev;
+}
+
+static bool vhost_log_dev_is_set(void)
+{
+    return vhost_log_dev != NULL;
+}
+
 static int vhost_sync_dirty_bitmap(struct vhost_dev *dev,
                                    MemoryRegionSection *section,
                                    hwaddr first,
@@ -141,13 +157,16 @@ static int vhost_sync_dirty_bitmap(struct vhost_dev *dev,
     start_addr = MAX(first, start_addr);
     end_addr = MIN(last, end_addr);
 
-    for (i = 0; i < dev->mem->nregions; ++i) {
-        struct vhost_memory_region *reg = dev->mem->regions + i;
-        vhost_dev_sync_region(dev, section, start_addr, end_addr,
-                              reg->guest_phys_addr,
-                              range_get_last(reg->guest_phys_addr,
-                                             reg->memory_size));
+    if (vhost_log_dev_enabled(dev)) {
+        for (i = 0; i < dev->mem->nregions; ++i) {
+            struct vhost_memory_region *reg = dev->mem->regions + i;
+            vhost_dev_sync_region(dev, section, start_addr, end_addr,
+                                  reg->guest_phys_addr,
+                                  range_get_last(reg->guest_phys_addr,
+                                                 reg->memory_size));
+        }
     }
+
     for (i = 0; i < dev->nvqs; ++i) {
         struct vhost_virtqueue *vq = dev->vqs + i;
 
@@ -943,6 +962,19 @@ static int vhost_dev_set_log(struct vhost_dev *dev, bool enable_log)
             goto err_vq;
         }
     }
+
+    /*
+     * During migration devices can't be removed, so we at log start
+     * we select our vhost_device that will scan the memory sections
+     * and skip for the others. This is possible because the log is shared
+     * amongst all vhost devices.
+     */
+    if (enable_log && !vhost_log_dev_is_set()) {
+        vhost_log_set_dev(dev);
+    } else if (!enable_log) {
+        vhost_log_set_dev(NULL);
+    }
+
     return 0;
 err_vq:
     for (; i >= 0; --i) {
-- 
2.39.3


