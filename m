Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA067D4A40
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 10:34:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvCrX-0006gu-Jt; Tue, 24 Oct 2023 04:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qvCrV-0006eE-E2
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:34:05 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qvCrS-0001by-WA
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698136443; x=1729672443;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=CPMK5XyY8c3uU14JBUuoVodn9h8wuyEnTavDRpXnB6U=;
 b=ITQqM7YiPN7bS2W2/39LMFISzPPPazd7rYuWZEz+Ovnwp9WM+15LLegW
 TFtpFFdY8iU2peUYWMMFAIBkOpWj4xomeKeQh6FTFbiUlVBqzRRPl2xiC
 Yn/r4b22ffjRlpSucBEyZSQSObBAnaGUCEBEt/E2dN8MWLMOYe+EaL2WH
 6kkM85QKNMac9FntIZ65OU3X5habEHgyxp8TebkICuoiZXLL0EeIi2UOS
 0lac8aW46xJHvRob2XlxwGrvfYUK/omMpcPMUVjOvc1NovEvXHqiFbQJi
 xvZpxKKEdNmPD3bXljGrezCIV+f4PZwDP1+zR/PuK6PacXcnpbDzKQru7 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="8562639"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="8562639"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2023 01:33:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="1089779640"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; d="scan'208";a="1089779640"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmsmga005.fm.intel.com with ESMTP; 24 Oct 2023 01:33:57 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] target/i386: Add support of KVM_FEATURE_ASYNC_PF_VMEXIT for
 guest
Date: Tue, 24 Oct 2023 04:33:54 -0400
Message-Id: <20231024083354.1171308-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

KVM_FEATURE_ASYNC_PF_VMEXIT has been introduced for years, however QEMU
doesn't support expose it to guest. Add support for it.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index bdca901dfaa4..d664a408b3c7 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -856,7 +856,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .feat_names = {
             "kvmclock", "kvm-nopiodelay", "kvm-mmu", "kvmclock",
             "kvm-asyncpf", "kvm-steal-time", "kvm-pv-eoi", "kvm-pv-unhalt",
-            NULL, "kvm-pv-tlb-flush", NULL, "kvm-pv-ipi",
+            NULL, "kvm-pv-tlb-flush", "kvm-asyncpf-vmexit", "kvm-pv-ipi",
             "kvm-poll-control", "kvm-pv-sched-yield", "kvm-asyncpf-int", "kvm-msi-ext-dest-id",
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-- 
2.34.1


