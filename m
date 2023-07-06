Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D81FB749516
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 07:50:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHHsu-00071r-Nl; Thu, 06 Jul 2023 01:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1qHHsn-0006yS-78
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 01:50:26 -0400
Received: from mga14.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1qHHsk-0006KB-OT
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 01:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688622622; x=1720158622;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=haDKb8RmSCZ2SkfI2GOfbbn6hbDbzWIlrMDivRx+v5A=;
 b=SDPwpW86Fdd5ibl5DiJ5RRF1/OpOAiFxCe+KT3Iy4K8dFBnAMCHG8MIt
 zGducnQixJmGeq2S8HHzRj0uy+hUsFe8nbXL1WWn0ccjjXGo6oOWN453j
 BUHcKxGi0ygq1l6nM9Iusf35GMX8k7MNTw50W+BfaycCNMp5PBFGp4u3e
 8eYkvDQbTj5DVurJQ8W+L8B2Ip97c+U08d/Qw6fAIqIbnLxaEYZ4+ibmX
 XU8Ao/isfDuJda/rjOP8z0TDRnaI+sUTj4cQ1QIK56HRV8ZJprB0ukDg9
 QXsU1j36ZcUzihstR3/jQ72bM/+7X82Q8p+rHio5FEAWtWBv80SDYe8b1 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="363540168"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; d="scan'208";a="363540168"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2023 22:50:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="863975943"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; d="scan'208";a="863975943"
Received: from st-server.bj.intel.com ([10.240.193.102])
 by fmsmga001.fm.intel.com with ESMTP; 05 Jul 2023 22:50:03 -0700
From: Tao Su <tao1.su@linux.intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, imammedo@redhat.com, xiaoyao.li@intel.com,
 lei4.wang@intel.com, qian.wen@intel.com, tao1.su@linux.intel.com
Subject: [PATCH v2 5/6] target/i386: Add few security fix bits in
 ARCH_CAPABILITIES into SapphireRapids CPU model
Date: Thu,  6 Jul 2023 13:49:48 +0800
Message-Id: <20230706054949.66556-6-tao1.su@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230706054949.66556-1-tao1.su@linux.intel.com>
References: <20230706054949.66556-1-tao1.su@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.55.52.115;
 envelope-from=tao1.su@linux.intel.com; helo=mga14.intel.com
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

From: Lei Wang <lei4.wang@intel.com>

SapphireRapids has bit 13, 14 and 15 of MSR_IA32_ARCH_CAPABILITIES
enabled, which are related to some security fixes.

Add version 2 of SapphireRapids CPU model with those bits enabled also.

Signed-off-by: Lei Wang <lei4.wang@intel.com>
Signed-off-by: Tao Su <tao1.su@linux.intel.com>
---
 target/i386/cpu.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 852c45b965..ec229072e7 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3944,8 +3944,17 @@ static const X86CPUDefinition builtin_x86_defs[] = {
         .model_id = "Intel Xeon Processor (SapphireRapids)",
         .versions = (X86CPUVersionDefinition[]) {
             { .version = 1 },
-            { /* end of list */ },
-        },
+            {
+                .version = 2,
+                .props = (PropValue[]) {
+                    { "sbdr-ssdp-no", "on" },
+                    { "fbsdp-no", "on" },
+                    { "psdp-no", "on" },
+                    { /* end of list */ }
+                }
+            },
+            { /* end of list */ }
+        }
     },
     {
         .name = "Denverton",
-- 
2.34.1


