Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64873AAFE96
	for <lists+qemu-devel@lfdr.de>; Thu,  8 May 2025 17:12:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD2r2-0001HH-52; Thu, 08 May 2025 11:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uD2qu-0000jw-CV
 for qemu-devel@nongnu.org; Thu, 08 May 2025 11:08:00 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uD2qq-0007RF-E9
 for qemu-devel@nongnu.org; Thu, 08 May 2025 11:07:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746716876; x=1778252876;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pOOQrH0r21D3RUmO6grDlkePBA5BARKSWD6S8v1sNVA=;
 b=Lx6mdL9Oza8bLPZPTmp4LjWo6Z+8EE2DYWeAP6zbbzbD7mktt+N4h25J
 A9bZLqYn4+zOMUrPT5DQmDHofMVYMwfalwVtRqaNddO7kW3b+Xt7GwPOi
 8mlB//AFNm8PxwN5vPKoRi7RUkdWohP2s1uUJk2CicJXc09oLStxa6LMK
 Bxwf9Ma+kBBMjnxh7gbwhqBmpwJEdzlz/gdH/Gpcga/BUlC/LXzg6psEx
 Ri++kP3dLkB7XIKTz8pyUpRv/vpdBPdk9DtS+fKUmsl5iyxl290/R4yEh
 +ILi4o+2TbTsmfzoMk6j3DlYg9RHk+N4TPCGGMdf0uf6l2mZW6joTMckL A==;
X-CSE-ConnectionGUID: AFw/ulhtS3SZLbO9nLnxEw==
X-CSE-MsgGUID: 1ydjQbqPQIu0Dk1YnymB4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="73888417"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="73888417"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 08:07:01 -0700
X-CSE-ConnectionGUID: durcEn7/Q4mZwrA5xTWj6g==
X-CSE-MsgGUID: kg9m63EFRjW4JNemURaQFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="141440345"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa005.jf.intel.com with ESMTP; 08 May 2025 08:06:58 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v9 41/55] i386/apic: Skip kvm_apic_put() for TDX
Date: Thu,  8 May 2025 10:59:47 -0400
Message-ID: <20250508150002.689633-42-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250508150002.689633-1-xiaoyao.li@intel.com>
References: <20250508150002.689633-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

KVM neithers allow writing to MSR_IA32_APICBASE for TDs, nor allow for
KVM_SET_LAPIC[*].

Note, KVM_GET_LAPIC is also disallowed for TDX. It is called in the path

  do_kvm_cpu_synchronize_state()
  -> kvm_arch_get_registers()
     -> kvm_get_apic()

and it's already disllowed for confidential guest through
guest_state_protected.

[*] https://lore.kernel.org/all/Z3w4Ku4Jq0CrtXne@google.com/

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes in v8:
- Fix the coding style; (Francesco)
---
 hw/i386/kvm/apic.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/i386/kvm/apic.c b/hw/i386/kvm/apic.c
index 757510600098..cb65fca49586 100644
--- a/hw/i386/kvm/apic.c
+++ b/hw/i386/kvm/apic.c
@@ -17,6 +17,7 @@
 #include "system/hw_accel.h"
 #include "system/kvm.h"
 #include "kvm/kvm_i386.h"
+#include "kvm/tdx.h"
 
 static inline void kvm_apic_set_reg(struct kvm_lapic_state *kapic,
                                     int reg_id, uint32_t val)
@@ -141,6 +142,10 @@ static void kvm_apic_put(CPUState *cs, run_on_cpu_data data)
     struct kvm_lapic_state kapic;
     int ret;
 
+    if (is_tdx_vm()) {
+        return;
+    }
+
     kvm_put_apicbase(s->cpu, s->apicbase);
     kvm_put_apic_state(s, &kapic);
 
-- 
2.43.0


