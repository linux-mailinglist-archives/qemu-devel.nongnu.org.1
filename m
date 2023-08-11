Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66591779601
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 19:19:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUVma-00055J-1C; Fri, 11 Aug 2023 13:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pawan.kumar.gupta@linux.intel.com>)
 id 1qUVmW-00054P-Uw
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 13:18:36 -0400
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pawan.kumar.gupta@linux.intel.com>)
 id 1qUVmU-00073P-IH
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 13:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691774314; x=1723310314;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Y5ATu1ZdM0Drf0OcKUvGdeaoQ0sQywLY8iy5xiM7WGc=;
 b=U/Vg4Z1Ci0HzcASDOp5x5QGj87Ruo9yKt+HGh0t606TBUrOZqQxuxuar
 QXQoY1FIpF/bDMMiTHMXZPh5xHUf1E7JQBImhqtGStasEsFvts0n68FAY
 ukmTrtU/FckaAg/o6b0rQwLckc0A6uIb0vWq975bVfp+pezeZvxbXwN4T
 TxF9EH7BwzgAOzsX0UFzDCj+zWDr05I5jSiYLyTGYgABc8Tz3ZAOuFP6J
 EGfX3bg0SJQ8ozP1aHNXjLqSuJbKh6AaTC/ufYbiyPDA1qAslioJ+beBD
 ga8GSdGRaKOE6SXWf7tn+nhAJNNEukk8o0QL8nISpz19vxlr7fXdt5Lii g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="435614376"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; d="scan'208";a="435614376"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2023 10:18:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="802736796"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; d="scan'208";a="802736796"
Received: from keylianx-mobl.amr.corp.intel.com (HELO desk) ([10.212.254.196])
 by fmsmga004-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 10:18:29 -0700
Date: Fri, 11 Aug 2023 10:18:28 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, tao1.su@linux.intel.com,
 xiaoyao.li@intel.com, Yu Zhang <yu.zhang@ionos.com>,
 Daniel Sneddon <daniel.sneddon@linux.intel.com>,
 antonio.gomez.iglesias@intel.com, Chao Gao <chao.gao@intel.com>
Subject: [PATCH] target/i386: Export GDS_NO bit to guests
Message-ID: <c373f3f92b542b738f296d44bb6a916a1cded7bd.1691774049.git.pawan.kumar.gupta@linux.intel.com>
References: <CAMGffEmG6TNq0n3+4OJAgXc8J0OevY60KHZekXCBs3LoK9vehA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffEmG6TNq0n3+4OJAgXc8J0OevY60KHZekXCBs3LoK9vehA@mail.gmail.com>
Received-SPF: none client-ip=134.134.136.31;
 envelope-from=pawan.kumar.gupta@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
This is just compile tested.


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



