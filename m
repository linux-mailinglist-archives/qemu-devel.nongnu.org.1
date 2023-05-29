Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EED714E7D
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 18:35:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3fpD-0003ME-VI; Mon, 29 May 2023 12:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1q3fp6-0003LB-AU
 for qemu-devel@nongnu.org; Mon, 29 May 2023 12:34:20 -0400
Received: from mga03.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1q3fp4-00076S-KL
 for qemu-devel@nongnu.org; Mon, 29 May 2023 12:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685378058; x=1716914058;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pKr273Dx34J7BBEG7udj0OoqHPV+n96yVyK9wUcBmTM=;
 b=UDjr7kFNtDt9k1dx1NulpwlonJ7QcWkGv3TMGzan17WluBqCCL96exgo
 ujlLJdhhhGlUSc0h4qpJreXx0Z4cLkrXyKQOR0bDw6XJ08FztChJEbwi8
 xEYNdiZLyN3CC3+IZBhLsaAtnBOGbTJPBPwLryAokehAKg0Q24KPiHJyg
 RU5lSs9FLonomf46Qo6APY+8E31mH+uo/N/M+DC56qCXReB3TnrWaE+Sv
 R8w/LZC+kD6flCHxNnJMz6QBBcKOjwSbPu1q0iV/PvxF/5I1ZBxdFCXMk
 UIaZjqUy8XqUBb2wdY0M8rKsMo1TK/Fnz6GewMQpt5EIuo+18VGRLgVta A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="357991690"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; d="scan'208";a="357991690"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2023 09:34:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="771215615"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; d="scan'208";a="771215615"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.28])
 by fmsmga008.fm.intel.com with ESMTP; 29 May 2023 09:34:15 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 2/3] hw/smbios: Fix thread count in type4
Date: Tue, 30 May 2023 00:43:42 +0800
Message-Id: <20230529164343.467793-3-zhao1.liu@linux.intel.com>
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

From SMBIOS 3.0 specification, thread count field means:

Thread Count is the total number of threads detected by the BIOS for
this processor socket. It is a processor-wide count, not a
thread-per-core count. [1]

So here we should use threads per socket other than threads per core.

[1] SMBIOS 3.0.0, section 7.5.8, Processor Information - Thread Count

Fixes: c97294ec1b9e ("SMBIOS: Build aggregate smbios tables and entry point")
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/smbios/smbios.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index d67415d44dd8..f80a701cdfc1 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -713,6 +713,7 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
 {
     char sock_str[128];
     size_t tbl_len = SMBIOS_TYPE_4_LEN_V28;
+    unsigned cpus_per_socket = ms->smp.max_cpus / ms->smp.sockets;
 
     if (smbios_ep_type == SMBIOS_ENTRY_POINT_TYPE_64) {
         tbl_len = SMBIOS_TYPE_4_LEN_V30;
@@ -750,14 +751,14 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
     t->core_count = (ms->smp.cores > 255) ? 0xFF : ms->smp.cores;
     t->core_enabled = t->core_count;
 
-    t->thread_count = (ms->smp.threads > 255) ? 0xFF : ms->smp.threads;
+    t->thread_count = (cpus_per_socket > 255) ? 0xFF : cpus_per_socket;
 
     t->processor_characteristics = cpu_to_le16(0x02); /* Unknown */
     t->processor_family2 = cpu_to_le16(0x01); /* Other */
 
     if (tbl_len == SMBIOS_TYPE_4_LEN_V30) {
         t->core_count2 = t->core_enabled2 = cpu_to_le16(ms->smp.cores);
-        t->thread_count2 = cpu_to_le16(ms->smp.threads);
+        t->thread_count2 = cpu_to_le16(cpus_per_socket);
     }
 
     SMBIOS_BUILD_TABLE_POST;
-- 
2.34.1


