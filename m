Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B261B7CA266
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 10:49:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsJHm-0003BM-Bo; Mon, 16 Oct 2023 04:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qsJHZ-0002va-7D
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:49:02 -0400
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qsJHW-0001LN-9g
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697446138; x=1728982138;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pRR4PipXHtJ9LbhLVu38kzyRCPbzt3WZeY50EyJlqBE=;
 b=eQ7zgheTgon8Sga36ylJQCPkiJd49rrKi48bO37obr3tAVLAW4ss+Kbk
 Yn/O68y73E90ncgWGugDSTYluuKbSmJv4FKfQ2BmkPKdV3FjzUokPuDDe
 uHhX+Lq2c0JRdJFXJ/FcYHWcyggWeW0/5n02G1Ct+kmR/dU6wdVKSeLi9
 vOSnuy6FHmLJPwlSd1fjD8pAD0bDhzhFY72IGqqo6tZe3vp2Ceb3LD915
 D99aH+zYIrZVfRjJmDMsaKaVMm+gXELNnnOE1ogOPHSb/owGwu6oqFo6o
 e3YKLTx+Lg2INLZMznd+603Gl5VLPmGatTZjYffZmam4e9CXbjT5gaYfQ Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="365737696"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; d="scan'208";a="365737696"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2023 01:48:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="749223022"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; d="scan'208";a="749223022"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2023 01:48:41 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 20/27] vfio/container: Bypass EEH if iommufd backend
Date: Mon, 16 Oct 2023 16:32:16 +0800
Message-Id: <20231016083223.1519410-21-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016083223.1519410-1-zhenzhong.duan@intel.com>
References: <20231016083223.1519410-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.151;
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

IBM EEH is only supported by legacy backend currently, bypass it
for IOMMUFD backend.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/container.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index c86accdb38..dd9534afab 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -1047,6 +1047,8 @@ static VFIOLegacyContainer *vfio_eeh_as_container(AddressSpace *as)
 {
     VFIOAddressSpace *space = vfio_get_address_space(as);
     VFIOContainer *bcontainer = NULL;
+    const VFIOIOMMUBackendOpsClass *ops = VFIO_IOMMU_BACKEND_OPS_CLASS(
+                      object_class_by_name(TYPE_VFIO_IOMMU_BACKEND_LEGACY_OPS));
 
     if (QLIST_EMPTY(&space->containers)) {
         /* No containers to act on */
@@ -1055,7 +1057,7 @@ static VFIOLegacyContainer *vfio_eeh_as_container(AddressSpace *as)
 
     bcontainer = QLIST_FIRST(&space->containers);
 
-    if (QLIST_NEXT(bcontainer, next)) {
+    if (QLIST_NEXT(bcontainer, next) || bcontainer->ops != ops) {
         /*
          * We don't yet have logic to synchronize EEH state across
          * multiple containers
-- 
2.34.1


