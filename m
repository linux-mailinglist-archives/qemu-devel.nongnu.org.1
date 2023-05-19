Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3BF709ABA
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:58:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01Yg-0007hJ-AQ; Fri, 19 May 2023 10:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q01Ye-0007PH-1O
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:58:16 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q01Ya-0005ki-72
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:58:14 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3f4c6c4b51eso32606165e9.2
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684508290; x=1687100290;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=S58N+s3UhZ1MdJCUBFQ6Kp6HUpEehLFEK5qchVNWraI=;
 b=ZDltrDAZ5gGlKsxe0lXGWutMLFMgqMmYI6wpGJePtpGZiVsnAR8e0wy756YKiF7nh5
 W6IXZHvddpKo1vECBlUy4Mo2gXP1b+2I9rZrPwbZ9P+e/xOZ0yVtoBSC85XQjtnQOjOG
 RGdz+w701R20ntDiSz8WfDc0+RJa58Sq651b4Zk/+HFsDBcpKdnDhUvnmlFNVSUWQ1II
 o66ONrarLsovzC9d711Yc+2ppQASfqE2wUn1lv+bHVa0bvOuhOghszhsfAmseFIC7EQd
 j8xkiTxZLzs+krjvUx9KmXPH4AEzEWpNjNJ+PPtGkMuIBVKy/bwUzHwQPn8oGcS/II7v
 Bp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684508290; x=1687100290;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S58N+s3UhZ1MdJCUBFQ6Kp6HUpEehLFEK5qchVNWraI=;
 b=NrTpMu0qV2jdEMRoAFEcWU6ubiGHfKoa9Ca4z5GV9Y+EYLnle+VUKgJacwHmQi7m4p
 ANQHrIjG/maJKJqbE2/hovFSTOZhSZeZyp96iRtDLx6K1nRATvWwQrPphdCsnNz8enVD
 bAwFKs55gucOE6g6G3F3LX0GtJOPRkRT7ht7SZW9IYZ+JAR/VkJGz/31FLBkUSmTrH2P
 zjHkHV7KYPgttK/T1S8+nE58WXS3FE5cdyVLmRJU7xYspC4T5oVZnbSQe0CC3MGNUqt/
 WZY+r2h159IF1Ec4uAosZ1qmMI395E+ULxMLhTJLxd9GPFOHCu5VE8F45eSMWHFUGm18
 pphA==
X-Gm-Message-State: AC+VfDxK4J+mffbZZLVngIfyW9wYHTmiStCxM0BE1P3Fyc6CaU9F/qji
 Uw4UYp1TUjL8Qc6qam2A+EKNLg==
X-Google-Smtp-Source: ACHHUZ7amOOp7DhEvIhI4ZrRtJEPeDzfZR0rnLcTsnrKurMYJtKcmFDlmgQnhm7Noh9SX/JfR7ODEw==
X-Received: by 2002:a1c:ed13:0:b0:3f4:253b:92a9 with SMTP id
 l19-20020a1ced13000000b003f4253b92a9mr1712364wmh.30.1684508290626; 
 Fri, 19 May 2023 07:58:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 22-20020a05600c231600b003f421979398sm2622848wmo.26.2023.05.19.07.58.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 07:58:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH] Revert "arm/kvm: add support for MTE"
Date: Fri, 19 May 2023 15:58:08 +0100
Message-Id: <20230519145808.348701-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This reverts commit b320e21c48ce64853904bea6631c0158cc2ef227,
which accidentally broke TCG, because it made the TCG -cpu max
report the presence of MTE to the guest even if the board hadn't
enabled MTE by wiring up the tag RAM. This meant that if the guest
then tried to use MTE QEMU would segfault accessing the
non-existent tag RAM:

    ==346473==ERROR: UndefinedBehaviorSanitizer: SEGV on unknown address (pc 0x55f328952a4a bp 0x00000213a400 sp 0x7f7871859b80 T346476)
    ==346473==The signal is caused by a READ memory access.
    ==346473==Hint: this fault was caused by a dereference of a high value address (see register values below).  Disassemble the provided pc to learn which register was used.
        #0 0x55f328952a4a in address_space_to_flatview /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/include/exec/memory.h:1108:12
        #1 0x55f328952a4a in address_space_translate /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/include/exec/memory.h:2797:31
        #2 0x55f328952a4a in allocation_tag_mem /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../target/arm/tcg/mte_helper.c:176:10
        #3 0x55f32895366c in helper_stgm /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../target/arm/tcg/mte_helper.c:461:15
        #4 0x7f782431a293  (<unknown module>)

It's also not clear that the KVM logic is correct either:
MTE defaults to on there, rather than being only on if the
board wants it on.

Revert the whole commit for now so we can sort out the issues.

(We didn't catch this in CI because we have no test cases in
avocado that use guests with MTE support.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Richard, do you want to apply this to master as a buildfix?
---
 target/arm/cpu.h     |  4 ---
 target/arm/kvm_arm.h | 19 ------------
 hw/arm/virt.c        | 73 +++++++++++++++++++-------------------------
 target/arm/cpu.c     |  9 +++---
 target/arm/kvm.c     | 35 ---------------------
 target/arm/kvm64.c   |  5 ---
 6 files changed, 36 insertions(+), 109 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c3463e39bcd..d469a2637b3 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -935,9 +935,6 @@ struct ArchCPU {
      */
     uint32_t psci_conduit;
 
-    /* CPU has Memory Tag Extension */
-    bool has_mte;
-
     /* For v8M, initial value of the Secure VTOR */
     uint32_t init_svtor;
     /* For v8M, initial value of the Non-secure VTOR */
@@ -1056,7 +1053,6 @@ struct ArchCPU {
     bool prop_pauth;
     bool prop_pauth_impdef;
     bool prop_lpa2;
-    OnOffAuto prop_mte;
 
     /* DCZ blocksize, in log_2(words), ie low 4 bits of DCZID_EL0 */
     uint32_t dcz_blocksize;
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 2083547bf60..330fbe5c722 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -313,13 +313,6 @@ bool kvm_arm_pmu_supported(void);
  */
 bool kvm_arm_sve_supported(void);
 
-/**
- * kvm_arm_mte_supported:
- *
- * Returns: true if KVM can enable MTE, and false otherwise.
- */
-bool kvm_arm_mte_supported(void);
-
 /**
  * kvm_arm_get_max_vm_ipa_size:
  * @ms: Machine state handle
@@ -384,8 +377,6 @@ void kvm_arm_pvtime_init(CPUState *cs, uint64_t ipa);
 
 int kvm_arm_set_irq(int cpu, int irqtype, int irq, int level);
 
-void kvm_arm_enable_mte(Object *cpuobj, Error **errp);
-
 #else
 
 /*
@@ -412,11 +403,6 @@ static inline bool kvm_arm_steal_time_supported(void)
     return false;
 }
 
-static inline bool kvm_arm_mte_supported(void)
-{
-    return false;
-}
-
 /*
  * These functions should never actually be called without KVM support.
  */
@@ -465,11 +451,6 @@ static inline uint32_t kvm_arm_sve_get_vls(CPUState *cs)
     g_assert_not_reached();
 }
 
-static inline void kvm_arm_enable_mte(Object *cpuobj, Error **errp)
-{
-    g_assert_not_reached();
-}
-
 #endif
 
 static inline const char *gic_class_name(void)
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 06b514b25c3..b99ae185016 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2146,7 +2146,7 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
-    if (vms->mte && hvf_enabled()) {
+    if (vms->mte && (kvm_enabled() || hvf_enabled())) {
         error_report("mach-virt: %s does not support providing "
                      "MTE to the guest CPU",
                      current_accel_name());
@@ -2216,48 +2216,39 @@ static void machvirt_init(MachineState *machine)
         }
 
         if (vms->mte) {
-            if (tcg_enabled()) {
-                /* Create the memory region only once, but link to all cpus. */
-                if (!tag_sysmem) {
-                    /*
-                     * The property exists only if MemTag is supported.
-                     * If it is, we must allocate the ram to back that up.
-                     */
-                    if (!object_property_find(cpuobj, "tag-memory")) {
-                        error_report("MTE requested, but not supported "
-                                     "by the guest CPU");
-                        exit(1);
-                    }
-
-                    tag_sysmem = g_new(MemoryRegion, 1);
-                    memory_region_init(tag_sysmem, OBJECT(machine),
-                                       "tag-memory", UINT64_MAX / 32);
-
-                    if (vms->secure) {
-                        secure_tag_sysmem = g_new(MemoryRegion, 1);
-                        memory_region_init(secure_tag_sysmem, OBJECT(machine),
-                                           "secure-tag-memory",
-                                           UINT64_MAX / 32);
-
-                        /* As with ram, secure-tag takes precedence over tag. */
-                        memory_region_add_subregion_overlap(secure_tag_sysmem,
-                                                            0, tag_sysmem, -1);
-                    }
-                }
-
-                object_property_set_link(cpuobj, "tag-memory",
-                                         OBJECT(tag_sysmem), &error_abort);
-                if (vms->secure) {
-                    object_property_set_link(cpuobj, "secure-tag-memory",
-                                             OBJECT(secure_tag_sysmem),
-                                             &error_abort);
-                }
-            } else if (kvm_enabled()) {
-                if (!kvm_arm_mte_supported()) {
-                    error_report("MTE requested, but not supported by KVM");
+            /* Create the memory region only once, but link to all cpus. */
+            if (!tag_sysmem) {
+                /*
+                 * The property exists only if MemTag is supported.
+                 * If it is, we must allocate the ram to back that up.
+                 */
+                if (!object_property_find(cpuobj, "tag-memory")) {
+                    error_report("MTE requested, but not supported "
+                                 "by the guest CPU");
                     exit(1);
                 }
-                kvm_arm_enable_mte(cpuobj, &error_abort);
+
+                tag_sysmem = g_new(MemoryRegion, 1);
+                memory_region_init(tag_sysmem, OBJECT(machine),
+                                   "tag-memory", UINT64_MAX / 32);
+
+                if (vms->secure) {
+                    secure_tag_sysmem = g_new(MemoryRegion, 1);
+                    memory_region_init(secure_tag_sysmem, OBJECT(machine),
+                                       "secure-tag-memory", UINT64_MAX / 32);
+
+                    /* As with ram, secure-tag takes precedence over tag.  */
+                    memory_region_add_subregion_overlap(secure_tag_sysmem, 0,
+                                                        tag_sysmem, -1);
+                }
+            }
+
+            object_property_set_link(cpuobj, "tag-memory", OBJECT(tag_sysmem),
+                                     &error_abort);
+            if (vms->secure) {
+                object_property_set_link(cpuobj, "secure-tag-memory",
+                                         OBJECT(secure_tag_sysmem),
+                                         &error_abort);
             }
         }
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index f6a88e52ac2..5182ed0c911 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1480,7 +1480,6 @@ void arm_cpu_post_init(Object *obj)
                                      qdev_prop_allow_set_link_before_realize,
                                      OBJ_PROP_LINK_STRONG);
         }
-        cpu->has_mte = true;
     }
 #endif
 }
@@ -1617,7 +1616,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         }
         if (cpu->tag_memory) {
             error_setg(errp,
-                       "Cannot enable %s when guest CPUs has tag memory enabled",
+                       "Cannot enable %s when guest CPUs has MTE enabled",
                        current_accel_name());
             return;
         }
@@ -1997,10 +1996,10 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
 #ifndef CONFIG_USER_ONLY
-    if (!cpu->has_mte && cpu_isar_feature(aa64_mte, cpu)) {
+    if (cpu->tag_memory == NULL && cpu_isar_feature(aa64_mte, cpu)) {
         /*
-         * Disable the MTE feature bits if we do not have the feature
-         * setup by the machine.
+         * Disable the MTE feature bits if we do not have tag-memory
+         * provided by the machine.
          */
         cpu->isar.id_aa64pfr1 =
             FIELD_DP64(cpu->isar.id_aa64pfr1, ID_AA64PFR1, MTE, 0);
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 9553488ecd1..84da49332c4 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -31,7 +31,6 @@
 #include "hw/boards.h"
 #include "hw/irq.h"
 #include "qemu/log.h"
-#include "migration/blocker.h"
 
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_LAST_INFO
@@ -1065,37 +1064,3 @@ bool kvm_arch_cpu_check_are_resettable(void)
 void kvm_arch_accel_class_init(ObjectClass *oc)
 {
 }
-
-void kvm_arm_enable_mte(Object *cpuobj, Error **errp)
-{
-    static bool tried_to_enable;
-    static bool succeeded_to_enable;
-    Error *mte_migration_blocker = NULL;
-    int ret;
-
-    if (!tried_to_enable) {
-        /*
-         * MTE on KVM is enabled on a per-VM basis (and retrying doesn't make
-         * sense), and we only want a single migration blocker as well.
-         */
-        tried_to_enable = true;
-
-        ret = kvm_vm_enable_cap(kvm_state, KVM_CAP_ARM_MTE, 0);
-        if (ret) {
-            error_setg_errno(errp, -ret, "Failed to enable KVM_CAP_ARM_MTE");
-            return;
-        }
-
-        /* TODO: add proper migration support with MTE enabled */
-        error_setg(&mte_migration_blocker,
-                   "Live migration disabled due to MTE enabled");
-        if (migrate_add_blocker(mte_migration_blocker, errp)) {
-            error_free(mte_migration_blocker);
-            return;
-        }
-        succeeded_to_enable = true;
-    }
-    if (succeeded_to_enable) {
-        object_property_set_bool(cpuobj, "has_mte", true, NULL);
-    }
-}
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 1893f387936..810db33ccbd 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -756,11 +756,6 @@ bool kvm_arm_steal_time_supported(void)
     return kvm_check_extension(kvm_state, KVM_CAP_STEAL_TIME);
 }
 
-bool kvm_arm_mte_supported(void)
-{
-    return kvm_check_extension(kvm_state, KVM_CAP_ARM_MTE);
-}
-
 QEMU_BUILD_BUG_ON(KVM_ARM64_SVE_VQ_MIN != 1);
 
 uint32_t kvm_arm_sve_get_vls(CPUState *cs)
-- 
2.34.1


