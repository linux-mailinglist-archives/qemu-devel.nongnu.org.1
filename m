Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5809B0016
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Oct 2024 12:25:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4HSP-0003z0-UR; Fri, 25 Oct 2024 06:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1t4HSL-0003wX-RY
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 06:22:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1t4HSG-0000Rg-5n
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 06:22:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729851723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WasbB+l8Sq0E1hfncqKYkoiF7eukfetMDPKaKHIofd0=;
 b=eQP7YBYohLkYX/E1MjDdGAYffslMLAgWxJ/B5579URDh7TKWBY6b4vuTWSIlPl1ZyZyX5F
 D4fe3pzn2m26MDUIBKkzCSIUZeJXD5STHxTDzvno8VXDhmlHA9wJQPRDAEgznYVsJ+y1pE
 WlVh8/RpAP5DaG2P54LRnjivaWFr/hs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-534-Q9ZxuDlYMBW_Ha33cn8wwQ-1; Fri,
 25 Oct 2024 06:22:00 -0400
X-MC-Unique: Q9ZxuDlYMBW_Ha33cn8wwQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D1F419560B4; Fri, 25 Oct 2024 10:21:58 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.194.5])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CE159196BB7D; Fri, 25 Oct 2024 10:21:52 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvmarm@lists.linux.dev,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com
Cc: shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org,
 pbonzini@redhat.com
Subject: [RFC 16/21] arm/kvm: Allow reading all the writable ID registers
Date: Fri, 25 Oct 2024 12:17:35 +0200
Message-ID: <20241025101959.601048-17-eric.auger@redhat.com>
In-Reply-To: <20241025101959.601048-1-eric.auger@redhat.com>
References: <20241025101959.601048-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

At the moment kvm_arm_get_host_cpu_features() reads a subset of the
ID regs. As we want to introduce properties for all writable ID reg
fields, we want more genericity and read more default host register
values.

Introduce a new get_host_cpu_idregs() helper and add a new exhaustive
boolean parameter to kvm_arm_get_host_cpu_features() and
kvm_arm_set_cpu_features_from_host() to select the right behavior.
the host cpu model keeps the legacy behavior while the new custom
model will read the legacy regs plus all the writable ones. This
definitively brings some redundancy.

A writable_map IdRegMap is introduced in the CPU object. A subsequent
patch will populate it.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 target/arm/cpu.h        |  3 +++
 target/arm/kvm_arm.h    |  9 +++++--
 target/arm/cpu64.c      |  4 ++--
 target/arm/kvm.c        | 53 ++++++++++++++++++++++++++++++++++++++---
 target/arm/trace-events |  1 +
 5 files changed, 63 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 30b265e9b0..96c42ac410 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1045,6 +1045,9 @@ struct ArchCPU {
      */
     ARMIdRegsState writable_id_regs;
 
+    /* ID reg writable bitmask (KVM only) */
+    IdRegMap *writable_map;
+
     /* QOM property to indicate we should use the back-compat CNTFRQ default */
     bool backcompat_cntfrq;
 
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 9868065277..c2da1dffb2 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -143,8 +143,12 @@ uint32_t kvm_arm_sve_get_vls(ARMCPU *cpu);
  *
  * Set up the ARMCPU struct fields up to match the information probed
  * from the host CPU.
+ *
+ * @cpu: cpu object
+ * @exhaustive: if true, all the feature ID regs are queried instead of
+ *              a subset
  */
-void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu);
+void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu, bool exhaustive);
 
 /**
  * kvm_arm_add_vcpu_properties:
@@ -245,7 +249,8 @@ static inline int kvm_arm_get_writable_id_regs(ARMCPU *cpu, IdRegMap *idregmap)
 /*
  * These functions should never actually be called without KVM support.
  */
-static inline void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
+static inline void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu,
+                                                      bool exhaustive)
 {
     g_assert_not_reached();
 }
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 9f20886668..86b0797d4b 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -710,14 +710,14 @@ static void aarch64_host_initfn(Object *obj)
 {
 #if defined(CONFIG_KVM)
     ARMCPU *cpu = ARM_CPU(obj);
-    kvm_arm_set_cpu_features_from_host(cpu);
+    kvm_arm_set_cpu_features_from_host(cpu, false);
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
         aarch64_add_sve_properties(obj);
         aarch64_add_pauth_properties(obj);
     }
 #elif defined(CONFIG_HVF)
     ARMCPU *cpu = ARM_CPU(obj);
-    hvf_arm_set_cpu_features_from_host(cpu);
+    hvf_arm_set_cpu_features_from_host(cpu, false);
     aarch64_add_pauth_properties(obj);
 #else
     g_assert_not_reached();
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index bd53554832..a0daf4c382 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -40,6 +40,7 @@
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/ghes.h"
 #include "target/arm/gtimer.h"
+#include "cpu-custom.h"
 
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_LAST_INFO
@@ -255,8 +256,49 @@ static int get_host_cpu_reg64(int fd, ARMHostCPUFeatures *ahcf, ARMSysReg sr)
     return ret;
 }
 
+/*
+ * get_host_cpu_idregs: Read all the writable ID reg host values
+ *
+ * Need to be called once the writable mask has been populated
+ * Note we may want to read all the known id regs but some of them are not
+ * writable and return an error, hence the choice of reading only those which
+ * are writable. Those are aslo readable!
+ */
+static int get_host_cpu_idregs(ARMCPU *cpu, int fd, ARMHostCPUFeatures *ahcf)
+{
+    int err = 0;
+    int i;
 
-static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
+    for (i = 0; i < NR_ID_REGS; i++) {
+        ARM64SysReg *sysregdesc = &arm64_id_regs[i];
+        ARMSysReg *sysreg = sysregdesc->sysreg;
+        uint64_t writable_mask = cpu->writable_map->regs[i];
+        uint64_t *reg;
+        int ret;
+
+        if (!sysreg || !writable_mask) {
+            continue;
+        }
+
+        reg = &ahcf->isar.idregs.regs[i];
+        ret = read_sys_reg64(fd, reg,
+                             ARM64_SYS_REG(sysreg->op0, sysreg->op1,
+                                           sysreg->crn, sysreg->crm,
+                                           sysreg->op2));
+        trace_get_host_cpu_idregs(sysregdesc->name, *reg);
+        if (ret) {
+            error_report("%s error reading value of host %s register (%m)",
+                         __func__, sysregdesc->name);
+
+            err = ret;
+        }
+    }
+    return err;
+}
+
+static bool
+kvm_arm_get_host_cpu_features(ARMCPU *cpu, ARMHostCPUFeatures *ahcf,
+                              bool exhaustive)
 {
     /* Identify the feature bits corresponding to the host CPU, and
      * fill out the ARMHostCPUClass fields accordingly. To do this
@@ -383,6 +425,11 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         err |= get_host_cpu_reg32(fd, ahcf, SYS_ID_DFR1_EL1);
         err |= get_host_cpu_reg32(fd, ahcf, SYS_ID_MMFR5_EL1);
 
+        /* Make sure writable ID reg values are read */
+        if (exhaustive) {
+            err |= get_host_cpu_idregs(cpu, fd, ahcf);
+        }
+
         /*
          * DBGDIDR is a bit complicated because the kernel doesn't
          * provide an accessor for it in 64-bit mode, which is what this
@@ -453,13 +500,13 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     return true;
 }
 
-void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
+void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu, bool exhaustive)
 {
     CPUARMState *env = &cpu->env;
 
     if (!arm_host_cpu_features.dtb_compatible) {
         if (!kvm_enabled() ||
-            !kvm_arm_get_host_cpu_features(&arm_host_cpu_features)) {
+            !kvm_arm_get_host_cpu_features(cpu, &arm_host_cpu_features, exhaustive)) {
             /* We can't report this error yet, so flag that we need to
              * in arm_cpu_realizefn().
              */
diff --git a/target/arm/trace-events b/target/arm/trace-events
index 4438dce7be..0df3bfafff 100644
--- a/target/arm/trace-events
+++ b/target/arm/trace-events
@@ -13,3 +13,4 @@ arm_gt_update_irq(int timer, int irqstate) "gt_update_irq: timer %d irqstate %d"
 
 # kvm.c
 kvm_arm_fixup_msi_route(uint64_t iova, uint64_t gpa) "MSI iova = 0x%"PRIx64" is translated into 0x%"PRIx64
+get_host_cpu_idregs(const char *name, uint64_t value) "scratch vcpu gost value for %s is 0x%"PRIx64
-- 
2.41.0


