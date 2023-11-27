Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9469A7FA12C
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 14:37:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7bnW-0004ic-UU; Mon, 27 Nov 2023 08:37:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1r7bnQ-0004iC-Uc; Mon, 27 Nov 2023 08:37:08 -0500
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1r7bnO-0004kA-Sw; Mon, 27 Nov 2023 08:37:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1701092226; x=1732628226;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=CWhBjRkSbqANn+mLHDp+w6S4baYfmYMcV7HRxpAvnec=;
 b=LjGhoYco3mBNkTgJ2U9JwNpP7xe8uXWRWNS9Cy45DxRw4EuLWWGkSqaV
 dfN3x2AJAPgSzrn4DDGRNpA+bytKQCmTens4aRKaoPW7FbX4N+LDMSgCg
 Ad+YkR/DxF3EsQNhNTgYbdNqvzvG9DOXcxfFfMvJP+XEeThPejViIcaPl
 6h2p/JJf+T2Us6zzL4c8A9henncOGCHHKUyAwe8N5I6s5LazAEr9S1fLM
 7ftdzrrwvnof+GOILkOS2RqdnbUIYp/nitqbMr2+l1dE0fMyxWUVrT70n
 3c+LMmDBbzMmm0jKYTmOOW5A6FN+eKN4ki7yY74Ya14Oz3+uOWdmd6Kwb A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="396606756"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; d="scan'208";a="396606756"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2023 05:37:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="771927394"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; d="scan'208";a="771927394"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmsmga007.fm.intel.com with ESMTP; 27 Nov 2023 05:37:02 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2] docs/s390: Fix wrong command example in
 s390-cpu-topology.rst
Date: Mon, 27 Nov 2023 21:49:17 +0800
Message-Id: <20231127134917.568552-1-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=134.134.136.65;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
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

From: Zhao Liu <zhao1.liu@intel.com>

From s390_possible_cpu_arch_ids() in hw/s390x/s390-virtio-ccw.c, the
"core-id" is the index of possible_cpus->cpus[], so it should only be
less than possible_cpus->len, which is equal to ms->smp.max_cpus.

Fix the wrong "core-id" 112, because it isn't less than maxcpus (36) in
-smp, and the valid core ids are 0-35 inclusive.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
---
Changes since v1 RFC:
 * Fixed typo. (Nina)
 * Polished the description of the reason for fixing the wrong core-id.
   (Nina)
---
 docs/devel/s390-cpu-topology.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/devel/s390-cpu-topology.rst b/docs/devel/s390-cpu-topology.rst
index 9eab28d5e5d8..48313b92d417 100644
--- a/docs/devel/s390-cpu-topology.rst
+++ b/docs/devel/s390-cpu-topology.rst
@@ -15,7 +15,7 @@ have default values:
     -smp 1,drawers=3,books=3,sockets=2,cores=2,maxcpus=36 \
     -device z14-s390x-cpu,core-id=19,entitlement=high \
     -device z14-s390x-cpu,core-id=11,entitlement=low \
-    -device z14-s390x-cpu,core-id=112,entitlement=high \
+    -device z14-s390x-cpu,core-id=12,entitlement=high \
    ...
 
 Additions to query-cpus-fast
@@ -78,7 +78,7 @@ modifiers for all configured vCPUs.
       "dedicated": true,
       "thread-id": 537005,
       "props": {
-        "core-id": 112,
+        "core-id": 12,
         "socket-id": 0,
         "drawer-id": 3,
         "book-id": 2
@@ -86,7 +86,7 @@ modifiers for all configured vCPUs.
       "cpu-state": "operating",
       "entitlement": "high",
       "qom-path": "/machine/peripheral-anon/device[2]",
-      "cpu-index": 112,
+      "cpu-index": 12,
       "target": "s390x"
     }
   ]
-- 
2.34.1


