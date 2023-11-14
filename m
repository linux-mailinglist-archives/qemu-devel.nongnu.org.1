Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EE67EAE05
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 11:27:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2qdX-0005Gz-VT; Tue, 14 Nov 2023 05:27:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r2qdG-00058p-Er; Tue, 14 Nov 2023 05:26:58 -0500
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r2qdE-0007jy-Te; Tue, 14 Nov 2023 05:26:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699957616; x=1731493616;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cUCPSSkRfmQWPToOtzwU716BqrqKL3tmwbY3XxblW/U=;
 b=OEcQMlwg9lNYExsaqJPiDsMZTjUuZ+9SDt/H7ovBFqelwgA2c+vgMafu
 OZwUm9Jy5ozDPyt0tD1vDVES/O+a8wzzTQspX1o03U15BrF/pOlMFJFFH
 Wq/zxIlCZkNcj2vobOL76BjJozM+F24DjrpT/e20IhMImiGPAMz0Ytoe9
 Y1HU7W+efa/qu0IcMFRHo51OMwsFGMxUEgvwEqXJMAKsnsUcVQU2+mTeS
 IOIcwAQdrjR4uB6fC4qN+JD8zdms72TeDrPBMCqsya0y7r94cse4ymGCA
 5hHKdMWkbVFQnmGCW2TGiLdGe3gV6mni5k5ScSFoHEDoSQGamKDIFcng6 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="394543712"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; d="scan'208";a="394543712"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2023 02:26:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="888213207"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; d="scan'208";a="888213207"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2023 02:26:50 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PATCH v6 19/21] hw/arm: Activate IOMMUFD for virt machines
Date: Tue, 14 Nov 2023 18:09:53 +0800
Message-Id: <20231114100955.1961974-20-zhenzhong.duan@intel.com>
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

From: Cédric Le Goater <clg@redhat.com>

Signed-off-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 3ada335a24..660f49db49 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -8,6 +8,7 @@ config ARM_VIRT
     imply TPM_TIS_SYSBUS
     imply TPM_TIS_I2C
     imply NVDIMM
+    imply IOMMUFD
     select ARM_GIC
     select ACPI
     select ARM_SMMUV3
-- 
2.34.1


