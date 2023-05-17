Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F14E706263
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 10:11:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzC6K-00022L-W9; Wed, 17 May 2023 04:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzC5z-0001s1-4F; Wed, 17 May 2023 04:01:21 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzC5r-0000Yb-RZ; Wed, 17 May 2023 04:01:11 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1B86B6752;
 Wed, 17 May 2023 11:00:58 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 7D6095E0A;
 Wed, 17 May 2023 11:00:57 +0300 (MSK)
Received: (nullmailer pid 3624105 invoked by uid 1000);
 Wed, 17 May 2023 08:00:56 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v8.0.1 09/36] target/arm: Initialize debug capabilities only
 once
Date: Wed, 17 May 2023 11:00:29 +0300
Message-Id: <20230517080056.3623993-9-mjt@msgid.tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <<20230517073442.3622973-0-mjt@msgid.tls.msk.ru>
References: <20230517073442.3622973-0-mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

kvm_arm_init_debug() used to be called several times on a SMP system as
kvm_arch_init_vcpu() calls it. Move the call to kvm_arch_init() to make
sure it will be called only once; otherwise it will overwrite pointers
to memory allocated with the previous call and leak it.

Fixes: e4482ab7e3 ("target-arm: kvm - add support for HW assisted debug")
Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-id: 20230405153644.25300-1-akihiko.odaki@daynix.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit ad5c6ddea327758daa9f0e6edd916be39dce7dca)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 target/arm/kvm.c     |  2 ++
 target/arm/kvm64.c   | 18 ++++--------------
 target/arm/kvm_arm.h |  8 ++++++++
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index f022c644d2..84da49332c 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -280,6 +280,8 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         }
     }
 
+    kvm_arm_init_debug(s);
+
     return ret;
 }
 
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 1197253d12..810db33ccb 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -74,24 +74,16 @@ GArray *hw_breakpoints, *hw_watchpoints;
 #define get_hw_bp(i)    (&g_array_index(hw_breakpoints, HWBreakpoint, i))
 #define get_hw_wp(i)    (&g_array_index(hw_watchpoints, HWWatchpoint, i))
 
-/**
- * kvm_arm_init_debug() - check for guest debug capabilities
- * @cs: CPUState
- *
- * kvm_check_extension returns the number of debug registers we have
- * or 0 if we have none.
- *
- */
-static void kvm_arm_init_debug(CPUState *cs)
+void kvm_arm_init_debug(KVMState *s)
 {
-    have_guest_debug = kvm_check_extension(cs->kvm_state,
+    have_guest_debug = kvm_check_extension(s,
                                            KVM_CAP_SET_GUEST_DEBUG);
 
-    max_hw_wps = kvm_check_extension(cs->kvm_state, KVM_CAP_GUEST_DEBUG_HW_WPS);
+    max_hw_wps = kvm_check_extension(s, KVM_CAP_GUEST_DEBUG_HW_WPS);
     hw_watchpoints = g_array_sized_new(true, true,
                                        sizeof(HWWatchpoint), max_hw_wps);
 
-    max_hw_bps = kvm_check_extension(cs->kvm_state, KVM_CAP_GUEST_DEBUG_HW_BPS);
+    max_hw_bps = kvm_check_extension(s, KVM_CAP_GUEST_DEBUG_HW_BPS);
     hw_breakpoints = g_array_sized_new(true, true,
                                        sizeof(HWBreakpoint), max_hw_bps);
     return;
@@ -920,8 +912,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
     }
     cpu->mp_affinity = mpidr & ARM64_AFFINITY_MASK;
 
-    kvm_arm_init_debug(cs);
-
     /* Check whether user space can specify guest syndrome value */
     kvm_arm_init_serror_injection(cs);
 
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 99017b635c..330fbe5c72 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -18,6 +18,14 @@
 #define KVM_ARM_VGIC_V2   (1 << 0)
 #define KVM_ARM_VGIC_V3   (1 << 1)
 
+/**
+ * kvm_arm_init_debug() - initialize guest debug capabilities
+ * @s: KVMState
+ *
+ * Should be called only once before using guest debug capabilities.
+ */
+void kvm_arm_init_debug(KVMState *s);
+
 /**
  * kvm_arm_vcpu_init:
  * @cs: CPUState
-- 
2.39.2


