Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 921EF749519
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 07:51:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHHso-0006xl-4k; Thu, 06 Jul 2023 01:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1qHHsj-0006wr-3H
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 01:50:22 -0400
Received: from mga14.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1qHHsf-0006JI-3T
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 01:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688622617; x=1720158617;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qiXbTdCNXGAjJFEKGqhAhlOpDOijXguo2GxG7v09bGE=;
 b=Yvy2A5YvgjbhP0zSdAcBWx688/sdYUhQlES3mRTIOlj0pcN64qlaItgs
 dJFKrSxPy/X/AQbzq0liK6h9dL6niiO5rrQ2692V1dGGsR/xJ4XV5SBSP
 rz83s6j6dMh7H7EsYP0gjIeoEhbvZ1uFxUqIxPXK2ZG5A+RDUQLXBWxhP
 LlNi3XMlybqz0qOH1Gp1irLFbaImE1oDjFiG1NF9ZXsX/VlOkIrfOxtHx
 z7/YNYhoUS3gOR4Qrfdg3Sm0ryxfJ3uTjEAocpbq/ZeCmGVInohPwVu90
 nI5InAwevZRG+V8sd6TUxnpv3eqLspRGQVovtKnu65pFzsYgnmw8J2RGs g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="363540162"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; d="scan'208";a="363540162"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2023 22:50:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="863975939"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; d="scan'208";a="863975939"
Received: from st-server.bj.intel.com ([10.240.193.102])
 by fmsmga001.fm.intel.com with ESMTP; 05 Jul 2023 22:50:01 -0700
From: Tao Su <tao1.su@linux.intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, imammedo@redhat.com, xiaoyao.li@intel.com,
 lei4.wang@intel.com, qian.wen@intel.com, tao1.su@linux.intel.com
Subject: [PATCH v2 4/6] target/i386: Add new bit definitions of
 MSR_IA32_ARCH_CAPABILITIES
Date: Thu,  6 Jul 2023 13:49:47 +0800
Message-Id: <20230706054949.66556-5-tao1.su@linux.intel.com>
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

Currently, bit 13, 14, 15 and 24 of MSR_IA32_ARCH_CAPABILITIES are
disclosed for fixing security issues, so add those bit definitions.

Signed-off-by: Tao Su <tao1.su@linux.intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 target/i386/cpu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c196b0a482..e0771a1043 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1022,7 +1022,11 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 #define MSR_ARCH_CAP_PSCHANGE_MC_NO     (1U << 6)
 #define MSR_ARCH_CAP_TSX_CTRL_MSR       (1U << 7)
 #define MSR_ARCH_CAP_TAA_NO             (1U << 8)
+#define MSR_ARCH_CAP_SBDR_SSDP_NO       (1U << 13)
+#define MSR_ARCH_CAP_FBSDP_NO           (1U << 14)
+#define MSR_ARCH_CAP_PSDP_NO            (1U << 15)
 #define MSR_ARCH_CAP_FB_CLEAR           (1U << 17)
+#define MSR_ARCH_CAP_PBRSB_NO           (1U << 24)
 
 #define MSR_CORE_CAP_SPLIT_LOCK_DETECT  (1U << 5)
 
-- 
2.34.1


