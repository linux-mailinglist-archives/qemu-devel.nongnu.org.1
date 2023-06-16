Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F22297325D4
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 05:24:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qA03g-0000FL-Ai; Thu, 15 Jun 2023 23:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1qA03e-0000Es-9P
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 23:23:30 -0400
Received: from mga04.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1qA03c-0002FT-P7
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 23:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686885808; x=1718421808;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6rz8fK8ieTjIlDbcuEaPUiagZzOl7Fbib763W9wK8S8=;
 b=ajjmRSERvMfywNqkrofMBBbYc4g6/DNw3sMDVtpX3GAwA+g7a2qWdPG8
 9Pnq4ybrbfehO7pI8fWGWwPLei8HWv12GyHQn6RmM009XLuYZmNu5QZnr
 k7kJtDNsRfZnoOJvrSTtZZHuV5Z2LBH8bZIL+yCBqgGzpNgDXD5cGlbCq
 vGHlwOCGbFw21yxf7iboxmK0v3aY6JeA0iShIMwJrUlmlYteyEFmCncBt
 F5isv5gu6sMkzPBvH1csx8j3yfLeY4Nu0BNQEQHVzGGEi0Cov9ge7O/xh
 R1rkB9D42vsO1n6QJ6gfmJPayCo+Zk9iehWgKY85Fz64vPPUqri4MnK2o A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="357979174"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; d="scan'208";a="357979174"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2023 20:23:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="715846008"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; d="scan'208";a="715846008"
Received: from st-server.bj.intel.com ([10.240.193.102])
 by fmsmga007.fm.intel.com with ESMTP; 15 Jun 2023 20:23:25 -0700
From: Tao Su <tao1.su@linux.intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, xiaoyao.li@intel.com, lei4.wang@intel.com,
 qian.wen@intel.com, imammedo@redhat.com, tao1.su@linux.intel.com
Subject: [PATCH 5/7] target/i386: Add few security fix bits in
 ARCH_CAPABILITIES into SapphireRapids CPU model
Date: Fri, 16 Jun 2023 11:23:09 +0800
Message-Id: <20230616032311.19137-6-tao1.su@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230616032311.19137-1-tao1.su@linux.intel.com>
References: <20230616032311.19137-1-tao1.su@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.55.52.120;
 envelope-from=tao1.su@linux.intel.com; helo=mga04.intel.com
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

Latest stepping (8) of SapphireRapids has bit 13, 14 and 15 of
MSR_IA32_ARCH_CAPABILITIES enabled, which are related to some security
fixes.

Add version 2 of SapphireRapids CPU model with those bits enabled also.

Signed-off-by: Lei Wang <lei4.wang@intel.com>
Signed-off-by: Tao Su <tao1.su@linux.intel.com>
---
 target/i386/cpu.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b5321240c6..f84fd20bb1 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3854,8 +3854,17 @@ static const X86CPUDefinition builtin_x86_defs[] = {
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


