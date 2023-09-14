Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0CF79FD13
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 09:17:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qggW7-0002tD-8v; Thu, 14 Sep 2023 03:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qggW5-0002t4-P4
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 03:11:57 -0400
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qggW4-0006BI-9u
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 03:11:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1694675516; x=1726211516;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=o0xqXS2pqWHAmiFScEJ8wU0LIvknrc6zkMnLQpxHdcY=;
 b=bupB96OicQd8zW5aU3+qAqP0eRJY1qnTjzOxUKp/7YFiSGWXK2spyOCz
 gHevZwjwM/08oemotfhP5r1GMfr3GS5VhWS4+sZB5FH+kTkLvvYrx199l
 Rumi4kPv/EQGm7LGz0R/r+j02JMgM01R0MI2A2E0Q4AgqxrqFUJScBJtO
 K5MH6BqjsPnb66z3veiPrLMB24CZPi6QwSp04/8qMEKZCnnMX+xgDf7DO
 v/OCX8A3jSnF76JgxXCi3fHsJhtuwNWtx1JC8CY6iTlqnLjLnSgkH1JTQ
 0a6cyl/KWWYV6Bo/nTrm0rwuKcxcG2ZuV+cKcQeChXhBlSY315OWpIpRX A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="359135933"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; d="scan'208";a="359135933"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2023 00:11:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="779526212"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; d="scan'208";a="779526212"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orsmga001.jf.intel.com with ESMTP; 14 Sep 2023 00:11:29 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Babu Moger <babu.moger@amd.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v4 04/21] hw/cpu: Update the comments of nr_cores and nr_dies
Date: Thu, 14 Sep 2023 15:21:42 +0800
Message-Id: <20230914072159.1177582-5-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914072159.1177582-1-zhao1.liu@linux.intel.com>
References: <20230914072159.1177582-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.55.52.151;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
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

From: Zhao Liu <zhao1.liu@intel.com>

In the nr_threads' comment, specify it represents the
number of threads in the "core" to avoid confusion.

Also add comment for nr_dies in CPUX86State.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since v3:
 * The new patch split out of CPUSTATE.nr_cores' fix. (Xiaoyao)
---
 include/hw/core/cpu.h | 2 +-
 target/i386/cpu.h     | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 92a4234439a3..df908b23c692 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -277,7 +277,7 @@ struct qemu_work_item;
  *   See TranslationBlock::TCG CF_CLUSTER_MASK.
  * @tcg_cflags: Pre-computed cflags for this cpu.
  * @nr_cores: Number of cores within this CPU package.
- * @nr_threads: Number of threads within this CPU.
+ * @nr_threads: Number of threads within this CPU core.
  * @running: #true if CPU is currently running (lockless).
  * @has_waiter: #true if a CPU is currently waiting for the cpu_exec_end;
  * valid under cpu_list_lock.
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index fbb05eace57e..70eb3bc23eb8 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1881,6 +1881,7 @@ typedef struct CPUArchState {
 
     TPRAccess tpr_access_type;
 
+    /* Number of dies within this CPU package. */
     unsigned nr_dies;
 } CPUX86State;
 
-- 
2.34.1


