Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD05BA1B764
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Jan 2025 14:45:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbJvZ-0003l4-HR; Fri, 24 Jan 2025 08:40:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tbJvB-0001ja-B0
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 08:40:32 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tbJv5-00042W-F4
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 08:40:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737726024; x=1769262024;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JKMlucssmDcGsanH6kb+uP0DlL1BGA8NocL5uyi4aSQ=;
 b=eTp70tKdpAv0t7Tb0Yih1ui6Pk2s96E1QKfkkxcrXvWcEdD+7uSdSIKN
 UGWT+siS1Od+7iNV3kSSBiGRqo4G/seyYmRB7aUuzq+E2WeiyqOl3ygrz
 bGCbc6WEPHM5R35p/YOQfKcoW3QC2lSuDknudxxQufwFYJrJifKgLID7U
 P2uChoefxakr3m0ZIqS+hBzkTSdI5JXw9wrs9nRIHDal5xsp+CX2ij5Rv
 raraWJfsSpgJ6CV6SRP+nBT4+CHNw4jc3f41AL05WnmaMUsWvGy7f/oxP
 BvneAKZGOYHp6PasPwMk3xtSAF3Smh0Rd64zEtbuB9t+JRet6IYNF0m1C w==;
X-CSE-ConnectionGUID: wiZgsbWVQim+dSL5ss83ww==
X-CSE-MsgGUID: sNvXmOeDR6O8IiXadwku1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="49246618"
X-IronPort-AV: E=Sophos;i="6.13,231,1732608000"; d="scan'208";a="49246618"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2025 05:39:59 -0800
X-CSE-ConnectionGUID: MhmOIQIkSiiYhKyyfDZaXg==
X-CSE-MsgGUID: F+sYU9DxSfK/Y6tdvLojTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111804477"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa003.fm.intel.com with ESMTP; 24 Jan 2025 05:39:55 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>, xiaoyao.li@intel.com,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: [PATCH v7 47/52] i386/cgs: Introduce
 x86_confidential_guest_check_features()
Date: Fri, 24 Jan 2025 08:20:43 -0500
Message-Id: <20250124132048.3229049-48-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124132048.3229049-1-xiaoyao.li@intel.com>
References: <20250124132048.3229049-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

To do cgs specific feature checking. Note the feature checking in
x86_cpu_filter_features() is valid for non-cgs VMs. For cgs VMs like
TDX, what features can be supported has more restrictions.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/confidential-guest.h | 13 +++++++++++++
 target/i386/kvm/kvm.c            |  8 ++++++++
 2 files changed, 21 insertions(+)

diff --git a/target/i386/confidential-guest.h b/target/i386/confidential-guest.h
index 777d43cc9688..48b88dbd3130 100644
--- a/target/i386/confidential-guest.h
+++ b/target/i386/confidential-guest.h
@@ -42,6 +42,7 @@ struct X86ConfidentialGuestClass {
     void (*cpu_instance_init)(X86ConfidentialGuest *cg, CPUState *cpu);
     uint32_t (*adjust_cpuid_features)(X86ConfidentialGuest *cg, uint32_t feature,
                                       uint32_t index, int reg, uint32_t value);
+    int (*check_features)(X86ConfidentialGuest *cg, CPUState *cs);
 };
 
 /**
@@ -91,4 +92,16 @@ static inline int x86_confidential_guest_adjust_cpuid_features(X86ConfidentialGu
     }
 }
 
+static inline int x86_confidential_guest_check_features(X86ConfidentialGuest *cg,
+                                                        CPUState *cs)
+{
+    X86ConfidentialGuestClass *klass = X86_CONFIDENTIAL_GUEST_GET_CLASS(cg);
+
+    if (klass->check_features) {
+        return klass->check_features(cg, cs);
+    }
+
+    return 0;
+}
+
 #endif
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 17d7bf6ae9aa..27b4a069d194 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2092,6 +2092,14 @@ int kvm_arch_init_vcpu(CPUState *cs)
     int r;
     Error *local_err = NULL;
 
+    if (current_machine->cgs) {
+        r = x86_confidential_guest_check_features(
+                X86_CONFIDENTIAL_GUEST(current_machine->cgs), cs);
+        if (r < 0) {
+            return r;
+        }
+    }
+
     memset(&cpuid_data, 0, sizeof(cpuid_data));
 
     cpuid_i = 0;
-- 
2.34.1


