Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FC97325D1
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 05:24:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qA03e-0000Ed-D5; Thu, 15 Jun 2023 23:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1qA03b-0000EU-UG
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 23:23:27 -0400
Received: from mga04.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1qA03a-0002FT-DG
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 23:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686885806; x=1718421806;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MUTK+oCoXEsWO+pwqGUVkFjo79OvtzDYyt+nk5Bdc04=;
 b=YVPUrxrBShM2PD+IsXebw/TV08OULtutHfPlpSmC+yPUYqqaxjoTlEGe
 bv6sJ8u91GNtjfHr78wRVUCOvzTJt68/bXRNQC4fImHdY+/TcO6F4ZN44
 fNQN+SjGQ9kEVBV8gON65fWht+tzb+R6ZNgW0vaPgIj0qI0MhSpZ1Oleb
 DJTbKq0CxFAX1h8WoNKse6KvoB5i0T1JGY/oTjHenRUNACoJjlHfIjFFc
 erhMuMu3SzPEGAPiaqPCCrIzeSGfePGMSjtU1KORBmrUmUGrWpHjx04qA
 WPie0sVqStSNwijNngyGfvYiEsvjrbpcG1rmYyf5Lxx6sUT5RrDZQgJhk w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="357979167"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; d="scan'208";a="357979167"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2023 20:23:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="715846004"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; d="scan'208";a="715846004"
Received: from st-server.bj.intel.com ([10.240.193.102])
 by fmsmga007.fm.intel.com with ESMTP; 15 Jun 2023 20:23:23 -0700
From: Tao Su <tao1.su@linux.intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, xiaoyao.li@intel.com, lei4.wang@intel.com,
 qian.wen@intel.com, imammedo@redhat.com, tao1.su@linux.intel.com
Subject: [PATCH 4/7] target/i386: Add new bit definitions of
 MSR_IA32_ARCH_CAPABILITIES
Date: Fri, 16 Jun 2023 11:23:08 +0800
Message-Id: <20230616032311.19137-5-tao1.su@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230616032311.19137-1-tao1.su@linux.intel.com>
References: <20230616032311.19137-1-tao1.su@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.55.52.120;
 envelope-from=tao1.su@linux.intel.com; helo=mga04.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

Currently, bit 13, 14, 15 and 24 of MSR_IA32_ARCH_CAPABILITIES are
disclosed for fixing security issues, so add those bit definitions
and feature names.

Signed-off-by: Tao Su <tao1.su@linux.intel.com>
---
 target/i386/cpu.c | 4 ++--
 target/i386/cpu.h | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 7898a4c79a..b5321240c6 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1069,10 +1069,10 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "rdctl-no", "ibrs-all", "rsba", "skip-l1dfl-vmentry",
             "ssb-no", "mds-no", "pschange-mc-no", "tsx-ctrl",
             "taa-no", NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
+            NULL, "sbdr-ssdp-no", "fbsdp-no", "psdp-no",
             NULL, "fb-clear", NULL, NULL,
             NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
+            "pbrsb-no", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
         .msr = {
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 64d50acf41..6221b1c0a4 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1022,7 +1022,11 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 #define MSR_ARCH_CAP_PSCHANGE_MC_NO     (1U << 6)
 #define MSR_ARCH_CAP_TSX_CTRL_MSR       (1U << 7)
 #define MSR_ARCH_CAP_TAA_NO             (1U << 8)
+#define MSR_ARCH_CAP_SBDR_SSDP_NO       (1u << 13)
+#define MSR_ARCH_CAP_FBSDP_NO           (1u << 14)
+#define MSR_ARCH_CAP_PSDP_NO            (1u << 15)
 #define MSR_ARCH_CAP_FB_CLEAR           (1U << 17)
+#define MSR_ARCH_CAP_PBRSB_NO           (1U << 24)
 
 #define MSR_CORE_CAP_SPLIT_LOCK_DETECT  (1U << 5)
 
-- 
2.34.1


