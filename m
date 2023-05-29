Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC435714E7C
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 18:35:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3fpF-0003MT-Gv; Mon, 29 May 2023 12:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1q3fpA-0003La-Rf
 for qemu-devel@nongnu.org; Mon, 29 May 2023 12:34:24 -0400
Received: from mga03.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1q3fp6-00075s-0R
 for qemu-devel@nongnu.org; Mon, 29 May 2023 12:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685378060; x=1716914060;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zvFuRLI9smAGYPpwowT9/Rn2/EsH7SSFkJPHWVone30=;
 b=PEUb0fhobGn4g2RYVgvd3pDDKTKY9LcWUrQuFIq1zlYlgI4ra0/LkpkM
 G0XVM4yzJOxK/9pvGoIF7Z7pIPEdD2fcuGo6WY85+i2wvSWAgG/HHP9hH
 5OpP3P4ODdJL43ByRfJIp9ICs0mqe+SXCh8UJnyCS5/JWHhpRRYc7+LFZ
 ZxdCGoVD8yS1Tnl8cHbmK5FciahDkSep2rR4lGQqEaCCfzY6pU4G0NQDd
 32cA2lQZU3Wm4to7EftHFfTS+vtcx66a6EgoNHRNja8sO5NJQjBuZztNa
 4z+Btx5Y2nO4xy6NnD0rWD8a9SLQ650yC5L3cdpxt9YavFWT/L0Ly4Uha g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="357991693"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; d="scan'208";a="357991693"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2023 09:34:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="771215628"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; d="scan'208";a="771215628"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.28])
 by fmsmga008.fm.intel.com with ESMTP; 29 May 2023 09:34:17 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 3/3] hw/smbios: Fix core count in type4
Date: Tue, 30 May 2023 00:43:43 +0800
Message-Id: <20230529164343.467793-4-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230529164343.467793-1-zhao1.liu@linux.intel.com>
References: <20230529164343.467793-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=134.134.136.65;
 envelope-from=zhao1.liu@linux.intel.com; helo=mga03.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
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
 hw/smbios/smbios.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index f80a701cdfc1..32e26bffa2df 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -714,6 +714,7 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
     char sock_str[128];
     size_t tbl_len = SMBIOS_TYPE_4_LEN_V28;
     unsigned cpus_per_socket = ms->smp.max_cpus / ms->smp.sockets;
+    unsigned cores_per_socket = cpus_per_socket / ms->smp.threads;
 
     if (smbios_ep_type == SMBIOS_ENTRY_POINT_TYPE_64) {
         tbl_len = SMBIOS_TYPE_4_LEN_V30;
@@ -748,7 +749,7 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
     SMBIOS_TABLE_SET_STR(4, asset_tag_number_str, type4.asset);
     SMBIOS_TABLE_SET_STR(4, part_number_str, type4.part);
 
-    t->core_count = (ms->smp.cores > 255) ? 0xFF : ms->smp.cores;
+    t->core_count = (cores_per_socket > 255) ? 0xFF : cores_per_socket;
     t->core_enabled = t->core_count;
 
     t->thread_count = (cpus_per_socket > 255) ? 0xFF : cpus_per_socket;
@@ -757,7 +758,7 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
     t->processor_family2 = cpu_to_le16(0x01); /* Other */
 
     if (tbl_len == SMBIOS_TYPE_4_LEN_V30) {
-        t->core_count2 = t->core_enabled2 = cpu_to_le16(ms->smp.cores);
+        t->core_count2 = t->core_enabled2 = cpu_to_le16(cores_per_socket);
         t->thread_count2 = cpu_to_le16(cpus_per_socket);
     }
 
-- 
2.34.1


