Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 766E8717A71
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 10:45:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4HQy-0002Dr-Hb; Wed, 31 May 2023 04:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1q4HQW-000296-HH
 for qemu-devel@nongnu.org; Wed, 31 May 2023 04:43:29 -0400
Received: from mga06b.intel.com ([134.134.136.31] helo=mga06.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1q4HQU-0005fZ-8W
 for qemu-devel@nongnu.org; Wed, 31 May 2023 04:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685522606; x=1717058606;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=COnzqPMSLYOBORO/c5DfjIidhTqe6fjVzZt1QcuYJos=;
 b=HvrX4QvcyGN7RfKP6YSKz4DGiDEJliYE9SacMbGAHgcaGjJLz3Q0HpHn
 cC0Bl/lDm5pt9N7q11EzP60X02N+zN3mGx8KKEY8Ikixe/G+Nc6yi6Uey
 pdRgAFFvuNI6AvoVO4ysMX0cutFS5Vd9TzK06Xb8r0jlPCK5fkTGPCoVh
 aSJjZPwBjJJ7/t8jSNKGl+6AZ5/3lo2FpC7WK8y606W4JeEiJChOKuAik
 P6PiAei3DoZAGohlIKggF7QCJyhoQ0+J7n+2LStiJN5sdHBMdisWiFnP2
 D+CN0yQvL2qCukAVccxdsC57bohR6HV1l8GKkvch9AGyHRH796ofQlIHI A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="418669276"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; d="scan'208";a="418669276"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2023 01:43:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="1036956432"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; d="scan'208";a="1036956432"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.46])
 by fmsmga005.fm.intel.com with ESMTP; 31 May 2023 01:43:22 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Chenyi Qiang <chenyi.qiang@intel.com>, lei4.wang@intel.com
Subject: [PATCH v4 4/8] target/i386/intel-pt: print special message for
 INTEL_PT_ADDR_RANGES_NUM
Date: Wed, 31 May 2023 04:43:07 -0400
Message-Id: <20230531084311.3807277-5-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531084311.3807277-1-xiaoyao.li@intel.com>
References: <20230531084311.3807277-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.31; envelope-from=xiaoyao.li@intel.com;
 helo=mga06.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

Bit[2:0] of CPUID.14H_01H:EAX stands as a whole for the number of INTEL
PT ADDR RANGES. For unsupported value that exceeds what KVM reports,
report it as a whole in mark_unavailable_features() as well.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/cpu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e735c366bc97..03471efee66b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4888,7 +4888,14 @@ static void mark_unavailable_features(X86CPU *cpu, FeatureWord w, uint64_t mask,
         return;
     }
 
-    for (i = 0; i < 64; ++i) {
+    if ((w == FEAT_14_1_EAX) && (mask & INTEL_PT_ADDR_RANGES_NUM_MASK)) {
+        warn_report("%s: CPUID.14H_01H:EAX [bit 2:0]", verbose_prefix);
+        i = 3;
+    } else {
+        i = 0;
+    }
+
+    for (; i < 64; ++i) {
         if ((1ULL << i) & mask) {
             g_autofree char *feat_word_str = feature_word_description(f, i);
             warn_report("%s: %s%s%s [bit %d]",
-- 
2.34.1


