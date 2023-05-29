Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E55EC714E7E
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 18:35:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3fpD-0003M0-Km; Mon, 29 May 2023 12:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1q3fp6-0003LA-8c
 for qemu-devel@nongnu.org; Mon, 29 May 2023 12:34:20 -0400
Received: from mga03.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1q3fp3-000763-VO
 for qemu-devel@nongnu.org; Mon, 29 May 2023 12:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685378057; x=1716914057;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gbgnB1zu57ADLHW0NaG4NBp7Kwj1jx45mnQ8rIdMkvE=;
 b=WjYU4NoVYjIKunrqcParlLRPt8HSor+Xnn3h5AfmdzZWA9d9pC0/YnF4
 wttMjmfOtKkPOVb50lEGUuCMrLcFaZK4eNlN34veYyMHyScogdGB9KD58
 kt2LQCdBeFvbjU+kCBK9WNW/aa+XBJIrUeD9RyxcJIHFjdDg6h/KCAA8+
 +qaZXaUyE5yeEief2kmIKf93KZeZL693zKumZ5KNmNTvcTlnHd/RBkjMH
 f+MAM7Idg4FRt1h21HkxCkn2Xq0uQLfBznzlXWP7Avi4a+GxZSgg7pgCD
 qdmLjaZyAdArt73GMTnXQy8ZSSUz/Wt2KiqQy/lVAITLrpQNkmLxQbiy3 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="357991688"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; d="scan'208";a="357991688"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2023 09:34:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="771215608"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; d="scan'208";a="771215608"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.28])
 by fmsmga008.fm.intel.com with ESMTP; 29 May 2023 09:34:14 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 1/3] hw/smbios: Fix smbios_smp_sockets caculation
Date: Tue, 30 May 2023 00:43:41 +0800
Message-Id: <20230529164343.467793-2-zhao1.liu@linux.intel.com>
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

Here're 2 mistakes:
1. 003f230e37d7 ("machine: Tweak the order of topology members in struct
   CpuTopology") changes the meaning of smp.cores but doesn't fix
   original smp.cores uses. And because of the introduction of cluster,
   now smp.cores means the number of cores in one cluster. So smp.cores
   * smp.threads just means the cpus in a cluster not in a socket.
2. smp.cpus means the number of initial online cpus, not the total
   number of cpus. For such topology calculation, smp.max_cpus
   should be considered.

Since the number of sockets has already been recorded in smp structure,
use smp.sockets directly.

Fixes: 003f230e37d7 ("machine: Tweak the order of topology members in struct CpuTopology")
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/smbios/smbios.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index d2007e70fb05..d67415d44dd8 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -1088,8 +1088,7 @@ void smbios_get_tables(MachineState *ms,
         smbios_build_type_2_table();
         smbios_build_type_3_table();
 
-        smbios_smp_sockets = DIV_ROUND_UP(ms->smp.cpus,
-                                          ms->smp.cores * ms->smp.threads);
+        smbios_smp_sockets = ms->smp.sockets;
         assert(smbios_smp_sockets >= 1);
 
         for (i = 0; i < smbios_smp_sockets; i++) {
-- 
2.34.1


