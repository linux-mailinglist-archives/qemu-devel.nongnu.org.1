Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB16731233
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 10:32:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9iOZ-00049l-Bv; Thu, 15 Jun 2023 04:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q9iOM-00047d-RW
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 04:31:45 -0400
Received: from mga02.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q9iOL-0000pe-6Z
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 04:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686817901; x=1718353901;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=8alUIXuyR/7W1QBGpx82YSHlL1+ZOiSzVjL2k/2dBGc=;
 b=h36YzSMkbammAfpa587DE9GysGhx2YinTpxiBm/WoK98K5qSo411uuex
 iW7Jg1XD521sfOto/cxHEWHlv4mbPi+9BdALxTQ/aDfqd+U+B02k3ijot
 9IJ8LdcYIkPJQdtoumaP6Xt33d9y6E/yNR55qzphmsh3C7Bbax6+eUBZ4
 aNrSbt84u6lO59VtMwAKWr5M1rrSzhU3VO26dWpsLNxoNbdqvv35XEWHA
 OkogcJFP5GDjgTlDBSdN+vs8RiRRNg6B4OnQmH+rsl3x3KjpTSUCkB5No
 z5JovmeAikto5EbTS77LPW1k0DdI8Q/78LgVbP3yO0cv/o4rSuVp19u85 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="348521175"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; d="scan'208";a="348521175"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2023 01:31:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="706569860"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; d="scan'208";a="706569860"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2023 01:31:36 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com,
	clg@redhat.com,
	chao.p.peng@intel.com
Subject: [PATCH] vfio/migration: Fix return value of vfio_migration_realize()
Date: Thu, 15 Jun 2023 16:18:51 +0800
Message-Id: <20230615081851.326816-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mga02.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

We should print "Migration disabled" when migration is blocked
in vfio_migration_realize().

Fix it by reverting return value of migrate_add_blocker(),
meanwhile error out directly once migrate_add_blocker() failed.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/common.c    | 4 ++--
 hw/vfio/migration.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index fa8fd949b1cf..8505385798f3 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -399,7 +399,7 @@ int vfio_block_multiple_devices_migration(Error **errp)
         multiple_devices_migration_blocker = NULL;
     }
 
-    return ret;
+    return !ret;
 }
 
 void vfio_unblock_multiple_devices_migration(void)
@@ -444,7 +444,7 @@ int vfio_block_giommu_migration(Error **errp)
         giommu_migration_blocker = NULL;
     }
 
-    return ret;
+    return !ret;
 }
 
 void vfio_migration_finalize(void)
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 6b58dddb8859..0146521d129a 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -646,12 +646,12 @@ int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
     }
 
     ret = vfio_block_multiple_devices_migration(errp);
-    if (ret) {
+    if (ret || (errp && *errp)) {
         return ret;
     }
 
     ret = vfio_block_giommu_migration(errp);
-    if (ret) {
+    if (ret || (errp && *errp)) {
         return ret;
     }
 
@@ -667,7 +667,7 @@ add_blocker:
         error_free(vbasedev->migration_blocker);
         vbasedev->migration_blocker = NULL;
     }
-    return ret;
+    return !ret;
 }
 
 void vfio_migration_exit(VFIODevice *vbasedev)
-- 
2.34.1


