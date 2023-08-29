Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1047678BD78
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 06:14:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaq6f-0007Yf-FX; Tue, 29 Aug 2023 00:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qian.wen@intel.com>)
 id 1qaq6c-0007Xm-Rq
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 00:13:30 -0400
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qian.wen@intel.com>)
 id 1qaq6a-0005xf-83
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 00:13:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1693282408; x=1724818408;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=trRHMCaxL8HH/RDBMQuNGezTx8m3gpA8aj+8rjtgPAs=;
 b=jUSUx9/m9R//WKJPcu7e5ijekD0KxUVoy4/mk61sJnPvuzbgEXL8k9Lk
 PGggi3x/Jgj5rOWvOFHY5wcCvoa0f5mGJmesiT3RNURFq/xgb0MAD6FhZ
 EnpbIF5suA/BlzKpcE09sqDd84upIzUinoqy6faRgyqq2XjbqmrUZpXPY
 /ClQbceBdFXKdFPJQBGv0AJSWfjZVnh3RWJpU4IM+c5/P4C/lfv4JLU+1
 J3kmifK5QIY4QUfEaGEkZ+PeuFoiC5LT9UV5tFGlUUNJZealnBazf8XwW
 7Aw1FPoelruX4pW7Lj6t5weRFn5ZIcrS7Ej0UIKs2it8+77/ESSrHOnfg w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="439220486"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; d="scan'208";a="439220486"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2023 21:13:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="862087986"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; d="scan'208";a="862087986"
Received: from pc.sh.intel.com ([10.238.200.75])
 by orsmga004.jf.intel.com with ESMTP; 28 Aug 2023 21:13:23 -0700
From: Qian Wen <qian.wen@intel.com>
To: qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com, zhao1.liu@intel.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, babu.moger@amd.com,
 Qian Wen <qian.wen@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [PATCH v4 2/2] target/i386: Avoid overflow of the cache parameter
 enumerated by leaf 4
Date: Tue, 29 Aug 2023 12:24:05 +0800
Message-Id: <20230829042405.932523-3-qian.wen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230829042405.932523-1-qian.wen@intel.com>
References: <20230829042405.932523-1-qian.wen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.31; envelope-from=qian.wen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

According to SDM, CPUID.0x4:EAX[31:26] indicates the Maximum number of
addressable IDs for processor cores in the physical package. If we
launch over 64 cores VM, the 6-bit field will overflow, and the wrong
core_id number will be reported.

Since the HW reports 0x3f when the intel processor has over 64 cores,
limit the max value written to EBX[31:26] to 63, so max num_cores should
be 64.

Signed-off-by: Qian Wen <qian.wen@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index fc0437bdb1..90fe0a6a46 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -248,7 +248,7 @@ static void encode_cache_cpuid4(CPUCacheInfo *cache,
     *eax = CACHE_TYPE(cache->type) |
            CACHE_LEVEL(cache->level) |
            (cache->self_init ? CACHE_SELF_INIT_LEVEL : 0) |
-           ((num_cores - 1) << 26) |
+           ((MIN(num_cores, 64) - 1) << 26) |
            ((num_apic_ids - 1) << 14);
 
     assert(cache->line_size > 0);
-- 
2.25.1


