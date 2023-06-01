Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8854F7196C5
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 11:22:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4eU6-0007tk-9q; Thu, 01 Jun 2023 05:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1q4eU4-0007tI-Hm
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:20:40 -0400
Received: from mga04.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1q4eU2-0004eq-R7
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:20:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685611238; x=1717147238;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pwFQKZy1ANvQqxrZKuban+jk49J7lZcU4BzHYMzhEYU=;
 b=K6nUW0JYFuAEUNDCyTw01qqTYDGX9g0Y5AvKAHLh+lXGMkUftdvoR9Xl
 pH+xsMqDOQ/VV8z3zGZqXYHFBgRgUh50twFXfpu8n4QnuPRlG7pyOlEkK
 Rb9g7ud4bz/XOdcCtALvqzpT44+6FxISZtKst3VCbxHbsu+eU5iLmdej8
 nL+ZTazkRvrF4n2NUtrYTmFdIJrG8maYVkaCkWCttqoEgWuntkh/xBCc+
 eSTmToLfOYJ73SomJIiNU4LOzUZm1R/ivRp2B91BgeaqGXdXQREGXr28f
 D4izvabeF1CWYkSsu23rwAaFfZ2tHSpZ/9p4t7T/bd246LhwIoSvVbeAc Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="354359878"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; d="scan'208";a="354359878"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2023 02:20:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="953995756"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; d="scan'208";a="953995756"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.28])
 by fmsmga006.fm.intel.com with ESMTP; 01 Jun 2023 02:20:29 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 3/3] hw/smbios: Fix core count in type4
Date: Thu,  1 Jun 2023 17:29:52 +0800
Message-Id: <20230601092952.1114727-4-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230601092952.1114727-1-zhao1.liu@linux.intel.com>
References: <20230601092952.1114727-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.55.52.120;
 envelope-from=zhao1.liu@linux.intel.com; helo=mga04.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
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

From SMBIOS 3.0 specification, core count field means:

Core Count is the number of cores detected by the BIOS for this
processor socket. [1]

Before 003f230e37d7 ("machine: Tweak the order of topology members in
struct CpuTopology"), MachineState.smp.cores means "the number of cores
in one package", and it's correct to use smp.cores for core count.

But 003f230e37d7 changes the smp.cores' meaning to "the number of cores
in one die" and doesn't change the original smp.cores' use in smbios as
well, which makes core count in type4 go wrong.

Fix this issue with the correct "cores per socket" caculation.

[1] SMBIOS 3.0.0, section 7.5.6, Processor Information - Core Count

Fixes: 003f230e37d7 ("machine: Tweak the order of topology members in struct CpuTopology")
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since v1:
 * Calculate cores_per_socket in a different way from
   threads_per_socket.
 * Add the sanity check to ensure consistency of results between these 2
   ways. This can help not miss any future change of cpu topology.
---
 hw/smbios/smbios.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index faf82d4ae646..2b46a51dfcad 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -714,6 +714,7 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
     char sock_str[128];
     size_t tbl_len = SMBIOS_TYPE_4_LEN_V28;
     unsigned threads_per_socket;
+    unsigned cores_per_socket;
 
     if (smbios_ep_type == SMBIOS_ENTRY_POINT_TYPE_64) {
         tbl_len = SMBIOS_TYPE_4_LEN_V30;
@@ -750,8 +751,16 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
 
     /* smp.max_cpus is the total number of threads for the system. */
     threads_per_socket = ms->smp.max_cpus / ms->smp.sockets;
+    cores_per_socket = ms->smp.cores * ms->smp.clusters * ms->smp.dies;
 
-    t->core_count = (ms->smp.cores > 255) ? 0xFF : ms->smp.cores;
+    /*
+     * Currently, max_cpus = threads * cores * clusters * dies * sockets.
+     * threads_per_socket and cores_per_socket are calculated in 2 ways so
+     * that this sanity check ensures we won't miss any topology level.
+     */
+    g_assert(cores_per_socket == (threads_per_socket / ms->smp.threads));
+
+    t->core_count = (cores_per_socket > 255) ? 0xFF : cores_per_socket;
     t->core_enabled = t->core_count;
 
     t->thread_count = (threads_per_socket > 255) ? 0xFF : threads_per_socket;
@@ -760,7 +769,7 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
     t->processor_family2 = cpu_to_le16(0x01); /* Other */
 
     if (tbl_len == SMBIOS_TYPE_4_LEN_V30) {
-        t->core_count2 = t->core_enabled2 = cpu_to_le16(ms->smp.cores);
+        t->core_count2 = t->core_enabled2 = cpu_to_le16(cores_per_socket);
         t->thread_count2 = cpu_to_le16(threads_per_socket);
     }
 
-- 
2.34.1


