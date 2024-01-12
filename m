Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FD582BB1F
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 07:02:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOAbM-0004g3-IC; Fri, 12 Jan 2024 01:01:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <binbin.wu@linux.intel.com>)
 id 1rOAbD-0004fK-L6
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 01:00:59 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <binbin.wu@linux.intel.com>)
 id 1rOAb9-0001Y8-SW
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 01:00:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705039256; x=1736575256;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TjGvkLnFdATYJZjMoetdlVNdiuJsV6qD9qhxqSL1S54=;
 b=ny5Vd1AmflA0+JzFI84CNHJx8zWx3/17opcSFqmH85s1KMznagzPh+rb
 BER5uXOIsODtPCFXVKmZ3bjXNm7wXbcKuyAwvWkIlmiQgHirIDJFoYdmJ
 Xz/LMt6IGw9F/MBHNJwlJeavwCB6VaMaRS6IHvoXx6IMrP61T7P1rMjCj
 GA6BkeizHBhGXh7nr4PaArnghuu9EtK8NxoKEabFO9CkVLz/hKLpZU1c9
 VTxyR9fEZ+YA21aYML2LIoXm2ZnLjEGpceAjXC/HjD1By6Q6GbLznFz3Y
 mXD4ipnH+TRZcdLXCjtIlaHBMdGfAyuwWEJ4+Y2X6741ppKSOlxBr5Pm6 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="5815754"
X-IronPort-AV: E=Sophos;i="6.04,188,1695711600"; 
   d="scan'208";a="5815754"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2024 22:00:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="873274718"
X-IronPort-AV: E=Sophos;i="6.04,188,1695711600"; d="scan'208";a="873274718"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO
 binbinwu-mobl.sh.intel.com) ([10.238.2.99])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2024 22:00:48 -0800
From: Binbin Wu <binbin.wu@linux.intel.com>
To: qemu-devel@nongnu.org,
	kvm@vger.kernel.org
Cc: pbonzini@redhat.com, xiaoyao.li@intel.com, chao.gao@intel.com,
 robert.hu@linux.intel.com, binbin.wu@linux.intel.com
Subject: [PATCH v4 1/2] target/i386: add support for LAM in CPUID enumeration
Date: Fri, 12 Jan 2024 14:00:41 +0800
Message-Id: <20240112060042.19925-2-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240112060042.19925-1-binbin.wu@linux.intel.com>
References: <20240112060042.19925-1-binbin.wu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.11;
 envelope-from=binbin.wu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Linear Address Masking (LAM) is a new Intel CPU feature, which allows
software to use of the untranslated address bits for metadata.

The bit definition:
CPUID.(EAX=7,ECX=1):EAX[26]

Add CPUID definition for LAM.

Note LAM feature is not supported for TCG of target-i386, LAM CPIUD bit
will not be added to TCG_7_1_EAX_FEATURES.

More info can be found in Intel ISE Chapter "LINEAR ADDRESS MASKING(LAM)"
https://cdrdv2.intel.com/v1/dl/getContent/671368

Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
Co-developed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
Tested-by: Xuelian Guo <xuelian.guo@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/cpu.c | 2 +-
 target/i386/cpu.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 2524881ce2..fc862dfeb1 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -967,7 +967,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "fsrc", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, "amx-fp16", NULL, "avx-ifma",
-            NULL, NULL, NULL, NULL,
+            NULL, NULL, "lam", NULL,
             NULL, NULL, NULL, NULL,
         },
         .cpuid = {
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 7f0786e8b9..18ea755644 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -925,6 +925,8 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 #define CPUID_7_1_EAX_AMX_FP16          (1U << 21)
 /* Support for VPMADD52[H,L]UQ */
 #define CPUID_7_1_EAX_AVX_IFMA          (1U << 23)
+/* Linear Address Masking */
+#define CPUID_7_1_EAX_LAM               (1U << 26)
 
 /* Support for VPDPB[SU,UU,SS]D[,S] */
 #define CPUID_7_1_EDX_AVX_VNNI_INT8     (1U << 4)
-- 
2.25.1


