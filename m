Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7048687C4CB
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Mar 2024 22:39:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rksn9-00022b-Uq; Thu, 14 Mar 2024 17:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rksmv-00022J-B4
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 17:38:57 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rksmt-00080R-6h
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 17:38:57 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42ELDh9X022241; Thu, 14 Mar 2024 21:38:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=8VHbxUYRLJxMjFuiJotJejqiZKa1+U3oCH5CckEI2Ok=;
 b=kCROYhrII0Wy2YPwN0yVHENwAyvhU4hfbJ/HgcsFumAx1n4Ch+cI1E4i/G0Z4Dm4gkxO
 mnM6/++xugCmdT6chEiXDJJ5DaESuArjsEXVtBEQUxXhyOAsn4y9N6y6Zd5YPMLiqjHp
 sMp2udv9T8swziY5zxX+egNhIbLbqL1TPhw1TH3BSVRXUwKbU6sypzwO3sjc+i1fQsoO
 TRCpUPrjp+g9tgDDrvvUbCx/E0NmRV/LTu3pjeCDdWQ17JmH5o41ARRlslfjzNLyKuHs
 Y3t8R88eJ9wF2uGxWhj6JYA5r20crUWzGZ4rTo4AbkOal6/eIPGXTpO/ifIq5/PRSYKW JA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wv0achb1a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Mar 2024 21:38:52 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 42EJmWjv019794; Thu, 14 Mar 2024 21:38:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3wre7ayv2m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Mar 2024 21:38:51 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42ELco1e002045;
 Thu, 14 Mar 2024 21:38:51 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3wre7ayv1k-2; Thu, 14 Mar 2024 21:38:51 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com, eperezma@redhat.com,
 joao.m.martins@oracle.com, si-wei.liu@oracle.com
Subject: [PATCH v4 2/2] vhost: Perform memory section dirty scans once per
 iteration
Date: Thu, 14 Mar 2024 13:27:35 -0700
Message-Id: <1710448055-11709-2-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1710448055-11709-1-git-send-email-si-wei.liu@oracle.com>
References: <1710448055-11709-1-git-send-email-si-wei.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 spamscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403140166
X-Proofpoint-GUID: xwoCXlDLRva1Bznec4muIpTBaeNj87bS
X-Proofpoint-ORIG-GUID: xwoCXlDLRva1Bznec4muIpTBaeNj87bS
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
but not for the memory sections which are the same. So essentially
we end up scanning the dirty log too often.

To fix that, select a vhost device responsible for scanning the
log with regards to memory sections dirty tracking. It is selected
when we enable the logger (during migration) and cleared when we
disable the logger. If the vhost logger device goes away for some
reason, the logger will be re-selected from the rest of vhost
devices.

After making mem-section logger a singleton instance, constant cost
of 7%-9% (like the 1 queue report) will be seen, no matter how many
queues or how many vhost devices are configured:

48 queues -> 8.71%    [.] vhost_dev_sync_region.isra.13
2 devices, 8 queues -> 7.97%   [.] vhost_dev_sync_region.isra.14

Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>

---
v3 -> v4:
  - add comment to clarify effect on cache locality and
    performance

v2 -> v3:
  - add after-fix benchmark to commit log
  - rename vhost_log_dev_enabled to vhost_dev_should_log
  - remove unneeded comparisons for backend_type
  - use QLIST array instead of single flat list to store vhost
    logger devices
  - simplify logger election logic
---
 hw/virtio/vhost.c         | 67 ++++++++++++++++++++++++++++++++++++++++++-----
 include/hw/virtio/vhost.h |  1 +
 2 files changed, 62 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 612f4db..58522f1 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -45,6 +45,7 @@
 
 static struct vhost_log *vhost_log[VHOST_BACKEND_TYPE_MAX];
 static struct vhost_log *vhost_log_shm[VHOST_BACKEND_TYPE_MAX];
+static QLIST_HEAD(, vhost_dev) vhost_log_devs[VHOST_BACKEND_TYPE_MAX];
 
 /* Memslots used by backends that support private memslots (without an fd). */
 static unsigned int used_memslots;
@@ -149,6 +150,47 @@ bool vhost_dev_has_iommu(struct vhost_dev *dev)
     }
 }
 
+static inline bool vhost_dev_should_log(struct vhost_dev *dev)
+{
+    assert(dev->vhost_ops);
+    assert(dev->vhost_ops->backend_type > VHOST_BACKEND_TYPE_NONE);
+    assert(dev->vhost_ops->backend_type < VHOST_BACKEND_TYPE_MAX);
+
+    return dev == QLIST_FIRST(&vhost_log_devs[dev->vhost_ops->backend_type]);
+}
+
+static inline void vhost_dev_elect_mem_logger(struct vhost_dev *hdev, bool add)
+{
+    VhostBackendType backend_type;
+
+    assert(hdev->vhost_ops);
+
+    backend_type = hdev->vhost_ops->backend_type;
+    assert(backend_type > VHOST_BACKEND_TYPE_NONE);
+    assert(backend_type < VHOST_BACKEND_TYPE_MAX);
+
+    if (add && !QLIST_IS_INSERTED(hdev, logdev_entry)) {
+        if (QLIST_EMPTY(&vhost_log_devs[backend_type])) {
+            QLIST_INSERT_HEAD(&vhost_log_devs[backend_type],
+                              hdev, logdev_entry);
+        } else {
+            /*
+             * The first vhost_device in the list is selected as the shared
+             * logger to scan memory sections. Put new entry next to the head
+             * to avoid inadvertent change to the underlying logger device.
+             * This is done in order to get better cache locality and to avoid
+             * performance churn on the hot path for log scanning. Even when
+             * new devices come and go quickly, it wouldn't end up changing
+             * the active leading logger device at all.
+             */
+            QLIST_INSERT_AFTER(QLIST_FIRST(&vhost_log_devs[backend_type]),
+                               hdev, logdev_entry);
+        }
+    } else if (!add && QLIST_IS_INSERTED(hdev, logdev_entry)) {
+        QLIST_REMOVE(hdev, logdev_entry);
+    }
+}
+
 static int vhost_sync_dirty_bitmap(struct vhost_dev *dev,
                                    MemoryRegionSection *section,
                                    hwaddr first,
@@ -166,12 +208,14 @@ static int vhost_sync_dirty_bitmap(struct vhost_dev *dev,
     start_addr = MAX(first, start_addr);
     end_addr = MIN(last, end_addr);
 
-    for (i = 0; i < dev->mem->nregions; ++i) {
-        struct vhost_memory_region *reg = dev->mem->regions + i;
-        vhost_dev_sync_region(dev, section, start_addr, end_addr,
-                              reg->guest_phys_addr,
-                              range_get_last(reg->guest_phys_addr,
-                                             reg->memory_size));
+    if (vhost_dev_should_log(dev)) {
+        for (i = 0; i < dev->mem->nregions; ++i) {
+            struct vhost_memory_region *reg = dev->mem->regions + i;
+            vhost_dev_sync_region(dev, section, start_addr, end_addr,
+                                  reg->guest_phys_addr,
+                                  range_get_last(reg->guest_phys_addr,
+                                                 reg->memory_size));
+        }
     }
     for (i = 0; i < dev->nvqs; ++i) {
         struct vhost_virtqueue *vq = dev->vqs + i;
@@ -383,6 +427,7 @@ static void vhost_log_put(struct vhost_dev *dev, bool sync)
         g_free(log);
     }
 
+    vhost_dev_elect_mem_logger(dev, false);
     dev->log = NULL;
     dev->log_size = 0;
 }
@@ -998,6 +1043,15 @@ static int vhost_dev_set_log(struct vhost_dev *dev, bool enable_log)
             goto err_vq;
         }
     }
+
+    /*
+     * At log start we select our vhost_device logger that will scan the
+     * memory sections and skip for the others. This is possible because
+     * the log is shared amongst all vhost devices for a given type of
+     * backend.
+     */
+    vhost_dev_elect_mem_logger(dev, enable_log);
+
     return 0;
 err_vq:
     for (; i >= 0; --i) {
@@ -2068,6 +2122,7 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
             VHOST_OPS_DEBUG(r, "vhost_set_log_base failed");
             goto fail_log;
         }
+        vhost_dev_elect_mem_logger(hdev, true);
     }
     if (vrings) {
         r = vhost_dev_set_vring_enable(hdev, true);
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 0247778..d75faf4 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -129,6 +129,7 @@ struct vhost_dev {
     void *opaque;
     struct vhost_log *log;
     QLIST_ENTRY(vhost_dev) entry;
+    QLIST_ENTRY(vhost_dev) logdev_entry;
     QLIST_HEAD(, vhost_iommu) iommu_list;
     IOMMUNotifier n;
     const VhostDevConfigOps *config_ops;
-- 
1.8.3.1


