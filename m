Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E26D5717A6F
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 10:44:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4HQa-00029u-Lb; Wed, 31 May 2023 04:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1q4HQV-00028m-Eb
 for qemu-devel@nongnu.org; Wed, 31 May 2023 04:43:27 -0400
Received: from mga06b.intel.com ([134.134.136.31] helo=mga06.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1q4HQP-0005fO-ED
 for qemu-devel@nongnu.org; Wed, 31 May 2023 04:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685522601; x=1717058601;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tCe2NK+4wo5tYFcR9V7u1zkUeKhtImrp9c2scYoxMcc=;
 b=chGVtOS/xmsrpyXMcKItWYV/XaSF57sVVhYWiUaYu9/PgnOlixttcfy3
 ty6gaUXUA4aHwJoBDjLjM0X7FWb6PNjkaP5SNiY4PYy3S/uhNRatlQhGF
 1tX7C3oOr/tQrpwqc69qwqrQZ9tQrFCqtBdlqg8i7XOv795hhnJ7nYPDy
 XK4n6bLWJb19aY8yGMImlUy14Rf1e+tzebnb0cDmEwpVdkfJ2GWEOvV8s
 je4orI+iEm5Z4oOJWPF7VggpzoFfrWR+MC8oyaX4lvIusbLIyWsEWAznG
 qfRdm1YAFi0mm/pIwqLHnp891P7SF6/gQ27pgLU3KHHv2A6J/v0JIZsTM Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="418669242"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; d="scan'208";a="418669242"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2023 01:43:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="1036956395"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; d="scan'208";a="1036956395"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.46])
 by fmsmga005.fm.intel.com with ESMTP; 31 May 2023 01:43:17 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Chenyi Qiang <chenyi.qiang@intel.com>, lei4.wang@intel.com
Subject: [PATCH v4 1/8] target/i386: Print CPUID subleaf info for unsupported
 feature
Date: Wed, 31 May 2023 04:43:04 -0400
Message-Id: <20230531084311.3807277-2-xiaoyao.li@intel.com>
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
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Some CPUID leaves have meaningful subleaf index. Print the subleaf info
in feature_word_description for CPUID features.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1242bd541a53..88e90c1f7b7c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4745,8 +4745,9 @@ static char *feature_word_description(FeatureWordInfo *f, uint32_t bit)
         {
             const char *reg = get_register_name_32(f->cpuid.reg);
             assert(reg);
-            return g_strdup_printf("CPUID.%02XH:%s",
-                                   f->cpuid.eax, reg);
+            return g_strdup_printf("CPUID.%02XH_%02XH:%s",
+                                   f->cpuid.eax,
+                                   f->cpuid.needs_ecx ? f->cpuid.ecx : 0, reg);
         }
     case MSR_FEATURE_WORD:
         return g_strdup_printf("MSR(%02XH)",
-- 
2.34.1


