Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A527273694F
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 12:31:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBYd5-0005zV-1I; Tue, 20 Jun 2023 06:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qBYd2-0005y1-Px
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:30:28 -0400
Received: from mga06b.intel.com ([134.134.136.31] helo=mga06.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qBYd1-00026h-Ac
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687257027; x=1718793027;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qJ6Q/bXIWmELYbiZjhKv3GbdmcK1dk0TdvM+vzulRys=;
 b=bXQnmG0OAjdQ+Cy3ibyJZhhN2vMO/LjeTa9Hxxz7zDId3tUgd1aDYmnc
 Q5W8qKxPOFKf70XQKVS/bYSYcF8Wsl6hAv4zDv1aWCtw1hM5SEgWgp8U2
 F3ZXNdQVbiKvoVnGFOdlCVUFHG+8Y/TOvkYQLenWjHGyDPN+mkbjH3/vx
 Isa1Wxqo7nEbZzBgxCJSO6hdRsRwmLvgkrb3juPGeI83rmyCshOxYWiuV
 JyGHBSWVjMIZLj082So9FmVNxhWKW89ZyyRI4kj806luef9bSQYqKGBGR
 N086VgLLQ8BX3XrIMnKY5KJ0RU1By5eUlRQ1Qi+L4g651PaM2OnAe3IZO g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="423488467"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; d="scan'208";a="423488467"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2023 03:30:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="714002254"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; d="scan'208";a="714002254"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.28])
 by orsmga002.jf.intel.com with ESMTP; 20 Jun 2023 03:30:23 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 2/4] hw/smbios: Fix smbios_smp_sockets caculation
Date: Tue, 20 Jun 2023 18:39:56 +0800
Message-Id: <20230620103958.3907565-3-zhao1.liu@linux.intel.com>
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

smp.sockets is the number of sockets which is configured by "-smp" (
otherwise, the default is 1). Trying to recalculate it here with another
rules leads to errors, such as:

1. 003f230e37d7 ("machine: Tweak the order of topology members in struct
   CpuTopology") changes the meaning of smp.cores but doesn't fix
   original smp.cores uses.

   With the introduction of cluster, now smp.cores means the number of
   cores in one cluster. So smp.cores * smp.threads just means the
   threads in a cluster not in a socket.

2. On the other hand, we shouldn't use smp.cpus here because it
   indicates the initial number of online CPUs at the boot time, and is
   not mathematically related to smp.sockets.

So stop reinventing the another wheel and use the topo values that
has been calculated.

Fixes: 003f230e37d7 ("machine: Tweak the order of topology members in struct CpuTopology")
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
v3:
 * Reorganized changlog. (Igor)

v2:
 * None.
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


