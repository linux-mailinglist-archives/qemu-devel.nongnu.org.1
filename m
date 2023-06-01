Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A747196C6
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 11:22:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4eU4-0007sx-Nm; Thu, 01 Jun 2023 05:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1q4eU2-0007rz-HD
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:20:38 -0400
Received: from mga04.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1q4eU0-0004eq-Vd
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:20:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685611236; x=1717147236;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gbgnB1zu57ADLHW0NaG4NBp7Kwj1jx45mnQ8rIdMkvE=;
 b=PpoMOnHsFr2PBwRdERS7xOxC0uI+VVZHbXrgKvgr+WPgY7kNX7ktd/N+
 9XqeMB8fh0UOuvVumfBU7Ik6I92O3OEtTaBjy3lW4n7GDHtKfqTl1BPMZ
 kvB3HdtHTFLdKIRATJRtXWYlEcQJHEal/WdlslXjw7dQT4/skpWEzHVL+
 zP5H6gMnJwMRnXbqryiraa4mXbNFSufdm91U4eDTRUyxU6IgUYOd5NnVq
 zDUNLxs+3kQ9qEF6WqGcdHRWjT0w/FxYYHSGfXwG1LGO7w5OhQVI1lGXm
 4nEXx06MBrpWgGjnFB+J9IXtlXYhfh3xTgBHNGOG66aGiXtnXz6r7vOTE Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="354359867"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; d="scan'208";a="354359867"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2023 02:20:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="953995705"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; d="scan'208";a="953995705"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.28])
 by fmsmga006.fm.intel.com with ESMTP; 01 Jun 2023 02:20:25 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 1/3] hw/smbios: Fix smbios_smp_sockets caculation
Date: Thu,  1 Jun 2023 17:29:50 +0800
Message-Id: <20230601092952.1114727-2-zhao1.liu@linux.intel.com>
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


