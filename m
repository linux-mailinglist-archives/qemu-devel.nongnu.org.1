Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 911F5A82873
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Apr 2025 16:47:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2WeZ-0008IN-T9; Wed, 09 Apr 2025 10:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1u2WeW-0008Gq-Uj
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 10:43:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1u2WeQ-0006A8-KN
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 10:43:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744209815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j1l3HkQcrDrLz1xvELCNLE/9BnrKcpujJN5qXpUnHaE=;
 b=NF2S/cNxFLKvFccwp7XwPGyWGrLJfoGwevYAZNN2gZizmcEoi4icrx+h3z8Z2JV5XuNsq6
 oFhx9IxqTqVqZ5Cpjj2QNYBfM3ljVNIy1iN3PGnWwjOvsZoK6L1gOuM9w1BYPM6EBAAtVG
 RW59k9GVajzSWXaiiNa3l2wUEJEvTuU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-TcJAfdk3NLe6Ystz7wjVnQ-1; Wed,
 09 Apr 2025 10:43:33 -0400
X-MC-Unique: TcJAfdk3NLe6Ystz7wjVnQ-1
X-Mimecast-MFC-AGG-ID: TcJAfdk3NLe6Ystz7wjVnQ_1744209811
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 183A818001FB; Wed,  9 Apr 2025 14:43:31 +0000 (UTC)
Received: from gondolin.redhat.com (unknown [10.45.227.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E4D7E1828A87; Wed,  9 Apr 2025 14:43:23 +0000 (UTC)
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
Subject: [PATCH for-10.1 v5 02/13] arm/cpu: Store aa64isar0/aa64zfr0 into the
 idregs arrays
Date: Wed,  9 Apr 2025 16:42:53 +0200
Message-ID: <20250409144304.912325-3-cohuck@redhat.com>
In-Reply-To: <20250409144304.912325-1-cohuck@redhat.com>
References: <20250409144304.912325-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.505,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Eric Auger <eric.auger@redhat.com>

Also add kvm add accessors for storing host features into idregs.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Sebastian Ott <sebott@redhat.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/arm/cpu-features.h | 57 ++++++++++++++++++++-------------------
 target/arm/cpu-sysregs.h  |  4 +++
 target/arm/cpu.c          | 10 +++----
 target/arm/cpu.h          |  2 --
 target/arm/cpu64.c        |  8 +++---
 target/arm/helper.c       |  6 +++--
 target/arm/hvf/hvf.c      |  3 ++-
 target/arm/kvm.c          | 30 ++++++++++++++++++---
 target/arm/tcg/cpu64.c    | 44 ++++++++++++++++++------------
 9 files changed, 101 insertions(+), 63 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 525e4cee12f6..779bcd1abb36 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -22,6 +22,7 @@
 
 #include "hw/registerfields.h"
 #include "qemu/host-utils.h"
+#include "cpu-sysregs.h"
 
 /*
  * Naming convention for isar_feature functions:
@@ -376,92 +377,92 @@ static inline bool isar_feature_aa32_doublelock(const ARMISARegisters *id)
  */
 static inline bool isar_feature_aa64_aes(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, AES) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR0, AES) != 0;
 }
 
 static inline bool isar_feature_aa64_pmull(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, AES) > 1;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR0, AES) > 1;
 }
 
 static inline bool isar_feature_aa64_sha1(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, SHA1) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR0, SHA1) != 0;
 }
 
 static inline bool isar_feature_aa64_sha256(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, SHA2) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR0, SHA2) != 0;
 }
 
 static inline bool isar_feature_aa64_sha512(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, SHA2) > 1;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR0, SHA2) > 1;
 }
 
 static inline bool isar_feature_aa64_crc32(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, CRC32) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR0, CRC32) != 0;
 }
 
 static inline bool isar_feature_aa64_atomics(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, ATOMIC) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR0, ATOMIC) != 0;
 }
 
 static inline bool isar_feature_aa64_rdm(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, RDM) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR0, RDM) != 0;
 }
 
 static inline bool isar_feature_aa64_sha3(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, SHA3) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR0, SHA3) != 0;
 }
 
 static inline bool isar_feature_aa64_sm3(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, SM3) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR0, SM3) != 0;
 }
 
 static inline bool isar_feature_aa64_sm4(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, SM4) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR0, SM4) != 0;
 }
 
 static inline bool isar_feature_aa64_dp(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, DP) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR0, DP) != 0;
 }
 
 static inline bool isar_feature_aa64_fhm(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, FHM) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR0, FHM) != 0;
 }
 
 static inline bool isar_feature_aa64_condm_4(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, TS) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR0, TS) != 0;
 }
 
 static inline bool isar_feature_aa64_condm_5(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, TS) >= 2;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR0, TS) >= 2;
 }
 
 static inline bool isar_feature_aa64_rndr(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, RNDR) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR0, RNDR) != 0;
 }
 
 static inline bool isar_feature_aa64_tlbirange(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, TLB) == 2;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR0, TLB) == 2;
 }
 
 static inline bool isar_feature_aa64_tlbios(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, TLB) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR0, TLB) != 0;
 }
 
 static inline bool isar_feature_aa64_jscvt(const ARMISARegisters *id)
@@ -927,52 +928,52 @@ static inline bool isar_feature_aa64_doublelock(const ARMISARegisters *id)
 
 static inline bool isar_feature_aa64_sve2(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, SVEVER) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ZFR0, SVEVER) != 0;
 }
 
 static inline bool isar_feature_aa64_sve2_aes(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, AES) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ZFR0, AES) != 0;
 }
 
 static inline bool isar_feature_aa64_sve2_pmull128(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, AES) >= 2;
+    return FIELD_EX64_IDREG(id, ID_AA64ZFR0, AES) >= 2;
 }
 
 static inline bool isar_feature_aa64_sve2_bitperm(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, BITPERM) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ZFR0, BITPERM) != 0;
 }
 
 static inline bool isar_feature_aa64_sve_bf16(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, BFLOAT16) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ZFR0, BFLOAT16) != 0;
 }
 
 static inline bool isar_feature_aa64_sve2_sha3(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, SHA3) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ZFR0, SHA3) != 0;
 }
 
 static inline bool isar_feature_aa64_sve2_sm4(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, SM4) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ZFR0, SM4) != 0;
 }
 
 static inline bool isar_feature_aa64_sve_i8mm(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, I8MM) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ZFR0, I8MM) != 0;
 }
 
 static inline bool isar_feature_aa64_sve_f32mm(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, F32MM) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ZFR0, F32MM) != 0;
 }
 
 static inline bool isar_feature_aa64_sve_f64mm(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, F64MM) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ZFR0, F64MM) != 0;
 }
 
 static inline bool isar_feature_aa64_sme_f64f64(const ARMISARegisters *id)
diff --git a/target/arm/cpu-sysregs.h b/target/arm/cpu-sysregs.h
index 7877a3b06a8e..e89a1105904c 100644
--- a/target/arm/cpu-sysregs.h
+++ b/target/arm/cpu-sysregs.h
@@ -39,4 +39,8 @@ extern const uint32_t id_register_sysreg[NUM_ID_IDX];
 
 int get_sysreg_idx(ARMSysRegs sysreg);
 
+#ifdef CONFIG_KVM
+uint64_t idregs_sysreg_to_kvm_reg(ARMSysRegs sysreg);
+#endif
+
 #endif /* ARM_CPU_SYSREGS_H */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 01786ac7879c..750a4e957cb2 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1968,6 +1968,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
     ARMCPU *cpu = ARM_CPU(dev);
+    ARMISARegisters *isar = &cpu->isar;
     ARMCPUClass *acc = ARM_CPU_GET_CLASS(dev);
     CPUARMState *env = &cpu->env;
     Error *local_err = NULL;
@@ -2173,7 +2174,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 
         unset_feature(env, ARM_FEATURE_NEON);
 
-        t = cpu->isar.id_aa64isar0;
+        t = GET_IDREG(isar, ID_AA64ISAR0);
         t = FIELD_DP64(t, ID_AA64ISAR0, AES, 0);
         t = FIELD_DP64(t, ID_AA64ISAR0, SHA1, 0);
         t = FIELD_DP64(t, ID_AA64ISAR0, SHA2, 0);
@@ -2181,7 +2182,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         t = FIELD_DP64(t, ID_AA64ISAR0, SM3, 0);
         t = FIELD_DP64(t, ID_AA64ISAR0, SM4, 0);
         t = FIELD_DP64(t, ID_AA64ISAR0, DP, 0);
-        cpu->isar.id_aa64isar0 = t;
+        SET_IDREG(isar, ID_AA64ISAR0, t);
 
         t = cpu->isar.id_aa64isar1;
         t = FIELD_DP64(t, ID_AA64ISAR1, FCMA, 0);
@@ -2223,12 +2224,9 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
     if (!cpu->has_neon && !cpu->has_vfp) {
-        uint64_t t;
         uint32_t u;
 
-        t = cpu->isar.id_aa64isar0;
-        t = FIELD_DP64(t, ID_AA64ISAR0, FHM, 0);
-        cpu->isar.id_aa64isar0 = t;
+        FIELD_DP64_IDREG(isar, ID_AA64ISAR0, FHM, 0);
 
         t = cpu->isar.id_aa64isar1;
         t = FIELD_DP64(t, ID_AA64ISAR1, FRINTTS, 0);
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 5048c85b188c..57d00da0a927 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1097,7 +1097,6 @@ struct ArchCPU {
         uint32_t dbgdidr;
         uint32_t dbgdevid;
         uint32_t dbgdevid1;
-        uint64_t id_aa64isar0;
         uint64_t id_aa64isar1;
         uint64_t id_aa64isar2;
         uint64_t id_aa64pfr0;
@@ -1108,7 +1107,6 @@ struct ArchCPU {
         uint64_t id_aa64mmfr3;
         uint64_t id_aa64dfr0;
         uint64_t id_aa64dfr1;
-        uint64_t id_aa64zfr0;
         uint64_t id_aa64smfr0;
         uint64_t reset_pmcr_el0;
         uint64_t idregs[NUM_ID_IDX];
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 62eff5375c19..c781efeb7cef 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -136,7 +136,7 @@ void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
              * SVE is disabled and so are all vector lengths.  Good.
              * Disable all SVE extensions as well.
              */
-            cpu->isar.id_aa64zfr0 = 0;
+            SET_IDREG(&cpu->isar, ID_AA64ZFR0, 0);
             return;
         }
 
@@ -639,6 +639,7 @@ void arm_cpu_lpa2_finalize(ARMCPU *cpu, Error **errp)
 static void aarch64_a57_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
+    ARMISARegisters *isar = &cpu->isar;
 
     cpu->dtb_compatible = "arm,cortex-a57";
     set_feature(&cpu->env, ARM_FEATURE_V8);
@@ -676,7 +677,7 @@ static void aarch64_a57_initfn(Object *obj)
     cpu->isar.id_isar6 = 0;
     cpu->isar.id_aa64pfr0 = 0x00002222;
     cpu->isar.id_aa64dfr0 = 0x10305106;
-    cpu->isar.id_aa64isar0 = 0x00011120;
+    SET_IDREG(isar, ID_AA64ISAR0, 0x00011120);
     cpu->isar.id_aa64mmfr0 = 0x00001124;
     cpu->isar.dbgdidr = 0x3516d000;
     cpu->isar.dbgdevid = 0x01110f13;
@@ -700,6 +701,7 @@ static void aarch64_a57_initfn(Object *obj)
 static void aarch64_a53_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
+    ARMISARegisters *isar = &cpu->isar;
 
     cpu->dtb_compatible = "arm,cortex-a53";
     set_feature(&cpu->env, ARM_FEATURE_V8);
@@ -737,7 +739,7 @@ static void aarch64_a53_initfn(Object *obj)
     cpu->isar.id_isar6 = 0;
     cpu->isar.id_aa64pfr0 = 0x00002222;
     cpu->isar.id_aa64dfr0 = 0x10305106;
-    cpu->isar.id_aa64isar0 = 0x00011120;
+    SET_IDREG(isar, ID_AA64ISAR0, 0x00011120);
     cpu->isar.id_aa64mmfr0 = 0x00001122; /* 40 bit physical addr */
     cpu->isar.dbgdidr = 0x3516d000;
     cpu->isar.dbgdevid = 0x00110f13;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index bb445e30cd15..8062e5190425 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7750,6 +7750,8 @@ void register_cp_regs_for_features(ARMCPU *cpu)
 {
     /* Register all the coprocessor registers based on feature bits */
     CPUARMState *env = &cpu->env;
+    ARMISARegisters *isar = &cpu->isar;
+
     if (arm_feature(env, ARM_FEATURE_M)) {
         /* M profile has no coprocessor registers */
         return;
@@ -7939,7 +7941,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = cpu->isar.id_aa64zfr0 },
+              .resetvalue = GET_IDREG(isar, ID_AA64ZFR0)},
             { .name = "ID_AA64SMFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
@@ -7999,7 +8001,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = cpu->isar.id_aa64isar0 },
+              .resetvalue = GET_IDREG(isar, ID_AA64ISAR0)},
             { .name = "ID_AA64ISAR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 2439af63a05a..0213702ef094 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -19,6 +19,7 @@
 #include "system/hw_accel.h"
 #include "hvf_arm.h"
 #include "cpregs.h"
+#include "cpu-sysregs.h"
 
 #include <mach/mach_time.h>
 
@@ -865,7 +866,7 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         { HV_SYS_REG_ID_AA64PFR1_EL1, &host_isar.id_aa64pfr1 },
         { HV_SYS_REG_ID_AA64DFR0_EL1, &host_isar.id_aa64dfr0 },
         { HV_SYS_REG_ID_AA64DFR1_EL1, &host_isar.id_aa64dfr1 },
-        { HV_SYS_REG_ID_AA64ISAR0_EL1, &host_isar.id_aa64isar0 },
+        { HV_SYS_REG_ID_AA64ISAR0_EL1, &host_isar.idregs[ID_AA64ISAR0_EL1_IDX] },
         { HV_SYS_REG_ID_AA64ISAR1_EL1, &host_isar.id_aa64isar1 },
         /* Add ID_AA64ISAR2_EL1 here when HVF supports it */
         { HV_SYS_REG_ID_AA64MMFR0_EL1, &host_isar.id_aa64mmfr0 },
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index da30bdbb2349..d187df80f077 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -26,6 +26,7 @@
 #include "system/kvm_int.h"
 #include "kvm_arm.h"
 #include "cpu.h"
+#include "cpu-sysregs.h"
 #include "trace.h"
 #include "internals.h"
 #include "hw/pci/pci.h"
@@ -246,6 +247,28 @@ static bool kvm_arm_pauth_supported(void)
             kvm_check_extension(kvm_state, KVM_CAP_ARM_PTRAUTH_GENERIC));
 }
 
+
+uint64_t idregs_sysreg_to_kvm_reg(ARMSysRegs sysreg)
+{
+    return ARM64_SYS_REG((sysreg & CP_REG_ARM64_SYSREG_OP0_MASK) >> CP_REG_ARM64_SYSREG_OP0_SHIFT,
+                         (sysreg & CP_REG_ARM64_SYSREG_OP1_MASK) >> CP_REG_ARM64_SYSREG_OP1_SHIFT,
+                         (sysreg & CP_REG_ARM64_SYSREG_CRN_MASK) >> CP_REG_ARM64_SYSREG_CRN_SHIFT,
+                         (sysreg & CP_REG_ARM64_SYSREG_CRM_MASK) >> CP_REG_ARM64_SYSREG_CRM_SHIFT,
+                         (sysreg & CP_REG_ARM64_SYSREG_OP2_MASK) >> CP_REG_ARM64_SYSREG_OP2_SHIFT);
+}
+
+/* read a sysreg value and store it in the idregs */
+static int get_host_cpu_reg(int fd, ARMHostCPUFeatures *ahcf, ARMIDRegisterIdx index)
+{
+    uint64_t *reg;
+    int ret;
+
+    reg = &ahcf->isar.idregs[index];
+    ret = read_sys_reg64(fd, reg,
+                         idregs_sysreg_to_kvm_reg(id_register_sysreg[index]));
+    return ret;
+}
+
 static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 {
     /* Identify the feature bits corresponding to the host CPU, and
@@ -306,6 +329,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 
     ahcf->target = init.target;
     ahcf->dtb_compatible = "arm,arm-v8";
+    int fd = fdarray[2];
 
     err = read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64pfr0,
                          ARM64_SYS_REG(3, 0, 0, 4, 0));
@@ -337,8 +361,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
                               ARM64_SYS_REG(3, 0, 0, 5, 0));
         err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64dfr1,
                               ARM64_SYS_REG(3, 0, 0, 5, 1));
-        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64isar0,
-                              ARM64_SYS_REG(3, 0, 0, 6, 0));
+        err |= get_host_cpu_reg(fd, ahcf, ID_AA64ISAR0_EL1_IDX);
         err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64isar1,
                               ARM64_SYS_REG(3, 0, 0, 6, 1));
         err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64isar2,
@@ -447,8 +470,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
              * enabled SVE support, which resulted in an error rather than RAZ.
              * So only read the register if we set KVM_ARM_VCPU_SVE above.
              */
-            err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64zfr0,
-                                  ARM64_SYS_REG(3, 0, 0, 4, 4));
+            err |= get_host_cpu_reg(fd, ahcf, ID_AA64ZFR0_EL1_IDX);
         }
     }
 
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 29ab0ac79da9..f31bb9ceaac9 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -32,6 +32,7 @@
 static void aarch64_a35_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
+    ARMISARegisters *isar = &cpu->isar;
 
     cpu->dtb_compatible = "arm,cortex-a35";
     set_feature(&cpu->env, ARM_FEATURE_V8);
@@ -66,7 +67,7 @@ static void aarch64_a35_initfn(Object *obj)
     cpu->isar.id_aa64pfr1 = 0;
     cpu->isar.id_aa64dfr0 = 0x10305106;
     cpu->isar.id_aa64dfr1 = 0;
-    cpu->isar.id_aa64isar0 = 0x00011120;
+    SET_IDREG(isar, ID_AA64ISAR0, 0x00011120);
     cpu->isar.id_aa64isar1 = 0;
     cpu->isar.id_aa64mmfr0 = 0x00101122;
     cpu->isar.id_aa64mmfr1 = 0;
@@ -204,6 +205,7 @@ static const Property arm_cpu_lpa2_property =
 static void aarch64_a55_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
+    ARMISARegisters *isar = &cpu->isar;
 
     cpu->dtb_compatible = "arm,cortex-a55";
     set_feature(&cpu->env, ARM_FEATURE_V8);
@@ -221,7 +223,7 @@ static void aarch64_a55_initfn(Object *obj)
     cpu->ctr = 0x84448004; /* L1Ip = VIPT */
     cpu->dcz_blocksize = 4; /* 64 bytes */
     cpu->isar.id_aa64dfr0  = 0x0000000010305408ull;
-    cpu->isar.id_aa64isar0 = 0x0000100010211120ull;
+    SET_IDREG(isar, ID_AA64ISAR0, 0x0000100010211120ull);
     cpu->isar.id_aa64isar1 = 0x0000000000100001ull;
     cpu->isar.id_aa64mmfr0 = 0x0000000000101122ull;
     cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;
@@ -276,6 +278,7 @@ static void aarch64_a55_initfn(Object *obj)
 static void aarch64_a72_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
+    ARMISARegisters *isar = &cpu->isar;
 
     cpu->dtb_compatible = "arm,cortex-a72";
     set_feature(&cpu->env, ARM_FEATURE_V8);
@@ -311,7 +314,7 @@ static void aarch64_a72_initfn(Object *obj)
     cpu->isar.id_isar5 = 0x00011121;
     cpu->isar.id_aa64pfr0 = 0x00002222;
     cpu->isar.id_aa64dfr0 = 0x10305106;
-    cpu->isar.id_aa64isar0 = 0x00011120;
+    SET_IDREG(isar, ID_AA64ISAR0, 0x00011120);
     cpu->isar.id_aa64mmfr0 = 0x00001124;
     cpu->isar.dbgdidr = 0x3516d000;
     cpu->isar.dbgdevid = 0x01110f13;
@@ -335,6 +338,7 @@ static void aarch64_a72_initfn(Object *obj)
 static void aarch64_a76_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
+    ARMISARegisters *isar = &cpu->isar;
 
     cpu->dtb_compatible = "arm,cortex-a76";
     set_feature(&cpu->env, ARM_FEATURE_V8);
@@ -352,7 +356,7 @@ static void aarch64_a76_initfn(Object *obj)
     cpu->ctr = 0x8444C004;
     cpu->dcz_blocksize = 4;
     cpu->isar.id_aa64dfr0  = 0x0000000010305408ull;
-    cpu->isar.id_aa64isar0 = 0x0000100010211120ull;
+    SET_IDREG(isar, ID_AA64ISAR0, 0x0000100010211120ull);
     cpu->isar.id_aa64isar1 = 0x0000000000100001ull;
     cpu->isar.id_aa64mmfr0 = 0x0000000000101122ull;
     cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;
@@ -408,6 +412,7 @@ static void aarch64_a76_initfn(Object *obj)
 static void aarch64_a64fx_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
+    ARMISARegisters *isar = &cpu->isar;
 
     cpu->dtb_compatible = "arm,a64fx";
     set_feature(&cpu->env, ARM_FEATURE_V8);
@@ -431,9 +436,9 @@ static void aarch64_a64fx_initfn(Object *obj)
     cpu->isar.id_aa64mmfr0 = 0x0000000000001122;
     cpu->isar.id_aa64mmfr1 = 0x0000000011212100;
     cpu->isar.id_aa64mmfr2 = 0x0000000000001011;
-    cpu->isar.id_aa64isar0 = 0x0000000010211120;
+    SET_IDREG(isar, ID_AA64ISAR0, 0x0000000010211120);
     cpu->isar.id_aa64isar1 = 0x0000000000010001;
-    cpu->isar.id_aa64zfr0 = 0x0000000000000000;
+    SET_IDREG(isar, ID_AA64ZFR0, 0x0000000000000000);
     cpu->clidr = 0x0000000080000023;
     /* 64KB L1 dcache */
     cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 256, 64 * KiB, 7);
@@ -581,6 +586,7 @@ static void define_neoverse_v1_cp_reginfo(ARMCPU *cpu)
 static void aarch64_neoverse_n1_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
+    ARMISARegisters *isar = &cpu->isar;
 
     cpu->dtb_compatible = "arm,neoverse-n1";
     set_feature(&cpu->env, ARM_FEATURE_V8);
@@ -598,7 +604,7 @@ static void aarch64_neoverse_n1_initfn(Object *obj)
     cpu->ctr = 0x8444c004;
     cpu->dcz_blocksize = 4;
     cpu->isar.id_aa64dfr0  = 0x0000000110305408ull;
-    cpu->isar.id_aa64isar0 = 0x0000100010211120ull;
+    SET_IDREG(isar, ID_AA64ISAR0, 0x0000100010211120ull);
     cpu->isar.id_aa64isar1 = 0x0000000000100001ull;
     cpu->isar.id_aa64mmfr0 = 0x0000000000101125ull;
     cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;
@@ -656,6 +662,7 @@ static void aarch64_neoverse_n1_initfn(Object *obj)
 static void aarch64_neoverse_v1_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
+    ARMISARegisters *isar = &cpu->isar;
 
     cpu->dtb_compatible = "arm,neoverse-v1";
     set_feature(&cpu->env, ARM_FEATURE_V8);
@@ -676,7 +683,7 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
     cpu->id_aa64afr1 = 0x00000000;
     cpu->isar.id_aa64dfr0  = 0x000001f210305519ull;
     cpu->isar.id_aa64dfr1 = 0x00000000;
-    cpu->isar.id_aa64isar0 = 0x1011111110212120ull; /* with FEAT_RNG */
+    SET_IDREG(isar, ID_AA64ISAR0, 0x1011111110212120ull); /* with FEAT_RNG */
     cpu->isar.id_aa64isar1 = 0x0011100001211032ull;
     cpu->isar.id_aa64mmfr0 = 0x0000000000101125ull;
     cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;
@@ -735,7 +742,7 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
     cpu->isar.mvfr2 = 0x00000043;
 
     /* From 3.7.5 ID_AA64ZFR0_EL1 */
-    cpu->isar.id_aa64zfr0 = 0x0000100000100000;
+    SET_IDREG(isar, ID_AA64ZFR0, 0x0000100000100000);
     cpu->sve_vq.supported = (1 << 0)  /* 128bit */
                             | (1 << 1);  /* 256bit */
 
@@ -882,6 +889,7 @@ static const ARMCPRegInfo cortex_a710_cp_reginfo[] = {
 static void aarch64_a710_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
+    ARMISARegisters *isar = &cpu->isar;
 
     cpu->dtb_compatible = "arm,cortex-a710";
     set_feature(&cpu->env, ARM_FEATURE_V8);
@@ -919,12 +927,12 @@ static void aarch64_a710_initfn(Object *obj)
     cpu->isar.id_pfr2  = 0x00000011;
     cpu->isar.id_aa64pfr0  = 0x1201111120111112ull; /* GIC filled in later */
     cpu->isar.id_aa64pfr1  = 0x0000000000000221ull;
-    cpu->isar.id_aa64zfr0  = 0x0000110100110021ull; /* with Crypto */
+    SET_IDREG(isar, ID_AA64ZFR0, 0x0000110100110021ull); /* with Crypto */
     cpu->isar.id_aa64dfr0  = 0x000011f010305619ull;
     cpu->isar.id_aa64dfr1  = 0;
     cpu->id_aa64afr0       = 0;
     cpu->id_aa64afr1       = 0;
-    cpu->isar.id_aa64isar0 = 0x0221111110212120ull; /* with Crypto */
+    SET_IDREG(isar, ID_AA64ISAR0, 0x0221111110212120ull); /* with Crypto */
     cpu->isar.id_aa64isar1 = 0x0010111101211052ull;
     cpu->isar.id_aa64mmfr0 = 0x0000022200101122ull;
     cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;
@@ -983,6 +991,7 @@ static const ARMCPRegInfo neoverse_n2_cp_reginfo[] = {
 static void aarch64_neoverse_n2_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
+    ARMISARegisters *isar = &cpu->isar;
 
     cpu->dtb_compatible = "arm,neoverse-n2";
     set_feature(&cpu->env, ARM_FEATURE_V8);
@@ -1020,12 +1029,12 @@ static void aarch64_neoverse_n2_initfn(Object *obj)
     cpu->isar.id_pfr2  = 0x00000011;
     cpu->isar.id_aa64pfr0  = 0x1201111120111112ull; /* GIC filled in later */
     cpu->isar.id_aa64pfr1  = 0x0000000000000221ull;
-    cpu->isar.id_aa64zfr0  = 0x0000110100110021ull; /* with Crypto */
+    SET_IDREG(isar, ID_AA64ZFR0, 0x0000110100110021ull); /* with Crypto */
     cpu->isar.id_aa64dfr0  = 0x000011f210305619ull;
     cpu->isar.id_aa64dfr1  = 0;
     cpu->id_aa64afr0       = 0;
     cpu->id_aa64afr1       = 0;
-    cpu->isar.id_aa64isar0 = 0x1221111110212120ull; /* with Crypto and FEAT_RNG */
+    SET_IDREG(isar, ID_AA64ISAR0, 0x1221111110212120ull); /* with Crypto and FEAT_RNG */
     cpu->isar.id_aa64isar1 = 0x0011111101211052ull;
     cpu->isar.id_aa64mmfr0 = 0x0000022200101125ull;
     cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;
@@ -1083,6 +1092,7 @@ static void aarch64_neoverse_n2_initfn(Object *obj)
 void aarch64_max_tcg_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
+    ARMISARegisters *isar = &cpu->isar;
     uint64_t t;
     uint32_t u;
 
@@ -1133,7 +1143,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, CTR_EL0, DIC, 1);
     cpu->ctr = t;
 
-    t = cpu->isar.id_aa64isar0;
+    t = GET_IDREG(isar, ID_AA64ISAR0);
     t = FIELD_DP64(t, ID_AA64ISAR0, AES, 2);      /* FEAT_PMULL */
     t = FIELD_DP64(t, ID_AA64ISAR0, SHA1, 1);     /* FEAT_SHA1 */
     t = FIELD_DP64(t, ID_AA64ISAR0, SHA2, 2);     /* FEAT_SHA512 */
@@ -1148,7 +1158,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ISAR0, TS, 2);       /* FEAT_FlagM2 */
     t = FIELD_DP64(t, ID_AA64ISAR0, TLB, 2);      /* FEAT_TLBIRANGE */
     t = FIELD_DP64(t, ID_AA64ISAR0, RNDR, 1);     /* FEAT_RNG */
-    cpu->isar.id_aa64isar0 = t;
+    SET_IDREG(isar, ID_AA64ISAR0, t);
 
     t = cpu->isar.id_aa64isar1;
     t = FIELD_DP64(t, ID_AA64ISAR1, DPB, 2);      /* FEAT_DPB2 */
@@ -1244,7 +1254,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64MMFR3, SPEC_FPACC, 1); /* FEAT_FPACC_SPEC */
     cpu->isar.id_aa64mmfr3 = t;
 
-    t = cpu->isar.id_aa64zfr0;
+    t = GET_IDREG(isar, ID_AA64ZFR0);
     t = FIELD_DP64(t, ID_AA64ZFR0, SVEVER, 1);
     t = FIELD_DP64(t, ID_AA64ZFR0, AES, 2);       /* FEAT_SVE_PMULL128 */
     t = FIELD_DP64(t, ID_AA64ZFR0, BITPERM, 1);   /* FEAT_SVE_BitPerm */
@@ -1254,7 +1264,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ZFR0, I8MM, 1);      /* FEAT_I8MM */
     t = FIELD_DP64(t, ID_AA64ZFR0, F32MM, 1);     /* FEAT_F32MM */
     t = FIELD_DP64(t, ID_AA64ZFR0, F64MM, 1);     /* FEAT_F64MM */
-    cpu->isar.id_aa64zfr0 = t;
+    SET_IDREG(isar, ID_AA64ZFR0, t);
 
     t = cpu->isar.id_aa64dfr0;
     t = FIELD_DP64(t, ID_AA64DFR0, DEBUGVER, 10); /* FEAT_Debugv8p8 */
-- 
2.48.1


