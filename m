Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2FB7E6A3C
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 13:02:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r13it-0001qr-QB; Thu, 09 Nov 2023 07:01:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r13io-0001qZ-DS
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 07:01:18 -0500
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r13il-0001a4-O7
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 07:01:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699531275; x=1731067275;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5ejhTNqCwupSTAJs1yfEG2tXWeKhQlFW3fCS+eeO2Bc=;
 b=FhGfju0VjXn/r1thLtinGoW+RlITmnfzTBgovnNCcxKKIH9gpKAZyBSv
 GK3yrwFSqrKnAM+9YVQ+w1n5yLrFMgPLjgC6l+dzTRptLTjwJdmsctwgp
 CDZ4PapEsDXIlJkxpjhMkFnBG5TRLFX+KcAGJSimJdkJvWsyAG6IoY3Bf
 ulqlPeoT0jxz89+/4TxL0sWi6Na6fRlSyT921oTWcjn1XKIR/fCso7b1/
 KFS9SYNwA3coAJ2XtALmjs0FTVKXsNCcCinQp4j7oHIhw/ZXw6zl2SwFv
 Stl6E266GMYeBOO1M2xBbTTCUHZzavXi8MzifyFfOIsEwl8MErCxcjNRI Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="369305243"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; d="scan'208";a="369305243"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2023 04:01:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; d="scan'208";a="11515509"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2023 04:01:08 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v5 04/20] vfio/iommufd: Relax assert check for iommufd backend
Date: Thu,  9 Nov 2023 19:45:13 +0800
Message-Id: <20231109114529.1904193-5-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109114529.1904193-1-zhenzhong.duan@intel.com>
References: <20231109114529.1904193-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.136;
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


