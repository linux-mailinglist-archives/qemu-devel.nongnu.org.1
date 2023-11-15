Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F647EBDA6
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 08:19:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3AA6-00052R-Nu; Wed, 15 Nov 2023 02:18:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r3A9w-000497-9G
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 02:18:02 -0500
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r3A9u-0002RE-CI
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 02:17:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700032678; x=1731568678;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AgibimtbXXvqSJpqEHAW5GI2bX71Q1KTh1X5lWn26Tc=;
 b=bhMQ2zFOOq2tE1nhRQrUHHNHEo+EFL0S9RGF5RjyIzOcybejUfTXKWk4
 ghwsBwkucVi7/z7jcvzVU3ehc9zxbv6e53v7twGwzbnqE1XU8FhzpVaCI
 Fqx3osOFcz3MJB4bY/8Mffa6aH07TQmE0Ld8iXXK5BXEiPu1uU61C92xZ
 FI3NWu17zcPXrbUEIelW2vrcMygrwjflZyBR9QsSHuGyGH3g5+vEppOl/
 zrC+pQV3w/n/lz0P2z3YajOkO2TQQOkCTpjd9vZNtNEmS6JNRy3kyljfT
 SBzZg4wk0ReU6n75Dy+GLDfwfgdyKW7GJcTvgLy3p5NVMblwcvl1LYCy4 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="390622625"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="390622625"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2023 23:17:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="714798174"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="714798174"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orsmga003.jf.intel.com with ESMTP; 14 Nov 2023 23:17:51 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, xiaoyao.li@intel.com,
 Michael Roth <michael.roth@amd.com>,
 Sean Christopherson <seanjc@google.com>,
 Claudio Fontana <cfontana@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>
Subject: [PATCH v3 22/70] i386/tdx: Integrate tdx_caps->xfam_fixed0/1 into
 tdx_cpuid_lookup
Date: Wed, 15 Nov 2023 02:14:31 -0500
Message-Id: <20231115071519.2864957-23-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231115071519.2864957-1-xiaoyao.li@intel.com>
References: <20231115071519.2864957-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.115; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

KVM requires userspace to pass XFAM configuration via CPUID 0xD leaves.

Convert tdx_caps->xfam_fixed0/1 into corresponding
tdx_cpuid_lookup[].tdx_fixed0/1 field of CPUID 0xD leaves. Thus the
requirement can be applied naturally.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/cpu.c     |  3 ---
 target/i386/cpu.h     |  3 +++
 target/i386/kvm/tdx.c | 24 ++++++++++++++++++++++++
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 358d9c0a655a..128b01054ff3 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1575,9 +1575,6 @@ static const X86RegisterInfo32 x86_reg_info_32[CPU_NB_REGS32] = {
 };
 #undef REGISTER
 
-/* CPUID feature bits available in XSS */
-#define CPUID_XSTATE_XSS_MASK    (XSTATE_ARCH_LBR_MASK)
-
 ExtSaveArea x86_ext_save_areas[XSAVE_STATE_AREA_COUNT] = {
     [XSTATE_FP_BIT] = {
         /* x87 FP state component is always enabled if XSAVE is supported */
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index bd9151d3bcaa..d0b7ba5d113e 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -588,6 +588,9 @@ typedef enum X86Seg {
                                  XSTATE_Hi16_ZMM_MASK | XSTATE_PKRU_MASK | \
                                  XSTATE_XTILE_CFG_MASK | XSTATE_XTILE_DATA_MASK)
 
+/* CPUID feature bits available in XSS */
+#define CPUID_XSTATE_XSS_MASK    (XSTATE_ARCH_LBR_MASK)
+
 /* CPUID feature words */
 typedef enum FeatureWord {
     FEAT_1_EDX,         /* CPUID[1].EDX */
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 7fa86858de58..be7771bd97d7 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -400,6 +400,30 @@ static void update_tdx_cpuid_lookup_by_tdx_caps(void)
         entry->tdx_fixed0 &= ~config;
         entry->tdx_fixed1 &= ~config;
     }
+
+    /*
+     * Because KVM gets XFAM settings via CPUID leaves 0xD,  map
+     * tdx_caps->xfam_fixed{0, 1} into tdx_cpuid_lookup[].tdx_fixed{0, 1}.
+     *
+     * Then the enforment applies in tdx_get_configurable_cpuid() naturally.
+     */
+    tdx_cpuid_lookup[FEAT_XSAVE_XCR0_LO].tdx_fixed0 =
+            (uint32_t)~tdx_caps->xfam_fixed0 & CPUID_XSTATE_XCR0_MASK;
+    tdx_cpuid_lookup[FEAT_XSAVE_XCR0_LO].tdx_fixed1 =
+            (uint32_t)tdx_caps->xfam_fixed1 & CPUID_XSTATE_XCR0_MASK;
+    tdx_cpuid_lookup[FEAT_XSAVE_XCR0_HI].tdx_fixed0 =
+            (~tdx_caps->xfam_fixed0 & CPUID_XSTATE_XCR0_MASK) >> 32;
+    tdx_cpuid_lookup[FEAT_XSAVE_XCR0_HI].tdx_fixed1 =
+            (tdx_caps->xfam_fixed1 & CPUID_XSTATE_XCR0_MASK) >> 32;
+
+    tdx_cpuid_lookup[FEAT_XSAVE_XSS_LO].tdx_fixed0 =
+            (uint32_t)~tdx_caps->xfam_fixed0 & CPUID_XSTATE_XSS_MASK;
+    tdx_cpuid_lookup[FEAT_XSAVE_XSS_LO].tdx_fixed1 =
+            (uint32_t)tdx_caps->xfam_fixed1 & CPUID_XSTATE_XSS_MASK;
+    tdx_cpuid_lookup[FEAT_XSAVE_XSS_HI].tdx_fixed0 =
+            (~tdx_caps->xfam_fixed0 & CPUID_XSTATE_XSS_MASK) >> 32;
+    tdx_cpuid_lookup[FEAT_XSAVE_XSS_HI].tdx_fixed1 =
+            (tdx_caps->xfam_fixed1 & CPUID_XSTATE_XSS_MASK) >> 32;
 }
 
 int tdx_kvm_init(MachineState *ms, Error **errp)
-- 
2.34.1


