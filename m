Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA6D81ACBD
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 03:47:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG95e-0003Bh-2x; Wed, 20 Dec 2023 21:47:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rG95Y-0003BD-KH
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 21:47:08 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rG95X-0001cB-4e
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 21:47:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1703126827; x=1734662827;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Gd+tFvdGt3W/t48Q+rDRlX7qwgi29FoQ/LCJjp0D35k=;
 b=enuFSYLm5JjqJ5WCUeLhqHaQR4kfsqaKpGQ5m5feX0UqpVdlGh68rHOZ
 AcsJdFaDl0al/VLRtpi8ub5m8qpgHM3ZnSOFvKln2mqs2EX9eaJCO3uiA
 Enl1/pjwP+qoKWaTLaZJE9xHCNLKoy92SCE5rbdkmnhDdj5z/ZBdgTaod
 EidHW5fSPvRqTbgAlA7+e91m352vMBNRQoGvI9zVkVY7H0hAMWy9ZG7JC
 sGhfPRC1sQkgjXyA/FV1KxoqvFnCv3HNvn8XkMrrFQbeDJWGDvf+JhADO
 hT8UNy762l6jXQYKQynHMZLw0XLa00lpY4CzvLwr0yLAAKsrdKCaDN19p A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="9381329"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="9381329"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Dec 2023 18:47:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="920176652"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; d="scan'208";a="920176652"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Dec 2023 18:47:02 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH] vfio/container: Rename vfio_init_container to vfio_set_iommu
Date: Thu, 21 Dec 2023 10:45:17 +0800
Message-Id: <20231221024517.254074-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

vfio_container_init() and vfio_init_container() names are confusing
especially when we see vfio_init_container() calls vfio_container_init().

vfio_container_init() operates on base container which is consistent
with all routines handling 'VFIOContainerBase *' ops.

vfio_init_container() operates on legacy container and setup IOMMU
context with ioctl(VFIO_SET_IOMMU).

So choose to rename vfio_init_container to vfio_set_iommu to avoid
the confusion.

No functional change intended.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/container.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 8d334f52f2..bd25b9fbad 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -392,8 +392,8 @@ static const VFIOIOMMUClass *vfio_get_iommu_class(int iommu_type, Error **errp)
     return VFIO_IOMMU_CLASS(klass);
 }
 
-static int vfio_init_container(VFIOContainer *container, int group_fd,
-                               VFIOAddressSpace *space, Error **errp)
+static int vfio_set_iommu(VFIOContainer *container, int group_fd,
+                          VFIOAddressSpace *space, Error **errp)
 {
     int iommu_type, ret;
     const VFIOIOMMUClass *vioc;
@@ -616,7 +616,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     container->fd = fd;
     bcontainer = &container->bcontainer;
 
-    ret = vfio_init_container(container, group->fd, space, errp);
+    ret = vfio_set_iommu(container, group->fd, space, errp);
     if (ret) {
         goto free_container_exit;
     }
-- 
2.34.1


