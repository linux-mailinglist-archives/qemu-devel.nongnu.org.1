Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE4373BF83
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 22:28:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCnMq-0005Vw-I5; Fri, 23 Jun 2023 16:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pawan.kumar.gupta@linux.intel.com>)
 id 1qCnMj-0005Vj-MF
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 16:26:45 -0400
Received: from mga09.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pawan.kumar.gupta@linux.intel.com>)
 id 1qCnMd-0004H1-Mz
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 16:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687551999; x=1719087999;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=A2vOZ5LrKFon+ktVAulSszTiqag9LzYoL32QNEaHZ0g=;
 b=UpxdlJ6AQ0cbt0KtaDey8KHcdauk3/nKvEmB9ZfJUYeObzY9LzMdp/IH
 LxbBf09qV4c9QxEuyD2KbFrJ9QFEMDrrkBmxNc6eHL7G0phwaEf+PUK8E
 y7XeFc4mIN03aGyg3F/lPE3x6qK4sQfcdXehaVNGPn34ttVpnn7Ic8iND
 Ry6dfCE1tlE/rldS557UZoegduP35iBreRR5O9/7ar55VYBC9VWLfPH/B
 pS79nKLr9cBKNeHHrXJZo3QpsVKuPlsT0YIs49T5ueMfeT/UUtJIS8Q47
 mJF0dhhJdnvvabw5aVfpkm4MPY20vwBXrE+kRk88IIrlxWZWKJKqTMRAZ g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="363405742"
X-IronPort-AV: E=Sophos;i="6.01,153,1684825200"; d="scan'208";a="363405742"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2023 13:26:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="745117011"
X-IronPort-AV: E=Sophos;i="6.01,153,1684825200"; d="scan'208";a="745117011"
Received: from mdissana-mobl.amr.corp.intel.com (HELO desk) ([10.209.104.138])
 by orsmga008-auth.jf.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 13:26:33 -0700
Date: Fri, 23 Jun 2023 13:26:25 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Chao Gao <chao.gao@intel.com>
Subject: [PATCH] target/i386: Export MSR_ARCH_CAPABILITIES bits to guests
Message-ID: <63d85cc76d4cdc51e6c732478b81d8f13be11e5a.1687551881.git.pawan.kumar.gupta@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: none client-ip=134.134.136.24;
 envelope-from=pawan.kumar.gupta@linux.intel.com; helo=mga09.intel.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) AC_FROM_MANY_DOTS=2.999, BAYES_00=-1.9,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Intel CPUs there are certain bits in MSR_ARCH_CAPABILITIES that
indicates if the CPU is not affected by a vulnerability. Without these
bits guests may try to deploy the mitigation even if the CPU is not
affected.

Export the bits to guests that indicate immunity to hardware
vulnerabilities.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 target/i386/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1242bd541a53..66d6062aea7c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1049,10 +1049,10 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "rdctl-no", "ibrs-all", "rsba", "skip-l1dfl-vmentry",
             "ssb-no", "mds-no", "pschange-mc-no", "tsx-ctrl",
             "taa-no", NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
+            NULL, "sbdr-ssdp-no", "fbsdp-no", "psdp-no",
             NULL, "fb-clear", NULL, NULL,
             NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
+            "pbrsb-no", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
         .msr = {
-- 
2.34.1


