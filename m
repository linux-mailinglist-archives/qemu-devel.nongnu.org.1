Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DD4A82860
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Apr 2025 16:46:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2WfK-0000IG-PV; Wed, 09 Apr 2025 10:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1u2WfI-0000Hk-LY
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 10:44:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1u2WfF-0006JS-Vv
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 10:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744209869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KU8KYAO7LjeMrOIdyYve4QFQjpBPq5keKiNjt2jq/Xk=;
 b=MiZZiMiE4Az7rvj8xEC7HutsWKr17BD0QHFPiFcydk0fwlklGy/f0xEkBBdG5oRWzFbfw6
 aQSGW1boj0oJmaUcazZdwDMp78iRraPKdI47cvoJf9UdwfiwgqWcMYzRHI4TSp5GvQtVtT
 iTEPx667pc3lmN/SG91TIEgriHkS/dw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-givgGwG3P2mR--1Fqar0PQ-1; Wed,
 09 Apr 2025 10:44:25 -0400
X-MC-Unique: givgGwG3P2mR--1Fqar0PQ-1
X-Mimecast-MFC-AGG-ID: givgGwG3P2mR--1Fqar0PQ_1744209863
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D5D2519560BE; Wed,  9 Apr 2025 14:44:22 +0000 (UTC)
Received: from gondolin.redhat.com (unknown [10.45.227.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DA5A3180B48E; Wed,  9 Apr 2025 14:44:16 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 oliver.upton@linux.dev, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com,
 agraf@csgraf.de
Cc: shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org,
 pbonzini@redhat.com, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH for-10.1 v5 10/13] arm/cpu: Store id_dfr0/1 into the idregs
 array
Date: Wed,  9 Apr 2025 16:43:01 +0200
Message-ID: <20250409144304.912325-11-cohuck@redhat.com>
In-Reply-To: <20250409144304.912325-1-cohuck@redhat.com>
References: <20250409144304.912325-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.505,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Sebastian Ott <sebott@redhat.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/intc/armv7m_nvic.c     |  2 +-
 target/arm/cpu-features.h | 16 ++++++++--------
 target/arm/cpu.c          | 13 +++++--------
 target/arm/cpu.h          |  2 --
 target/arm/cpu64.c        |  4 ++--
 target/arm/helper.c       |  4 ++--
 target/arm/kvm.c          |  6 ++----
 target/arm/tcg/cpu-v7m.c  | 12 ++++++------
 target/arm/tcg/cpu32.c    | 30 ++++++++++++++----------------
 target/arm/tcg/cpu64.c    | 16 ++++++++--------
 10 files changed, 48 insertions(+), 57 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 407933eaf42e..7f42803fef7c 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1274,7 +1274,7 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
         if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
             goto bad_offset;
         }
-        return cpu->isar.id_dfr0;
+        return GET_IDREG(isar, ID_DFR0);
     case 0xd4c: /* AFR0.  */
         if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
             goto bad_offset;
diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 156130085067..cad34f0ad403 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -299,22 +299,22 @@ static inline bool isar_feature_aa32_ats1e1(const ARMISARegisters *id)
 static inline bool isar_feature_aa32_pmuv3p1(const ARMISARegisters *id)
 {
     /* 0xf means "non-standard IMPDEF PMU" */
-    return FIELD_EX32(id->id_dfr0, ID_DFR0, PERFMON) >= 4 &&
-        FIELD_EX32(id->id_dfr0, ID_DFR0, PERFMON) != 0xf;
+    return FIELD_EX32_IDREG(id, ID_DFR0, PERFMON) >= 4 &&
+        FIELD_EX32_IDREG(id, ID_DFR0, PERFMON) != 0xf;
 }
 
 static inline bool isar_feature_aa32_pmuv3p4(const ARMISARegisters *id)
 {
     /* 0xf means "non-standard IMPDEF PMU" */
-    return FIELD_EX32(id->id_dfr0, ID_DFR0, PERFMON) >= 5 &&
-        FIELD_EX32(id->id_dfr0, ID_DFR0, PERFMON) != 0xf;
+    return FIELD_EX32_IDREG(id, ID_DFR0, PERFMON) >= 5 &&
+        FIELD_EX32_IDREG(id, ID_DFR0, PERFMON) != 0xf;
 }
 
 static inline bool isar_feature_aa32_pmuv3p5(const ARMISARegisters *id)
 {
     /* 0xf means "non-standard IMPDEF PMU" */
-    return FIELD_EX32(id->id_dfr0, ID_DFR0, PERFMON) >= 6 &&
-        FIELD_EX32(id->id_dfr0, ID_DFR0, PERFMON) != 0xf;
+    return FIELD_EX32_IDREG(id, ID_DFR0, PERFMON) >= 6 &&
+        FIELD_EX32_IDREG(id, ID_DFR0, PERFMON) != 0xf;
 }
 
 static inline bool isar_feature_aa32_hpd(const ARMISARegisters *id)
@@ -359,12 +359,12 @@ static inline bool isar_feature_aa32_ssbs(const ARMISARegisters *id)
 
 static inline bool isar_feature_aa32_debugv7p1(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_dfr0, ID_DFR0, COPDBG) >= 5;
+    return FIELD_EX32_IDREG(id, ID_DFR0, COPDBG) >= 5;
 }
 
 static inline bool isar_feature_aa32_debugv8p2(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_dfr0, ID_DFR0, COPDBG) >= 8;
+    return FIELD_EX32_IDREG(id, ID_DFR0, COPDBG) >= 8;
 }
 
 static inline bool isar_feature_aa32_doublelock(const ARMISARegisters *id)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 51027e279f5f..a3de5ee2b19c 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2324,7 +2324,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
          * feature registers as well.
          */
         FIELD_DP32_IDREG(isar, ID_PFR1, SECURITY, 0);
-        cpu->isar.id_dfr0 = FIELD_DP32(cpu->isar.id_dfr0, ID_DFR0, COPSDBG, 0);
+        FIELD_DP32_IDREG(isar, ID_DFR0, COPSDBG, 0);
         FIELD_DP64_IDREG(isar, ID_AA64PFR0, EL3, 0);
 
         /* Disable the realm management extension, which requires EL3. */
@@ -2352,7 +2352,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 #endif
     } else {
         FIELD_DP64_IDREG(isar, ID_AA64DFR0, PMUVER, 0);
-        cpu->isar.id_dfr0 = FIELD_DP32(cpu->isar.id_dfr0, ID_DFR0, PERFMON, 0);
+        FIELD_DP32_IDREG(isar, ID_DFR0, PERFMON, 0);
         cpu->pmceid0 = 0;
         cpu->pmceid1 = 0;
     }
@@ -2415,15 +2415,12 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         FIELD_DP64_IDREG(isar, ID_AA64DFR0, TRACEBUFFER, 0);
         /* FEAT_TRF (Self-hosted Trace Extension) */
         FIELD_DP64_IDREG(isar, ID_AA64DFR0, TRACEFILT, 0);
-        cpu->isar.id_dfr0 =
-            FIELD_DP32(cpu->isar.id_dfr0, ID_DFR0, TRACEFILT, 0);
+        FIELD_DP32_IDREG(isar, ID_DFR0, TRACEFILT, 0);
         /* Trace Macrocell system register access */
         FIELD_DP64_IDREG(isar, ID_AA64DFR0, TRACEVER, 0);
-        cpu->isar.id_dfr0 =
-            FIELD_DP32(cpu->isar.id_dfr0, ID_DFR0, COPTRC, 0);
+        FIELD_DP32_IDREG(isar, ID_DFR0, COPTRC, 0);
         /* Memory mapped trace */
-        cpu->isar.id_dfr0 =
-            FIELD_DP32(cpu->isar.id_dfr0, ID_DFR0, MMAPTRC, 0);
+        FIELD_DP32_IDREG(isar, ID_DFR0, MMAPTRC, 0);
         /* FEAT_AMU (Activity Monitors Extension) */
         FIELD_DP64_IDREG(isar, ID_AA64PFR0, AMU, 0);
         FIELD_DP32_IDREG(isar, ID_PFR0, AMU, 0);
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 3d68938c2893..496c7f9a3ce7 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1082,8 +1082,6 @@ struct ArchCPU {
         uint32_t mvfr0;
         uint32_t mvfr1;
         uint32_t mvfr2;
-        uint32_t id_dfr0;
-        uint32_t id_dfr1;
         uint32_t dbgdidr;
         uint32_t dbgdevid;
         uint32_t dbgdevid1;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index a35acf63aef7..292d09fb8e9b 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -654,7 +654,7 @@ static void aarch64_a57_initfn(Object *obj)
     cpu->reset_sctlr = 0x00c50838;
     SET_IDREG(isar, ID_PFR0, 0x00000131);
     SET_IDREG(isar, ID_PFR1, 0x00011011);
-    cpu->isar.id_dfr0 = 0x03010066;
+    SET_IDREG(isar, ID_DFR0, 0x03010066);
     cpu->id_afr0 = 0x00000000;
     cpu->isar.id_mmfr0 = 0x10101105;
     cpu->isar.id_mmfr1 = 0x40000000;
@@ -716,7 +716,7 @@ static void aarch64_a53_initfn(Object *obj)
     cpu->reset_sctlr = 0x00c50838;
     SET_IDREG(isar, ID_PFR0, 0x00000131);
     SET_IDREG(isar, ID_PFR1, 0x00011011);
-    cpu->isar.id_dfr0 = 0x03010066;
+    SET_IDREG(isar, ID_DFR0, 0x03010066);
     cpu->id_afr0 = 0x00000000;
     cpu->isar.id_mmfr0 = 0x10101105;
     cpu->isar.id_mmfr1 = 0x40000000;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 86f21ad2a18c..69e9e681d21d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7798,7 +7798,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa32_tid3,
-              .resetvalue = cpu->isar.id_dfr0 },
+              .resetvalue = GET_IDREG(isar, ID_DFR0)},
             { .name = "ID_AFR0", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
@@ -8133,7 +8133,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = cpu->isar.id_dfr1 },
+              .resetvalue = GET_IDREG(isar, ID_DFR1)},
             { .name = "ID_MMFR5", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 6,
               .access = PL1_R, .type = ARM_CP_CONST,
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 91610d45aef8..1f7b8d40f002 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -373,8 +373,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
          */
         err |= get_host_cpu_reg(fd, ahcf, ID_AA64PFR0_EL1_IDX);
         err |= get_host_cpu_reg(fd, ahcf, ID_AA64PFR1_EL1_IDX);
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_dfr0,
-                              ARM64_SYS_REG(3, 0, 0, 1, 2));
+        err |= get_host_cpu_reg(fd, ahcf, ID_DFR0_EL1_IDX);
         err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr0,
                               ARM64_SYS_REG(3, 0, 0, 1, 4));
         err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr1,
@@ -400,8 +399,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         err |= read_sys_reg32(fdarray[2], &ahcf->isar.mvfr2,
                               ARM64_SYS_REG(3, 0, 0, 3, 2));
         err |= get_host_cpu_reg(fd, ahcf, ID_PFR2_EL1_IDX);
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_dfr1,
-                              ARM64_SYS_REG(3, 0, 0, 3, 5));
+        err |= get_host_cpu_reg(fd, ahcf, ID_DFR1_EL1_IDX);
         err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr5,
                               ARM64_SYS_REG(3, 0, 0, 3, 6));
 
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index aa86fdd528f4..eb4e9653bfb6 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -61,7 +61,7 @@ static void cortex_m0_initfn(Object *obj)
      */
     SET_IDREG(isar, ID_PFR0, 0x00000030);
     SET_IDREG(isar, ID_PFR1, 0x00000200);
-    cpu->isar.id_dfr0 = 0x00100000;
+    SET_IDREG(isar, ID_DFR0, 0x00100000);
     cpu->id_afr0 = 0x00000000;
     cpu->isar.id_mmfr0 = 0x00000030;
     cpu->isar.id_mmfr1 = 0x00000000;
@@ -87,7 +87,7 @@ static void cortex_m3_initfn(Object *obj)
     cpu->pmsav7_dregion = 8;
     SET_IDREG(isar, ID_PFR0, 0x00000030);
     SET_IDREG(isar, ID_PFR1, 0x00000200);
-    cpu->isar.id_dfr0 = 0x00100000;
+    SET_IDREG(isar, ID_DFR0, 0x00100000);
     cpu->id_afr0 = 0x00000000;
     cpu->isar.id_mmfr0 = 0x00000030;
     cpu->isar.id_mmfr1 = 0x00000000;
@@ -118,7 +118,7 @@ static void cortex_m4_initfn(Object *obj)
     cpu->isar.mvfr2 = 0x00000000;
     SET_IDREG(isar, ID_PFR0, 0x00000030);
     SET_IDREG(isar, ID_PFR1, 0x00000200);
-    cpu->isar.id_dfr0 = 0x00100000;
+    SET_IDREG(isar, ID_DFR0, 0x00100000);
     cpu->id_afr0 = 0x00000000;
     cpu->isar.id_mmfr0 = 0x00000030;
     cpu->isar.id_mmfr1 = 0x00000000;
@@ -149,7 +149,7 @@ static void cortex_m7_initfn(Object *obj)
     cpu->isar.mvfr2 = 0x00000040;
     SET_IDREG(isar, ID_PFR0, 0x00000030);
     SET_IDREG(isar, ID_PFR1, 0x00000200);
-    cpu->isar.id_dfr0 = 0x00100000;
+    SET_IDREG(isar, ID_DFR0, 0x00100000);
     cpu->id_afr0 = 0x00000000;
     cpu->isar.id_mmfr0 = 0x00100030;
     cpu->isar.id_mmfr1 = 0x00000000;
@@ -182,7 +182,7 @@ static void cortex_m33_initfn(Object *obj)
     cpu->isar.mvfr2 = 0x00000040;
     SET_IDREG(isar, ID_PFR0, 0x00000030);
     SET_IDREG(isar, ID_PFR1, 0x00000210);
-    cpu->isar.id_dfr0 = 0x00200000;
+    SET_IDREG(isar, ID_DFR0, 0x00200000);
     cpu->id_afr0 = 0x00000000;
     cpu->isar.id_mmfr0 = 0x00101F40;
     cpu->isar.id_mmfr1 = 0x00000000;
@@ -220,7 +220,7 @@ static void cortex_m55_initfn(Object *obj)
     cpu->isar.mvfr2 = 0x00000040;
     SET_IDREG(isar, ID_PFR0, 0x20000030);
     SET_IDREG(isar, ID_PFR1, 0x00000230);
-    cpu->isar.id_dfr0 = 0x10200000;
+    SET_IDREG(isar, ID_DFR0, 0x10200000);
     cpu->id_afr0 = 0x00000000;
     cpu->isar.id_mmfr0 = 0x00111040;
     cpu->isar.id_mmfr1 = 0x00000000;
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index dcc3064ebb86..191b602c8c65 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -82,11 +82,11 @@ void aa32_max_features(ARMCPU *cpu)
     t = FIELD_DP32(t, ID_PFR2, SSBS, 1);          /* FEAT_SSBS */
     SET_IDREG(isar, ID_PFR2, t);
 
-    t = cpu->isar.id_dfr0;
+    t = GET_IDREG(isar, ID_DFR0);
     t = FIELD_DP32(t, ID_DFR0, COPDBG, 10);       /* FEAT_Debugv8p8 */
     t = FIELD_DP32(t, ID_DFR0, COPSDBG, 10);      /* FEAT_Debugv8p8 */
     t = FIELD_DP32(t, ID_DFR0, PERFMON, 6);       /* FEAT_PMUv3p5 */
-    cpu->isar.id_dfr0 = t;
+    SET_IDREG(isar, ID_DFR0, t);
 
     /* Debug ID registers. */
 
@@ -116,9 +116,7 @@ void aa32_max_features(ARMCPU *cpu)
     t = FIELD_DP32(t, DBGDEVID1, PCSROFFSET, 2);
     cpu->isar.dbgdevid1 = t;
 
-    t = cpu->isar.id_dfr1;
-    t = FIELD_DP32(t, ID_DFR1, HPMN0, 1);         /* FEAT_HPMN0 */
-    cpu->isar.id_dfr1 = t;
+    FIELD_DP32_IDREG(isar, ID_DFR1, HPMN0, 1);         /* FEAT_HPMN0 */
 }
 
 /* CPU models. These are not needed for the AArch64 linux-user build. */
@@ -230,7 +228,7 @@ static void arm1136_r2_initfn(Object *obj)
     cpu->reset_sctlr = 0x00050078;
     SET_IDREG(isar, ID_PFR0, 0x111);
     SET_IDREG(isar, ID_PFR1, 0x1);
-    cpu->isar.id_dfr0 = 0x2;
+    SET_IDREG(isar, ID_DFR0, 0x2);
     cpu->id_afr0 = 0x3;
     cpu->isar.id_mmfr0 = 0x01130003;
     cpu->isar.id_mmfr1 = 0x10030302;
@@ -262,7 +260,7 @@ static void arm1136_initfn(Object *obj)
     cpu->reset_sctlr = 0x00050078;
     SET_IDREG(isar, ID_PFR0, 0x111);
     SET_IDREG(isar, ID_PFR1, 0x1);
-    cpu->isar.id_dfr0 = 0x2;
+    SET_IDREG(isar, ID_DFR0, 0x2);
     cpu->id_afr0 = 0x3;
     cpu->isar.id_mmfr0 = 0x01130003;
     cpu->isar.id_mmfr1 = 0x10030302;
@@ -295,7 +293,7 @@ static void arm1176_initfn(Object *obj)
     cpu->reset_sctlr = 0x00050078;
     SET_IDREG(isar, ID_PFR0, 0x111);
     SET_IDREG(isar, ID_PFR1, 0x11);
-    cpu->isar.id_dfr0 = 0x33;
+    SET_IDREG(isar, ID_DFR0, 0x33);
     cpu->id_afr0 = 0;
     cpu->isar.id_mmfr0 = 0x01130003;
     cpu->isar.id_mmfr1 = 0x10030302;
@@ -325,7 +323,7 @@ static void arm11mpcore_initfn(Object *obj)
     cpu->ctr = 0x1d192992; /* 32K icache 32K dcache */
     SET_IDREG(isar, ID_PFR0, 0x111);
     SET_IDREG(isar, ID_PFR1, 0x1);
-    cpu->isar.id_dfr0 = 0;
+    SET_IDREG(isar, ID_DFR0, 0);
     cpu->id_afr0 = 0x2;
     cpu->isar.id_mmfr0 = 0x01100103;
     cpu->isar.id_mmfr1 = 0x10020302;
@@ -365,7 +363,7 @@ static void cortex_a8_initfn(Object *obj)
     cpu->reset_sctlr = 0x00c50078;
     SET_IDREG(isar, ID_PFR0, 0x1031);
     SET_IDREG(isar, ID_PFR1, 0x11);
-    cpu->isar.id_dfr0 = 0x400;
+    SET_IDREG(isar, ID_DFR0, 0x400);
     cpu->id_afr0 = 0;
     cpu->isar.id_mmfr0 = 0x31100003;
     cpu->isar.id_mmfr1 = 0x20000000;
@@ -441,7 +439,7 @@ static void cortex_a9_initfn(Object *obj)
     cpu->reset_sctlr = 0x00c50078;
     SET_IDREG(isar, ID_PFR0, 0x1031);
     SET_IDREG(isar, ID_PFR1, 0x11);
-    cpu->isar.id_dfr0 = 0x000;
+    SET_IDREG(isar, ID_DFR0, 0x000);
     cpu->id_afr0 = 0;
     cpu->isar.id_mmfr0 = 0x00100103;
     cpu->isar.id_mmfr1 = 0x20000000;
@@ -507,7 +505,7 @@ static void cortex_a7_initfn(Object *obj)
     cpu->reset_sctlr = 0x00c50078;
     SET_IDREG(isar, ID_PFR0, 0x00001131);
     SET_IDREG(isar, ID_PFR1, 0x00011011);
-    cpu->isar.id_dfr0 = 0x02010555;
+    SET_IDREG(isar, ID_DFR0, 0x02010555);
     cpu->id_afr0 = 0x00000000;
     cpu->isar.id_mmfr0 = 0x10101105;
     cpu->isar.id_mmfr1 = 0x40000000;
@@ -559,7 +557,7 @@ static void cortex_a15_initfn(Object *obj)
     cpu->reset_sctlr = 0x00c50078;
     SET_IDREG(isar, ID_PFR0, 0x00001131);
     SET_IDREG(isar, ID_PFR1, 0x00011011);
-    cpu->isar.id_dfr0 = 0x02010555;
+    SET_IDREG(isar, ID_DFR0, 0x02010555);
     cpu->id_afr0 = 0x00000000;
     cpu->isar.id_mmfr0 = 0x10201105;
     cpu->isar.id_mmfr1 = 0x20000000;
@@ -603,7 +601,7 @@ static void cortex_r5_initfn(Object *obj)
     cpu->midr = 0x411fc153; /* r1p3 */
     SET_IDREG(isar, ID_PFR0, 0x0131);
     SET_IDREG(isar, ID_PFR1, 0x001);
-    cpu->isar.id_dfr0 = 0x010400;
+    SET_IDREG(isar, ID_DFR0, 0x010400);
     cpu->id_afr0 = 0x0;
     cpu->isar.id_mmfr0 = 0x0210030;
     cpu->isar.id_mmfr1 = 0x00000000;
@@ -750,7 +748,7 @@ static void cortex_r52_initfn(Object *obj)
     cpu->reset_sctlr = 0x30c50838;
     SET_IDREG(isar, ID_PFR0, 0x00000131);
     SET_IDREG(isar, ID_PFR1, 0x10111001);
-    cpu->isar.id_dfr0 = 0x03010006;
+    SET_IDREG(isar, ID_DFR0, 0x03010006);
     cpu->id_afr0 = 0x00000000;
     cpu->isar.id_mmfr0 = 0x00211040;
     cpu->isar.id_mmfr1 = 0x40000000;
@@ -982,7 +980,7 @@ static void arm_max_initfn(Object *obj)
     cpu->reset_sctlr = 0x00c50838;
     SET_IDREG(isar, ID_PFR0, 0x00000131);
     SET_IDREG(isar, ID_PFR1, 0x00011011);
-    cpu->isar.id_dfr0 = 0x03010066;
+    SET_IDREG(isar, ID_DFR0, 0x03010066);
     cpu->id_afr0 = 0x00000000;
     cpu->isar.id_mmfr0 = 0x10101105;
     cpu->isar.id_mmfr1 = 0x40000000;
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index cfaf01fbf9bc..738826a7bf97 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -51,7 +51,7 @@ static void aarch64_a35_initfn(Object *obj)
     cpu->ctr = 0x84448004;
     SET_IDREG(isar, ID_PFR0, 0x00000131);
     SET_IDREG(isar, ID_PFR1, 0x00011011);
-    cpu->isar.id_dfr0 = 0x03010066;
+    SET_IDREG(isar, ID_DFR0, 0x03010066);
     cpu->id_afr0 = 0;
     cpu->isar.id_mmfr0 = 0x10201105;
     cpu->isar.id_mmfr1 = 0x40000000;
@@ -228,7 +228,7 @@ static void aarch64_a55_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64PFR0, 0x0000000010112222ull);
     SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000010ull);
     cpu->id_afr0       = 0x00000000;
-    cpu->isar.id_dfr0  = 0x04010088;
+    SET_IDREG(isar, ID_DFR0, 0x04010088);
     SET_IDREG(isar, ID_ISAR0, 0x02101110);
     SET_IDREG(isar, ID_ISAR1, 0x13112111);
     SET_IDREG(isar, ID_ISAR2, 0x21232042);
@@ -297,7 +297,7 @@ static void aarch64_a72_initfn(Object *obj)
     cpu->reset_sctlr = 0x00c50838;
     SET_IDREG(isar, ID_PFR0, 0x00000131);
     SET_IDREG(isar, ID_PFR1, 0x00011011);
-    cpu->isar.id_dfr0 = 0x03010066;
+    SET_IDREG(isar, ID_DFR0, 0x03010066);
     cpu->id_afr0 = 0x00000000;
     cpu->isar.id_mmfr0 = 0x10201105;
     cpu->isar.id_mmfr1 = 0x40000000;
@@ -361,7 +361,7 @@ static void aarch64_a76_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64PFR0, 0x1100000010111112ull); /* GIC filled in later */
     SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000010ull);
     cpu->id_afr0       = 0x00000000;
-    cpu->isar.id_dfr0  = 0x04010088;
+    SET_IDREG(isar, ID_DFR0, 0x04010088);
     SET_IDREG(isar, ID_ISAR0, 0x02101110);
     SET_IDREG(isar, ID_ISAR1, 0x13112111);
     SET_IDREG(isar, ID_ISAR2, 0x21232042);
@@ -609,7 +609,7 @@ static void aarch64_neoverse_n1_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64PFR0, 0x1100000010111112ull); /* GIC filled in later */
     SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000020ull);
     cpu->id_afr0       = 0x00000000;
-    cpu->isar.id_dfr0  = 0x04010088;
+    SET_IDREG(isar, ID_DFR0, 0x04010088);
     SET_IDREG(isar, ID_ISAR0, 0x02101110);
     SET_IDREG(isar, ID_ISAR1, 0x13112111);
     SET_IDREG(isar, ID_ISAR2, 0x21232042);
@@ -688,7 +688,7 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64PFR0, 0x1101110120111112ull); /* GIC filled in later */
     SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000020ull);
     cpu->id_afr0       = 0x00000000;
-    cpu->isar.id_dfr0  = 0x15011099;
+    SET_IDREG(isar, ID_DFR0, 0x15011099);
     SET_IDREG(isar, ID_ISAR0, 0x02101110);
     SET_IDREG(isar, ID_ISAR1, 0x13112111);
     SET_IDREG(isar, ID_ISAR2, 0x21232042);
@@ -904,7 +904,7 @@ static void aarch64_a710_initfn(Object *obj)
     cpu->revidr        = 0;
     SET_IDREG(isar, ID_PFR0, 0x21110131);
     SET_IDREG(isar, ID_PFR1, 0x00010000); /* GIC filled in later */
-    cpu->isar.id_dfr0  = 0x16011099;
+    SET_IDREG(isar, ID_DFR0, 0x16011099);
     cpu->id_afr0       = 0;
     cpu->isar.id_mmfr0 = 0x10201105;
     cpu->isar.id_mmfr1 = 0x40000000;
@@ -1007,7 +1007,7 @@ static void aarch64_neoverse_n2_initfn(Object *obj)
     cpu->revidr        = 0;
     SET_IDREG(isar, ID_PFR0, 0x21110131);
     SET_IDREG(isar, ID_PFR1, 0x00010000); /* GIC filled in later */
-    cpu->isar.id_dfr0  = 0x16011099;
+    SET_IDREG(isar, ID_DFR0, 0x16011099);
     cpu->id_afr0       = 0;
     cpu->isar.id_mmfr0 = 0x10201105;
     cpu->isar.id_mmfr1 = 0x40000000;
-- 
2.48.1


