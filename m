Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B01D714969
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 14:23:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3bt8-0004dT-AP; Mon, 29 May 2023 08:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1q3bsy-0004cQ-1n
 for qemu-devel@nongnu.org; Mon, 29 May 2023 08:22:04 -0400
Received: from mga02.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1q3bsw-0006TO-A5
 for qemu-devel@nongnu.org; Mon, 29 May 2023 08:22:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685362922; x=1716898922;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qhe/hXKUFpjcc/Z3UZSXmoPDKBpSnjhwWTrwLdNigX4=;
 b=XEW9Np4XNsMmyTYIMIW/O9SYNoMJ4lpeq1bGzyHeqH+7l3QmNeh7GWKN
 KqrDfRBJHOCE5PRWg2VGcEtVfUqWHRDPI8U7tduqWnvJlkdZGp27LHt17
 /i2fGPX9aFNYRnOSlCjcDVXfcxA4A++jnILzdNYJ2xleo59WtzG3mstyT
 aUQYiwKWDUdAfiEgTha3tce1flw7YLv7bDxa0N3HR+obnQaK5egfbw8T9
 ZeYPuTxJKVXw4yJmrZjiQaDe9rFgb+BlGYVX6/mtGhSZtkqWxApb3v6xR
 3yxmYfOpcqayeoMNy9hRMAWbtTD+7neCIhchCoBjRt9ytV0jrWrAopcpV w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="344190145"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; d="scan'208";a="344190145"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2023 05:21:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="850388589"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; d="scan'208";a="850388589"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.28])
 by fmsmga001.fm.intel.com with ESMTP; 29 May 2023 05:21:43 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Babu Moger <babu.moger@amd.com>,
 Zhao Liu <zhao1.liu@intel.com>, Robert Hoo <robert.hu@linux.intel.com>
Subject: [PATCH v2 04/17] i386/cpu: Fix i/d-cache topology to core level for
 Intel CPU
Date: Mon, 29 May 2023 20:30:48 +0800
Message-Id: <20230529123101.411267-5-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230529123101.411267-1-zhao1.liu@linux.intel.com>
References: <20230529123101.411267-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=134.134.136.20;
 envelope-from=zhao1.liu@linux.intel.com; helo=mga02.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

For i-cache and d-cache, the maximum IDs for CPUs sharing cache (
CPUID.04H.00H:EAX[bits 25:14] and CPUID.04H.01H:EAX[bits 25:14]) are
both 0, and this means i-cache and d-cache are shared in the SMT level.
This is correct if there's single thread per core, but is wrong for the
hyper threading case (one core contains multiple threads) since the
i-cache and d-cache are shared in the core level other than SMT level.

For AMD CPU, commit 8f4202fb1080 ("i386: Populate AMD Processor Cache
Information for cpuid 0x8000001D") has already introduced i/d cache
topology as core level by default.

Therefore, in order to be compatible with both multi-threaded and
single-threaded situations, we should set i-cache and d-cache be shared
at the core level by default.

This fix changes the default i/d cache topology from per-thread to
per-core. Potentially, this change in L1 cache topology may affect the
performance of the VM if the user does not specifically specify the
topology or bind the vCPU. However, the way to achieve optimal
performance should be to create a reasonable topology and set the
appropriate vCPU affinity without relying on QEMU's default topology
structure.

Fixes: 7e3482f82480 ("i386: Helpers to encode cache information consistently")
Suggested-by: Robert Hoo <robert.hu@linux.intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 * Split this fix from the patch named "i386/cpu: Fix number of
   addressable IDs in CPUID.04H".
 * Add the explanation of the impact on performance. (Xiaoyao)
---
 target/i386/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 384821ba4bd0..101161954173 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5841,12 +5841,12 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             switch (count) {
             case 0: /* L1 dcache info */
                 encode_cache_cpuid4(env->cache_info_cpuid4.l1d_cache,
-                                    1, cs->nr_cores,
+                                    cs->nr_threads, cs->nr_cores,
                                     eax, ebx, ecx, edx);
                 break;
             case 1: /* L1 icache info */
                 encode_cache_cpuid4(env->cache_info_cpuid4.l1i_cache,
-                                    1, cs->nr_cores,
+                                    cs->nr_threads, cs->nr_cores,
                                     eax, ebx, ecx, edx);
                 break;
             case 2: /* L2 cache info */
-- 
2.34.1


