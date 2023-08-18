Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86708780945
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 12:00:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWwCn-00056j-Si; Fri, 18 Aug 2023 05:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qWwCl-0004wB-Nh
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 05:55:43 -0400
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qWwCi-0007tV-VU
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 05:55:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692352541; x=1723888541;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UNz7MOGRmZ0RCC7N+iMVEuoRo4KVjeIFiDHKv0D5kJ0=;
 b=LkP9lv1+oEPodVPEoEdCpCd1Dt8RglSkNObWv6nlNyySjpTdM9+7L0Gd
 dzL3RxsYOQ8PPT4D+jTTooLLOY4ZAUfoSBP10D3/DSv/NqxX27SCUfavC
 QoPL6VFU8+7AWOAjMlHK+5liHT4gu88LaDw9vg6b6fjYlqFH99Be8DYiN
 4ezIIjmpjaavi4E1eHpSHSnGfNt6IMVguwWV1ZdH1bPxHWeK0VPMLDz/t
 yy3S1cOg61rvL3sDaPj64xJB5qyUCoEWVOoeFp+M+4C9MlR33ZNVY7F5p
 OwT5LW0ZflhWqdy48AA0/A+QW8fbQt4215Mxf0aOzFZm4+0kSJF0ojnw7 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="371965790"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; d="scan'208";a="371965790"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2023 02:55:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="849234866"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; d="scan'208";a="849234866"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.46])
 by fmsmga002.fm.intel.com with ESMTP; 18 Aug 2023 02:55:13 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Eduardo Habkost <eduardo@habkost.net>, Laszlo Ersek <lersek@redhat.com>,
 xiaoyao.li@intel.com, Isaku Yamahata <isaku.yamahata@gmail.com>,
 erdemaktas@google.com, Chenyi Qiang <chenyi.qiang@intel.com>
Subject: [PATCH v2 10/58] i386/tdx: Integrate tdx_caps->xfam_fixed0/1 into
 tdx_cpuid_lookup
Date: Fri, 18 Aug 2023 05:49:53 -0400
Message-Id: <20230818095041.1973309-11-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818095041.1973309-1-xiaoyao.li@intel.com>
References: <20230818095041.1973309-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.120; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.021,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
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
index 97ad229d8ba3..b8850a02539a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1568,9 +1568,6 @@ static const X86RegisterInfo32 x86_reg_info_32[CPU_NB_REGS32] = {
 };
 #undef REGISTER
 
-/* CPUID feature bits available in XSS */
-#define CPUID_XSTATE_XSS_MASK    (XSTATE_ARCH_LBR_MASK)
-
 ExtSaveArea x86_ext_save_areas[XSAVE_STATE_AREA_COUNT] = {
     [XSTATE_FP_BIT] = {
         /* x87 FP state component is always enabled if XSAVE is supported */
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c93dcd274531..d4a7f9e3f54c 100644
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
index 4518c79aecc8..19aed03f12c6 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -395,6 +395,30 @@ static void update_tdx_cpuid_lookup_by_tdx_caps(void)
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


