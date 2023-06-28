Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 026437412E6
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 15:46:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEVTu-0005CZ-SS; Wed, 28 Jun 2023 09:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qEVTe-0005BR-7w
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 09:44:58 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qEVTc-000885-Ne
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 09:44:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687959896; x=1719495896;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZUSL+eca/5GsGL4WFLQFgSwu2Mpnrl1Ujo1b6PRxk54=;
 b=d7/jOO7o/NM3hD05f2dExV4ffvNYcKZtAdR2fuow54M5Xel0UrUul8qq
 ZU721vsZ/5FJlYOFZkPyB3uHFVoW5VGYM4B1ZI/DMbu0pk4A03By0U5pN
 6eG0bmAnzxvN5LUYbHXKjWNs5HMM02k1W1XTRqagftBozHy7sxk8AqeD+
 zwCrRcuFTx+05f8ZO4I9LPs/NXotMLHRMjNi7nMcQV/nGBd0pdywu1rTV
 fg0IPHkBum4IUzDzwDrOZBtyT6ujPQlWxnxnUJs3Q97YOSvK+mmHOuKdR
 77aMlEDxKdYK/dXZ/sQd3yQUlNoad8GUdjL/SIVrfwbKlOnu0IeH91q2M Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="427854126"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; d="scan'208";a="427854126"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2023 06:44:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="806905480"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; d="scan'208";a="806905480"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.28])
 by FMSMGA003.fm.intel.com with ESMTP; 28 Jun 2023 06:44:51 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v4 2/4] hw/smbios: Fix smbios_smp_sockets caculation
Date: Wed, 28 Jun 2023 21:54:35 +0800
Message-Id: <20230628135437.1145805-3-zhao1.liu@linux.intel.com>
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
v4:
 * None.

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


