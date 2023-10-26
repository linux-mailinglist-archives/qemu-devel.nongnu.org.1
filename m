Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 071DA7D8142
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 12:53:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvxut-0002bR-Ef; Thu, 26 Oct 2023 06:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvxuM-0002Es-Vp
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 06:48:16 -0400
Received: from mgamail.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvxu9-0001Nv-DN
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 06:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698317277; x=1729853277;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=b3YC3uNOJHAxXEHMMdFXdR2eF8wgMFjKTbsf/i6lBr0=;
 b=Bi/QEAZXRBb5LLumhADpp7OvbgovG4Ink3bLIytCtsqhOYK526aMetty
 /GstOm/uNQ8K8hlEl0qQm/cLvPyrs4Ahvpri+KeiU/YR8Fao9Nl/qKYhp
 9+bIfX9shFebFYc4XFPzyuPZojLLmTsf1PqHfy22CzOFzJsia1dTue9/2
 /cB2lzn7/x6WIbGYj3ZfgdoEZVqUNQbJk1SEwMrxs1ZEs5B8eVnfzA0A7
 TNosIbOKGurRsa6F/FiUHqF/BBRO5cpdvbNC7zN3IhPFLtxKCEKNihuQ9
 3Y7gcgzOFXBLsJVLQpbVOzttkwCZmGz7Nq9P+B6pfIlcF2aVGo4TCZw3E g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="372563490"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; d="scan'208";a="372563490"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 03:47:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="463708"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 03:47:08 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 18/37] vfio/container: Implement attach/detach_device
Date: Thu, 26 Oct 2023 18:30:45 +0800
Message-Id: <20231026103104.1686921-19-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Eric Auger <eric.auger@redhat.com>

No fucntional change intended.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/common.c    | 16 ++++++++++++++++
 hw/vfio/container.c | 12 +++++-------
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index d62c815d7f..64565b4ae9 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1500,3 +1500,19 @@ retry:
 
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
index 36c34683ad..c8ff0f2037 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -874,8 +874,8 @@ static int vfio_device_groupid(VFIODevice *vbasedev, Error **errp)
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
@@ -915,14 +915,10 @@ int vfio_attach_device(char *name, VFIODevice *vbasedev,
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
@@ -934,6 +930,8 @@ void vfio_detach_device(VFIODevice *vbasedev)
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


