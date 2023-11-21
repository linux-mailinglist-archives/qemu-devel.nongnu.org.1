Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B27A7F27E8
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 09:48:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5MOz-00063M-SK; Tue, 21 Nov 2023 03:46:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r5MOv-00062b-BF
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 03:46:33 -0500
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r5MOt-0001Qo-0I
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 03:46:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700556391; x=1732092391;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Z+wJpLKhgIS1v006pPPmVkqIUKj3EnkrkRZBjwby9FQ=;
 b=afFwo/m1Z8c0T6JW5+ZS8l0wD+9JbwVjwLxzbe+GH7AiarROx0ijqpPF
 pWFJI4dua6uIHbaEO4m/7sKk4/P8NcOAQ2CXC2sKwPYT7S1GeyJHr4u3d
 zzGQTjonmm7aWdlcU1YbNEymzz6St+xhWr8yL+oVWrg1dkhzHEKzxg1/4
 +h748+CkpxsvhUIg3e1yPFVkdTAOTUkf8FcskGfuOT+Xe9UO3o8qUUGDM
 RGIGu5Ak1R/0YyFaGRhMzvtF8rEzdHjgLioS71oX6EtrLU+cnaAtjoBRK
 tG2m0mzKVqnwuIP5Li0zrIKtkWVxxIG905fb/wlB+Z2w3suuaPK6vaXQG g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="395721990"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; d="scan'208";a="395721990"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2023 00:46:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="884124850"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; d="scan'208";a="884124850"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2023 00:46:25 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com
Subject: [PATCH v7 03/27] vfio/common: return early if space isn't empty
Date: Tue, 21 Nov 2023 16:44:02 +0800
Message-Id: <20231121084426.1286987-4-zhenzhong.duan@intel.com>
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

This is a trivial optimization. If there is active container in space,
vfio_reset_handler will never be unregistered. So revert the check of
space->containers and return early.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
---
 hw/vfio/common.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 572ae7c934..934f4f5446 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1462,10 +1462,13 @@ VFIOAddressSpace *vfio_get_address_space(AddressSpace *as)
 
 void vfio_put_address_space(VFIOAddressSpace *space)
 {
-    if (QLIST_EMPTY(&space->containers)) {
-        QLIST_REMOVE(space, list);
-        g_free(space);
+    if (!QLIST_EMPTY(&space->containers)) {
+        return;
     }
+
+    QLIST_REMOVE(space, list);
+    g_free(space);
+
     if (QLIST_EMPTY(&vfio_address_spaces)) {
         qemu_unregister_reset(vfio_reset_handler, NULL);
     }
-- 
2.34.1


