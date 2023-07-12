Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B403B750044
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 09:41:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJURs-0004DA-RF; Wed, 12 Jul 2023 03:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qJURq-0004CF-71
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 03:39:42 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qJURo-0006oM-09
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 03:39:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1689147580; x=1720683580;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IB7rEdiNYXBzFckHyXh7dqXt6sd7meC6x/EAchCG7qo=;
 b=N/XDgyMqETg7x5rLI6D+UwuZejQIafQK6zic/kIRExRf23DpT5nt73gA
 nvR4h7rlVZ4b14OYF8Ez33DKNeXZfBWZZuZhwoAtCASgsG2Fc/1rJQWj5
 yZyNi7qXU2Uu37kRA4ergly9TI9629vpjCN6tWEE+h7muq6ACW6rOBnzu
 FZEWFjJXJby4GZZTUX49MvP1gqU9PtlNgPAf/oZMTaKjIviJU0+dzzeXV
 27zK+zEbbsdbMe1nHzj+y5OTk+hN8sy4sSKW9YEHqeEVpEhz3C51oCSu6
 HAaBW2K7cgYyZ0kLsEBzkIjiTWms9KfLoTs+W2buKeAaSS0z5PLeCw/dT w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="430953641"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; d="scan'208";a="430953641"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2023 00:39:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="835023994"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; d="scan'208";a="835023994"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2023 00:39:16 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, eric.auger@redhat.com, peterx@redhat.com,
 jasonwang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [RFC PATCH v4 07/24] vfio/common: Refactor vfio_viommu_preset() to be
 group agnostic
Date: Wed, 12 Jul 2023 15:25:11 +0800
Message-Id: <20230712072528.275577-8-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712072528.275577-1-zhenzhong.duan@intel.com>
References: <20230712072528.275577-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=zhenzhong.duan@intel.com; helo=mga07.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

So that it doesn't need to be moved into container.c as done
in following patch.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/common.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index f7e4dc0cef..a1fb0dafda 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -215,7 +215,22 @@ void vfio_unblock_multiple_devices_migration(void)
 
 bool vfio_viommu_preset(VFIODevice *vbasedev)
 {
-    return vbasedev->group->container->space->as != &address_space_memory;
+    VFIOAddressSpace *space;
+    VFIOContainer *container;
+    VFIODevice *tmp_vbasedev;
+
+    QLIST_FOREACH(space, &vfio_address_spaces, list) {
+        QLIST_FOREACH(container, &space->containers, next) {
+            tmp_vbasedev = NULL;
+            while ((vbasedev = vfio_container_dev_iter_next(container,
+                                                            vbasedev))) {
+                if (vbasedev == tmp_vbasedev) {
+                    return space->as != &address_space_memory;
+                }
+            }
+        }
+    }
+    g_assert_not_reached();
 }
 
 static void vfio_set_migration_error(int err)
-- 
2.34.1


