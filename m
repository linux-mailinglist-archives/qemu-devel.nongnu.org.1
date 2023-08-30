Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A1178D53F
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 12:54:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbIpX-0004bN-TF; Wed, 30 Aug 2023 06:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qbIpW-0004aM-Cu
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 06:53:46 -0400
Received: from mgamail.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qbIpT-0007je-Ok
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 06:53:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1693392824; x=1724928824;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FwV54K2kWvnU/H45Up13S/nT+vitO1lLqtEnEkMrTpo=;
 b=hPm5AuvEY8uVFHUPGhB20eNlfzIg4FRH5AhfI0H/YEeCIp0sOuUcM4dI
 7QPW0k8Onq5maDX6FSVHVmq34pmX3sEcVf1bSYPsTMrtB6wiqjhSY8S/b
 ItLfbhMHkYSvAAt63ogGusNFUWWl6b5K1Psc3Ck8MJ0skw1u+kI4xYNhU
 RN3EIV8czXPADq86NJjT6TxVqjQwlr5zGWgDtuJuZ+MkSGt49aWGDvlxE
 Za84fAOdQ4NaygbjupCK3gYjbBoXjPIvb8cpxEZe4nu91pAwVemY3CyrE
 0SzSDc7giWDbC85bg3QKRkSM5ANcMlIQ5tQ5ug3hxnmxPIPkFgrvxERDY g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="373016635"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; d="scan'208";a="373016635"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2023 03:53:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="715866214"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; d="scan'208";a="715866214"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2023 03:53:29 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v1 14/22] vfio/common: Simplify vfio_viommu_preset()
Date: Wed, 30 Aug 2023 18:37:46 +0800
Message-Id: <20230830103754.36461-15-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230830103754.36461-1-zhenzhong.duan@intel.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.93;
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

Commit "vfio/container-base: Introduce [attach/detach]_device container callbacks"
add support to link to address space, we can utilize it to simplify
vfio_viommu_preset().

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/common.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 86b6af5740..6c3e98d5fd 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -165,22 +165,7 @@ void vfio_unblock_multiple_devices_migration(void)
 
 bool vfio_viommu_preset(VFIODevice *vbasedev)
 {
-    VFIOAddressSpace *space;
-    VFIOContainer *container;
-    VFIODevice *tmp_dev;
-
-    QLIST_FOREACH(space, &vfio_address_spaces, list) {
-        QLIST_FOREACH(container, &space->containers, next) {
-            tmp_dev = NULL;
-            while ((tmp_dev = vfio_container_dev_iter_next(container,
-                                                           tmp_dev))) {
-                if (vbasedev == tmp_dev) {
-                    return space->as != &address_space_memory;
-                }
-            }
-        }
-    }
-    g_assert_not_reached();
+    return vbasedev->container->space->as != &address_space_memory;
 }
 
 static void vfio_set_migration_error(int err)
-- 
2.34.1


