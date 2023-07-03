Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E17F745616
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 09:29:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGDz1-0006Ef-TR; Mon, 03 Jul 2023 03:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qGDyz-0006EI-Ma
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 03:28:25 -0400
Received: from mga12.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qGDyw-0003yC-UQ
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 03:28:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688369302; x=1719905302;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mzmiumRbkMiqShyNMR0IULmYkTFgTraEzbJQDh209tg=;
 b=aOf+2vsI5UILEoWWpITVh38XOm1BIV2TuHeiD6GJywp2kRSw2yg2XI5+
 OvD6T6zLhwVnYqMDIC7a6s+vZKoZKi25/OIvirmx/2T08lqXLVhbrHpD4
 ExR2QSVmiGaMw8Ni3quY1E8gwo9oNLxuFZ1Ps3MAjsVfpyupIKO0baXQb
 LhF4AAdgLEnwTPmDKhcHDN1clqIDAU2Jmrg14Uedc4C7YT1qQXrFPYLbQ
 Jiv4N8fW8tQ4C3gf6joWYpyOIYnrV7WqbQj4UBUpyn06FmxICO1GH5dFG
 kDHGORJ9NYuGE2I1YgMJvCMPqxNPZISp0cx4r/fJmdyia6bRMAnFlmjUS w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="342405675"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; d="scan'208";a="342405675"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2023 00:28:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="748058786"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; d="scan'208";a="748058786"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2023 00:28:19 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, joao.m.martins@oracle.com,
 avihaih@nvidia.com, chao.p.peng@intel.com
Subject: [PATCH v6 7/7] vfio/migration: Return bool type for
 vfio_migration_realize()
Date: Mon,  3 Jul 2023 15:15:10 +0800
Message-Id: <20230703071510.160712-6-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230703071510.160712-1-zhenzhong.duan@intel.com>
References: <20230703071510.160712-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.136;
 envelope-from=zhenzhong.duan@intel.com; helo=mga12.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Make vfio_migration_realize() adhere to the convention of other realize()
callbacks(like qdev_realize) by returning bool instead of int.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Suggested-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/migration.c           | 15 ++++++++++-----
 hw/vfio/pci.c                 |  3 +--
 include/hw/vfio/vfio-common.h |  2 +-
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index e3954570c853..2674f4bc472d 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -846,7 +846,12 @@ void vfio_reset_bytes_transferred(void)
     bytes_transferred = 0;
 }
 
-int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
+/*
+ * Return true when either migration initialized or blocker registered.
+ * Currently only return false when adding blocker fails which will
+ * de-register vfio device.
+ */
+bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
 {
     Error *err = NULL;
     int ret;
@@ -854,7 +859,7 @@ int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
     if (vbasedev->enable_migration == ON_OFF_AUTO_OFF) {
         error_setg(&err, "%s: Migration is disabled for VFIO device",
                    vbasedev->name);
-        return vfio_block_migration(vbasedev, err, errp);
+        return !vfio_block_migration(vbasedev, err, errp);
     }
 
     ret = vfio_migration_init(vbasedev);
@@ -869,7 +874,7 @@ int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
                        vbasedev->name, ret, strerror(-ret));
         }
 
-        return vfio_block_migration(vbasedev, err, errp);
+        return !vfio_block_migration(vbasedev, err, errp);
     }
 
     if (!vbasedev->dirty_pages_supported) {
@@ -896,7 +901,7 @@ int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
     }
 
     trace_vfio_migration_realize(vbasedev->name);
-    return 0;
+    return true;
 
 add_blocker:
     ret = vfio_block_migration(vbasedev, err, errp);
@@ -904,7 +909,7 @@ out_deinit:
     if (ret) {
         vfio_migration_deinit(vbasedev);
     }
-    return ret;
+    return !ret;
 }
 
 void vfio_migration_exit(VFIODevice *vbasedev)
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index eefd4ec330d9..68dd99283620 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3207,8 +3207,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     }
 
     if (!pdev->failover_pair_id) {
-        ret = vfio_migration_realize(vbasedev, errp);
-        if (ret) {
+        if (!vfio_migration_realize(vbasedev, errp)) {
             goto out_deregister;
         }
     }
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 45167c8a8a54..da43d273524e 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -252,7 +252,7 @@ int vfio_spapr_create_window(VFIOContainer *container,
 int vfio_spapr_remove_window(VFIOContainer *container,
                              hwaddr offset_within_address_space);
 
-int vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
+bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
 void vfio_migration_exit(VFIODevice *vbasedev);
 
 #endif /* HW_VFIO_VFIO_COMMON_H */
-- 
2.34.1


