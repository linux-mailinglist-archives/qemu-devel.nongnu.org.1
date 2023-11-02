Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A447DED53
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 08:31:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyS9c-0005hO-8X; Thu, 02 Nov 2023 03:30:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qyS9Z-0005Yf-Ja
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 03:30:09 -0400
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qyS9X-0003Ox-72
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 03:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698910207; x=1730446207;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xP0P3YLnFVXz6lbotxMQPU3y5ur7D1Y6XVxWm0xG5cA=;
 b=Snil1fu8Xq5BKq4/VKtKz3f6VFH1P+4TgOpQ6dEfj9uIKddqkGm5UKyb
 vPqe7TE9f94Rh7HS9HFyYn6XcD9wBv2ZH4kjPa4xGDUjDB0oURkNBhyhc
 RLMJUVT/1mT/ysvKoePXGruIZY+Ag6mF0ogIXjEYOU/oWewFuoE2/bn8I
 9DPq4i6NLxQYo7ANwsSnvFFgGjsa15E5Hz5NiXI1tUp2Jeazd33YkNjsc
 u4+/eeiv7HWkJ1ju7RLRK3HFP2isY9kiLzXtNlsjBDLerAgpc39KqEBc1
 j8qbs9LMpaNxZKbh0bpbuOHSeXLRmb+CRpTL/tYGLH4vgCL2wk/X/tER1 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="452953226"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="452953226"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:29:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="711055448"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="711055448"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:29:47 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 20/41] vfio/container: Implement attach/detach_device
Date: Thu,  2 Nov 2023 15:12:41 +0800
Message-Id: <20231102071302.1818071-21-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.31;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Eric Auger <eric.auger@redhat.com>

No fucntional change intended.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/common.c    | 16 ++++++++++++++++
 hw/vfio/container.c | 12 +++++-------
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 8ef2e7967d..483ba82089 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1498,3 +1498,19 @@ retry:
 
     return info;
 }
+
+int vfio_attach_device(char *name, VFIODevice *vbasedev,
+                       AddressSpace *as, Error **errp)
+{
+    const VFIOIOMMUOps *ops = &vfio_legacy_ops;
+
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
index 721c0d7375..6bacf38222 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -873,8 +873,8 @@ static int vfio_device_groupid(VFIODevice *vbasedev, Error **errp)
  * @name and @vbasedev->name are likely to be different depending
  * on the type of the device, hence the need for passing @name
  */
-int vfio_attach_device(char *name, VFIODevice *vbasedev,
-                       AddressSpace *as, Error **errp)
+static int vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
+                                     AddressSpace *as, Error **errp)
 {
     int groupid = vfio_device_groupid(vbasedev, errp);
     VFIODevice *vbasedev_iter;
@@ -914,14 +914,10 @@ int vfio_attach_device(char *name, VFIODevice *vbasedev,
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
@@ -933,6 +929,8 @@ void vfio_detach_device(VFIODevice *vbasedev)
 const VFIOIOMMUOps vfio_legacy_ops = {
     .dma_map = vfio_legacy_dma_map,
     .dma_unmap = vfio_legacy_dma_unmap,
+    .attach_device = vfio_legacy_attach_device,
+    .detach_device = vfio_legacy_detach_device,
     .set_dirty_page_tracking = vfio_legacy_set_dirty_page_tracking,
     .query_dirty_bitmap = vfio_legacy_query_dirty_bitmap,
 };
-- 
2.34.1


