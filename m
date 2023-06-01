Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A73B719383
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 08:47:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4c4v-0004Jl-UL; Thu, 01 Jun 2023 02:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q4c4t-0004JK-QR
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 02:46:31 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q4c4s-00077p-7T
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 02:46:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685601989; x=1717137989;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3UTR/KowszX+j7VU9Hw0DVMlJ9VUAyQ+5cmzDF4TtKA=;
 b=UsOfqQkjN7nr47wLYbGM3UiT2m/aKHbin6T/6Q0MSxyilKfDAYtXiuYy
 rRpRp3N1lcDzjkwzRZ4gR1I+yRXG9c58vtr5jKzFrQaBKPPsb70KSB+0q
 ek2vjOrpaMOgXyf0rytCPMdPLVRN/eJbZmjZCO1hLJXLM8w0rKRJ9LNhY
 lSuw+kcO6ff7ocaNmxwr4ok5fFFY0ur3SgYpvije3id8JpPPNKVAnMsd/
 8Bp4qEPZdRXMfZaakbmpoMkhIP8BMAsFV8oq/i7SD9HG0pOJbuQFW4f2I
 7Wl5rKIVIQ0bRn26FcRzOYXlrow56aNalMVQFnk6Rdx4SbwfoIrtfwaot w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="421249362"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; d="scan'208";a="421249362"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2023 23:46:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="953953090"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; d="scan'208";a="953953090"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2023 23:46:25 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, peterx@redhat.com, jasowang@redhat.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com, clg@redhat.com,
 david@redhat.com, philmd@linaro.org, kwankhede@nvidia.com, cjia@nvidia.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com
Subject: [PATCH v2 3/4] memory: Document update on replay()
Date: Thu,  1 Jun 2023 14:33:19 +0800
Message-Id: <20230601063320.139308-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230601063320.139308-1-zhenzhong.duan@intel.com>
References: <20230601063320.139308-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=zhenzhong.duan@intel.com; helo=mga07.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
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

Currently replay() callback is declared to be exactly same semantics
as memory_region_iommu_replay().

Customed replay() may provide some extent of optimization depending on
notifier's type. E.g. intel_iommu, IOMMU_NOTIFIER_MAP is optimized to
provide only changed entries.

Clarify the semantics of replay() and provide more flexibility.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/exec/memory.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index eecc3eec6702..9a523ef62a94 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -441,9 +441,9 @@ struct IOMMUMemoryRegionClass {
      * call the IOMMU translate method for every page in the address space
      * with flag == IOMMU_NONE and then call the notifier if translate
      * returns a valid mapping. If this method is implemented then it
-     * overrides the default behaviour, and must provide the full semantics
-     * of memory_region_iommu_replay(), by calling @notifier for every
-     * translation present in the IOMMU.
+     * overrides the default behavior, and must provide corresponding
+     * semantics depending on notifier's type, e.g. IOMMU_NOTIFIER_MAP,
+     * notify changed entries; IOMMU_NOTIFIER_FULL_MAP, notify full entries.
      *
      * Optional method -- an IOMMU only needs to provide this method
      * if the default is inefficient or produces undesirable side effects.
-- 
2.34.1


