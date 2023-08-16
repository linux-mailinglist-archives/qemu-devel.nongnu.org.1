Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C98D77DBA3
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 10:05:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWBW8-0007Px-U9; Wed, 16 Aug 2023 04:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qian.wen@intel.com>)
 id 1qWBW1-0007PG-3e
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 04:04:29 -0400
Received: from mgamail.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qian.wen@intel.com>)
 id 1qWBVy-0008MB-3x
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 04:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692173066; x=1723709066;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rhcDtefcBFDAasr4AHeDTyJqx9lVvElMNCxflBoj/rk=;
 b=LENn1LMn837aPwfaNjr4wgWp02HWHpAMOdvhrqhDWKN/WcdK0JATXnPO
 zBDeVBggoSmWaVbHO4PR27mYzQ+iez3YjRKpeoaPOElE3bvsKVlu5kyEF
 QcGZEr0Ij8hX7MXUdzApQ3wTt2Y4g0Tdk93jmq61/4bXfXcKxLrgttqoc
 iPy84CArWKonTacFkyS40BqS18Tvsd8HoKMTojIjzOAoIO3jLIMwOWKCB
 epYx9G3PAMDjRJuD7vJCSE3WGQojn01TXnV3K3Qi2kzo6sseDXYhRlN4H
 ABpGy9AlDZI6hvAZiRnWET9yg8CSmQPzSI2TbpRRlCYK6Vb/weMNI4wbm w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="403450861"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; d="scan'208";a="403450861"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2023 01:04:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="711035464"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; d="scan'208";a="711035464"
Received: from pc.sh.intel.com ([10.238.200.75])
 by orsmga006.jf.intel.com with ESMTP; 16 Aug 2023 01:04:22 -0700
From: Qian Wen <qian.wen@intel.com>
To: qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com, zhao1.liu@intel.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, babu.moger@amd.com,
 Qian Wen <qian.wen@intel.com>
Subject: [PATCH v3 2/2] target/i386: Avoid overflow of the cache parameter
 enumerated by leaf 4
Date: Wed, 16 Aug 2023 16:06:58 +0800
Message-Id: <20230816080658.3562730-3-qian.wen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816080658.3562730-1-qian.wen@intel.com>
References: <20230816080658.3562730-1-qian.wen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.88; envelope-from=qian.wen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.04,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

According to SDM, CPUID.0x4:EAX[31:26] indicates the Maximum number of
addressable IDs for processor cores in the physical package. If we
launch over 64 cores VM, the 6-bit field will overflow, and the wrong
core_id number will be reported.

Since the HW reports 0x3f when the intel processor has over 64 cores,
limit the max value written to EBX[31:26] to 63, so max num_cores should
be 64.

Signed-off-by: Qian Wen <qian.wen@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5c008b9d7e..3b6854300a 100644
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


