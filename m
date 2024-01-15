Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5E882D59D
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 10:14:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPJ2N-0002xR-Cs; Mon, 15 Jan 2024 04:13:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rPJ2H-0002lK-QH
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 04:13:39 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rPJ2D-0003eA-Tl
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 04:13:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705310014; x=1736846014;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4POKoLQSTQibc+jS6vVE7uV8ynTlKVai1gHsD3hGN1U=;
 b=D8a22G2HqEQ/bEoPC2u9z2IDU0xB64aIzvGiWqF+Sy+igGYBoeS4AI8+
 STjAEVpj/NdiDolX8KXUubdBBbXnyHEFPqNvvlmvKTIi/9H2UwAJYPEua
 CRipsVRIE/7PZQRgOg7K9/6K2VtHL0FZqi8sFWxlMk+8zhoVPYys4J+h/
 KGFhrOM3E4panHOd1eeOy8NdHHkMyNYWwwRd29boSnktlPXazAcIki+4K
 4j2AyJm7qT4B87rNFefIuejZCL5aS/hnVP+/naD47K9ZkIuDl17AABUTg
 d6h7L3ybXLuFkAUOfpQxk50pnWKBE1PeJpPnACWYzDO0iVP70IrfEuDJu Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="12928492"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="12928492"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 01:13:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="902720581"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="902720581"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmsmga002.fm.intel.com with ESMTP; 15 Jan 2024 01:13:28 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
	Yang Weijiang <weijiang.yang@intel.com>
Subject: [PATCH 2/2] i386/cpu: Mask with XCR0/XSS mask for FEAT_XSAVE_XCR0_HI
 and FEAT_XSAVE_XSS_HI leafs
Date: Mon, 15 Jan 2024 04:13:25 -0500
Message-Id: <20240115091325.1904229-3-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240115091325.1904229-1-xiaoyao.li@intel.com>
References: <20240115091325.1904229-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.998, HK_RANDOM_FROM=0.998, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The value of FEAT_XSAVE_XCR0_HI leaf and FEAT_XSAVE_XSS_HI leaf also
need to be masked by XCR0 and XSS mask respectively, to make it
logically correct.

Fixes: 301e90675c3f ("target/i386: Enable support for XSAVES based features")
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b445e2957c4f..a5c08944a483 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6946,9 +6946,9 @@ static void x86_cpu_enable_xsave_components(X86CPU *cpu)
     }
 
     env->features[FEAT_XSAVE_XCR0_LO] = mask & CPUID_XSTATE_XCR0_MASK;
-    env->features[FEAT_XSAVE_XCR0_HI] = mask >> 32;
+    env->features[FEAT_XSAVE_XCR0_HI] = (mask & CPUID_XSTATE_XCR0_MASK) >> 32;
     env->features[FEAT_XSAVE_XSS_LO] = mask & CPUID_XSTATE_XSS_MASK;
-    env->features[FEAT_XSAVE_XSS_HI] = mask >> 32;
+    env->features[FEAT_XSAVE_XSS_HI] = (mask & CPUID_XSTATE_XSS_MASK) >> 32;
 }
 
 /***** Steps involved on loading and filtering CPUID data
-- 
2.34.1


