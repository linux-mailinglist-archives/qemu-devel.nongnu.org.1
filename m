Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3254573694D
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 12:31:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBYd9-00060X-Ry; Tue, 20 Jun 2023 06:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qBYd5-000604-EY
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:30:31 -0400
Received: from mga06b.intel.com ([134.134.136.31] helo=mga06.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qBYd3-00026h-Od
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687257029; x=1718793029;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=c5rRj0DF7YDyehIQ/cxq+CBMWxcnESap1Ld9Y4a+hLA=;
 b=GK74+NQf4TDSZ0rcrb1+acUbgmyG6ZZkAtfGrt9+FlRSO7VjO3Xum7a7
 OiY9vVQqkzuvnBFDIe73YyvyPseN7NvFJd3QWfhxJ38G4usbR+t1kTr+f
 SoCLvWtkvwrBi6Q5lWPc1mUbKaJAdG84RR7+lKz2il/lvZJ9ZxJHXwcjy
 X/W5wwQX+/FMhPiW+zUVAQIs0ItkYJkeZ/qIA9DXku0M6UKo23trwuY4N
 u0I5w2yQux8BoTVMtCr7xZeZbNeBxd1vjgqpXQFI7ErjJH1Rldm20VRav
 RzIjX34Od61081yE4Sy3wXJMIKjVm8wrpCrQnLlBlIiR/85HGuZWmJEWR Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="423488480"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; d="scan'208";a="423488480"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2023 03:30:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="714002261"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; d="scan'208";a="714002261"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.28])
 by orsmga002.jf.intel.com with ESMTP; 20 Jun 2023 03:30:26 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 3/4] hw/smbios: Fix thread count in type4
Date: Tue, 20 Jun 2023 18:39:57 +0800
Message-Id: <20230620103958.3907565-4-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620103958.3907565-1-zhao1.liu@linux.intel.com>
References: <20230620103958.3907565-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=134.134.136.31;
 envelope-from=zhao1.liu@linux.intel.com; helo=mga06.intel.com
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

From SMBIOS 3.0 specification, thread count field means:

Thread Count is the total number of threads detected by the BIOS for
this processor socket. It is a processor-wide count, not a
thread-per-core count. [1]

So here we should use threads per socket other than threads per core.

[1] SMBIOS 3.0.0, section 7.5.8, Processor Information - Thread Count

Fixes: c97294ec1b9e ("SMBIOS: Build aggregate smbios tables and entry point")
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
v3:
 * Use the wrapped hepler to get threads per socket.

v2:
 * Rename cpus_per_socket to threads_per_socket.
 * Add the comment about smp.max_cpus. Thread count and core count will
   be calculated in 2 ways and will add a sanity check to ensure we
   don't miss any topology level.
---
 hw/smbios/smbios.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index d67415d44dd8..3aae9328c014 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -713,6 +713,7 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
 {
     char sock_str[128];
     size_t tbl_len = SMBIOS_TYPE_4_LEN_V28;
+    unsigned threads_per_socket;
 
     if (smbios_ep_type == SMBIOS_ENTRY_POINT_TYPE_64) {
         tbl_len = SMBIOS_TYPE_4_LEN_V30;
@@ -747,17 +748,19 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
     SMBIOS_TABLE_SET_STR(4, asset_tag_number_str, type4.asset);
     SMBIOS_TABLE_SET_STR(4, part_number_str, type4.part);
 
+    threads_per_socket = machine_topo_get_threads_per_socket(ms);
+
     t->core_count = (ms->smp.cores > 255) ? 0xFF : ms->smp.cores;
     t->core_enabled = t->core_count;
 
-    t->thread_count = (ms->smp.threads > 255) ? 0xFF : ms->smp.threads;
+    t->thread_count = (threads_per_socket > 255) ? 0xFF : threads_per_socket;
 
     t->processor_characteristics = cpu_to_le16(0x02); /* Unknown */
     t->processor_family2 = cpu_to_le16(0x01); /* Other */
 
     if (tbl_len == SMBIOS_TYPE_4_LEN_V30) {
         t->core_count2 = t->core_enabled2 = cpu_to_le16(ms->smp.cores);
-        t->thread_count2 = cpu_to_le16(ms->smp.threads);
+        t->thread_count2 = cpu_to_le16(threads_per_socket);
     }
 
     SMBIOS_BUILD_TABLE_POST;
-- 
2.34.1


