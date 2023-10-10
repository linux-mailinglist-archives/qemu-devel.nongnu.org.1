Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D677BF2C0
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 08:06:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq5sQ-00025o-AU; Tue, 10 Oct 2023 02:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qq5sN-00021M-9X
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 02:05:51 -0400
Received: from mgamail.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qq5sI-0005Fd-7d
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 02:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1696917946; x=1728453946;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=IRiTVEt+WNq08AAs4bzBamGsV/glfW2kqK+IBcIjGW8=;
 b=A4vuKZZJyjyMabkclR/2QpybPXLzgGpkv3fjpacF7vD70TNHF38VuySt
 QSSDnQaB2XzisDb4RubsywCr3JRwv1xpA9krYcHBcipWlVQEEzoGkiayW
 /RDuyNZ5rTPsl3JQNYQbGWDTPMxJlQDlYz2sSzB9S+Y3YY0dDIW60O2tx
 smdvCb0sl+eYWc8znUnA4VT6WyxmtTc8v1olUUv2HFQHYUW4XCFy9XG3y
 w3gWEN1d/rhd8qQtvSgKs76VpavDkV2lSy0YMuvwMQzTLpiDEcLiQ+V1t
 EX5Co/VFhvbF4vMMdtua6+y550rXXZv/H3kTjYMH+S7XNfv/KHazxCrlc Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="415316004"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; d="scan'208";a="415316004"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2023 23:05:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="897041182"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; d="scan'208";a="897041182"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmsmga001.fm.intel.com with ESMTP; 09 Oct 2023 23:03:59 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org,
	xiaoyao.li@intel.com
Subject: [PATCH] targer/i386/cpu: Fix CPUID_HT exposure
Date: Tue, 10 Oct 2023 02:05:39 -0400
Message-Id: <20231010060539.210258-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.88; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

When explicitly booting a multiple vcpus vm with "-cpu +ht", it gets
warning of

  warning: host doesn't support requested feature: CPUID.01H:EDX.ht [bit 28]

Make CPUID_HT as supported unconditionally can resolve the warning.
However it introduces another issue that it also expose CPUID_HT to
guest when "-cpu host/max" with only 1 vcpu. To fix this, need mark
CPUID_HT as the no_autoenable_flags.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/cpu.c     | 1 +
 target/i386/kvm/kvm.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index cec5d2b7b65e..32c077455f04 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -778,6 +778,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .cpuid = {.eax = 1, .reg = R_EDX, },
         .tcg_features = TCG_FEATURES,
+        .no_autoenable_flags = CPUID_HT,
     },
     [FEAT_1_ECX] = {
         .type = CPUID_FEATURE_WORD,
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index f6c7f7e26869..ab72bcdfad13 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -373,6 +373,8 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
     if (function == 1 && reg == R_EDX) {
         /* KVM before 2.6.30 misreports the following features */
         ret |= CPUID_MTRR | CPUID_PAT | CPUID_MCE | CPUID_MCA;
+        /* KVM never reports CPUID_HT but QEMU can support when vcpus > 1 */
+        ret |= CPUID_HT;
     } else if (function == 1 && reg == R_ECX) {
         /* We can set the hypervisor flag, even if KVM does not return it on
          * GET_SUPPORTED_CPUID

base-commit: cea3ea670fe265421131aad90c36fbb87bc4d206
-- 
2.34.1


