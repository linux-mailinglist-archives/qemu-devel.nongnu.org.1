Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 005F67F27E9
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 09:48:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5MQk-0001yX-MB; Tue, 21 Nov 2023 03:48:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r5MQX-0000xr-El
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 03:48:17 -0500
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r5MQR-0002Ds-M6
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 03:48:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700556487; x=1732092487;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3VgUu1aR166z5MaIUW2c52jqW4WEIS7JPL5AeKsrx2c=;
 b=gcGZvR3dVup/GlBZ3uZFO187XIhcTlzXADH/84zCurauocKKipPA9aK9
 Ogiyxzu3aiDlm2wRBYB8C113kmZTuj24hKz5LVp11V5slt2hq6AVetPGc
 bz+kqfNW5GxoJKuGs1y9bGDicRWoIGwUoWO2rcPBEa1pFbBpxMv36+aFj
 meXLEAAswsdcGT+UKKRPxAmyXwsuJCY48tGW8ZGcvX5HI5y0Ho6X9pA+V
 JdjQ5TkmCEhyzgpvTGF5V900/0wzM2InbGCgEGSo7lytWcG1adVKeK4Qc
 +ZiQGFxCveld0CqYryIrBWt0/pPegkm/yqWrn7jtNpUgVUpx1wa6p0igl A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="395722280"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; d="scan'208";a="395722280"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2023 00:47:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="884125118"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; d="scan'208";a="884125118"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2023 00:47:38 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com
Subject: [PATCH v7 20/27] kconfig: Activate IOMMUFD for s390x machines
Date: Tue, 21 Nov 2023 16:44:19 +0800
Message-Id: <20231121084426.1286987-21-zhenzhong.duan@intel.com>
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

From: Cédric Le Goater <clg@redhat.com>

Signed-off-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
---
 hw/s390x/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/s390x/Kconfig b/hw/s390x/Kconfig
index 4c068d7960..26ad104485 100644
--- a/hw/s390x/Kconfig
+++ b/hw/s390x/Kconfig
@@ -6,6 +6,7 @@ config S390_CCW_VIRTIO
     imply VFIO_CCW
     imply WDT_DIAG288
     imply PCIE_DEVICES
+    imply IOMMUFD
     select PCI_EXPRESS
     select S390_FLIC
     select S390_FLIC_KVM if KVM
-- 
2.34.1


