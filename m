Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE56CA77C69
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Apr 2025 15:42:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzbsP-0005Jl-DQ; Tue, 01 Apr 2025 09:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbsH-0005Ej-95
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:41:53 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbsF-0006Zf-KA
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743514911; x=1775050911;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lqgmctOznK2bav9EKRyz3Cr7vVK4UhygN00UQ3hENgc=;
 b=UtqwgxrCcLzAwG+/e9LZKnefmPKW1Igeip/X73G+M0RU/qTsRtsa6QvY
 JeNYR8d7VAe61kJv6+2Pzv3Ay5YKuzDLBVSFMgyjuLY3T3uW6RvFeM3pV
 XcGe+RL9nS6oQtUkfyJK0rxeIhcn8QpsZ5XFSrt27M9Y70p8RkTcyEUij
 g7qXvr+s1ocHSBFwF1MkYd7M48pPue00vUK9Tm6llTruaNJBde5GwDA+t
 C/NhadZT/B6hAb6u/ytf5Jp3vk36VriMd69WOTncjw4xH2aPWwStBY9Ia
 vnbKvjoxVUgQG+cYWzzTL17nbWJOIBLm4sbnASiMEqSwxCbCGIbAKY9HV Q==;
X-CSE-ConnectionGUID: 7snFiIU8RbWDU0/6Tv9e8A==
X-CSE-MsgGUID: SO8Dirs9SSmdwSoGUdh82w==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="32433230"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="32433230"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2025 06:41:42 -0700
X-CSE-ConnectionGUID: DIsW2/koTiKVmrRoUvtDBw==
X-CSE-MsgGUID: Oy3V9a/GSHiFsLnjI5JeBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="126639962"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa008.fm.intel.com with ESMTP; 01 Apr 2025 06:41:39 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v8 12/55] i386/tdx: Validate TD attributes
Date: Tue,  1 Apr 2025 09:01:22 -0400
Message-Id: <20250401130205.2198253-13-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250401130205.2198253-1-xiaoyao.li@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Validate TD attributes with tdx_caps that only supported bits are
allowed by KVM.

Besides, sanity check the attribute bits that have not been supported by
QEMU yet. e.g., debug bit, it will be allowed in the future when debug
TD support lands in QEMU.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
---
Changes in v8:
- Split the mrconfigid/mrowner/mrownerconfig part into a seperate next
  patch;

Changes in v7:
- Define TDX_SUPPORTED_TD_ATTRS as QEMU supported mask, to validates
  user's request. (Rick)

Changes in v3:
- using error_setg() for error report; (Daniel)
---
 target/i386/kvm/tdx.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 1202b2111ba8..aa043acb1a88 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -18,10 +18,15 @@
 #include "kvm_i386.h"
 #include "tdx.h"
 
+#define TDX_TD_ATTRIBUTES_DEBUG             BIT_ULL(0)
 #define TDX_TD_ATTRIBUTES_SEPT_VE_DISABLE   BIT_ULL(28)
 #define TDX_TD_ATTRIBUTES_PKS               BIT_ULL(30)
 #define TDX_TD_ATTRIBUTES_PERFMON           BIT_ULL(63)
 
+#define TDX_SUPPORTED_TD_ATTRS  (TDX_TD_ATTRIBUTES_SEPT_VE_DISABLE |\
+                                 TDX_TD_ATTRIBUTES_PKS | \
+                                 TDX_TD_ATTRIBUTES_PERFMON)
+
 static TdxGuest *tdx_guest;
 
 static struct kvm_tdx_capabilities *tdx_caps;
@@ -153,13 +158,33 @@ static int tdx_kvm_type(X86ConfidentialGuest *cg)
     return KVM_X86_TDX_VM;
 }
 
-static void setup_td_guest_attributes(X86CPU *x86cpu)
+static int tdx_validate_attributes(TdxGuest *tdx, Error **errp)
+{
+    if ((tdx->attributes & ~tdx_caps->supported_attrs)) {
+        error_setg(errp, "Invalid attributes 0x%lx for TDX VM "
+                   "(KVM supported: 0x%llx)", tdx->attributes,
+                   tdx_caps->supported_attrs);
+        return -1;
+    }
+
+    if (tdx->attributes & ~TDX_SUPPORTED_TD_ATTRS) {
+        warn_report("Some QEMU unsupported TD attribute bits being requested:"
+                    "requested: 0x%lx QEMU supported: 0x%llx",
+                    tdx->attributes, TDX_SUPPORTED_TD_ATTRS);
+    }
+
+    return 0;
+}
+
+static int setup_td_guest_attributes(X86CPU *x86cpu, Error **errp)
 {
     CPUX86State *env = &x86cpu->env;
 
     tdx_guest->attributes |= (env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_PKS) ?
                              TDX_TD_ATTRIBUTES_PKS : 0;
     tdx_guest->attributes |= x86cpu->enable_pmu ? TDX_TD_ATTRIBUTES_PERFMON : 0;
+
+    return tdx_validate_attributes(tdx_guest, errp);
 }
 
 static int setup_td_xfam(X86CPU *x86cpu, Error **errp)
@@ -225,7 +250,10 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
     init_vm = g_malloc0(sizeof(struct kvm_tdx_init_vm) +
                         sizeof(struct kvm_cpuid_entry2) * KVM_MAX_CPUID_ENTRIES);
 
-    setup_td_guest_attributes(x86cpu);
+    r = setup_td_guest_attributes(x86cpu, errp);
+    if (r) {
+        return r;
+    }
 
     r = setup_td_xfam(x86cpu, errp);
     if (r) {
-- 
2.34.1


