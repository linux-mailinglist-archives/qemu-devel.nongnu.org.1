Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 430D2A2C140
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Feb 2025 12:06:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgMBJ-0006DP-US; Fri, 07 Feb 2025 06:05:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1tgMAa-0005ge-Bl
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 06:05:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1tgMAV-0007IU-VQ
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 06:05:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738926306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=70+u6YF5Op0dzkhEBvg/ZpIKBMA1kz6muG0zwXklMEI=;
 b=P29OEr2MROxtrzMmIkzpCTujrALvMYs4tL7poj9orljhYb5EljcBka3OlqjE5JhY9TZK1/
 h5cUo509GR7HNn2sWC1yNPtHIejwDwxD1dty7BxL7l/i7qeRV5OIkaRR1gePbOl6wzs0pp
 F47R6O0lMqKUNrm+Kh3/YyBGS62E7vk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-225-LH0VVzitM9WZwgbVQ1Slag-1; Fri,
 07 Feb 2025 06:05:01 -0500
X-MC-Unique: LH0VVzitM9WZwgbVQ1Slag-1
X-Mimecast-MFC-AGG-ID: LH0VVzitM9WZwgbVQ1Slag
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86733195608E; Fri,  7 Feb 2025 11:04:59 +0000 (UTC)
Received: from gondolin.redhat.com (unknown [10.67.24.130])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9EC2919560A3; Fri,  7 Feb 2025 11:04:45 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 oliver.upton@linux.dev, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com
Cc: shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org,
 pbonzini@redhat.com, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 07/15] arm/cpu: Store aa64dfr0/1 into the idregs array
Date: Fri,  7 Feb 2025 12:02:40 +0100
Message-ID: <20250207110248.1580465-8-cohuck@redhat.com>
In-Reply-To: <20250207110248.1580465-1-cohuck@redhat.com>
References: <20250207110248.1580465-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Eric Auger <eric.auger@redhat.com>

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/arm/cpu-features.h | 16 ++++++++--------
 target/arm/cpu.c          | 15 +++++----------
 target/arm/cpu.h          |  2 --
 target/arm/cpu64.c        |  4 ++--
 target/arm/helper.c       |  4 ++--
 target/arm/internals.h    |  6 +++---
 target/arm/kvm.c          |  6 ++----
 target/arm/tcg/cpu64.c    | 33 +++++++++++++++++----------------
 8 files changed, 39 insertions(+), 47 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index a26b05cb9804..05de9e0d9932 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -890,30 +890,30 @@ static inline bool isar_feature_aa64_nv2(const ARMISARegisters *id)
 
 static inline bool isar_feature_aa64_pmuv3p1(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) >= 4 &&
-        FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) != 0xf;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64DFR0, PMUVER) >= 4 &&
+        FIELD_EX64_IDREG(&id->idregs, ID_AA64DFR0, PMUVER) != 0xf;
 }
 
 static inline bool isar_feature_aa64_pmuv3p4(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) >= 5 &&
-        FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) != 0xf;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64DFR0, PMUVER) >= 5 &&
+        FIELD_EX64_IDREG(&id->idregs, ID_AA64DFR0, PMUVER) != 0xf;
 }
 
 static inline bool isar_feature_aa64_pmuv3p5(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) >= 6 &&
-        FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) != 0xf;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64DFR0, PMUVER) >= 6 &&
+        FIELD_EX64_IDREG(&id->idregs, ID_AA64DFR0, PMUVER) != 0xf;
 }
 
 static inline bool isar_feature_aa64_debugv8p2(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, DEBUGVER) >= 8;
+    return FIELD_EX64_IDREG(&id->idregs, ID_AA64DFR0, DEBUGVER) >= 8;
 }
 
 static inline bool isar_feature_aa64_doublelock(const ARMISARegisters *id)
 {
-    return FIELD_SEX64(id->id_aa64dfr0, ID_AA64DFR0, DOUBLELOCK) >= 0;
+    return FIELD_SEX64_IDREG(&id->idregs, ID_AA64DFR0, DOUBLELOCK) >= 0;
 }
 
 static inline bool isar_feature_aa64_sve2(const ARMISARegisters *id)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 3e7f2e495e68..8f2d58cffbfd 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2370,8 +2370,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
                 cpu);
 #endif
     } else {
-        cpu->isar.id_aa64dfr0 =
-            FIELD_DP64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, PMUVER, 0);
+        FIELD_DP64_IDREG(idregs, ID_AA64DFR0, PMUVER, 0);
         cpu->isar.id_dfr0 = FIELD_DP32(cpu->isar.id_dfr0, ID_DFR0, PERFMON, 0);
         cpu->pmceid0 = 0;
         cpu->pmceid1 = 0;
@@ -2431,19 +2430,15 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
          * try to access the non-existent system registers for them.
          */
         /* FEAT_SPE (Statistical Profiling Extension) */
-        cpu->isar.id_aa64dfr0 =
-            FIELD_DP64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, PMSVER, 0);
+        FIELD_DP64_IDREG(idregs, ID_AA64DFR0, PMSVER, 0);
         /* FEAT_TRBE (Trace Buffer Extension) */
-        cpu->isar.id_aa64dfr0 =
-            FIELD_DP64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, TRACEBUFFER, 0);
+        FIELD_DP64_IDREG(idregs, ID_AA64DFR0, TRACEBUFFER, 0);
         /* FEAT_TRF (Self-hosted Trace Extension) */
-        cpu->isar.id_aa64dfr0 =
-            FIELD_DP64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, TRACEFILT, 0);
+        FIELD_DP64_IDREG(idregs, ID_AA64DFR0, TRACEFILT, 0);
         cpu->isar.id_dfr0 =
             FIELD_DP32(cpu->isar.id_dfr0, ID_DFR0, TRACEFILT, 0);
         /* Trace Macrocell system register access */
-        cpu->isar.id_aa64dfr0 =
-            FIELD_DP64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, TRACEVER, 0);
+        FIELD_DP64_IDREG(idregs, ID_AA64DFR0, TRACEVER, 0);
         cpu->isar.id_dfr0 =
             FIELD_DP32(cpu->isar.id_dfr0, ID_DFR0, COPTRC, 0);
         /* Memory mapped trace */
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index fbbec43dbdac..99b0c2a4b39d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1067,8 +1067,6 @@ struct ArchCPU {
         uint32_t dbgdidr;
         uint32_t dbgdevid;
         uint32_t dbgdevid1;
-        uint64_t id_aa64dfr0;
-        uint64_t id_aa64dfr1;
         uint64_t id_aa64smfr0;
         uint64_t reset_pmcr_el0;
         uint64_t idregs[NUM_ID_IDX];
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index ba39b8cc1ee0..22286a1844a4 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -649,7 +649,7 @@ static void aarch64_a57_initfn(Object *obj)
     cpu->isar.id_isar5 = 0x00011121;
     cpu->isar.id_isar6 = 0;
     SET_IDREG(idregs, ID_AA64PFR0, 0x00002222);
-    cpu->isar.id_aa64dfr0 = 0x10305106;
+    SET_IDREG(idregs, ID_AA64DFR0, 0x10305106);
     SET_IDREG(idregs, ID_AA64ISAR0, 0x00011120);
     SET_IDREG(idregs, ID_AA64MMFR0, 0x00001124);
     cpu->isar.dbgdidr = 0x3516d000;
@@ -711,7 +711,7 @@ static void aarch64_a53_initfn(Object *obj)
     cpu->isar.id_isar5 = 0x00011121;
     cpu->isar.id_isar6 = 0;
     SET_IDREG(idregs, ID_AA64PFR0, 0x00002222);
-    cpu->isar.id_aa64dfr0 = 0x10305106;
+    SET_IDREG(idregs, ID_AA64DFR0, 0x10305106);
     SET_IDREG(idregs, ID_AA64ISAR0, 0x00011120);
     SET_IDREG(idregs, ID_AA64MMFR0, 0x00001122); /* 40 bit physical addr */
     cpu->isar.dbgdidr = 0x3516d000;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index d1d9a0d53f08..437ba8a53934 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7740,12 +7740,12 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = cpu->isar.id_aa64dfr0 },
+              .resetvalue = GET_IDREG(idregs, ID_AA64DFR0) },
             { .name = "ID_AA64DFR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = cpu->isar.id_aa64dfr1 },
+              .resetvalue = GET_IDREG(idregs, ID_AA64DFR1) },
             { .name = "ID_AA64DFR2_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 863a84edf81c..af2590964754 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1035,7 +1035,7 @@ static inline bool regime_using_lpae_format(CPUARMState *env, ARMMMUIdx mmu_idx)
 static inline int arm_num_brps(ARMCPU *cpu)
 {
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
-        return FIELD_EX64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, BRPS) + 1;
+        return FIELD_EX64_IDREG(&cpu->isar.idregs, ID_AA64DFR0, BRPS) + 1;
     } else {
         return FIELD_EX32(cpu->isar.dbgdidr, DBGDIDR, BRPS) + 1;
     }
@@ -1049,7 +1049,7 @@ static inline int arm_num_brps(ARMCPU *cpu)
 static inline int arm_num_wrps(ARMCPU *cpu)
 {
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
-        return FIELD_EX64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, WRPS) + 1;
+        return FIELD_EX64_IDREG(&cpu->isar.idregs, ID_AA64DFR0, WRPS) + 1;
     } else {
         return FIELD_EX32(cpu->isar.dbgdidr, DBGDIDR, WRPS) + 1;
     }
@@ -1063,7 +1063,7 @@ static inline int arm_num_wrps(ARMCPU *cpu)
 static inline int arm_num_ctx_cmps(ARMCPU *cpu)
 {
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
-        return FIELD_EX64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, CTX_CMPS) + 1;
+        return FIELD_EX64_IDREG(&cpu->isar.idregs, ID_AA64DFR0, CTX_CMPS) + 1;
     } else {
         return FIELD_EX32(cpu->isar.dbgdidr, DBGDIDR, CTX_CMPS) + 1;
     }
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 87b5e7cec118..7597c84ff2ce 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -363,10 +363,8 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         err |= get_host_cpu_reg64(fd, ahcf, SYS_ID_AA64PFR1_EL1);
         err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64smfr0,
                               ARM64_SYS_REG(3, 0, 0, 4, 5));
-        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64dfr0,
-                              ARM64_SYS_REG(3, 0, 0, 5, 0));
-        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64dfr1,
-                              ARM64_SYS_REG(3, 0, 0, 5, 1));
+        err |= get_host_cpu_reg64(fd, ahcf, SYS_ID_AA64DFR0_EL1);
+        err |= get_host_cpu_reg64(fd, ahcf, SYS_ID_AA64DFR1_EL1);
         err |= get_host_cpu_reg64(fd, ahcf, SYS_ID_AA64ISAR0_EL1);
         err |= get_host_cpu_reg64(fd, ahcf, SYS_ID_AA64ISAR1_EL1);
         err |= get_host_cpu_reg64(fd, ahcf, SYS_ID_AA64ISAR2_EL1);
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 0f98c6981380..ce4cb449a381 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -65,8 +65,8 @@ static void aarch64_a35_initfn(Object *obj)
     cpu->isar.id_isar5 = 0x00011121;
     SET_IDREG(idregs, ID_AA64PFR0, 0x00002222);
     SET_IDREG(idregs, ID_AA64PFR1, 0);
-    cpu->isar.id_aa64dfr0 = 0x10305106;
-    cpu->isar.id_aa64dfr1 = 0;
+    SET_IDREG(idregs, ID_AA64DFR0, 0x10305106);
+    SET_IDREG(idregs, ID_AA64DFR1, 0);
     SET_IDREG(idregs, ID_AA64ISAR0, 0x00011120);
     SET_IDREG(idregs, ID_AA64ISAR1, 0);
     SET_IDREG(idregs, ID_AA64MMFR0, 0x00101122);
@@ -219,7 +219,7 @@ static void aarch64_a55_initfn(Object *obj)
     cpu->clidr = 0x82000023;
     cpu->ctr = 0x84448004; /* L1Ip = VIPT */
     cpu->dcz_blocksize = 4; /* 64 bytes */
-    cpu->isar.id_aa64dfr0  = 0x0000000010305408ull;
+    SET_IDREG(idregs, ID_AA64DFR0, 0x0000000010305408ull);
     SET_IDREG(idregs, ID_AA64ISAR0, 0x0000100010211120ull);
     SET_IDREG(idregs, ID_AA64ISAR1, 0x0000000000100001ull);
     SET_IDREG(idregs, ID_AA64MMFR0, 0x0000000000101122ull);
@@ -310,7 +310,7 @@ static void aarch64_a72_initfn(Object *obj)
     cpu->isar.id_isar4 = 0x00011142;
     cpu->isar.id_isar5 = 0x00011121;
     SET_IDREG(idregs, ID_AA64PFR0, 0x00002222);
-    cpu->isar.id_aa64dfr0 = 0x10305106;
+    SET_IDREG(idregs, ID_AA64DFR0, 0x10305106);
     SET_IDREG(idregs, ID_AA64ISAR0, 0x00011120);
     SET_IDREG(idregs, ID_AA64MMFR0, 0x00001124);
     cpu->isar.dbgdidr = 0x3516d000;
@@ -352,7 +352,7 @@ static void aarch64_a76_initfn(Object *obj)
     cpu->clidr = 0x82000023;
     cpu->ctr = 0x8444C004;
     cpu->dcz_blocksize = 4;
-    cpu->isar.id_aa64dfr0  = 0x0000000010305408ull;
+    SET_IDREG(idregs, ID_AA64DFR0, 0x0000000010305408ull),
     SET_IDREG(idregs, ID_AA64ISAR0, 0x0000100010211120ull);
     SET_IDREG(idregs, ID_AA64ISAR1, 0x0000000000100001ull);
     SET_IDREG(idregs, ID_AA64MMFR0, 0x0000000000101122ull);
@@ -426,8 +426,8 @@ static void aarch64_a64fx_initfn(Object *obj)
     cpu->reset_sctlr = 0x30000180;
     SET_IDREG(idregs, ID_AA64PFR0, 0x0000000101111111); /* No RAS Extensions */
     SET_IDREG(idregs, ID_AA64PFR1, 0x0000000000000000);
-    cpu->isar.id_aa64dfr0 = 0x0000000010305408;
-    cpu->isar.id_aa64dfr1 = 0x0000000000000000;
+    SET_IDREG(idregs, ID_AA64DFR0, 0x0000000010305408),
+    SET_IDREG(idregs, ID_AA64DFR1, 0x0000000000000000),
     cpu->id_aa64afr0 = 0x0000000000000000;
     cpu->id_aa64afr1 = 0x0000000000000000;
     SET_IDREG(idregs, ID_AA64MMFR0, 0x0000000000001122);
@@ -600,7 +600,7 @@ static void aarch64_neoverse_n1_initfn(Object *obj)
     cpu->clidr = 0x82000023;
     cpu->ctr = 0x8444c004;
     cpu->dcz_blocksize = 4;
-    cpu->isar.id_aa64dfr0  = 0x0000000110305408ull;
+    SET_IDREG(idregs, ID_AA64DFR0, 0x0000000110305408ull);
     SET_IDREG(idregs, ID_AA64ISAR0, 0x0000100010211120ull);
     SET_IDREG(idregs, ID_AA64ISAR1, 0x0000000000100001ull);
     SET_IDREG(idregs, ID_AA64MMFR0, 0x0000000000101125ull);
@@ -678,8 +678,8 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
     cpu->dcz_blocksize = 4;
     cpu->id_aa64afr0 = 0x00000000;
     cpu->id_aa64afr1 = 0x00000000;
-    cpu->isar.id_aa64dfr0  = 0x000001f210305519ull;
-    cpu->isar.id_aa64dfr1 = 0x00000000;
+    SET_IDREG(idregs, ID_AA64DFR0, 0x000001f210305519ull),
+    SET_IDREG(idregs, ID_AA64DFR1, 0x00000000),
     SET_IDREG(idregs, ID_AA64ISAR0, 0x1011111110212120ull); /* with FEAT_RNG */
     SET_IDREG(idregs, ID_AA64ISAR1, 0x0011000001211032ull);
     SET_IDREG(idregs, ID_AA64MMFR0, 0x0000000000101125ull);
@@ -925,8 +925,9 @@ static void aarch64_a710_initfn(Object *obj)
     SET_IDREG(idregs, ID_AA64PFR0, 0x1201111120111112ull); /* GIC filled in later */
     SET_IDREG(idregs, ID_AA64PFR1, 0x0000000000000221ull);
     SET_IDREG(idregs, ID_AA64ZFR0, 0x0000110100110021ull); /* with Crypto */
-    cpu->isar.id_aa64dfr0  = 0x000011f010305619ull;
-    cpu->isar.id_aa64dfr1  = 0;
+    SET_IDREG(idregs, ID_AA64DFR0, 0x000011f010305619ull);
+    SET_IDREG(idregs, ID_AA64DFR0, 0x000011f010305619ull);
+    SET_IDREG(idregs, ID_AA64DFR1, 0);
     cpu->id_aa64afr0       = 0;
     cpu->id_aa64afr1       = 0;
     SET_IDREG(idregs, ID_AA64ISAR0, 0x0221111110212120ull); /* with Crypto */
@@ -1027,8 +1028,8 @@ static void aarch64_neoverse_n2_initfn(Object *obj)
     SET_IDREG(idregs, ID_AA64PFR0, 0x1201111120111112ull); /* GIC filled in later */
     SET_IDREG(idregs, ID_AA64PFR1, 0x0000000000000221ull);
     SET_IDREG(idregs, ID_AA64ZFR0, 0x0000110100110021ull); /* with Crypto */
-    cpu->isar.id_aa64dfr0  = 0x000011f210305619ull;
-    cpu->isar.id_aa64dfr1  = 0;
+    SET_IDREG(idregs, ID_AA64DFR0, 0x000011f210305619ull);
+    SET_IDREG(idregs, ID_AA64DFR1, 0);
     cpu->id_aa64afr0       = 0;
     cpu->id_aa64afr1       = 0;
     SET_IDREG(idregs, ID_AA64ISAR0, 0x1221111110212120ull); /* with Crypto and FEAT_RNG */
@@ -1259,11 +1260,11 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ZFR0, F64MM, 1);     /* FEAT_F64MM */
     SET_IDREG(idregs, ID_AA64ZFR0, t);
 
-    t = cpu->isar.id_aa64dfr0;
+    t = GET_IDREG(idregs, ID_AA64DFR0);
     t = FIELD_DP64(t, ID_AA64DFR0, DEBUGVER, 10); /* FEAT_Debugv8p8 */
     t = FIELD_DP64(t, ID_AA64DFR0, PMUVER, 6);    /* FEAT_PMUv3p5 */
     t = FIELD_DP64(t, ID_AA64DFR0, HPMN0, 1);     /* FEAT_HPMN0 */
-    cpu->isar.id_aa64dfr0 = t;
+    SET_IDREG(idregs, ID_AA64DFR0, t);
 
     t = cpu->isar.id_aa64smfr0;
     t = FIELD_DP64(t, ID_AA64SMFR0, F32F32, 1);   /* FEAT_SME */
-- 
2.48.1


