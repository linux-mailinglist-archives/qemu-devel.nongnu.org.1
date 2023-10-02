Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B50247B4CE5
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 09:54:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnDji-0000Y3-Eh; Mon, 02 Oct 2023 03:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin3.li@intel.com>) id 1qnDjg-0000W0-7z
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 03:53:00 -0400
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin3.li@intel.com>) id 1qnDje-0007db-Iu
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 03:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1696233178; x=1727769178;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ne8O60ozJokQr2WgOKMMWCA/CTrneWREah0s6x/I350=;
 b=BGIE0t1Q/E3tW2ZwPupZhXj3S3kdgTVbDNlBlENxDjPEYxNbhdBP9fMm
 QvzB1MeLQcorBMMGvJ+lXZy+ch7e58EtCPrPBi4moaARHMB8a4AGOmtFe
 LubUmRsy5g6VfFOyl4leeFYVHDuO4JdysBLZ1m1cBe67COq0n9aTA7EWo
 X0XRtrpRThMTpmRlCwHxqwt1dP7AimzFwgvkPt/9aqrvWlldiNacv6Fxv
 8RcK+nMbXMZTR7cM+0SE6hznG2yMX8tJpKA4ccRezLOj0t2OhdlKbunZK
 W4pFiXYPzhgGUaopnaUK9VsC84j1reJbVgtpXErha2BLVniFRdKF+Ovf4 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="361975581"
X-IronPort-AV: E=Sophos;i="6.03,193,1694761200"; d="scan'208";a="361975581"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2023 00:52:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="750511630"
X-IronPort-AV: E=Sophos;i="6.03,193,1694761200"; d="scan'208";a="750511630"
Received: from unknown (HELO fred..) ([172.25.112.68])
 by orsmga002.jf.intel.com with ESMTP; 02 Oct 2023 00:52:49 -0700
From: Xin Li <xin3.li@intel.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, richard.henderson@linaro.org, pbonzini@redhat.com,
 eduardo@habkost.net, seanjc@google.com, chao.gao@intel.com, hpa@zytor.com,
 xiaoyao.li@intel.com, weijiang.yang@intel.com
Subject: [PATCH v2 3/4] target/i386: enumerate VMX nested-exception support
Date: Mon,  2 Oct 2023 00:23:12 -0700
Message-Id: <20231002072313.17603-4-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231002072313.17603-1-xin3.li@intel.com>
References: <20231002072313.17603-1-xin3.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.136; envelope-from=xin3.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Allow VMX nested-exception support to be exposed in KVM guests, thus
nested KVM guests can enumerate it.

Tested-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 scripts/kvm/vmxcap | 1 +
 target/i386/cpu.c  | 1 +
 target/i386/cpu.h  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/scripts/kvm/vmxcap b/scripts/kvm/vmxcap
index 3fb4d5b342..97097518a8 100755
--- a/scripts/kvm/vmxcap
+++ b/scripts/kvm/vmxcap
@@ -116,6 +116,7 @@ controls = [
             54: 'INS/OUTS instruction information',
             55: 'IA32_VMX_TRUE_*_CTLS support',
             56: 'Skip checks on event error code',
+            58: 'VMX nested exception support',
             },
         msr = MSR_IA32_VMX_BASIC,
         ),
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 59fdb2a01a..da0876842f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1341,6 +1341,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             [54] = "vmx-ins-outs",
             [55] = "vmx-true-ctls",
             [56] = "vmx-any-errcode",
+            [58] = "vmx-nested-exception",
         },
         .msr = {
             .index = MSR_IA32_VMX_BASIC,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 322547aa49..f4f0c57574 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1051,6 +1051,7 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 #define MSR_VMX_BASIC_INS_OUTS                       (1ULL << 54)
 #define MSR_VMX_BASIC_TRUE_CTLS                      (1ULL << 55)
 #define MSR_VMX_BASIC_ANY_ERRCODE                    (1ULL << 56)
+#define MSR_VMX_BASIC_NESTED_EXCEPTION               (1ULL << 58)
 
 #define MSR_VMX_MISC_PREEMPTION_TIMER_SHIFT_MASK     0x1Full
 #define MSR_VMX_MISC_STORE_LMA                       (1ULL << 5)
-- 
2.34.1


