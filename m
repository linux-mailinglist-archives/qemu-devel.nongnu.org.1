Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85637717336
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 03:34:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Ai3-0001S6-0D; Tue, 30 May 2023 21:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <binbin.wu@linux.intel.com>)
 id 1q4Ai0-0001LP-RD
 for qemu-devel@nongnu.org; Tue, 30 May 2023 21:33:04 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <binbin.wu@linux.intel.com>)
 id 1q4Ahy-0006l7-SB
 for qemu-devel@nongnu.org; Tue, 30 May 2023 21:33:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685496782; x=1717032782;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Zsq+hvfNQwS85hL3oR3fwOxOVihCHzchO6BgwimsaeU=;
 b=W4oNs4a9IH04BClDof3MoSYtF94OzPMLsfFl+eaFuEqtLz0SKgqUInVU
 xL4iS9o2lfsiyIDBu20SGnGM59HHs20eyu2EF7vqxt8i54+gQIxsuW1oE
 8AlG+JiZ3GVh1jyzCH2TqC7rnSvihA30cDRDdVirW6Xl6IRu2MEvgICiO
 /DBiNOHbopytIsYSk/f33zOGJc0YHAYQ/hAy1op5Dgvfg5rCIcfQGi0e9
 VzMXDNrATXDlIPYwldBoWc/AKGNIiyAKWXvE2oK2kAfbWS/eD14yaHNRF
 y45W1I0im1aJqRsXRztmJ0hCL5GWjnJpTjy2qpZTg98kVMZ4t+Ef/bSxa w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="420861871"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; d="scan'208";a="420861871"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2023 18:33:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="851024463"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; d="scan'208";a="851024463"
Received: from binbinwu-mobl.ccr.corp.intel.com ([10.255.31.25])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2023 18:32:58 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, xiaoyao.li@intel.com, chao.gao@intel.com,
 robert.hu@linux.intel.com, binbin.wu@linux.intel.com
Subject: [PATCH v2 1/1] target/i386: add support for LAM in CPUID enumeration
Date: Wed, 31 May 2023 09:32:50 +0800
Message-Id: <20230531013250.18311-2-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230531013250.18311-1-binbin.wu@linux.intel.com>
References: <20230531013250.18311-1-binbin.wu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=134.134.136.100;
 envelope-from=binbin.wu@linux.intel.com; helo=mga07.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
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

From: Robert Hoo <robert.hu@linux.intel.com>

Linear Address Masking (LAM) is a new Intel CPU feature, which allows software
to use of the untranslated address bits for metadata.

The bit definition:
CPUID.(EAX=7,ECX=1):EAX[26]

Add CPUID definition for LAM.

More info can be found in Intel ISE Chapter "LINEAR ADDRESS MASKING (LAM)"
https://cdrdv2.intel.com/v1/dl/getContent/671368

Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
Co-developed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 target/i386/cpu.c | 2 +-
 target/i386/cpu.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1242bd541a..f4436b3657 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -881,7 +881,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "fsrc", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, "amx-fp16", NULL, "avx-ifma",
-            NULL, NULL, NULL, NULL,
+            NULL, NULL, "lam", NULL,
             NULL, NULL, NULL, NULL,
         },
         .cpuid = {
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 7201a71de8..eb800ba2e2 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -924,6 +924,8 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 #define CPUID_7_1_EAX_AMX_FP16          (1U << 21)
 /* Support for VPMADD52[H,L]UQ */
 #define CPUID_7_1_EAX_AVX_IFMA          (1U << 23)
+/* Linear Address Masking */
+#define CPUID_7_1_EAX_LAM               (1U << 26)
 
 /* Support for VPDPB[SU,UU,SS]D[,S] */
 #define CPUID_7_1_EDX_AVX_VNNI_INT8     (1U << 4)
-- 
2.25.1


