Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 835817196C4
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 11:22:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4eU5-0007tT-N2; Thu, 01 Jun 2023 05:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1q4eU3-0007sv-WA
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:20:40 -0400
Received: from mga04.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1q4eU2-0004ef-Bt
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685611238; x=1717147238;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TenYkCSJGAYG6vndeCXgN52jDW+vKh7tZ6foDGnmN0c=;
 b=cfOAzGuI/DDwgMCNU1/BIL4MDiRJTKfPktdFphqrePMMeDxUqBMPk5kH
 UDOgZIRyaiIfE3KEfEJcnL/1WEsTHWioxHmTpawuVD4x3v46++jSKjodY
 DkwlX1rWc2paI+EfvCLQWMzjNUDg0j2AF2wG1wAMkrW9YU0SF9sXpfyZo
 DqYDoW2y3LmH04JBcjJxr7iEdUJ++UwrCM+J5CRkEMrjwH8hnOO/nZ/js
 bGLeoKkNwwBk66wxeR5RZoK2pZfbj4uZyGiCY42kbduos7syN7BGc+un2
 Gn+aL4ThVb8fm2j2bOFUDwogS7pxcV7YDWMRUtzSwPt7Phm98QTIRizDF g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="354359870"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; d="scan'208";a="354359870"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2023 02:20:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="953995725"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; d="scan'208";a="953995725"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.28])
 by fmsmga006.fm.intel.com with ESMTP; 01 Jun 2023 02:20:27 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 2/3] hw/smbios: Fix thread count in type4
Date: Thu,  1 Jun 2023 17:29:51 +0800
Message-Id: <20230601092952.1114727-3-zhao1.liu@linux.intel.com>
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

From SMBIOS 3.0 specification, thread count field means:

Thread Count is the total number of threads detected by the BIOS for
this processor socket. It is a processor-wide count, not a
thread-per-core count. [1]

So here we should use threads per socket other than threads per core.

[1] SMBIOS 3.0.0, section 7.5.8, Processor Information - Thread Count

Fixes: c97294ec1b9e ("SMBIOS: Build aggregate smbios tables and entry point")
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since v1:
 * Rename cpus_per_socket to threads_per_socket.
 * Add the comment about smp.max_cpus. Thread count and core count will
   be calculated in 2 ways and will add a sanity check to ensure we
   don't miss any topology level.
---
 hw/smbios/smbios.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index d67415d44dd8..faf82d4ae646 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -713,6 +713,7 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
 {
     char sock_str[128];
     size_t tbl_len = SMBIOS_TYPE_4_LEN_V28;
+    unsigned threads_per_socket;
 
     if (smbios_ep_type == SMBIOS_ENTRY_POINT_TYPE_64) {
         tbl_len = SMBIOS_TYPE_4_LEN_V30;
@@ -747,17 +748,20 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
     SMBIOS_TABLE_SET_STR(4, asset_tag_number_str, type4.asset);
     SMBIOS_TABLE_SET_STR(4, part_number_str, type4.part);
 
+    /* smp.max_cpus is the total number of threads for the system. */
+    threads_per_socket = ms->smp.max_cpus / ms->smp.sockets;
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


