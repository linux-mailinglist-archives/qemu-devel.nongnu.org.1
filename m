Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9AC7F27F3
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 09:49:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5MP3-00064q-Ef; Tue, 21 Nov 2023 03:46:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r5MP2-00064f-08
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 03:46:40 -0500
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r5MP0-0001Qo-Cu
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 03:46:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700556398; x=1732092398;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GB2wT+bF18h6O66WxNQkH6AVmyasMVqzPc1b9COIOfU=;
 b=jj33+jjr1l3TFZRpOEs6iKzPK2zVBcMzJs4146n5zeMn4Ukev4aU649M
 ond5vp+bXCpwjyjA5eSP2SliPVR/2hdWcwgxDeCGty3ZEK+n98NUGdOAY
 u/kE8E0FVSppCDcLypm0VjCpTmULoq7bn7Kuu4wW3ciA2E6N7xZV75Kod
 QtWP8nau8ItJj1NwfazycEz1ehrV+seOIwjcGbaAM3ChxMkrKuhuRVpI2
 1A5OsDodmyF/qcuYVfwOHoPWS3rZ4B/YitqvweDKYT1UruwlJl2797yJ2
 NbQFekasi9sXzBky6Wg85wJSh3R4M2wYUJUPRo8snaa8FOSaNvm0vJuz5 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="395722026"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; d="scan'208";a="395722026"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2023 00:46:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="884124874"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; d="scan'208";a="884124874"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2023 00:46:33 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com
Subject: [PATCH v7 05/27] vfio/iommufd: Relax assert check for iommufd backend
Date: Tue, 21 Nov 2023 16:44:04 +0800
Message-Id: <20231121084426.1286987-6-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121084426.1286987-1-zhenzhong.duan@intel.com>
References: <20231121084426.1286987-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.65;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
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
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
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


