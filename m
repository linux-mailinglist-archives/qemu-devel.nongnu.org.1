Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAAEAE14D9
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Jun 2025 09:24:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSW6M-0007fJ-C2; Fri, 20 Jun 2025 03:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uSW6J-0007UW-43
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 03:23:51 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uSW6D-0008Ot-Pp
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 03:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750404226; x=1781940226;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=D+dc7LHOrfFxCsSPxmn1Invm9HS5geBOVM4r4eW7FRQ=;
 b=MtQ8Qjg7OXmTHqHCVSSffGr/TFDSD9PJMepPs46Bc2hwgNhON2A2aX1F
 d1W/kBlzVWFfaRDf4dtvMQ7WHbtZAQtjxx0GM02GswVuvQ66+q1oGIZZx
 eWR3l4WMxBRA9U7mYq4ic+xHcgzaF8VkrVOul4w5OOJ25gfFnHYUmpcqR
 PA+b+6F8Y5DaOEchrv63/R8YVdREGpdXtkIYiNdO1ouKIJylGqUNdMyRd
 rfW7wlsFok95wH6QjFs+o+fY22MXpmlYiJFf6XM9WHjsSO9BP983xaHDb
 9+15O9SQ3sAp3Mv1wE4v7vdgEbl/29fpd77M+p2M3svWXjH6PHeaYhelu Q==;
X-CSE-ConnectionGUID: QI2sqmoeTaOkmf51vJ6Hzg==
X-CSE-MsgGUID: ENB2rFWuTh+jvLg+UpUo9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52532576"
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; d="scan'208";a="52532576"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 00:23:44 -0700
X-CSE-ConnectionGUID: 2YECpPkhRgiAZmHz/gOYkQ==
X-CSE-MsgGUID: vJdbcjvaRB6EuQqodVWYKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; d="scan'208";a="181863295"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 00:23:40 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v2 19/19] intel_iommu: Enable host device when x-flts=on in
 scalable mode
Date: Fri, 20 Jun 2025 15:18:13 +0800
Message-Id: <20250620071813.55571-20-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250620071813.55571-1-zhenzhong.duan@intel.com>
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Now that all infrastructures of supporting passthrough device running
with stage-1 translation are there, enable it now.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 0b322078cc..88ccce1f94 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -5305,6 +5305,8 @@ static bool vtd_check_hiod(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
                    "when x-flts=on");
         return false;
     }
+
+    return true;
 #endif
 
     error_setg(errp, "host device is uncompatible with stage-1 translation");
-- 
2.34.1


