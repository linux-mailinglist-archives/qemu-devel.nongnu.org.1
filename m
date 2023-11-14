Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 405487EADF7
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 11:26:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2qcF-0002zu-0C; Tue, 14 Nov 2023 05:25:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r2qcB-0002vO-DU
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 05:25:52 -0500
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r2qc9-0007eY-E9
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 05:25:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699957549; x=1731493549;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1LQoTAq2xCzVb9zK/Ayjl8PxMnVgOzkUS9bgxmrH0Uk=;
 b=ea5ZH7dUVOrxdjTbY11ec6ymS6eh1tth5mnjbF1k5OxJrhYIFwW3QS7E
 pfMdpecYiuBe77DkQgXld9llLWs7aZFCBwu0Nvpezj/G5zKfErY9443Yg
 1Mbnl7oYrGxseciQcv6LBISXwNRxqysal55RmtGEFykwI7h+SiFwpJNcH
 wBBu9SojIKRsIXQM1hIIvSg8Wq7AI12nD/cbnLkgSooni+FTKmmDaIqqy
 zQMZi+oOaEMAF8HFHmyZ2IwACMUVUJ1ftxh/D6/lxhZx8RY80HfuBwmWk
 cxfTPPJD/LqTsXLhF7SIRwWvOt3IT6crjCxqcJm/21aZEt9rNt4bexRx8 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="394543442"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; d="scan'208";a="394543442"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2023 02:25:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="888212880"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; d="scan'208";a="888212880"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2023 02:25:43 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v6 05/21] vfio/iommufd: Relax assert check for iommufd backend
Date: Tue, 14 Nov 2023 18:09:39 +0800
Message-Id: <20231114100955.1961974-6-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.65;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Currently iommufd doesn't support dirty page sync yet,
but it will not block us doing live migration if VFIO
migration is force enabled.

So in this case we allow set_dirty_page_tracking to be NULL.
Note we don't need same change for query_dirty_bitmap because
when dirty page sync isn't supported, query_dirty_bitmap will
never be called.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/container-base.c | 4 ++++
 hw/vfio/container.c      | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 71f7274973..eee2dcfe76 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -55,6 +55,10 @@ void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
 int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
                                            bool start)
 {
+    if (!bcontainer->dirty_pages_supported) {
+        return 0;
+    }
+
     g_assert(bcontainer->ops->set_dirty_page_tracking);
     return bcontainer->ops->set_dirty_page_tracking(bcontainer, start);
 }
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 6bacf38222..ed2d721b2b 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -216,10 +216,6 @@ static int vfio_legacy_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
         .argsz = sizeof(dirty),
     };
 
-    if (!bcontainer->dirty_pages_supported) {
-        return 0;
-    }
-
     if (start) {
         dirty.flags = VFIO_IOMMU_DIRTY_PAGES_FLAG_START;
     } else {
-- 
2.34.1


