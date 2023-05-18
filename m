Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA3D7081E5
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 14:55:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzd6R-0004Bf-T3; Thu, 18 May 2023 08:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd6C-00048m-Tm
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:19 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd68-0007x6-Bg
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:14 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-30636edb493so826487f8f.1
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 05:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684414271; x=1687006271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Dvb2oduGiED8gUe4k3v43syGsJCxTmuhvJjtOtVniqQ=;
 b=qHAX684DAkLm9UkP5iMjLsWMrJyhH4x7Ot0R68kYSaDCpeHl6Cfl5CbJ94Rd/QHxo7
 EJUDkRM9lr4VZgFoZH3vemczu07jP7rKKe/K5pC36cCfjkpP3khksPIlb/or3RfsYvlL
 uva5EBpYlAwQPg+57x/njYHpOETXxHWMlvHfIMo3ARXGSx4vaf8CKGmqXSTZS1jL3uQX
 jgRv6/YEP/E8Wrc9QBVgaQKcl8BBJ4ayhXOrcz+1Gx0QWVYKpyd/T0SJWQIGuuKA3wIj
 1zRyAZVhEYceezrhavOAWEP6NFjpCAW8y7yvrlqzweydjMbW9nFqB/qhvQH/6y2rpYbA
 gOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684414271; x=1687006271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dvb2oduGiED8gUe4k3v43syGsJCxTmuhvJjtOtVniqQ=;
 b=BI0zy/tW3iBtarTQRIarrTzWg1w1vo2Uz4dGUrV1QFQu+oImxeHRhbe6+pRTLGQZWW
 cTvu1Kc/34K4lZhEgSRLbj/mmd/f3vft5BXa71NctOdrYl8cv+HXj4yZpFaft0nMJlja
 6MAsPiRp75IK176tcaCkLA66IlIsNTMlDLUTPnhaTxHy9QGYgsyHMpAMhel+OvaymlsM
 L4yJKDgGDRBVo/7xpKEObnYfJ9CmJVUwtnS7MSKYPNsa3MEKPsIHXjK0xvS38O/TqJHO
 zCkSfgWZ/54yfj6TxsXmkWi3mlHwTjCSZPTEVg/iT5myi9b3XK4Es1t436hUTU6k2X5g
 SSJg==
X-Gm-Message-State: AC+VfDxheuzf481K27cCtRXlvrN5nfW20ztY6OMvyk8nJq2CzlB478qr
 LhdRbrzoIQQ6HxZHtfDYlpAkVmDemaB/jqc5yT0=
X-Google-Smtp-Source: ACHHUZ7C1KL/Eme44iEShD6KN0VpK1bIHJ2YWNfVZoPlGsYzoRNFZ3bGqMX7c5uQ3eesGcoNxSA+iQ==
X-Received: by 2002:adf:ebc6:0:b0:309:4ece:a412 with SMTP id
 v6-20020adfebc6000000b003094ecea412mr647906wrn.14.1684414270657; 
 Thu, 18 May 2023 05:51:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z21-20020a1c4c15000000b003f42d2f4531sm5201321wmf.48.2023.05.18.05.51.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 05:51:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/29] arm/kvm: add support for MTE
Date: Thu, 18 May 2023 13:50:42 +0100
Message-Id: <20230518125107.146421-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518125107.146421-1-peter.maydell@linaro.org>
References: <20230518125107.146421-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

From: Cornelia Huck <cohuck@redhat.com>

Extend the 'mte' property for the virt machine to cover KVM as
well. For KVM, we don't allocate tag memory, but instead enable the
capability.

If MTE has been enabled, we need to disable migration, as we do not
yet have a way to migrate the tags as well. Therefore, MTE will stay
off with KVM unless requested explicitly.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230428095533.21747-2-cohuck@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h     |  4 +++
 target/arm/kvm_arm.h | 19 ++++++++++++
 hw/arm/virt.c        | 73 +++++++++++++++++++++++++-------------------
 target/arm/cpu.c     |  9 +++---
 target/arm/kvm.c     | 35 +++++++++++++++++++++
 target/arm/kvm64.c   |  5 +++
 6 files changed, 109 insertions(+), 36 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d469a2637b3..c3463e39bcd 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -935,6 +935,9 @@ struct ArchCPU {
      */
     uint32_t psci_conduit;
 
+    /* CPU has Memory Tag Extension */
+    bool has_mte;
+
     /* For v8M, initial value of the Secure VTOR */
     uint32_t init_svtor;
     /* For v8M, initial value of the Non-secure VTOR */
@@ -1053,6 +1056,7 @@ struct ArchCPU {
     bool prop_pauth;
     bool prop_pauth_impdef;
     bool prop_lpa2;
+    OnOffAuto prop_mte;
 
     /* DCZ blocksize, in log_2(words), ie low 4 bits of DCZID_EL0 */
     uint32_t dcz_blocksize;
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 330fbe5c722..2083547bf60 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -313,6 +313,13 @@ bool kvm_arm_pmu_supported(void);
  */
 bool kvm_arm_sve_supported(void);
 
+/**
+ * kvm_arm_mte_supported:
+ *
+ * Returns: true if KVM can enable MTE, and false otherwise.
+ */
+bool kvm_arm_mte_supported(void);
+
 /**
  * kvm_arm_get_max_vm_ipa_size:
  * @ms: Machine state handle
@@ -377,6 +384,8 @@ void kvm_arm_pvtime_init(CPUState *cs, uint64_t ipa);
 
 int kvm_arm_set_irq(int cpu, int irqtype, int irq, int level);
 
+void kvm_arm_enable_mte(Object *cpuobj, Error **errp);
+
 #else
 
 /*
@@ -403,6 +412,11 @@ static inline bool kvm_arm_steal_time_supported(void)
     return false;
 }
 
+static inline bool kvm_arm_mte_supported(void)
+{
+    return false;
+}
+
 /*
  * These functions should never actually be called without KVM support.
  */
@@ -451,6 +465,11 @@ static inline uint32_t kvm_arm_sve_get_vls(CPUState *cs)
     g_assert_not_reached();
 }
 
+static inline void kvm_arm_enable_mte(Object *cpuobj, Error **errp)
+{
+    g_assert_not_reached();
+}
+
 #endif
 
 static inline const char *gic_class_name(void)
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index b99ae185016..06b514b25c3 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2146,7 +2146,7 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
-    if (vms->mte && (kvm_enabled() || hvf_enabled())) {
+    if (vms->mte && hvf_enabled()) {
         error_report("mach-virt: %s does not support providing "
                      "MTE to the guest CPU",
                      current_accel_name());
@@ -2216,39 +2216,48 @@ static void machvirt_init(MachineState *machine)
         }
 
         if (vms->mte) {
-            /* Create the memory region only once, but link to all cpus. */
-            if (!tag_sysmem) {
-                /*
-                 * The property exists only if MemTag is supported.
-                 * If it is, we must allocate the ram to back that up.
-                 */
-                if (!object_property_find(cpuobj, "tag-memory")) {
-                    error_report("MTE requested, but not supported "
-                                 "by the guest CPU");
+            if (tcg_enabled()) {
+                /* Create the memory region only once, but link to all cpus. */
+                if (!tag_sysmem) {
+                    /*
+                     * The property exists only if MemTag is supported.
+                     * If it is, we must allocate the ram to back that up.
+                     */
+                    if (!object_property_find(cpuobj, "tag-memory")) {
+                        error_report("MTE requested, but not supported "
+                                     "by the guest CPU");
+                        exit(1);
+                    }
+
+                    tag_sysmem = g_new(MemoryRegion, 1);
+                    memory_region_init(tag_sysmem, OBJECT(machine),
+                                       "tag-memory", UINT64_MAX / 32);
+
+                    if (vms->secure) {
+                        secure_tag_sysmem = g_new(MemoryRegion, 1);
+                        memory_region_init(secure_tag_sysmem, OBJECT(machine),
+                                           "secure-tag-memory",
+                                           UINT64_MAX / 32);
+
+                        /* As with ram, secure-tag takes precedence over tag. */
+                        memory_region_add_subregion_overlap(secure_tag_sysmem,
+                                                            0, tag_sysmem, -1);
+                    }
+                }
+
+                object_property_set_link(cpuobj, "tag-memory",
+                                         OBJECT(tag_sysmem), &error_abort);
+                if (vms->secure) {
+                    object_property_set_link(cpuobj, "secure-tag-memory",
+                                             OBJECT(secure_tag_sysmem),
+                                             &error_abort);
+                }
+            } else if (kvm_enabled()) {
+                if (!kvm_arm_mte_supported()) {
+                    error_report("MTE requested, but not supported by KVM");
                     exit(1);
                 }
-
-                tag_sysmem = g_new(MemoryRegion, 1);
-                memory_region_init(tag_sysmem, OBJECT(machine),
-                                   "tag-memory", UINT64_MAX / 32);
-
-                if (vms->secure) {
-                    secure_tag_sysmem = g_new(MemoryRegion, 1);
-                    memory_region_init(secure_tag_sysmem, OBJECT(machine),
-                                       "secure-tag-memory", UINT64_MAX / 32);
-
-                    /* As with ram, secure-tag takes precedence over tag.  */
-                    memory_region_add_subregion_overlap(secure_tag_sysmem, 0,
-                                                        tag_sysmem, -1);
-                }
-            }
-
-            object_property_set_link(cpuobj, "tag-memory", OBJECT(tag_sysmem),
-                                     &error_abort);
-            if (vms->secure) {
-                object_property_set_link(cpuobj, "secure-tag-memory",
-                                         OBJECT(secure_tag_sysmem),
-                                         &error_abort);
+                kvm_arm_enable_mte(cpuobj, &error_abort);
             }
         }
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 5182ed0c911..f6a88e52ac2 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1480,6 +1480,7 @@ void arm_cpu_post_init(Object *obj)
                                      qdev_prop_allow_set_link_before_realize,
                                      OBJ_PROP_LINK_STRONG);
         }
+        cpu->has_mte = true;
     }
 #endif
 }
@@ -1616,7 +1617,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         }
         if (cpu->tag_memory) {
             error_setg(errp,
-                       "Cannot enable %s when guest CPUs has MTE enabled",
+                       "Cannot enable %s when guest CPUs has tag memory enabled",
                        current_accel_name());
             return;
         }
@@ -1996,10 +1997,10 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
 #ifndef CONFIG_USER_ONLY
-    if (cpu->tag_memory == NULL && cpu_isar_feature(aa64_mte, cpu)) {
+    if (!cpu->has_mte && cpu_isar_feature(aa64_mte, cpu)) {
         /*
-         * Disable the MTE feature bits if we do not have tag-memory
-         * provided by the machine.
+         * Disable the MTE feature bits if we do not have the feature
+         * setup by the machine.
          */
         cpu->isar.id_aa64pfr1 =
             FIELD_DP64(cpu->isar.id_aa64pfr1, ID_AA64PFR1, MTE, 0);
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 84da49332c4..9553488ecd1 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -31,6 +31,7 @@
 #include "hw/boards.h"
 #include "hw/irq.h"
 #include "qemu/log.h"
+#include "migration/blocker.h"
 
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_LAST_INFO
@@ -1064,3 +1065,37 @@ bool kvm_arch_cpu_check_are_resettable(void)
 void kvm_arch_accel_class_init(ObjectClass *oc)
 {
 }
+
+void kvm_arm_enable_mte(Object *cpuobj, Error **errp)
+{
+    static bool tried_to_enable;
+    static bool succeeded_to_enable;
+    Error *mte_migration_blocker = NULL;
+    int ret;
+
+    if (!tried_to_enable) {
+        /*
+         * MTE on KVM is enabled on a per-VM basis (and retrying doesn't make
+         * sense), and we only want a single migration blocker as well.
+         */
+        tried_to_enable = true;
+
+        ret = kvm_vm_enable_cap(kvm_state, KVM_CAP_ARM_MTE, 0);
+        if (ret) {
+            error_setg_errno(errp, -ret, "Failed to enable KVM_CAP_ARM_MTE");
+            return;
+        }
+
+        /* TODO: add proper migration support with MTE enabled */
+        error_setg(&mte_migration_blocker,
+                   "Live migration disabled due to MTE enabled");
+        if (migrate_add_blocker(mte_migration_blocker, errp)) {
+            error_free(mte_migration_blocker);
+            return;
+        }
+        succeeded_to_enable = true;
+    }
+    if (succeeded_to_enable) {
+        object_property_set_bool(cpuobj, "has_mte", true, NULL);
+    }
+}
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 810db33ccbd..1893f387936 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -756,6 +756,11 @@ bool kvm_arm_steal_time_supported(void)
     return kvm_check_extension(kvm_state, KVM_CAP_STEAL_TIME);
 }
 
+bool kvm_arm_mte_supported(void)
+{
+    return kvm_check_extension(kvm_state, KVM_CAP_ARM_MTE);
+}
+
 QEMU_BUILD_BUG_ON(KVM_ARM64_SVE_VQ_MIN != 1);
 
 uint32_t kvm_arm_sve_get_vls(CPUState *cs)
-- 
2.34.1


