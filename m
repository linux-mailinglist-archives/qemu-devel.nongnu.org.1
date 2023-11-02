Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9317DED82
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 08:37:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qySAa-0000ur-22; Thu, 02 Nov 2023 03:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qySAH-0000Hs-Oc
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 03:30:58 -0400
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qySAG-0003PH-02
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 03:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698910252; x=1730446252;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5ejhTNqCwupSTAJs1yfEG2tXWeKhQlFW3fCS+eeO2Bc=;
 b=lLutUUvKh+Zp4kwmjGoqY7ufVJE3HF+cdgTTQAqzGXIuL+ZF1Y1/DuXX
 wOoDYnnMzUJ02UskkXYaIGvR+lmDfP4RGe7hgQqaQzTrS9kRIQeM7BlJO
 AVEVVtHUTNdC12SKU6KLM7OnyPeTmOJsiaI6oJdSWaqIrt6hKUNWOt06z
 P8jWBUMcBFY55q3B3jjmpWnaFmfz0cLK0Grs82XmYMwRcttcl11g/E7LQ
 5xCdz6C0unoEiodoDTXd37LvQoJ4PmBr4mPX1PtrzZ6lOhTMmFR+VTwbj
 lMiOCnJCjmYcHpqX6/SA7HmRHGxu9yK2dTRuVZHOZwEsYGkukikSx1P9b g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="452953334"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="452953334"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:30:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="711055665"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="711055665"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:30:29 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 29/41] vfio/iommufd: Relax assert check for iommufd backend
Date: Thu,  2 Nov 2023 15:12:50 +0800
Message-Id: <20231102071302.1818071-30-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Currently iommufd doesn't support dirty page sync yet,
but it will not block us doing live migration if VFIO
migration is force enabled.

So in this case we allow set_dirty_page_tracking to be NULL.
Note we don't need same change for query_dirty_bitmap because
when dirty page sync isn't supported, query_dirty_bitmap will
never be called.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
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


