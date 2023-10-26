Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4B57D8132
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 12:51:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvxvH-00047N-1w; Thu, 26 Oct 2023 06:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvxvC-00041K-Sf; Thu, 26 Oct 2023 06:49:02 -0400
Received: from mgamail.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvxvB-0001Nv-54; Thu, 26 Oct 2023 06:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698317341; x=1729853341;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GXWVJSJKrA6OskhLM2e5zCd84xdWO+/D3ApsdMrVliA=;
 b=ZPjF3C+xwaCy0Od1nj1i75bvmcQOZWEAq3ar12501YJoOVufPb0PDSBA
 pcL0BF8HJkrj7zktUw/4KezS2w904G+74dOY6FKz03rFGZgXWd7p9Ln3v
 fHlGBZei/xhJIktkHQTO/axGmiNCjq9C1ZMnI3jzENQJFLDdKcQFjLa7E
 5XSG5OE31cm2nCzJ5IIH7G1RHshi7t3st3AA4Fu8FI2flIHKA/ccv4GJY
 HF3FSOH11e1rqVtUisEaJx2NVAcAPx5vQggCZEQqNlgeaXTeWzjFsv/b4
 7dsXKm30QjoDnnwHffZ2IdS8v4/jnBsnDoZz939JX5MCKeP9K1SO3jrMv A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="372563751"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; d="scan'208";a="372563751"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 03:48:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="463825"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 03:47:52 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 qemu-ppc@nongnu.org (open list:sPAPR (pseries))
Subject: [PATCH v3 29/37] vfio/iommufd: Bypass EEH if iommufd backend
Date: Thu, 26 Oct 2023 18:30:56 +0800
Message-Id: <20231026103104.1686921-30-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 hw/ppc/spapr_pci_vfio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
index d1d07bec46..a2518838a1 100644
--- a/hw/ppc/spapr_pci_vfio.c
+++ b/hw/ppc/spapr_pci_vfio.c
@@ -93,10 +93,10 @@ static VFIOContainer *vfio_eeh_as_container(AddressSpace *as)
 
     bcontainer = QLIST_FIRST(&space->containers);
 
-    if (QLIST_NEXT(bcontainer, next)) {
+    if (QLIST_NEXT(bcontainer, next) || bcontainer->ops != &vfio_legacy_ops) {
         /*
          * We don't yet have logic to synchronize EEH state across
-         * multiple containers
+         * multiple containers, iommufd isn't supported too.
          */
         bcontainer = NULL;
         goto out;
-- 
2.34.1


