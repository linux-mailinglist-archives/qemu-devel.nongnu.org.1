Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D44B97412D7
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 15:46:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEVU0-0005EG-OY; Wed, 28 Jun 2023 09:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qEVTl-0005Cf-H8
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 09:45:07 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qEVTi-00089l-91
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 09:45:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687959902; x=1719495902;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=o69eaL3+onIsEWii+kpARMjg37wbuabYwIfkzHgP+uw=;
 b=Wyhw/21a+7B+bsIzDNHiJnLU+g8NPQB/bRchFexFH1n3b/g0ZNvY1HXV
 2I3NEOFVBsmbyJkC29yH/1UeyVi5Pv1si+yqitFfAHjnyMgBOPE9YWjyG
 9T/9EYgUsAAlgywIGG2269ijFC2/wLfY9F57V2mcaZ2LG2YR7A/8lUK9Z
 Y5nyGnMlYQstCAO5bUXkZsiwkIa1RUIU+cQeMUg0AGzwcf29IMugFp5vM
 tNmCFKB+BkxNS6NcFy0rRy6RFIS+yLYMpzteopL9HDR8TBcOxdXsEs2hq
 l0TNbLg1RFiTZ44yvAWx1Tk0Ee6BqDlaI3OFk1by3olSxZwtoOKSi7ea6 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="427854153"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; d="scan'208";a="427854153"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2023 06:44:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="806905501"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; d="scan'208";a="806905501"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.28])
 by FMSMGA003.fm.intel.com with ESMTP; 28 Jun 2023 06:44:57 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v4 4/4] hw/smbios: Fix core count in type4
Date: Wed, 28 Jun 2023 21:54:37 +0800
Message-Id: <20230628135437.1145805-5-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230628135437.1145805-1-zhao1.liu@linux.intel.com>
References: <20230628135437.1145805-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=134.134.136.100;
 envelope-from=zhao1.liu@linux.intel.com; helo=mga07.intel.com
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
v4:
 * None.

v3:
 * Use the wrapped helper to get cores per socket.

v2:
 * Calculate cores_per_socket in a different way from
   threads_per_socket.
 * Add the sanity check to ensure consistency of results between these 2
   ways. This can help not miss any future change of cpu topology.
---
 hw/smbios/smbios.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 3aae9328c014..10cd22f610ef 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -714,6 +714,7 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
     char sock_str[128];
     size_t tbl_len = SMBIOS_TYPE_4_LEN_V28;
     unsigned threads_per_socket;
+    unsigned cores_per_socket;
 
     if (smbios_ep_type == SMBIOS_ENTRY_POINT_TYPE_64) {
         tbl_len = SMBIOS_TYPE_4_LEN_V30;
@@ -749,8 +750,9 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
     SMBIOS_TABLE_SET_STR(4, part_number_str, type4.part);
 
     threads_per_socket = machine_topo_get_threads_per_socket(ms);
+    cores_per_socket = machine_topo_get_cores_per_socket(ms);
 
-    t->core_count = (ms->smp.cores > 255) ? 0xFF : ms->smp.cores;
+    t->core_count = (cores_per_socket > 255) ? 0xFF : cores_per_socket;
     t->core_enabled = t->core_count;
 
     t->thread_count = (threads_per_socket > 255) ? 0xFF : threads_per_socket;
@@ -759,7 +761,7 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
     t->processor_family2 = cpu_to_le16(0x01); /* Other */
 
     if (tbl_len == SMBIOS_TYPE_4_LEN_V30) {
-        t->core_count2 = t->core_enabled2 = cpu_to_le16(ms->smp.cores);
+        t->core_count2 = t->core_enabled2 = cpu_to_le16(cores_per_socket);
         t->thread_count2 = cpu_to_le16(threads_per_socket);
     }
 
-- 
2.34.1


