Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E5A77C6CA
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 06:56:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVm4o-0000K3-IR; Tue, 15 Aug 2023 00:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pawan.kumar.gupta@linux.intel.com>)
 id 1qVm4l-0000Js-Jq
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 00:54:39 -0400
Received: from mgamail.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pawan.kumar.gupta@linux.intel.com>)
 id 1qVm4j-0008IQ-74
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 00:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692075277; x=1723611277;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=Pm0uI9c3cEbSvpHd54NlgkGYk9xvkiwwqP/rWnFt0Lc=;
 b=KMW7CcS/O8IGQCTrmbLhMH9JzJLYHiwIfPJNPewzIJGaIbseKDvY+nWh
 RwnYGaMs5ZLXEDuHawAWFibJRB7SXED8s8sZq7p1eamQJFt919YC5jSuy
 jbmLfkWWBzMq+A3EnNLlQsaYqZ0/Xi1DZbElJ4MVqzyfrEnSWqA7qoaxw
 PA0r6GxJ2tBbN6xWPQETImkpAZWZtM2a2e5NVKkkqrapgSnATc2JMdlsW
 qiW3MZsGPE7SzwYjX3sFLYVEOnJLecFUoGCkmTNFOFsprefbuRNVLmxPL
 gPwTCRiXIeiIllTypw9eBTEZkD5K2CsXJdwjm2uEWxU8W+5yGAlDxGk+6 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="369674955"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; d="scan'208";a="369674955"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2023 21:54:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="768704133"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; d="scan'208";a="768704133"
Received: from ajanarda-mobl1.amr.corp.intel.com (HELO desk) ([10.251.0.163])
 by orsmga001-auth.jf.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 21:54:29 -0700
Date: Mon, 14 Aug 2023 21:54:27 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, tao1.su@linux.intel.com,
 xiaoyao.li@intel.com, Yu Zhang <yu.zhang@ionos.com>,
 Jinpu Wang <jinpu.wang@ionos.com>
Subject: [PATCH v2] target/i386: Export GDS_NO bit to guests
Message-ID: <fde42d81ce454477ca8e27d5429a190b7366fe86.1692074650.git.pawan.kumar.gupta@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: none client-ip=192.55.52.93;
 envelope-from=pawan.kumar.gupta@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) AC_FROM_MANY_DOTS=2.999, BAYES_00=-1.9,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Gather Data Sampling (GDS) is a side-channel attack using Gather
instructions. Some Intel processors will set ARCH_CAP_GDS_NO bit in
MSR IA32_ARCH_CAPABILITIES to report that they are not vulnerable to
GDS.

Make this bit available to guests.

Closes: https://lore.kernel.org/qemu-devel/CAMGffEmG6TNq0n3+4OJAgXc8J0OevY60KHZekXCBs3LoK9vehA@mail.gmail.com/
Reported-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Tested-by: Jack Wang <jinpu.wang@ionos.com>
Tested-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
---
v2: Added commit tags

v1: https://lore.kernel.org/qemu-devel/c373f3f92b542b738f296d44bb6a916a1cded7bd.1691774049.git.pawan.kumar.gupta@linux.intel.com/

 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 97ad229d8ba3..48709b77689f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1155,7 +1155,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, "sbdr-ssdp-no", "fbsdp-no", "psdp-no",
             NULL, "fb-clear", NULL, NULL,
             NULL, NULL, NULL, NULL,
-            "pbrsb-no", NULL, NULL, NULL,
+            "pbrsb-no", NULL, "gds-no", NULL,
             NULL, NULL, NULL, NULL,
         },
         .msr = {
-- 
2.34.1


