Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 056C174951B
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 07:51:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHHsl-0006wQ-5p; Thu, 06 Jul 2023 01:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1qHHse-0006w2-Ps
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 01:50:16 -0400
Received: from mga14.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1qHHsc-0006JI-Jm
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 01:50:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688622614; x=1720158614;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=f+MXAAiTFbbg50fPC//hYMsj7e+h7w9tHOTQs+PooMQ=;
 b=KaFOPpi/Kwwh5xzBHn4RR/9AHPfzDoypKMJtlt4Rlr5VoPr6N1eldyco
 tP6yGrBGa5NOr2o3rJ91H7hgPQB4qAomANzXhrrmIV+y/PsBEaT0kyG7l
 QiCupwIaTuqKwR6yqbv7lI3dI3L9T4/o3boz3Pw/D5l2oaFhpfoEDsGLQ
 yNA/8as6QHg3GQEfugFIm8OFfcbz9IqEvxVxz74lqh1vQKFKyrwZ6DUdy
 1CgXwv4BJph/Fa5B2ryvNWAN1HlsWrQABaVcboYeiUFcSoeJ2JZXUn3gi
 557WquVZac6Os/8vWoCVVZfFGgLk84GZfgeTezTxhRie4EpNIrZAfeRex g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="363540153"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; d="scan'208";a="363540153"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2023 22:50:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="863975931"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; d="scan'208";a="863975931"
Received: from st-server.bj.intel.com ([10.240.193.102])
 by fmsmga001.fm.intel.com with ESMTP; 05 Jul 2023 22:49:55 -0700
From: Tao Su <tao1.su@linux.intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, imammedo@redhat.com, xiaoyao.li@intel.com,
 lei4.wang@intel.com, qian.wen@intel.com, tao1.su@linux.intel.com
Subject: [PATCH v2 1/6] target/i386: Add FEAT_7_1_EDX to adjust feature level
Date: Thu,  6 Jul 2023 13:49:44 +0800
Message-Id: <20230706054949.66556-2-tao1.su@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230706054949.66556-1-tao1.su@linux.intel.com>
References: <20230706054949.66556-1-tao1.su@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.55.52.115;
 envelope-from=tao1.su@linux.intel.com; helo=mga14.intel.com
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

Considering the case of FEAT_7_1_EAX being 0 and FEAT_7_1_EDX being
non-zero. Such as starting a VM on GraniteRapids using '-cpu host',
we can see two leafs CPUID_7_0 and CPUID_7_1 in VM, because both
CPUID_7_1_EAX and CPUID_7_1_EDX have non-zero value, but if minus all
FEAT_7_1_EAX features using
'-cpu host,-avx-vnni,-avx512-bf16,-fzrm,-fsrs,-fsrc,-amx-fp16', we can't
get CPUID_7_1 leaf even though CPUID_7_1_EDX has non-zero value.

So it is necessary to update cpuid_level_func7 by CPUID_7_1_EDX, otherwise
guest may report wrong maximum number sub-leaves in leaf 07H.

Fixes: eaaa197d5b11 ("target/i386: Add support for AVX-VNNI-INT8 in CPUID
enumeration")

Signed-off-by: Tao Su <tao1.su@linux.intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b5688cabb4..952744af97 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6880,6 +6880,7 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         x86_cpu_adjust_feat_level(cpu, FEAT_6_EAX);
         x86_cpu_adjust_feat_level(cpu, FEAT_7_0_ECX);
         x86_cpu_adjust_feat_level(cpu, FEAT_7_1_EAX);
+        x86_cpu_adjust_feat_level(cpu, FEAT_7_1_EDX);
         x86_cpu_adjust_feat_level(cpu, FEAT_8000_0001_EDX);
         x86_cpu_adjust_feat_level(cpu, FEAT_8000_0001_ECX);
         x86_cpu_adjust_feat_level(cpu, FEAT_8000_0007_EDX);
-- 
2.34.1


