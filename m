Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE2E7D4AF8
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 10:52:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvD9J-0006bV-R7; Tue, 24 Oct 2023 04:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qvD9I-0006bC-1A
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:52:28 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qvD9G-0005vv-De
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698137547; x=1729673547;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vG3avHPqLIgBk6CFRfp5zBkudtT1jFdHJhfibDtCqas=;
 b=VYnWZr9Z6sMPWhEZfrBBt3rXWSRIl2oSWc65q672cTBsyfQQo2r3+MP3
 m5DWrQL5mdxPW8rpEiOdkEKX4ZmUhDGOYmBR0AfV8iitmuVUqvQhPJ8j2
 IXulujLyt1R2pnd+ZfKTSHZzSGvunDOUZHneO/BoBmR2W7oMd8yBMWSig
 u7gvBMqsXfPhF0xZIagbPNP+Aj8Pc8JKL+1G5Lu9ZUy9YkBDJ8xKGS/yW
 J+CV4ZkCzbCkx0YhDh4KEkuTtAIay6nx+ypOzGyZ247BKD99qO2BB2/vo
 DBN3ANK5Aw9CAd3RWZIEkN7Sth4cnhgoZVDiORCk9W+5aZbKj2Y60L/V9 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="5638327"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="5638327"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2023 01:52:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="793417981"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; d="scan'208";a="793417981"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orsmga001.jf.intel.com with ESMTP; 24 Oct 2023 01:52:22 -0700
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
 Babu Moger <babu.moger@amd.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 04/20] hw/cpu: Update the comments of nr_cores and nr_dies
Date: Tue, 24 Oct 2023 17:03:07 +0800
Message-Id: <20231024090323.1859210-5-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024090323.1859210-1-zhao1.liu@linux.intel.com>
References: <20231024090323.1859210-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.9;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
Changes since v3:
 * The new patch split out of CPUSTATE.nr_cores' fix. (Xiaoyao)
---
 include/hw/core/cpu.h | 2 +-
 target/i386/cpu.h     | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 18593db5b20e..8197642671a9 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -408,7 +408,7 @@ struct qemu_work_item;
  *   See TranslationBlock::TCG CF_CLUSTER_MASK.
  * @tcg_cflags: Pre-computed cflags for this cpu.
  * @nr_cores: Number of cores within this CPU package.
- * @nr_threads: Number of threads within this CPU.
+ * @nr_threads: Number of threads within this CPU core.
  * @running: #true if CPU is currently running (lockless).
  * @has_waiter: #true if a CPU is currently waiting for the cpu_exec_end;
  * valid under cpu_list_lock.
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 471e71dbc5eb..a8f8fe3bbaf2 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1882,6 +1882,7 @@ typedef struct CPUArchState {
 
     TPRAccess tpr_access_type;
 
+    /* Number of dies within this CPU package. */
     unsigned nr_dies;
 } CPUX86State;
 
-- 
2.34.1


