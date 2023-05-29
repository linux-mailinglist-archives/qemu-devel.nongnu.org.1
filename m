Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAD371498F
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 14:35:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3c4y-0008JC-6u; Mon, 29 May 2023 08:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1q3c4g-0008E2-QM
 for qemu-devel@nongnu.org; Mon, 29 May 2023 08:34:10 -0400
Received: from mga04.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1q3c4e-00029t-OA
 for qemu-devel@nongnu.org; Mon, 29 May 2023 08:34:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685363648; x=1716899648;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=XuAKagteAexMEQ4SotNMhHfLEnHPvGDtrOoAZ+fZIck=;
 b=iBthjKRyZS/zE1mB2mRKlwDsQI4acG/fOHqx/Y4xniwW8zOyr/dErG6B
 NRnOyYMefCoE1UzGjn4Y/VuJKWOf7hQiuNF4DcEG3a40XfE4u5YBIuy61
 cdDZkhGvIscu5Kzx7mrWuFUtYok1Rl9A7Efd9RzhGDJbF9nRr/vXTeU8m
 FqvWzoTGno1ur5wvyl2XUb1YL1h60XYXB7uZIezxqDIj9dPryUwxesdAG
 SGPlLbteCCaIjnvsZfr2wD0irJL05gt2/pQboMQqw6AuOgbirvnPyW1xA
 RcnWntmDIZ8IEZjKoSvCRWjacBIAvxt8oaDs4ZXE4aKmUt0jB1s3ipqLM Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="353538567"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; d="scan'208";a="353538567"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2023 05:34:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="739136252"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; d="scan'208";a="739136252"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.28])
 by orsmga001.jf.intel.com with ESMTP; 29 May 2023 05:34:05 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Sunil Muthuswamy <sunilmut@microsoft.com>
Cc: qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH] i386/WHPX: Fix error message when fail to set ProcessorCount
Date: Mon, 29 May 2023 20:43:31 +0800
Message-Id: <20230529124331.412822-1-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.55.52.120;
 envelope-from=zhao1.liu@linux.intel.com; helo=mga04.intel.com
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

003f230e37d7 ("machine: Tweak the order of topology members in struct
CpuTopology") changes the meaning of MachineState.smp.cores from "the
number of cores in one package" to "the number of cores in one die"
and doesn't fix other uses of MachineState.smp.cores. And because of
the introduction of cluster, now smp.cores just means "the number of
cores in one cluster". This clearly does not fit the semantics here.

And before this error message, WHvSetPartitionProperty() is called to
set prop.ProcessorCount.

So the error message should show the prop.ProcessorCount other than
"cores per cluster" or "cores per package".

Cc: Sunil Muthuswamy <sunilmut@microsoft.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/whpx/whpx-all.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 52af81683c1e..5882bf22d0a1 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2613,8 +2613,8 @@ static int whpx_accel_init(MachineState *ms)
         sizeof(WHV_PARTITION_PROPERTY));
 
     if (FAILED(hr)) {
-        error_report("WHPX: Failed to set partition core count to %d,"
-                     " hr=%08lx", ms->smp.cores, hr);
+        error_report("WHPX: Failed to set partition processor count to %d,"
+                     " hr=%08lx", prop.ProcessorCount, hr);
         ret = -EINVAL;
         goto error;
     }
-- 
2.34.1


