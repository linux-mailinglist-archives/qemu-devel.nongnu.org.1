Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF939B000D
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Oct 2024 12:23:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4HSN-0003xd-QI; Fri, 25 Oct 2024 06:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1t4HSK-0003u3-As
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 06:22:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1t4HSD-0000R1-Nn
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 06:22:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729851720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gkibzcnB6clf7OmcuSAILk3dYeaUIpX/AS3GV2HV7Sg=;
 b=Ailgoskk+x9z7HE6diz38wEIqCckGrQAtKGwlCtttxemssDyWDO30AT0H/f41DCOGYwMUU
 CoCE35yj0qNwohN2wN+7gr6JmptEK9XM1r8D102Q0GQ9lnQ7gxli60UqUYfPbvVglj4BbK
 TXP8Ulwzi8ol/fy44baEg95Znc9fvGE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-gDVN1WiUOsabjshEosEhVA-1; Fri,
 25 Oct 2024 06:20:52 -0400
X-MC-Unique: gDVN1WiUOsabjshEosEhVA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CDDA41956088; Fri, 25 Oct 2024 10:20:50 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.194.5])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6D6E4196BB7D; Fri, 25 Oct 2024 10:20:44 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvmarm@lists.linux.dev,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com
Cc: shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org,
 pbonzini@redhat.com
Subject: [RFC 05/21] arm/cpu: Store aa64drf0/1 into the idregs array
Date: Fri, 25 Oct 2024 12:17:24 +0200
Message-ID: <20241025101959.601048-6-eric.auger@redhat.com>
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

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 target/arm/cpu-features.h | 40 ++++++++++++++++-----------------
 target/arm/cpu.h          |  5 +++--
 target/arm/cpu.c          | 27 +++++++---------------
 target/arm/cpu64.c        | 14 ++++--------
 target/arm/helper.c       |  6 ++---
 target/arm/kvm.c          | 24 +++++++++-----------
 target/arm/tcg/cpu64.c    | 47 ++++++++++++++++++---------------------
 7 files changed, 70 insertions(+), 93 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index de571b520f..5e195f117d 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -590,68 +590,68 @@ static inline bool isar_feature_aa64_mops(const ARMISARegisters *id)
 static inline bool isar_feature_aa64_fp_simd(const ARMISARegisters *id)
 {
     /* We always set the AdvSIMD and FP fields identically.  */
-    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, FP) != 0xf;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64PFR0, FP) != 0xf;
 }
 
 static inline bool isar_feature_aa64_fp16(const ARMISARegisters *id)
 {
     /* We always set the AdvSIMD and FP fields identically wrt FP16.  */
-    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, FP) == 1;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64PFR0, FP) == 1;
 }
 
 static inline bool isar_feature_aa64_aa32(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, EL0) >= 2;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64PFR0, EL0) >= 2;
 }
 
 static inline bool isar_feature_aa64_aa32_el1(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, EL1) >= 2;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64PFR0, EL1) >= 2;
 }
 
 static inline bool isar_feature_aa64_aa32_el2(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, EL2) >= 2;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64PFR0, EL2) >= 2;
 }
 
 static inline bool isar_feature_aa64_ras(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, RAS) != 0;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64PFR0, RAS) != 0;
 }
 
 static inline bool isar_feature_aa64_doublefault(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, RAS) >= 2;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64PFR0, RAS) >= 2;
 }
 
 static inline bool isar_feature_aa64_sve(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, SVE) != 0;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64PFR0, SVE) != 0;
 }
 
 static inline bool isar_feature_aa64_sel2(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, SEL2) != 0;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64PFR0, SEL2) != 0;
 }
 
 static inline bool isar_feature_aa64_rme(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, RME) != 0;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64PFR0, RME) != 0;
 }
 
 static inline bool isar_feature_aa64_dit(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, DIT) != 0;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64PFR0, DIT) != 0;
 }
 
 static inline bool isar_feature_aa64_scxtnum(const ARMISARegisters *id)
 {
-    int key = FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, CSV2);
+    int key = FIELD_EX64_IDREG(&id->idregs, ID_AA64PFR0, CSV2);
     if (key >= 2) {
         return true;      /* FEAT_CSV2_2 */
     }
     if (key == 1) {
-        key = FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, CSV2_FRAC);
+        key = FIELD_EX64_IDREG(&id->idregs, ID_AA64PFR1, CSV2_FRAC);
         return key >= 2;  /* FEAT_CSV2_1p2 */
     }
     return false;
@@ -659,37 +659,37 @@ static inline bool isar_feature_aa64_scxtnum(const ARMISARegisters *id)
 
 static inline bool isar_feature_aa64_ssbs(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, SSBS) != 0;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64PFR1, SSBS) != 0;
 }
 
 static inline bool isar_feature_aa64_bti(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, BT) != 0;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64PFR1, BT) != 0;
 }
 
 static inline bool isar_feature_aa64_mte_insn_reg(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, MTE) != 0;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64PFR1, MTE) != 0;
 }
 
 static inline bool isar_feature_aa64_mte(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, MTE) >= 2;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64PFR1, MTE) >= 2;
 }
 
 static inline bool isar_feature_aa64_mte3(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, MTE) >= 3;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64PFR1, MTE) >= 3;
 }
 
 static inline bool isar_feature_aa64_sme(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, SME) != 0;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64PFR1, SME) != 0;
 }
 
 static inline bool isar_feature_aa64_nmi(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, NMI) != 0;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64PFR1, NMI) != 0;
 }
 
 static inline bool isar_feature_aa64_tgran4_lpa2(const ARMISARegisters *id)
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 87df224121..bebee2e694 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -874,6 +874,9 @@ _set_idreg(MAP, SYS_ ## REG ## _EL1, regval);                 \
 #define FIELD_EX64_IDREG(MAP, REG, FIELD)                     \
 FIELD_EX64(_get_idreg(MAP, SYS_ ## REG ## _EL1), REG, FIELD)  \
 
+#define FIELD_EX32_IDREG(MAP, REG, FIELD)                     \
+FIELD_EX32(_get_idreg(MAP, SYS_ ## REG ## _EL1), REG, FIELD)  \
+
 #define SET_IDREG(MAP, REG, VALUE)                            \
 _set_idreg(MAP, SYS_ ## REG ## _EL1, VALUE)
 
@@ -1082,8 +1085,6 @@ struct ArchCPU {
         uint32_t dbgdidr;
         uint32_t dbgdevid;
         uint32_t dbgdevid1;
-        uint64_t id_aa64pfr0;
-        uint64_t id_aa64pfr1;
         uint64_t id_aa64mmfr0;
         uint64_t id_aa64mmfr1;
         uint64_t id_aa64mmfr2;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index a4b59b259c..cbfb6df435 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2121,14 +2121,11 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
     if (!cpu->has_vfp) {
-        uint64_t t;
         uint32_t u;
 
         FIELD_DP64_IDREG(idregs, ID_AA64ISAR1, JSCVT, 0);
 
-        t = cpu->isar.id_aa64pfr0;
-        t = FIELD_DP64(t, ID_AA64PFR0, FP, 0xf);
-        cpu->isar.id_aa64pfr0 = t;
+        FIELD_DP64_IDREG(idregs, ID_AA64PFR0, FP, 0xf);
 
         u = cpu->isar.id_isar6;
         u = FIELD_DP32(u, ID_ISAR6, JSCVT, 0);
@@ -2183,9 +2180,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         t = FIELD_DP64(t, ID_AA64ISAR1, I8MM, 0);
         SET_IDREG(idregs, ID_AA64ISAR1, t);
 
-        t = cpu->isar.id_aa64pfr0;
-        t = FIELD_DP64(t, ID_AA64PFR0, ADVSIMD, 0xf);
-        cpu->isar.id_aa64pfr0 = t;
+        FIELD_DP64_IDREG(idregs, ID_AA64PFR0, ADVSIMD, 0xf);
 
         u = cpu->isar.id_isar5;
         u = FIELD_DP32(u, ID_ISAR5, AES, 0);
@@ -2327,12 +2322,10 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
          */
         cpu->isar.id_pfr1 = FIELD_DP32(cpu->isar.id_pfr1, ID_PFR1, SECURITY, 0);
         cpu->isar.id_dfr0 = FIELD_DP32(cpu->isar.id_dfr0, ID_DFR0, COPSDBG, 0);
-        cpu->isar.id_aa64pfr0 = FIELD_DP64(cpu->isar.id_aa64pfr0,
-                                           ID_AA64PFR0, EL3, 0);
+        FIELD_DP64_IDREG(idregs, ID_AA64PFR0, EL3, 0);
 
         /* Disable the realm management extension, which requires EL3. */
-        cpu->isar.id_aa64pfr0 = FIELD_DP64(cpu->isar.id_aa64pfr0,
-                                           ID_AA64PFR0, RME, 0);
+        FIELD_DP64_IDREG(idregs, ID_AA64PFR0, RME, 0);
     }
 
     if (!cpu->has_el2) {
@@ -2367,8 +2360,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
          * Disable the hypervisor feature bits in the processor feature
          * registers if we don't have EL2.
          */
-        cpu->isar.id_aa64pfr0 = FIELD_DP64(cpu->isar.id_aa64pfr0,
-                                           ID_AA64PFR0, EL2, 0);
+        FIELD_DP64_IDREG(idregs, ID_AA64PFR0, EL2, 0);
         cpu->isar.id_pfr1 = FIELD_DP32(cpu->isar.id_pfr1,
                                        ID_PFR1, VIRTUALIZATION, 0);
     }
@@ -2389,8 +2381,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
          * This matches Cortex-A710 BROADCASTMTE input being LOW.
          */
         if (cpu->tag_memory == NULL) {
-            cpu->isar.id_aa64pfr1 =
-                FIELD_DP64(cpu->isar.id_aa64pfr1, ID_AA64PFR1, MTE, 1);
+            FIELD_DP64_IDREG(idregs, ID_AA64PFR1, MTE, 1);
         }
 #endif
     }
@@ -2429,13 +2420,11 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         cpu->isar.id_dfr0 =
             FIELD_DP32(cpu->isar.id_dfr0, ID_DFR0, MMAPTRC, 0);
         /* FEAT_AMU (Activity Monitors Extension) */
-        cpu->isar.id_aa64pfr0 =
-            FIELD_DP64(cpu->isar.id_aa64pfr0, ID_AA64PFR0, AMU, 0);
+        FIELD_DP64_IDREG(idregs, ID_AA64PFR0, AMU, 0);
         cpu->isar.id_pfr0 =
             FIELD_DP32(cpu->isar.id_pfr0, ID_PFR0, AMU, 0);
         /* FEAT_MPAM (Memory Partitioning and Monitoring Extension) */
-        cpu->isar.id_aa64pfr0 =
-            FIELD_DP64(cpu->isar.id_aa64pfr0, ID_AA64PFR0, MPAM, 0);
+        FIELD_DP64_IDREG(idregs, ID_AA64PFR0, MPAM, 0);
     }
 
     /* MPU can be configured out of a PMSA CPU either by setting has-mpu
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index d16c7487ac..7dd458012a 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -287,16 +287,13 @@ static bool cpu_arm_get_sve(Object *obj, Error **errp)
 static void cpu_arm_set_sve(Object *obj, bool value, Error **errp)
 {
     ARMCPU *cpu = ARM_CPU(obj);
-    uint64_t t;
 
     if (value && kvm_enabled() && !kvm_arm_sve_supported()) {
         error_setg(errp, "'sve' feature not supported by KVM on this host");
         return;
     }
 
-    t = cpu->isar.id_aa64pfr0;
-    t = FIELD_DP64(t, ID_AA64PFR0, SVE, value);
-    cpu->isar.id_aa64pfr0 = t;
+    FIELD_DP64_IDREG(&cpu->isar.idregs, ID_AA64PFR0, SVE, value);
 }
 
 void arm_cpu_sme_finalize(ARMCPU *cpu, Error **errp)
@@ -347,11 +344,8 @@ static bool cpu_arm_get_sme(Object *obj, Error **errp)
 static void cpu_arm_set_sme(Object *obj, bool value, Error **errp)
 {
     ARMCPU *cpu = ARM_CPU(obj);
-    uint64_t t;
 
-    t = cpu->isar.id_aa64pfr1;
-    t = FIELD_DP64(t, ID_AA64PFR1, SME, value);
-    cpu->isar.id_aa64pfr1 = t;
+    FIELD_DP64_IDREG(&cpu->isar.idregs, ID_AA64PFR1, SME, value);
 }
 
 static bool cpu_arm_get_sme_fa64(Object *obj, Error **errp)
@@ -635,7 +629,7 @@ static void aarch64_a57_initfn(Object *obj)
     cpu->isar.id_isar4 = 0x00011142;
     cpu->isar.id_isar5 = 0x00011121;
     cpu->isar.id_isar6 = 0;
-    cpu->isar.id_aa64pfr0 = 0x00002222;
+    SET_IDREG(idregs, ID_AA64PFR0, 0x00002222);
     cpu->isar.id_aa64dfr0 = 0x10305106;
     SET_IDREG(idregs, ID_AA64ISAR0, 0x00011120);
     cpu->isar.id_aa64mmfr0 = 0x00001124;
@@ -694,7 +688,7 @@ static void aarch64_a53_initfn(Object *obj)
     cpu->isar.id_isar4 = 0x00011142;
     cpu->isar.id_isar5 = 0x00011121;
     cpu->isar.id_isar6 = 0;
-    cpu->isar.id_aa64pfr0 = 0x00002222;
+    SET_IDREG(idregs, ID_AA64PFR0, 0x00002222);
     cpu->isar.id_aa64dfr0 = 0x10305106;
     SET_IDREG(idregs, ID_AA64ISAR0, 0x00011120);
     cpu->isar.id_aa64mmfr0 = 0x00001122; /* 40 bit physical addr */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 209b7c22b6..541bc27587 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7688,7 +7688,7 @@ static uint64_t id_pfr1_read(CPUARMState *env, const ARMCPRegInfo *ri)
 static uint64_t id_aa64pfr0_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     ARMCPU *cpu = env_archcpu(env);
-    uint64_t pfr0 = cpu->isar.id_aa64pfr0;
+    uint64_t pfr0 = GET_IDREG(&cpu->isar.idregs, ID_AA64PFR0);
 
     if (env->gicv3state) {
         pfr0 |= 1 << 24;
@@ -8868,7 +8868,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .access = PL1_R,
 #ifdef CONFIG_USER_ONLY
               .type = ARM_CP_CONST,
-              .resetvalue = cpu->isar.id_aa64pfr0
+              .resetvalue = GET_IDREG(idregs, ID_AA64PFR0)
 #else
               .type = ARM_CP_NO_RAW,
               .accessfn = access_aa64_tid3,
@@ -8880,7 +8880,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = cpu->isar.id_aa64pfr1},
+              .resetvalue = GET_IDREG(idregs, ID_AA64PFR1)},
             { .name = "ID_AA64PFR2_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index c30dc53622..888b10213c 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -304,8 +304,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     ahcf->dtb_compatible = "arm,arm-v8";
     int fd = fdarray[2];
 
-    err = read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64pfr0,
-                         ARM64_SYS_REG(3, 0, 0, 4, 0));
+    err = get_host_cpu_reg64(fd, ahcf, SYS_ID_AA64PFR0_EL1);
     if (unlikely(err < 0)) {
         /*
          * Before v4.15, the kernel only exposed a limited number of system
@@ -323,11 +322,10 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
          * ??? Either of these sounds like too much effort just
          *     to work around running a modern host kernel.
          */
-        ahcf->isar.id_aa64pfr0 = 0x00000011; /* EL1&0, AArch64 only */
+        SET_IDREG(&ahcf->isar.idregs, ID_AA64PFR0, 0x00000011); /* EL1&0, AArch64 only */
         err = 0;
     } else {
-        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64pfr1,
-                              ARM64_SYS_REG(3, 0, 0, 4, 1));
+        err |= get_host_cpu_reg64(fd, ahcf, SYS_ID_AA64PFR1_EL1);
         err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64smfr0,
                               ARM64_SYS_REG(3, 0, 0, 4, 5));
         err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64dfr0,
@@ -353,10 +351,8 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
          * than skipping the reads and leaving 0, as we must avoid
          * considering the values in every case.
          */
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_pfr0,
-                              ARM64_SYS_REG(3, 0, 0, 1, 0));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_pfr1,
-                              ARM64_SYS_REG(3, 0, 0, 1, 1));
+        err |= get_host_cpu_reg64(fd, ahcf, SYS_ID_AA64PFR0_EL1);
+        err |= get_host_cpu_reg64(fd, ahcf, SYS_ID_AA64PFR1_EL1);
         err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_dfr0,
                               ARM64_SYS_REG(3, 0, 0, 1, 2));
         err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr0,
@@ -407,14 +403,14 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
          * arch/arm64/kvm/sys_regs.c:trap_dbgidr() does.
          * We only do this if the CPU supports AArch32 at EL1.
          */
-        if (FIELD_EX32(ahcf->isar.id_aa64pfr0, ID_AA64PFR0, EL1) >= 2) {
-            int wrps = FIELD_EX64(ahcf->isar.id_aa64dfr0, ID_AA64DFR0, WRPS);
-            int brps = FIELD_EX64(ahcf->isar.id_aa64dfr0, ID_AA64DFR0, BRPS);
+        if (FIELD_EX32_IDREG(&ahcf->isar.idregs, ID_AA64PFR0, EL1) >= 2) {
+            int wrps = FIELD_EX64_IDREG(&ahcf->isar.idregs, ID_AA64DFR0, WRPS);
+            int brps = FIELD_EX64_IDREG(&ahcf->isar.idregs, ID_AA64DFR0, BRPS);
             int ctx_cmps =
-                FIELD_EX64(ahcf->isar.id_aa64dfr0, ID_AA64DFR0, CTX_CMPS);
+                FIELD_EX64_IDREG(&ahcf->isar.idregs, ID_AA64DFR0, CTX_CMPS);
             int version = 6; /* ARMv8 debug architecture */
             bool has_el3 =
-                !!FIELD_EX32(ahcf->isar.id_aa64pfr0, ID_AA64PFR0, EL3);
+                !!FIELD_EX32_IDREG(&ahcf->isar.idregs, ID_AA64PFR0, EL3);
             uint32_t dbgdidr = 0;
 
             dbgdidr = FIELD_DP32(dbgdidr, DBGDIDR, WRPS, wrps);
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 7be63f21a1..b2a88a0ebd 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -89,8 +89,8 @@ static void aarch64_a35_initfn(Object *obj)
     cpu->isar.id_isar3 = 0x01112131;
     cpu->isar.id_isar4 = 0x00011142;
     cpu->isar.id_isar5 = 0x00011121;
-    cpu->isar.id_aa64pfr0 = 0x00002222;
-    cpu->isar.id_aa64pfr1 = 0;
+    SET_IDREG(idregs, ID_AA64PFR0, 0x00002222);
+    SET_IDREG(idregs, ID_AA64PFR1, 0);
     cpu->isar.id_aa64dfr0 = 0x10305106;
     cpu->isar.id_aa64dfr1 = 0;
     SET_IDREG(idregs, ID_AA64ISAR0, 0x00011120);
@@ -181,11 +181,8 @@ static bool cpu_arm_get_rme(Object *obj, Error **errp)
 static void cpu_arm_set_rme(Object *obj, bool value, Error **errp)
 {
     ARMCPU *cpu = ARM_CPU(obj);
-    uint64_t t;
 
-    t = cpu->isar.id_aa64pfr0;
-    t = FIELD_DP64(t, ID_AA64PFR0, RME, value);
-    cpu->isar.id_aa64pfr0 = t;
+    FIELD_DP64_IDREG(&cpu->isar.idregs, ID_AA64PFR0, RME, value);
 }
 
 static void cpu_max_set_l0gptsz(Object *obj, Visitor *v, const char *name,
@@ -251,8 +248,8 @@ static void aarch64_a55_initfn(Object *obj)
     cpu->isar.id_aa64mmfr0 = 0x0000000000101122ull;
     cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;
     cpu->isar.id_aa64mmfr2 = 0x0000000000001011ull;
-    cpu->isar.id_aa64pfr0  = 0x0000000010112222ull;
-    cpu->isar.id_aa64pfr1  = 0x0000000000000010ull;
+    SET_IDREG(idregs, ID_AA64PFR0, 0x0000000010112222ull);
+    SET_IDREG(idregs, ID_AA64PFR1, 0x0000000000000010ull);
     cpu->id_afr0       = 0x00000000;
     cpu->isar.id_dfr0  = 0x04010088;
     cpu->isar.id_isar0 = 0x02101110;
@@ -332,7 +329,7 @@ static void aarch64_a72_initfn(Object *obj)
     cpu->isar.id_isar3 = 0x01112131;
     cpu->isar.id_isar4 = 0x00011142;
     cpu->isar.id_isar5 = 0x00011121;
-    cpu->isar.id_aa64pfr0 = 0x00002222;
+    SET_IDREG(idregs, ID_AA64PFR0, 0x00002222);
     cpu->isar.id_aa64dfr0 = 0x10305106;
     SET_IDREG(idregs, ID_AA64ISAR0, 0x00011120);
     cpu->isar.id_aa64mmfr0 = 0x00001124;
@@ -378,8 +375,8 @@ static void aarch64_a76_initfn(Object *obj)
     cpu->isar.id_aa64mmfr0 = 0x0000000000101122ull;
     cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;
     cpu->isar.id_aa64mmfr2 = 0x0000000000001011ull;
-    cpu->isar.id_aa64pfr0  = 0x1100000010111112ull; /* GIC filled in later */
-    cpu->isar.id_aa64pfr1  = 0x0000000000000010ull;
+    SET_IDREG(idregs, ID_AA64PFR0, 0x1100000010111112ull); /* GIC filled in later */
+    SET_IDREG(idregs, ID_AA64PFR1, 0x0000000000000010ull);
     cpu->id_afr0       = 0x00000000;
     cpu->isar.id_dfr0  = 0x04010088;
     cpu->isar.id_isar0 = 0x02101110;
@@ -441,8 +438,8 @@ static void aarch64_a64fx_initfn(Object *obj)
     cpu->revidr = 0x00000000;
     cpu->ctr = 0x86668006;
     cpu->reset_sctlr = 0x30000180;
-    cpu->isar.id_aa64pfr0 =   0x0000000101111111; /* No RAS Extensions */
-    cpu->isar.id_aa64pfr1 = 0x0000000000000000;
+    SET_IDREG(idregs, ID_AA64PFR0, 0x0000000101111111); /* No RAS Extensions */
+    SET_IDREG(idregs, ID_AA64PFR1, 0x0000000000000000);
     cpu->isar.id_aa64dfr0 = 0x0000000010305408;
     cpu->isar.id_aa64dfr1 = 0x0000000000000000;
     cpu->id_aa64afr0 = 0x0000000000000000;
@@ -620,8 +617,8 @@ static void aarch64_neoverse_n1_initfn(Object *obj)
     cpu->isar.id_aa64mmfr0 = 0x0000000000101125ull;
     cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;
     cpu->isar.id_aa64mmfr2 = 0x0000000000001011ull;
-    cpu->isar.id_aa64pfr0  = 0x1100000010111112ull; /* GIC filled in later */
-    cpu->isar.id_aa64pfr1  = 0x0000000000000020ull;
+    SET_IDREG(idregs, ID_AA64PFR0, 0x1100000010111112ull); /* GIC filled in later */
+    SET_IDREG(idregs, ID_AA64PFR1, 0x0000000000000020ull);
     cpu->id_afr0       = 0x00000000;
     cpu->isar.id_dfr0  = 0x04010088;
     cpu->isar.id_isar0 = 0x02101110;
@@ -696,8 +693,8 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
     cpu->isar.id_aa64mmfr0 = 0x0000000000101125ull;
     cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;
     cpu->isar.id_aa64mmfr2 = 0x0220011102101011ull;
-    cpu->isar.id_aa64pfr0  = 0x1101110120111112ull; /* GIC filled in later */
-    cpu->isar.id_aa64pfr1  = 0x0000000000000020ull;
+    SET_IDREG(idregs, ID_AA64PFR0, 0x1101110120111112ull); /* GIC filled in later */
+    SET_IDREG(idregs, ID_AA64PFR1, 0x0000000000000020ull);
     cpu->id_afr0       = 0x00000000;
     cpu->isar.id_dfr0  = 0x15011099;
     cpu->isar.id_isar0 = 0x02101110;
@@ -930,8 +927,8 @@ static void aarch64_a710_initfn(Object *obj)
     cpu->isar.mvfr1    = 0x13211111;
     cpu->isar.mvfr2    = 0x00000043;
     cpu->isar.id_pfr2  = 0x00000011;
-    cpu->isar.id_aa64pfr0  = 0x1201111120111112ull; /* GIC filled in later */
-    cpu->isar.id_aa64pfr1  = 0x0000000000000221ull;
+    SET_IDREG(idregs, ID_AA64PFR0, 0x1201111120111112ull); /* GIC filled in later */
+    SET_IDREG(idregs, ID_AA64PFR1, 0x0000000000000221ull);
     SET_IDREG(idregs, ID_AA64ZFR0, 0x0000110100110021ull); /* with Crypto */
     cpu->isar.id_aa64dfr0  = 0x000011f010305619ull;
     cpu->isar.id_aa64dfr1  = 0;
@@ -1029,8 +1026,8 @@ static void aarch64_neoverse_n2_initfn(Object *obj)
     cpu->isar.mvfr1    = 0x13211111;
     cpu->isar.mvfr2    = 0x00000043;
     cpu->isar.id_pfr2  = 0x00000011;
-    cpu->isar.id_aa64pfr0  = 0x1201111120111112ull; /* GIC filled in later */
-    cpu->isar.id_aa64pfr1  = 0x0000000000000221ull;
+    SET_IDREG(idregs, ID_AA64PFR0, 0x1201111120111112ull); /* GIC filled in later */
+    SET_IDREG(idregs, ID_AA64PFR1, 0x0000000000000221ull);
     SET_IDREG(idregs, ID_AA64ZFR0, 0x0000110100110021ull); /* with Crypto */
     cpu->isar.id_aa64dfr0  = 0x000011f210305619ull;
     cpu->isar.id_aa64dfr1  = 0;
@@ -1181,7 +1178,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ISAR2, WFXT, 2);     /* FEAT_WFxT */
     SET_IDREG(idregs, ID_AA64ISAR2, t);
 
-    t = cpu->isar.id_aa64pfr0;
+    t = GET_IDREG(idregs, ID_AA64PFR0);
     t = FIELD_DP64(t, ID_AA64PFR0, FP, 1);        /* FEAT_FP16 */
     t = FIELD_DP64(t, ID_AA64PFR0, ADVSIMD, 1);   /* FEAT_FP16 */
     t = FIELD_DP64(t, ID_AA64PFR0, RAS, 2);       /* FEAT_RASv1p1 + FEAT_DoubleFault */
@@ -1190,9 +1187,9 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64PFR0, DIT, 1);       /* FEAT_DIT */
     t = FIELD_DP64(t, ID_AA64PFR0, CSV2, 3);      /* FEAT_CSV2_3 */
     t = FIELD_DP64(t, ID_AA64PFR0, CSV3, 1);      /* FEAT_CSV3 */
-    cpu->isar.id_aa64pfr0 = t;
+    SET_IDREG(idregs, ID_AA64PFR0, t);
 
-    t = cpu->isar.id_aa64pfr1;
+    t = GET_IDREG(idregs, ID_AA64PFR1);
     t = FIELD_DP64(t, ID_AA64PFR1, BT, 1);        /* FEAT_BTI */
     t = FIELD_DP64(t, ID_AA64PFR1, SSBS, 2);      /* FEAT_SSBS2 */
     /*
@@ -1205,7 +1202,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64PFR1, SME, 1);       /* FEAT_SME */
     t = FIELD_DP64(t, ID_AA64PFR1, CSV2_FRAC, 0); /* FEAT_CSV2_3 */
     t = FIELD_DP64(t, ID_AA64PFR1, NMI, 1);       /* FEAT_NMI */
-    cpu->isar.id_aa64pfr1 = t;
+    SET_IDREG(idregs, ID_AA64PFR1, t);
 
     t = cpu->isar.id_aa64mmfr0;
     t = FIELD_DP64(t, ID_AA64MMFR0, PARANGE, 6); /* FEAT_LPA: 52 bits */
-- 
2.41.0


