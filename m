Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BB4A2C14E
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Feb 2025 12:08:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgMDG-0000dn-1b; Fri, 07 Feb 2025 06:07:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1tgMBl-00071k-42
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 06:06:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1tgMBh-0008Q6-Ta
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 06:06:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738926381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wrU20zztoNMIPrqfac+dLwEzESy8wjt5moiw757q8rY=;
 b=Fw60u/B23T9aBlRcpnyKbfhj4OELEc339lidIIl4BH5KD3Pc1vAKqWKrRRkn0E0AZ1uokD
 w8ETzB//DK5DrUyT4iMopoo01b+SH81d4nQr07s9ZLs1QQ3nR/toB2Gc1xdYViQJKnzKoO
 B/KNzyK092+41UP5P6pFhwIpVX62R7M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-426-jJiK21XlMfCM9Q8lLvY9NA-1; Fri,
 07 Feb 2025 06:06:15 -0500
X-MC-Unique: jJiK21XlMfCM9Q8lLvY9NA-1
X-Mimecast-MFC-AGG-ID: jJiK21XlMfCM9Q8lLvY9NA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA7AA1800876; Fri,  7 Feb 2025 11:06:13 +0000 (UTC)
Received: from gondolin.redhat.com (unknown [10.67.24.130])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3DA5B19560A3; Fri,  7 Feb 2025 11:05:59 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 oliver.upton@linux.dev, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com
Cc: shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org,
 pbonzini@redhat.com, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 12/15] arm/cpu: Store id_mmfr0-5 into the idregs array
Date: Fri,  7 Feb 2025 12:02:45 +0100
Message-ID: <20250207110248.1580465-13-cohuck@redhat.com>
In-Reply-To: <20250207110248.1580465-1-cohuck@redhat.com>
References: <20250207110248.1580465-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 hw/intc/armv7m_nvic.c     |  8 ++--
 target/arm/cpu-features.h | 18 ++++----
 target/arm/cpu.h          |  6 ---
 target/arm/cpu64.c        | 16 +++----
 target/arm/helper.c       | 12 ++---
 target/arm/kvm.c          | 18 +++-----
 target/arm/tcg/cpu-v7m.c  | 48 ++++++++++----------
 target/arm/tcg/cpu32.c    | 94 +++++++++++++++++++--------------------
 target/arm/tcg/cpu64.c    | 76 +++++++++++++++----------------
 9 files changed, 140 insertions(+), 156 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 456a1db62bdd..86e18cac116c 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1284,22 +1284,22 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
         if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
             goto bad_offset;
         }
-        return cpu->isar.id_mmfr0;
+        return GET_IDREG(idregs, ID_MMFR0);
     case 0xd54: /* MMFR1.  */
         if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
             goto bad_offset;
         }
-        return cpu->isar.id_mmfr1;
+        return GET_IDREG(idregs, ID_MMFR1);
     case 0xd58: /* MMFR2.  */
         if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
             goto bad_offset;
         }
-        return cpu->isar.id_mmfr2;
+        return GET_IDREG(idregs, ID_MMFR2);
     case 0xd5c: /* MMFR3.  */
         if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
             goto bad_offset;
         }
-        return cpu->isar.id_mmfr3;
+        return GET_IDREG(idregs, ID_MMFR3);
     case 0xd60: /* ISAR0.  */
         if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
             goto bad_offset;
diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 97c7fee70a7b..90ada4c2d227 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -283,17 +283,17 @@ static inline bool isar_feature_aa32_vminmaxnm(const ARMISARegisters *id)
 
 static inline bool isar_feature_aa32_pxn(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_mmfr0, ID_MMFR0, VMSA) >= 4;
+    return FIELD_EX32_IDREG(&id->idregs, ID_MMFR0, VMSA) >= 4;
 }
 
 static inline bool isar_feature_aa32_pan(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_mmfr3, ID_MMFR3, PAN) != 0;
+    return FIELD_EX32_IDREG(&id->idregs, ID_MMFR3, PAN) != 0;
 }
 
 static inline bool isar_feature_aa32_ats1e1(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_mmfr3, ID_MMFR3, PAN) >= 2;
+    return FIELD_EX32_IDREG(&id->idregs, ID_MMFR3, PAN) >= 2;
 }
 
 static inline bool isar_feature_aa32_pmuv3p1(const ARMISARegisters *id)
@@ -319,32 +319,32 @@ static inline bool isar_feature_aa32_pmuv3p5(const ARMISARegisters *id)
 
 static inline bool isar_feature_aa32_hpd(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_mmfr4, ID_MMFR4, HPDS) != 0;
+    return FIELD_EX32_IDREG(&id->idregs, ID_MMFR4, HPDS) != 0;
 }
 
 static inline bool isar_feature_aa32_ac2(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_mmfr4, ID_MMFR4, AC2) != 0;
+    return FIELD_EX32_IDREG(&id->idregs, ID_MMFR4, AC2) != 0;
 }
 
 static inline bool isar_feature_aa32_ccidx(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_mmfr4, ID_MMFR4, CCIDX) != 0;
+    return FIELD_EX32_IDREG(&id->idregs, ID_MMFR4, CCIDX) != 0;
 }
 
 static inline bool isar_feature_aa32_tts2uxn(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_mmfr4, ID_MMFR4, XNX) != 0;
+    return FIELD_EX32_IDREG(&id->idregs, ID_MMFR4, XNX) != 0;
 }
 
 static inline bool isar_feature_aa32_half_evt(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_mmfr4, ID_MMFR4, EVT) >= 1;
+    return FIELD_EX32_IDREG(&id->idregs, ID_MMFR4, EVT) >= 1;
 }
 
 static inline bool isar_feature_aa32_evt(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_mmfr4, ID_MMFR4, EVT) >= 2;
+    return FIELD_EX32_IDREG(&id->idregs, ID_MMFR4, EVT) >= 2;
 }
 
 static inline bool isar_feature_aa32_dit(const ARMISARegisters *id)
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 215ebf165e6b..f6e1836d0fdd 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1043,12 +1043,6 @@ struct ArchCPU {
      * field by reading the value from the KVM vCPU.
      */
     struct ARMISARegisters {
-        uint32_t id_mmfr0;
-        uint32_t id_mmfr1;
-        uint32_t id_mmfr2;
-        uint32_t id_mmfr3;
-        uint32_t id_mmfr4;
-        uint32_t id_mmfr5;
         uint32_t mvfr0;
         uint32_t mvfr1;
         uint32_t mvfr2;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 9f83984fa900..beba1733c99f 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -634,10 +634,10 @@ static void aarch64_a57_initfn(Object *obj)
     SET_IDREG(idregs, ID_PFR1, 0x00011011);
     SET_IDREG(idregs, ID_DFR0, 0x03010066);
     cpu->id_afr0 = 0x00000000;
-    cpu->isar.id_mmfr0 = 0x10101105;
-    cpu->isar.id_mmfr1 = 0x40000000;
-    cpu->isar.id_mmfr2 = 0x01260000;
-    cpu->isar.id_mmfr3 = 0x02102211;
+    SET_IDREG(idregs, ID_MMFR0, 0x10101105);
+    SET_IDREG(idregs, ID_MMFR1, 0x40000000);
+    SET_IDREG(idregs, ID_MMFR2, 0x01260000);
+    SET_IDREG(idregs, ID_MMFR3, 0x02102211);
     SET_IDREG(idregs, ID_ISAR0, 0x02101110);
     SET_IDREG(idregs, ID_ISAR1, 0x13112111);
     SET_IDREG(idregs, ID_ISAR2, 0x21232042);
@@ -696,10 +696,10 @@ static void aarch64_a53_initfn(Object *obj)
     SET_IDREG(idregs, ID_PFR1, 0x00011011);
     SET_IDREG(idregs, ID_DFR0, 0x03010066);
     cpu->id_afr0 = 0x00000000;
-    cpu->isar.id_mmfr0 = 0x10101105;
-    cpu->isar.id_mmfr1 = 0x40000000;
-    cpu->isar.id_mmfr2 = 0x01260000;
-    cpu->isar.id_mmfr3 = 0x02102211;
+    SET_IDREG(idregs, ID_MMFR0, 0x10101105);
+    SET_IDREG(idregs, ID_MMFR1, 0x40000000);
+    SET_IDREG(idregs, ID_MMFR2, 0x01260000);
+    SET_IDREG(idregs, ID_MMFR3, 0x02102211);
     SET_IDREG(idregs, ID_ISAR0, 0x02101110);
     SET_IDREG(idregs, ID_ISAR1, 0x13112111);
     SET_IDREG(idregs, ID_ISAR2, 0x21232042);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index e4a7d2493305..65b85cf5cc25 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7587,22 +7587,22 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa32_tid3,
-              .resetvalue = cpu->isar.id_mmfr0 },
+              .resetvalue = GET_IDREG(idregs, ID_MMFR0)},
             { .name = "ID_MMFR1", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa32_tid3,
-              .resetvalue = cpu->isar.id_mmfr1 },
+              .resetvalue = GET_IDREG(idregs, ID_MMFR1)},
             { .name = "ID_MMFR2", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 6,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa32_tid3,
-              .resetvalue = cpu->isar.id_mmfr2 },
+              .resetvalue = GET_IDREG(idregs, ID_MMFR2)},
             { .name = "ID_MMFR3", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 7,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa32_tid3,
-              .resetvalue = cpu->isar.id_mmfr3 },
+              .resetvalue = GET_IDREG(idregs, ID_MMFR3)},
             { .name = "ID_ISAR0", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
@@ -7637,7 +7637,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 6,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa32_tid3,
-              .resetvalue = cpu->isar.id_mmfr4 },
+              .resetvalue = GET_IDREG(idregs, ID_MMFR4)},
             { .name = "ID_ISAR6", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 7,
               .access = PL1_R, .type = ARM_CP_CONST,
@@ -7917,7 +7917,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 6,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = cpu->isar.id_mmfr5 },
+              .resetvalue = GET_IDREG(idregs, ID_MMFR5)},
             { .name = "RES_0_C0_C3_7", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 7,
               .access = PL1_R, .type = ARM_CP_CONST,
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index bea844adb07b..8881005ad9e6 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -383,14 +383,10 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         err |= get_host_cpu_reg64(fd, ahcf, SYS_ID_AA64PFR0_EL1);
         err |= get_host_cpu_reg64(fd, ahcf, SYS_ID_AA64PFR1_EL1);
         err |= get_host_cpu_reg32(fd, ahcf, SYS_ID_DFR0_EL1);
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr0,
-                              ARM64_SYS_REG(3, 0, 0, 1, 4));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr1,
-                              ARM64_SYS_REG(3, 0, 0, 1, 5));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr2,
-                              ARM64_SYS_REG(3, 0, 0, 1, 6));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr3,
-                              ARM64_SYS_REG(3, 0, 0, 1, 7));
+        err |= get_host_cpu_reg32(fd, ahcf, SYS_ID_MMFR0_EL1);
+        err |= get_host_cpu_reg32(fd, ahcf, SYS_ID_MMFR1_EL1);
+        err |= get_host_cpu_reg32(fd, ahcf, SYS_ID_MMFR2_EL1);
+        err |= get_host_cpu_reg32(fd, ahcf, SYS_ID_MMFR3_EL1);
         err |= get_host_cpu_reg32(fd, ahcf, SYS_ID_ISAR0_EL1);
         err |= get_host_cpu_reg32(fd, ahcf, SYS_ID_ISAR1_EL1);
         err |= get_host_cpu_reg32(fd, ahcf, SYS_ID_ISAR2_EL1);
@@ -398,8 +394,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         err |= get_host_cpu_reg32(fd, ahcf, SYS_ID_ISAR4_EL1);
         err |= get_host_cpu_reg32(fd, ahcf, SYS_ID_ISAR5_EL1);
         err |= get_host_cpu_reg32(fd, ahcf, SYS_ID_ISAR6_EL1);
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr4,
-                              ARM64_SYS_REG(3, 0, 0, 2, 6));
+        err |= get_host_cpu_reg32(fd, ahcf, SYS_ID_MMFR4_EL1);
 
         err |= read_sys_reg32(fdarray[2], &ahcf->isar.mvfr0,
                               ARM64_SYS_REG(3, 0, 0, 3, 0));
@@ -409,8 +404,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
                               ARM64_SYS_REG(3, 0, 0, 3, 2));
         err |= get_host_cpu_reg32(fd, ahcf, SYS_ID_PFR2_EL1);
         err |= get_host_cpu_reg32(fd, ahcf, SYS_ID_DFR1_EL1);
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr5,
-                              ARM64_SYS_REG(3, 0, 0, 3, 6));
+        err |= get_host_cpu_reg32(fd, ahcf, SYS_ID_MMFR5_EL1);
 
         /*
          * DBGDIDR is a bit complicated because the kernel doesn't
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index 2817d81ae8f5..5bff97beb704 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -64,10 +64,10 @@ static void cortex_m0_initfn(Object *obj)
     SET_IDREG(idregs, ID_PFR1, 0x00000200);
     SET_IDREG(idregs, ID_DFR0, 0x00100000);
     cpu->id_afr0 = 0x00000000;
-    cpu->isar.id_mmfr0 = 0x00000030;
-    cpu->isar.id_mmfr1 = 0x00000000;
-    cpu->isar.id_mmfr2 = 0x00000000;
-    cpu->isar.id_mmfr3 = 0x00000000;
+    SET_IDREG(idregs, ID_MMFR0, 0x00000030);
+    SET_IDREG(idregs, ID_MMFR1, 0x00000000);
+    SET_IDREG(idregs, ID_MMFR2, 0x00000000);
+    SET_IDREG(idregs, ID_MMFR3, 0x00000000);
     SET_IDREG(idregs, ID_ISAR0, 0x01141110);
     SET_IDREG(idregs, ID_ISAR1, 0x02111000);
     SET_IDREG(idregs, ID_ISAR2, 0x21112231);
@@ -90,10 +90,10 @@ static void cortex_m3_initfn(Object *obj)
     SET_IDREG(idregs, ID_PFR1, 0x00000200);
     SET_IDREG(idregs, ID_DFR0, 0x00100000);
     cpu->id_afr0 = 0x00000000;
-    cpu->isar.id_mmfr0 = 0x00000030;
-    cpu->isar.id_mmfr1 = 0x00000000;
-    cpu->isar.id_mmfr2 = 0x00000000;
-    cpu->isar.id_mmfr3 = 0x00000000;
+    SET_IDREG(idregs, ID_MMFR0, 0x00000030);
+    SET_IDREG(idregs, ID_MMFR1, 0x00000000);
+    SET_IDREG(idregs, ID_MMFR2, 0x00000000);
+    SET_IDREG(idregs, ID_MMFR3, 0x00000000);
     SET_IDREG(idregs, ID_ISAR0, 0x01141110);
     SET_IDREG(idregs, ID_ISAR1, 0x02111000);
     SET_IDREG(idregs, ID_ISAR2, 0x21112231);
@@ -121,10 +121,10 @@ static void cortex_m4_initfn(Object *obj)
     SET_IDREG(idregs, ID_PFR1, 0x00000200);
     SET_IDREG(idregs, ID_DFR0, 0x00100000);
     cpu->id_afr0 = 0x00000000;
-    cpu->isar.id_mmfr0 = 0x00000030;
-    cpu->isar.id_mmfr1 = 0x00000000;
-    cpu->isar.id_mmfr2 = 0x00000000;
-    cpu->isar.id_mmfr3 = 0x00000000;
+    SET_IDREG(idregs, ID_MMFR0, 0x00000030);
+    SET_IDREG(idregs, ID_MMFR1, 0x00000000);
+    SET_IDREG(idregs, ID_MMFR2, 0x00000000);
+    SET_IDREG(idregs, ID_MMFR3, 0x00000000);
     SET_IDREG(idregs, ID_ISAR0, 0x01141110);
     SET_IDREG(idregs, ID_ISAR1, 0x02111000);
     SET_IDREG(idregs, ID_ISAR2, 0x21112231);
@@ -152,10 +152,10 @@ static void cortex_m7_initfn(Object *obj)
     SET_IDREG(idregs, ID_PFR1, 0x00000200);
     SET_IDREG(idregs, ID_DFR0, 0x00100000);
     cpu->id_afr0 = 0x00000000;
-    cpu->isar.id_mmfr0 = 0x00100030;
-    cpu->isar.id_mmfr1 = 0x00000000;
-    cpu->isar.id_mmfr2 = 0x01000000;
-    cpu->isar.id_mmfr3 = 0x00000000;
+    SET_IDREG(idregs, ID_MMFR0, 0x00100030);
+    SET_IDREG(idregs, ID_MMFR1, 0x00000000);
+    SET_IDREG(idregs, ID_MMFR2, 0x01000000);
+    SET_IDREG(idregs, ID_MMFR3, 0x00000000);
     SET_IDREG(idregs, ID_ISAR0, 0x01101110);
     SET_IDREG(idregs, ID_ISAR1, 0x02112000);
     SET_IDREG(idregs, ID_ISAR2, 0x20232231);
@@ -185,10 +185,10 @@ static void cortex_m33_initfn(Object *obj)
     SET_IDREG(idregs, ID_PFR1, 0x00000210);
     SET_IDREG(idregs, ID_DFR0, 0x00200000);
     cpu->id_afr0 = 0x00000000;
-    cpu->isar.id_mmfr0 = 0x00101F40;
-    cpu->isar.id_mmfr1 = 0x00000000;
-    cpu->isar.id_mmfr2 = 0x01000000;
-    cpu->isar.id_mmfr3 = 0x00000000;
+    SET_IDREG(idregs, ID_MMFR0, 0x00101F40);
+    SET_IDREG(idregs, ID_MMFR1, 0x00000000);
+    SET_IDREG(idregs, ID_MMFR2, 0x01000000);
+    SET_IDREG(idregs, ID_MMFR3, 0x00000000);
     SET_IDREG(idregs, ID_ISAR0, 0x01101110);
     SET_IDREG(idregs, ID_ISAR1, 0x02212000);
     SET_IDREG(idregs, ID_ISAR2, 0x20232232);
@@ -223,10 +223,10 @@ static void cortex_m55_initfn(Object *obj)
     SET_IDREG(idregs, ID_PFR1, 0x00000230);
     SET_IDREG(idregs, ID_DFR0, 0x10200000);
     cpu->id_afr0 = 0x00000000;
-    cpu->isar.id_mmfr0 = 0x00111040;
-    cpu->isar.id_mmfr1 = 0x00000000;
-    cpu->isar.id_mmfr2 = 0x01000000;
-    cpu->isar.id_mmfr3 = 0x00000011;
+    SET_IDREG(idregs, ID_MMFR0, 0x00111040);
+    SET_IDREG(idregs, ID_MMFR1, 0x00000000);
+    SET_IDREG(idregs, ID_MMFR2, 0x01000000);
+    SET_IDREG(idregs, ID_MMFR3, 0x00000011);
     SET_IDREG(idregs, ID_ISAR0, 0x01103110);
     SET_IDREG(idregs, ID_ISAR1, 0x02212000);
     SET_IDREG(idregs, ID_ISAR2, 0x20232232);
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 1d2261865b39..a03642b07536 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -55,21 +55,17 @@ void aa32_max_features(ARMCPU *cpu)
     t = FIELD_DP32(t, MVFR2, FPMISC, 4);          /* FP MaxNum */
     cpu->isar.mvfr2 = t;
 
-    t = cpu->isar.id_mmfr3;
-    t = FIELD_DP32(t, ID_MMFR3, PAN, 2);          /* FEAT_PAN2 */
-    cpu->isar.id_mmfr3 = t;
+    FIELD_DP32_IDREG(idregs, ID_MMFR3, PAN, 2);          /* FEAT_PAN2 */
 
-    t = cpu->isar.id_mmfr4;
+    t = GET_IDREG(idregs, ID_MMFR4);
     t = FIELD_DP32(t, ID_MMFR4, HPDS, 2);         /* FEAT_HPDS2 */
     t = FIELD_DP32(t, ID_MMFR4, AC2, 1);          /* ACTLR2, HACTLR2 */
     t = FIELD_DP32(t, ID_MMFR4, CNP, 1);          /* FEAT_TTCNP */
     t = FIELD_DP32(t, ID_MMFR4, XNX, 1);          /* FEAT_XNX */
     t = FIELD_DP32(t, ID_MMFR4, EVT, 2);          /* FEAT_EVT */
-    cpu->isar.id_mmfr4 = t;
+    SET_IDREG(idregs, ID_MMFR4, t);
 
-    t = cpu->isar.id_mmfr5;
-    t = FIELD_DP32(t, ID_MMFR5, ETS, 2);          /* FEAT_ETS2 */
-    cpu->isar.id_mmfr5 = t;
+    FIELD_DP32_IDREG(idregs, ID_MMFR5, ETS, 2);          /* FEAT_ETS2 */
 
     t = GET_IDREG(idregs, ID_PFR0);
     t = FIELD_DP32(t, ID_PFR0, CSV2, 2);          /* FEAT_CSV2 */
@@ -230,9 +226,9 @@ static void arm1136_r2_initfn(Object *obj)
     SET_IDREG(idregs, ID_PFR1, 0x1);
     SET_IDREG(idregs, ID_DFR0, 0x2);
     cpu->id_afr0 = 0x3;
-    cpu->isar.id_mmfr0 = 0x01130003;
-    cpu->isar.id_mmfr1 = 0x10030302;
-    cpu->isar.id_mmfr2 = 0x01222110;
+    SET_IDREG(idregs, ID_MMFR0, 0x01130003);
+    SET_IDREG(idregs, ID_MMFR1, 0x10030302);
+    SET_IDREG(idregs, ID_MMFR2, 0x01222110);
     SET_IDREG(idregs, ID_ISAR0, 0x00140011);
     SET_IDREG(idregs, ID_ISAR1, 0x12002111);
     SET_IDREG(idregs, ID_ISAR2, 0x11231111);
@@ -262,9 +258,9 @@ static void arm1136_initfn(Object *obj)
     SET_IDREG(idregs, ID_PFR1, 0x1);
     SET_IDREG(idregs, ID_DFR0, 0x2);
     cpu->id_afr0 = 0x3;
-    cpu->isar.id_mmfr0 = 0x01130003;
-    cpu->isar.id_mmfr1 = 0x10030302;
-    cpu->isar.id_mmfr2 = 0x01222110;
+    SET_IDREG(idregs, ID_MMFR0, 0x01130003);
+    SET_IDREG(idregs, ID_MMFR1, 0x10030302);
+    SET_IDREG(idregs, ID_MMFR2, 0x01222110);
     SET_IDREG(idregs, ID_ISAR0, 0x00140011);
     SET_IDREG(idregs, ID_ISAR1, 0x12002111);
     SET_IDREG(idregs, ID_ISAR2, 0x11231111);
@@ -295,9 +291,9 @@ static void arm1176_initfn(Object *obj)
     SET_IDREG(idregs, ID_PFR1, 0x11);
     SET_IDREG(idregs, ID_DFR0, 0x33);
     cpu->id_afr0 = 0;
-    cpu->isar.id_mmfr0 = 0x01130003;
-    cpu->isar.id_mmfr1 = 0x10030302;
-    cpu->isar.id_mmfr2 = 0x01222100;
+    SET_IDREG(idregs, ID_MMFR0, 0x01130003);
+    SET_IDREG(idregs, ID_MMFR1, 0x10030302);
+    SET_IDREG(idregs, ID_MMFR2, 0x01222100);
     SET_IDREG(idregs, ID_ISAR0, 0x0140011);
     SET_IDREG(idregs, ID_ISAR1, 0x12002111);
     SET_IDREG(idregs, ID_ISAR2, 0x11231121);
@@ -325,9 +321,9 @@ static void arm11mpcore_initfn(Object *obj)
      SET_IDREG(idregs, ID_PFR1, 0x1);
     SET_IDREG(idregs, ID_DFR0, 0);
     cpu->id_afr0 = 0x2;
-    cpu->isar.id_mmfr0 = 0x01100103;
-    cpu->isar.id_mmfr1 = 0x10020302;
-    cpu->isar.id_mmfr2 = 0x01222000;
+    SET_IDREG(idregs, ID_MMFR0, 0x01100103);
+    SET_IDREG(idregs, ID_MMFR1, 0x10020302);
+    SET_IDREG(idregs, ID_MMFR2, 0x01222000);
     SET_IDREG(idregs, ID_ISAR0, 0x00100011);
     SET_IDREG(idregs, ID_ISAR1, 0x12002111);
     SET_IDREG(idregs, ID_ISAR2, 0x11221011);
@@ -365,10 +361,10 @@ static void cortex_a8_initfn(Object *obj)
     SET_IDREG(idregs, ID_PFR1, 0x11);
     SET_IDREG(idregs, ID_DFR0, 0x400);
     cpu->id_afr0 = 0;
-    cpu->isar.id_mmfr0 = 0x31100003;
-    cpu->isar.id_mmfr1 = 0x20000000;
-    cpu->isar.id_mmfr2 = 0x01202000;
-    cpu->isar.id_mmfr3 = 0x11;
+    SET_IDREG(idregs, ID_MMFR0, 0x31100003);
+    SET_IDREG(idregs, ID_MMFR1, 0x20000000);
+    SET_IDREG(idregs, ID_MMFR2, 0x01202000);
+    SET_IDREG(idregs, ID_MMFR3, 0x11);
     SET_IDREG(idregs, ID_ISAR0, 0x00101111);
     SET_IDREG(idregs, ID_ISAR1, 0x12112111);
     SET_IDREG(idregs, ID_ISAR2, 0x21232031);
@@ -441,10 +437,10 @@ static void cortex_a9_initfn(Object *obj)
     SET_IDREG(idregs, ID_PFR1, 0x11);
     SET_IDREG(idregs, ID_DFR0, 0x000);
     cpu->id_afr0 = 0;
-    cpu->isar.id_mmfr0 = 0x00100103;
-    cpu->isar.id_mmfr1 = 0x20000000;
-    cpu->isar.id_mmfr2 = 0x01230000;
-    cpu->isar.id_mmfr3 = 0x00002111;
+    SET_IDREG(idregs, ID_MMFR0, 0x00100103);
+    SET_IDREG(idregs, ID_MMFR1, 0x20000000);
+    SET_IDREG(idregs, ID_MMFR2, 0x01230000);
+    SET_IDREG(idregs, ID_MMFR3, 0x00002111);
     SET_IDREG(idregs, ID_ISAR0, 0x00101111);
     SET_IDREG(idregs, ID_ISAR1, 0x13112111);
     SET_IDREG(idregs, ID_ISAR2, 0x21232041);
@@ -507,10 +503,10 @@ static void cortex_a7_initfn(Object *obj)
     SET_IDREG(idregs, ID_PFR1, 0x00011011);
     SET_IDREG(idregs, ID_DFR0, 0x02010555);
     cpu->id_afr0 = 0x00000000;
-    cpu->isar.id_mmfr0 = 0x10101105;
-    cpu->isar.id_mmfr1 = 0x40000000;
-    cpu->isar.id_mmfr2 = 0x01240000;
-    cpu->isar.id_mmfr3 = 0x02102211;
+    SET_IDREG(idregs, ID_MMFR0, 0x10101105);
+    SET_IDREG(idregs, ID_MMFR1, 0x40000000);
+    SET_IDREG(idregs, ID_MMFR2, 0x01240000);
+    SET_IDREG(idregs, ID_MMFR3, 0x02102211);
     /*
      * a7_mpcore_r0p5_trm, page 4-4 gives 0x01101110; but
      * table 4-41 gives 0x02101110, which includes the arm div insns.
@@ -559,10 +555,10 @@ static void cortex_a15_initfn(Object *obj)
     SET_IDREG(idregs, ID_PFR1, 0x00011011);
     SET_IDREG(idregs, ID_DFR0, 0x02010555);
     cpu->id_afr0 = 0x00000000;
-    cpu->isar.id_mmfr0 = 0x10201105;
-    cpu->isar.id_mmfr1 = 0x20000000;
-    cpu->isar.id_mmfr2 = 0x01240000;
-    cpu->isar.id_mmfr3 = 0x02102211;
+    SET_IDREG(idregs, ID_MMFR0, 0x10201105);
+    SET_IDREG(idregs, ID_MMFR1, 0x20000000);
+    SET_IDREG(idregs, ID_MMFR2, 0x01240000);
+    SET_IDREG(idregs, ID_MMFR3, 0x02102211);
     SET_IDREG(idregs, ID_ISAR0, 0x02101110);
     SET_IDREG(idregs, ID_ISAR1, 0x13112111);
     SET_IDREG(idregs, ID_ISAR2, 0x21232041);
@@ -603,10 +599,10 @@ static void cortex_r5_initfn(Object *obj)
     SET_IDREG(idregs, ID_PFR1, 0x001);
     SET_IDREG(idregs, ID_DFR0, 0x010400);
     cpu->id_afr0 = 0x0;
-    cpu->isar.id_mmfr0 = 0x0210030;
-    cpu->isar.id_mmfr1 = 0x00000000;
-    cpu->isar.id_mmfr2 = 0x01200000;
-    cpu->isar.id_mmfr3 = 0x0211;
+    SET_IDREG(idregs, ID_MMFR0, 0x0210030);
+    SET_IDREG(idregs, ID_MMFR1, 0x00000000);
+    SET_IDREG(idregs, ID_MMFR2, 0x01200000);
+    SET_IDREG(idregs, ID_MMFR3, 0x0211);
     SET_IDREG(idregs, ID_ISAR0, 0x02101111);
     SET_IDREG(idregs, ID_ISAR1, 0x13112111);
     SET_IDREG(idregs, ID_ISAR2, 0x21232141);
@@ -750,11 +746,11 @@ static void cortex_r52_initfn(Object *obj)
     SET_IDREG(idregs, ID_PFR1, 0x10111001);
     SET_IDREG(idregs, ID_DFR0, 0x03010006);
     cpu->id_afr0 = 0x00000000;
-    cpu->isar.id_mmfr0 = 0x00211040;
-    cpu->isar.id_mmfr1 = 0x40000000;
-    cpu->isar.id_mmfr2 = 0x01200000;
-    cpu->isar.id_mmfr3 = 0xf0102211;
-    cpu->isar.id_mmfr4 = 0x00000010;
+    SET_IDREG(idregs, ID_MMFR0, 0x00211040);
+    SET_IDREG(idregs, ID_MMFR1, 0x40000000);
+    SET_IDREG(idregs, ID_MMFR2, 0x01200000);
+    SET_IDREG(idregs, ID_MMFR3, 0xf0102211);
+    SET_IDREG(idregs, ID_MMFR4, 0x00000010);
     SET_IDREG(idregs, ID_ISAR0, 0x02101110);
     SET_IDREG(idregs, ID_ISAR1, 0x13112111);
     SET_IDREG(idregs, ID_ISAR2, 0x21232142);
@@ -982,10 +978,10 @@ static void arm_max_initfn(Object *obj)
     SET_IDREG(idregs, ID_PFR1, 0x00011011);
     SET_IDREG(idregs, ID_DFR0, 0x03010066);
     cpu->id_afr0 = 0x00000000;
-    cpu->isar.id_mmfr0 = 0x10101105;
-    cpu->isar.id_mmfr1 = 0x40000000;
-    cpu->isar.id_mmfr2 = 0x01260000;
-    cpu->isar.id_mmfr3 = 0x02102211;
+    ET_IDREG(idregs, ID_MMFR0, 0x10101105);
+    ET_IDREG(idregs, ID_MMFR1, 0x40000000);
+    ET_IDREG(idregs, ID_MMFR2, 0x01260000);
+    ET_IDREG(idregs, ID_MMFR3, 0x02102211);
     SET_IDREG(idregs, ID_ISAR0, 0x02101110);
     SET_IDREG(idregs, ID_ISAR1, 0x13112111);
     SET_IDREG(idregs, ID_ISAR2, 0x21232042);
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index eb42633f3d80..54925b273efc 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -53,10 +53,10 @@ static void aarch64_a35_initfn(Object *obj)
     SET_IDREG(idregs, ID_PFR1, 0x00011011);
     SET_IDREG(idregs, ID_DFR0, 0x03010066);
     cpu->id_afr0 = 0;
-    cpu->isar.id_mmfr0 = 0x10201105;
-    cpu->isar.id_mmfr1 = 0x40000000;
-    cpu->isar.id_mmfr2 = 0x01260000;
-    cpu->isar.id_mmfr3 = 0x02102211;
+    SET_IDREG(idregs, ID_MMFR0, 0x10201105);
+    SET_IDREG(idregs, ID_MMFR1, 0x40000000);
+    SET_IDREG(idregs, ID_MMFR2, 0x01260000);
+    SET_IDREG(idregs, ID_MMFR3, 0x02102211);
     SET_IDREG(idregs, ID_ISAR0, 0x02101110);
     SET_IDREG(idregs, ID_ISAR1, 0x13112111);
     SET_IDREG(idregs, ID_ISAR2, 0x21232042);
@@ -236,11 +236,11 @@ static void aarch64_a55_initfn(Object *obj)
     SET_IDREG(idregs, ID_ISAR4, 0x00011142);
     SET_IDREG(idregs, ID_ISAR5, 0x01011121);
     SET_IDREG(idregs, ID_ISAR6, 0x00000010);
-    cpu->isar.id_mmfr0 = 0x10201105;
-    cpu->isar.id_mmfr1 = 0x40000000;
-    cpu->isar.id_mmfr2 = 0x01260000;
-    cpu->isar.id_mmfr3 = 0x02122211;
-    cpu->isar.id_mmfr4 = 0x00021110;
+    SET_IDREG(idregs, ID_MMFR0, 0x10201105);
+    SET_IDREG(idregs, ID_MMFR1, 0x40000000);
+    SET_IDREG(idregs, ID_MMFR2, 0x01260000);
+    SET_IDREG(idregs, ID_MMFR3, 0x02122211);
+    SET_IDREG(idregs, ID_MMFR4, 0x00021110);
     SET_IDREG(idregs, ID_PFR0, 0x10010131);
     SET_IDREG(idregs, ID_PFR1, 0x00011011);
     SET_IDREG(idregs, ID_PFR2, 0x00000011);
@@ -299,10 +299,10 @@ static void aarch64_a72_initfn(Object *obj)
     SET_IDREG(idregs, ID_PFR1, 0x00011011);
     SET_IDREG(idregs, ID_DFR0, 0x03010066);
     cpu->id_afr0 = 0x00000000;
-    cpu->isar.id_mmfr0 = 0x10201105;
-    cpu->isar.id_mmfr1 = 0x40000000;
-    cpu->isar.id_mmfr2 = 0x01260000;
-    cpu->isar.id_mmfr3 = 0x02102211;
+    SET_IDREG(idregs, ID_MMFR0, 0x10201105);
+    SET_IDREG(idregs, ID_MMFR1, 0x40000000);
+    SET_IDREG(idregs, ID_MMFR2, 0x01260000);
+    SET_IDREG(idregs, ID_MMFR3, 0x02102211);
     SET_IDREG(idregs, ID_ISAR0, 0x02101110);
     SET_IDREG(idregs, ID_ISAR1, 0x13112111);
     SET_IDREG(idregs, ID_ISAR2, 0x21232042);
@@ -369,11 +369,11 @@ static void aarch64_a76_initfn(Object *obj)
     SET_IDREG(idregs, ID_ISAR4, 0x00010142);
     SET_IDREG(idregs, ID_ISAR5, 0x01011121);
     SET_IDREG(idregs, ID_ISAR6, 0x00000010);
-    cpu->isar.id_mmfr0 = 0x10201105;
-    cpu->isar.id_mmfr1 = 0x40000000;
-    cpu->isar.id_mmfr2 = 0x01260000;
-    cpu->isar.id_mmfr3 = 0x02122211;
-    cpu->isar.id_mmfr4 = 0x00021110;
+    SET_IDREG(idregs, ID_MMFR0, 0x10201105);
+    SET_IDREG(idregs, ID_MMFR1, 0x40000000);
+    SET_IDREG(idregs, ID_MMFR2, 0x01260000);
+    SET_IDREG(idregs, ID_MMFR3, 0x02122211);
+    SET_IDREG(idregs, ID_MMFR4, 0x00021110);
     SET_IDREG(idregs, ID_PFR0, 0x10010131);
     SET_IDREG(idregs, ID_PFR1, 0x00010000); /* GIC filled in later */
     SET_IDREG(idregs, ID_PFR2, 0x00000011);
@@ -617,11 +617,11 @@ static void aarch64_neoverse_n1_initfn(Object *obj)
     SET_IDREG(idregs, ID_ISAR4, 0x00010142);
     SET_IDREG(idregs, ID_ISAR5, 0x01011121);
     SET_IDREG(idregs, ID_ISAR6, 0x00000010);
-    cpu->isar.id_mmfr0 = 0x10201105;
-    cpu->isar.id_mmfr1 = 0x40000000;
-    cpu->isar.id_mmfr2 = 0x01260000;
-    cpu->isar.id_mmfr3 = 0x02122211;
-    cpu->isar.id_mmfr4 = 0x00021110;
+    SET_IDREG(idregs, ID_MMFR0, 0x10201105);
+    SET_IDREG(idregs, ID_MMFR1, 0x40000000);
+    SET_IDREG(idregs, ID_MMFR2, 0x01260000);
+    SET_IDREG(idregs, ID_MMFR3, 0x02122211);
+    SET_IDREG(idregs, ID_MMFR4, 0x00021110);
     SET_IDREG(idregs, ID_PFR0, 0x10010131);
     SET_IDREG(idregs, ID_PFR1, 0x00010000); /* GIC filled in later */
     SET_IDREG(idregs, ID_PFR2, 0x00000011);
@@ -696,11 +696,11 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
     SET_IDREG(idregs, ID_ISAR4, 0x00010142);
     SET_IDREG(idregs, ID_ISAR5, 0x11011121);
     SET_IDREG(idregs, ID_ISAR6, 0x01100111);
-    cpu->isar.id_mmfr0 = 0x10201105;
-    cpu->isar.id_mmfr1 = 0x40000000;
-    cpu->isar.id_mmfr2 = 0x01260000;
-    cpu->isar.id_mmfr3 = 0x02122211;
-    cpu->isar.id_mmfr4 = 0x01021110;
+    SET_IDREG(idregs, ID_MMFR0, 0x10201105);
+    SET_IDREG(idregs, ID_MMFR1, 0x40000000);
+    SET_IDREG(idregs, ID_MMFR2, 0x01260000);
+    SET_IDREG(idregs, ID_MMFR3, 0x02122211);
+    SET_IDREG(idregs, ID_MMFR4, 0x01021110);
     SET_IDREG(idregs, ID_PFR0, 0x21110131);
     SET_IDREG(idregs, ID_PFR1, 0x00010000); /* GIC filled in later */
     SET_IDREG(idregs, ID_PFR2, 0x00000011);
@@ -906,17 +906,17 @@ static void aarch64_a710_initfn(Object *obj)
     SET_IDREG(idregs, ID_PFR1, 0x00010000); /* GIC filled in later */
     SET_IDREG(idregs, ID_DFR0, 0x16011099);
     cpu->id_afr0       = 0;
-    cpu->isar.id_mmfr0 = 0x10201105;
-    cpu->isar.id_mmfr1 = 0x40000000;
-    cpu->isar.id_mmfr2 = 0x01260000;
-    cpu->isar.id_mmfr3 = 0x02122211;
+    SET_IDREG(idregs, ID_MMFR0, 0x10201105);
+    SET_IDREG(idregs, ID_MMFR1, 0x40000000);
+    SET_IDREG(idregs, ID_MMFR2, 0x01260000);
+    SET_IDREG(idregs, ID_MMFR3, 0x02122211);
     SET_IDREG(idregs, ID_ISAR0, 0x02101110);
     SET_IDREG(idregs, ID_ISAR1, 0x13112111);
     SET_IDREG(idregs, ID_ISAR2, 0x21232042);
     SET_IDREG(idregs, ID_ISAR3, 0x01112131);
     SET_IDREG(idregs, ID_ISAR4, 0x00010142);
     SET_IDREG(idregs, ID_ISAR5, 0x11011121); /* with Crypto */
-    cpu->isar.id_mmfr4 = 0x21021110;
+    SET_IDREG(idregs, ID_MMFR4, 0x21021110);
     SET_IDREG(idregs, ID_ISAR6, 0x01111111);
     cpu->isar.mvfr0    = 0x10110222;
     cpu->isar.mvfr1    = 0x13211111;
@@ -1009,17 +1009,17 @@ static void aarch64_neoverse_n2_initfn(Object *obj)
     SET_IDREG(idregs, ID_PFR1, 0x00010000); /* GIC filled in later */
     SET_IDREG(idregs, ID_DFR0, 0x16011099);
     cpu->id_afr0       = 0;
-    cpu->isar.id_mmfr0 = 0x10201105;
-    cpu->isar.id_mmfr1 = 0x40000000;
-    cpu->isar.id_mmfr2 = 0x01260000;
-    cpu->isar.id_mmfr3 = 0x02122211;
+    SET_IDREG(idregs, ID_MMFR0, 0x10201105);
+    SET_IDREG(idregs, ID_MMFR1, 0x40000000);
+    SET_IDREG(idregs, ID_MMFR2, 0x01260000);
+    SET_IDREG(idregs, ID_MMFR3, 0x02122211);
     SET_IDREG(idregs, ID_ISAR0, 0x02101110);
     SET_IDREG(idregs, ID_ISAR1, 0x13112111);
     SET_IDREG(idregs, ID_ISAR2, 0x21232042);
     SET_IDREG(idregs, ID_ISAR3, 0x01112131);
     SET_IDREG(idregs, ID_ISAR4, 0x00010142);
     SET_IDREG(idregs, ID_ISAR5, 0x11011121); /* with Crypto */
-    cpu->isar.id_mmfr4 = 0x01021110;
+    SET_IDREG(idregs, ID_MMFR4, 0x01021110);
     SET_IDREG(idregs, ID_ISAR6, 0x01111111);
     cpu->isar.mvfr0    = 0x10110222;
     cpu->isar.mvfr1    = 0x13211111;
-- 
2.48.1


