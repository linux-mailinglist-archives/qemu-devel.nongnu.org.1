Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E067CA283
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 10:50:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsJH8-0000OA-U7; Mon, 16 Oct 2023 04:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qsJH3-000085-AO
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:48:31 -0400
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qsJGz-0001Al-C8
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:48:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697446105; x=1728982105;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=euPLFA5NrtvVaevtxFmWmjqgLWemtU5tMgfeDd/swdA=;
 b=jh7J3Q0tahSFI09qRpLjSR+VJCdXSVeFCoWOMeAIgWkWKTQ82Ek1svOy
 lkUVZ1Zu/CeGcxnQ/37MJRoxr+uSi8gZ3J/D3YzCW/41nikarojl7AkAs
 OCqVSM0y78RoIMmIK0bi74oOBnjQmlHpH+ZC2Z2zPC/QZFZEeJXCx/cv2
 J+BegqYnP1AaIIMylrLpJujC2x0+QBzYW+7NgF68m0fxBrydEA9W0Yj9s
 C4kDU31T4MfqPvd/MVLnwNoqwbQveaQqx5tH3Sev84Wu/mludJjdZEJoX
 Soh3j5Vi6EVcUw+09cRLWUN2YsI2VF8JMCHoPKqVcFwcUnK1UqhU1uFQd Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="365737651"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; d="scan'208";a="365737651"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2023 01:48:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="749222953"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; d="scan'208";a="749222953"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2023 01:48:19 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 15/27] vfio/container: Implement attach/detach_device
Date: Mon, 16 Oct 2023 16:32:11 +0800
Message-Id: <20231016083223.1519410-16-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016083223.1519410-1-zhenzhong.duan@intel.com>
References: <20231016083223.1519410-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.151;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Eric Auger <eric.auger@redhat.com>

No fucntional change intended.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/common.c    | 22 ++++++++++++++++++++++
 hw/vfio/container.c | 12 +++++-------
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index da1d64efca..ee2ebf4be9 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1552,3 +1552,25 @@ retry:
 
     return info;
 }
+
+int vfio_attach_device(char *name, VFIODevice *vbasedev,
+                       AddressSpace *as, Error **errp)
+{
+    const VFIOIOMMUBackendOpsClass *ops;
+
+    ops = VFIO_IOMMU_BACKEND_OPS_CLASS(
+                  object_class_by_name(TYPE_VFIO_IOMMU_BACKEND_LEGACY_OPS));
+    if (!ops) {
+        error_setg(errp, "VFIO IOMMU Backend not found!");
+        return -ENODEV;
+    }
+    return ops->attach_device(name, vbasedev, as, errp);
+}
+
+void vfio_detach_device(VFIODevice *vbasedev)
+{
+    if (!vbasedev->bcontainer) {
+        return;
+    }
+    vbasedev->bcontainer->ops->detach_device(vbasedev);
+}
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 9d5be749c7..c86accdb38 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -1117,8 +1117,8 @@ static int vfio_device_groupid(VFIODevice *vbasedev, Error **errp)
  * @name and @vbasedev->name are likely to be different depending
  * on the type of the device, hence the need for passing @name
  */
-int vfio_attach_device(char *name, VFIODevice *vbasedev,
-                       AddressSpace *as, Error **errp)
+static int vfio_legacy_attach_device(char *name, VFIODevice *vbasedev,
+                                     AddressSpace *as, Error **errp)
 {
     int groupid = vfio_device_groupid(vbasedev, errp);
     VFIODevice *vbasedev_iter;
@@ -1158,14 +1158,10 @@ int vfio_attach_device(char *name, VFIODevice *vbasedev,
     return ret;
 }
 
-void vfio_detach_device(VFIODevice *vbasedev)
+static void vfio_legacy_detach_device(VFIODevice *vbasedev)
 {
     VFIOGroup *group = vbasedev->group;
 
-    if (!vbasedev->bcontainer) {
-        return;
-    }
-
     QLIST_REMOVE(vbasedev, global_next);
     QLIST_REMOVE(vbasedev, container_next);
     vbasedev->bcontainer = NULL;
@@ -1180,6 +1176,8 @@ static void vfio_iommu_backend_legacy_ops_class_init(ObjectClass *oc,
 
     ops->dma_map = vfio_legacy_dma_map;
     ops->dma_unmap = vfio_legacy_dma_unmap;
+    ops->attach_device = vfio_legacy_attach_device;
+    ops->detach_device = vfio_legacy_detach_device;
     ops->set_dirty_page_tracking = vfio_legacy_set_dirty_page_tracking;
     ops->query_dirty_bitmap = vfio_legacy_query_dirty_bitmap;
     ops->add_window = vfio_legacy_add_section_window;
-- 
2.34.1


