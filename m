Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6827412DA
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 15:46:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEVTu-0005Cp-SJ; Wed, 28 Jun 2023 09:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qEVTf-0005Bv-Hd
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 09:44:59 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qEVTd-00088Q-OR
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 09:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687959897; x=1719495897;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4DPJq8oj0vzSj8F4qI9x0FHKf1kKXEnnAnZ0dqAQZEw=;
 b=DRINkirMCYle6YsYVFI4QaB4Ovpvisr1kjbOF/CbGnaBIBh/G4hgUhlI
 6VhOnsZ20RUQHh4RG1rb/vl4mCUm/pIB6NyrMIr+XoLRm3zcNFBlWPKeA
 70gZtJgFdM6X9V78ooQyaJcCXd2cZGP3jut0JPUWHGyHErtq+Q5yKvwe6
 NzQR20Rn2iXm+QFPyllqXb3s7M2UrfRH2OBtcZ6BvlnF/g06ig6nSfg9h
 1BFACva6Bs9tdK6aFj7+T/uV149lJxkUWBN9HC7tmAL5Vx7v4R2JtQTMB
 8FqOhmdR+I/VElSE7hdxZMD5bajfdDlnZpL53eSnpuagCRiu3m+Vdhy0h w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="427854142"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; d="scan'208";a="427854142"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2023 06:44:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="806905488"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; d="scan'208";a="806905488"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.28])
 by FMSMGA003.fm.intel.com with ESMTP; 28 Jun 2023 06:44:54 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v4 3/4] hw/smbios: Fix thread count in type4
Date: Wed, 28 Jun 2023 21:54:36 +0800
Message-Id: <20230628135437.1145805-4-zhao1.liu@linux.intel.com>
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

From SMBIOS 3.0 specification, thread count field means:

Thread Count is the total number of threads detected by the BIOS for
this processor socket. It is a processor-wide count, not a
thread-per-core count. [1]

So here we should use threads per socket other than threads per core.

[1] SMBIOS 3.0.0, section 7.5.8, Processor Information - Thread Count

Fixes: c97294ec1b9e ("SMBIOS: Build aggregate smbios tables and entry point")
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
v4:
 * None.

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


