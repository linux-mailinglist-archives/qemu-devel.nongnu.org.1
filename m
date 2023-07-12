Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D08C750042
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 09:41:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJUT8-0006eM-37; Wed, 12 Jul 2023 03:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qJUSa-0006BV-KO
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 03:40:28 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qJUSH-0006qy-Ja
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 03:40:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1689147609; x=1720683609;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/LsjfMjzO/AvjPkIef5al5ausQOOCCXnHbvv6J82mtk=;
 b=S3jR49nvC14wVVTu1VAzHutB4i2auIFAfQD1x5ZYW3etVEuuWKSWy1Aj
 Js76K6ySgAtaEmaYNwBjlizUG7jKABikTUYQSi8fF7b5q0HeyX5AxcwaP
 MT3i2FTtfPdBYLScML6lgwklZpyJQRMC22UfrepS95MT5J68idVq+WcA+
 9Mui7p9eiFen1WP5NSq0fhkMzWtk76ob+puqi/bM5hFAw9LotOmRsxYzK
 DCAXCDUbHB90zhMDXf0AFsDYQE06tS6LW5iGWwWuTHfMgEIAmTw5Ub+we
 4VX0Zzmw++N9dAhDa2NKwHW2bzHJ5jc28Ox4/THihnXxSmIynXoQw1TXD A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="430953782"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; d="scan'208";a="430953782"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2023 00:39:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="835024083"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; d="scan'208";a="835024083"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2023 00:39:52 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, eric.auger@redhat.com, peterx@redhat.com,
 jasonwang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [RFC PATCH v4 16/24] vfio/as: Simplify vfio_viommu_preset()
Date: Wed, 12 Jul 2023 15:25:20 +0800
Message-Id: <20230712072528.275577-17-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712072528.275577-1-zhenzhong.duan@intel.com>
References: <20230712072528.275577-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=zhenzhong.duan@intel.com; helo=mga07.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 T_SCC_BODY_TEXT_LINE=-0.01, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
 hw/vfio/as.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/hw/vfio/as.c b/hw/vfio/as.c
index 0a2363f437..a7179403b7 100644
--- a/hw/vfio/as.c
+++ b/hw/vfio/as.c
@@ -161,22 +161,7 @@ void vfio_unblock_multiple_devices_migration(void)
 
 bool vfio_viommu_preset(VFIODevice *vbasedev)
 {
-    VFIOAddressSpace *space;
-    VFIOContainer *container;
-    VFIODevice *tmp_vbasedev;
-
-    QLIST_FOREACH(space, &vfio_address_spaces, list) {
-        QLIST_FOREACH(container, &space->containers, next) {
-            tmp_vbasedev = NULL;
-            while ((vbasedev = vfio_container_dev_iter_next(container,
-                                                            vbasedev))) {
-                if (vbasedev == tmp_vbasedev) {
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


