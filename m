Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A37E7F9CA4
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 10:31:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7Xvi-0008Fg-6M; Mon, 27 Nov 2023 04:29:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1r7Xts-0007di-5Q; Mon, 27 Nov 2023 04:27:34 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1r7Xtp-0006zw-MJ; Mon, 27 Nov 2023 04:27:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1701077250; x=1732613250;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=k4qQ90xnlqxXg5xAF7O7KR0ZyHVrgDSO64RcTtfjB+k=;
 b=AioY9UxH3wPHBcK/Eg0nNvp78879ZDRD0NRCWN87/VW0CK2qj/TYcAeU
 Zhh1x5IaAmgis19n7aK+bCwDEeVP//gDa/9rOVARFgPz1RgvupMFtg39p
 43A2Ike4HTS/xz0pc9S6c6o8sAI90QtBfzazQHbFAtjf+NG7vr/lo2852
 T44Q4FTXFsfHta6BlVUwdAFYmfnyqNChsQOcgncfLazLcFFKaGfGfXcfQ
 Tf9/W9HYLfGtoIZettwJVAXyYYw/Jsa0dWS9nb9LVaUWkH0Qx25p09zxs
 SbnfimwCSnPBLbcDNqmf5GNmqmf9OxuT74sN2OqZmyhGSMV3fy2LkD2qy A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="14227784"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; d="scan'208";a="14227784"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2023 01:27:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="802586265"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; d="scan'208";a="802586265"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orsmga001.jf.intel.com with ESMTP; 27 Nov 2023 01:27:21 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC] docs/s390: Fix wrong command example in s390-cpu-topology.rst
Date: Mon, 27 Nov 2023 17:39:15 +0800
Message-Id: <20231127093915.565710-1-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.7;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From s390_possible_cpu_arch_ids() in hw/s390x/s390-virtio-ccw.c, the
"core-id" is the index of pssible_cpus->cpus[], so it should only be
less than possible_cpus->len, which is equal to ms->smp.max_cpus.

Fix the wrong "core-id" 112 because it is greater than maxcpus (36) in
-smp.

Cc: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
RFC: Not tested on S390 machine, just code reading.
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


