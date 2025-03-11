Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41543A5CAFA
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Mar 2025 17:36:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts2WW-0006c6-K2; Tue, 11 Mar 2025 12:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1ts2W1-00064o-Rl
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 12:31:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1ts2Vq-0003Le-GV
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 12:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741710682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5d+6l987FsgaYJO5TZpcfZPkBNxyHb1OOxsFWVjaoHk=;
 b=HG2KrXsAu6wbEAgW7JsQZ3DL0df7AJ6g5cCfSXTHifUlKcWJNxVJlEVjBNSU/GBbw1QKmw
 69U6p9OlnVJCg/fTRepZZEnEljr+8Sf5odnl9dXjBduTXnK8WmpwVa+a4OjoDcc9/g/zWW
 MAIHWd9wgeknobPHIKpclSIczElKz28=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-Bcl6_eaJOZ2jHGzKO-0Nzg-1; Tue,
 11 Mar 2025 12:31:20 -0400
X-MC-Unique: Bcl6_eaJOZ2jHGzKO-0Nzg-1
X-Mimecast-MFC-AGG-ID: Bcl6_eaJOZ2jHGzKO-0Nzg_1741710677
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE58B1801A00; Tue, 11 Mar 2025 16:31:16 +0000 (UTC)
Received: from gondolin.redhat.com (unknown [10.67.24.185])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B602F1800373; Tue, 11 Mar 2025 16:31:00 +0000 (UTC)
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
Subject: [PATCH v3 09/14] arm/cpu: Store id_isar0-7 into the idregs array
Date: Tue, 11 Mar 2025 17:28:19 +0100
Message-ID: <20250311162824.199721-10-cohuck@redhat.com>
In-Reply-To: <20250311162824.199721-1-cohuck@redhat.com>
References: <20250311162824.199721-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/intc/armv7m_nvic.c     |  12 ++--
 target/arm/cpu-features.h |  36 +++++-----
 target/arm/cpu.c          |  24 +++----
 target/arm/cpu.h          |   7 --
 target/arm/cpu64.c        |  28 ++++----
 target/arm/helper.c       |  14 ++--
 target/arm/kvm.c          |  21 ++----
 target/arm/tcg/cpu-v7m.c  |  90 +++++++++++++-----------
 target/arm/tcg/cpu32.c    | 144 +++++++++++++++++++++-----------------
 target/arm/tcg/cpu64.c    | 108 ++++++++++++++--------------
 10 files changed, 243 insertions(+), 241 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 5fd076098243..e1890a447b39 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1303,32 +1303,32 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
         if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
             goto bad_offset;
         }
-        return cpu->isar.id_isar0;
+        return GET_IDREG(&cpu->isar, ID_ISAR0);
     case 0xd64: /* ISAR1.  */
         if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
             goto bad_offset;
         }
-        return cpu->isar.id_isar1;
+        return GET_IDREG(&cpu->isar, ID_ISAR1);
     case 0xd68: /* ISAR2.  */
         if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
             goto bad_offset;
         }
-        return cpu->isar.id_isar2;
+        return GET_IDREG(&cpu->isar, ID_ISAR2);
     case 0xd6c: /* ISAR3.  */
         if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
             goto bad_offset;
         }
-        return cpu->isar.id_isar3;
+        return GET_IDREG(&cpu->isar, ID_ISAR3);
     case 0xd70: /* ISAR4.  */
         if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
             goto bad_offset;
         }
-        return cpu->isar.id_isar4;
+        return GET_IDREG(&cpu->isar, ID_ISAR4);
     case 0xd74: /* ISAR5.  */
         if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
             goto bad_offset;
         }
-        return cpu->isar.id_isar5;
+        return GET_IDREG(&cpu->isar, ID_ISAR5);
     case 0xd78: /* CLIDR */
         return cpu->clidr;
     case 0xd7c: /* CTR */
diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 1ac1f3e95984..003cf735e8ef 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -45,93 +45,93 @@
  */
 static inline bool isar_feature_aa32_thumb_div(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_isar0, ID_ISAR0, DIVIDE) != 0;
+    return FIELD_EX32_IDREG(id, ID_ISAR0, DIVIDE) != 0;
 }
 
 static inline bool isar_feature_aa32_arm_div(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_isar0, ID_ISAR0, DIVIDE) > 1;
+    return FIELD_EX32_IDREG(id, ID_ISAR0, DIVIDE) > 1;
 }
 
 static inline bool isar_feature_aa32_lob(const ARMISARegisters *id)
 {
     /* (M-profile) low-overhead loops and branch future */
-    return FIELD_EX32(id->id_isar0, ID_ISAR0, CMPBRANCH) >= 3;
+    return FIELD_EX32_IDREG(id, ID_ISAR0, CMPBRANCH) >= 3;
 }
 
 static inline bool isar_feature_aa32_jazelle(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_isar1, ID_ISAR1, JAZELLE) != 0;
+    return FIELD_EX32_IDREG(id, ID_ISAR1, JAZELLE) != 0;
 }
 
 static inline bool isar_feature_aa32_aes(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_isar5, ID_ISAR5, AES) != 0;
+    return FIELD_EX32_IDREG(id, ID_ISAR5, AES) != 0;
 }
 
 static inline bool isar_feature_aa32_pmull(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_isar5, ID_ISAR5, AES) > 1;
+    return FIELD_EX32_IDREG(id, ID_ISAR5, AES) > 1;
 }
 
 static inline bool isar_feature_aa32_sha1(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_isar5, ID_ISAR5, SHA1) != 0;
+    return FIELD_EX32_IDREG(id, ID_ISAR5, SHA1) != 0;
 }
 
 static inline bool isar_feature_aa32_sha2(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_isar5, ID_ISAR5, SHA2) != 0;
+    return FIELD_EX32_IDREG(id, ID_ISAR5, SHA2) != 0;
 }
 
 static inline bool isar_feature_aa32_crc32(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_isar5, ID_ISAR5, CRC32) != 0;
+    return FIELD_EX32_IDREG(id, ID_ISAR5, CRC32) != 0;
 }
 
 static inline bool isar_feature_aa32_rdm(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_isar5, ID_ISAR5, RDM) != 0;
+    return FIELD_EX32_IDREG(id, ID_ISAR5, RDM) != 0;
 }
 
 static inline bool isar_feature_aa32_vcma(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_isar5, ID_ISAR5, VCMA) != 0;
+    return FIELD_EX32_IDREG(id, ID_ISAR5, VCMA) != 0;
 }
 
 static inline bool isar_feature_aa32_jscvt(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_isar6, ID_ISAR6, JSCVT) != 0;
+    return FIELD_EX32_IDREG(id, ID_ISAR6, JSCVT) != 0;
 }
 
 static inline bool isar_feature_aa32_dp(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_isar6, ID_ISAR6, DP) != 0;
+    return FIELD_EX32_IDREG(id, ID_ISAR6, DP) != 0;
 }
 
 static inline bool isar_feature_aa32_fhm(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_isar6, ID_ISAR6, FHM) != 0;
+    return FIELD_EX32_IDREG(id, ID_ISAR6, FHM) != 0;
 }
 
 static inline bool isar_feature_aa32_sb(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_isar6, ID_ISAR6, SB) != 0;
+    return FIELD_EX32_IDREG(id, ID_ISAR6, SB) != 0;
 }
 
 static inline bool isar_feature_aa32_predinv(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_isar6, ID_ISAR6, SPECRES) != 0;
+    return FIELD_EX32_IDREG(id, ID_ISAR6, SPECRES) != 0;
 }
 
 static inline bool isar_feature_aa32_bf16(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_isar6, ID_ISAR6, BF16) != 0;
+    return FIELD_EX32_IDREG(id, ID_ISAR6, BF16) != 0;
 }
 
 static inline bool isar_feature_aa32_i8mm(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_isar6, ID_ISAR6, I8MM) != 0;
+    return FIELD_EX32_IDREG(id, ID_ISAR6, I8MM) != 0;
 }
 
 static inline bool isar_feature_aa32_ras(const ARMISARegisters *id)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index c0c6561c79ca..5e900caa4a9a 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2131,10 +2131,10 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 
         FIELD_DP64_IDREG(isar, ID_AA64PFR0, FP, 0xf);
 
-        u = cpu->isar.id_isar6;
+        u = GET_IDREG(isar, ID_ISAR6);
         u = FIELD_DP32(u, ID_ISAR6, JSCVT, 0);
         u = FIELD_DP32(u, ID_ISAR6, BF16, 0);
-        cpu->isar.id_isar6 = u;
+        SET_IDREG(isar, ID_ISAR6, u);
 
         u = cpu->isar.mvfr0;
         u = FIELD_DP32(u, MVFR0, FPSP, 0);
@@ -2186,20 +2186,20 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 
         FIELD_DP64_IDREG(isar, ID_AA64PFR0, ADVSIMD, 0xf);
 
-        u = cpu->isar.id_isar5;
+        u = GET_IDREG(isar, ID_ISAR5);
         u = FIELD_DP32(u, ID_ISAR5, AES, 0);
         u = FIELD_DP32(u, ID_ISAR5, SHA1, 0);
         u = FIELD_DP32(u, ID_ISAR5, SHA2, 0);
         u = FIELD_DP32(u, ID_ISAR5, RDM, 0);
         u = FIELD_DP32(u, ID_ISAR5, VCMA, 0);
-        cpu->isar.id_isar5 = u;
+        SET_IDREG(isar, ID_ISAR5, u);
 
-        u = cpu->isar.id_isar6;
+        u = GET_IDREG(isar, ID_ISAR6);
         u = FIELD_DP32(u, ID_ISAR6, DP, 0);
         u = FIELD_DP32(u, ID_ISAR6, FHM, 0);
         u = FIELD_DP32(u, ID_ISAR6, BF16, 0);
         u = FIELD_DP32(u, ID_ISAR6, I8MM, 0);
-        cpu->isar.id_isar6 = u;
+        SET_IDREG(isar, ID_ISAR6, u);
 
         if (!arm_feature(env, ARM_FEATURE_M)) {
             u = cpu->isar.mvfr1;
@@ -2237,19 +2237,17 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 
         unset_feature(env, ARM_FEATURE_THUMB_DSP);
 
-        u = cpu->isar.id_isar1;
-        u = FIELD_DP32(u, ID_ISAR1, EXTEND, 1);
-        cpu->isar.id_isar1 = u;
+        FIELD_DP32_IDREG(isar, ID_ISAR1, EXTEND, 1);
 
-        u = cpu->isar.id_isar2;
+        u = GET_IDREG(isar, ID_ISAR2);
         u = FIELD_DP32(u, ID_ISAR2, MULTU, 1);
         u = FIELD_DP32(u, ID_ISAR2, MULTS, 1);
-        cpu->isar.id_isar2 = u;
+        SET_IDREG(isar, ID_ISAR2, u);
 
-        u = cpu->isar.id_isar3;
+        u = GET_IDREG(isar, ID_ISAR3);
         u = FIELD_DP32(u, ID_ISAR3, SIMD, 1);
         u = FIELD_DP32(u, ID_ISAR3, SATURATE, 0);
-        cpu->isar.id_isar3 = u;
+        SET_IDREG(isar, ID_ISAR3, u);
     }
 
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b27522d8a139..3f48d58eb9f0 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1073,13 +1073,6 @@ struct ArchCPU {
      * field by reading the value from the KVM vCPU.
      */
     struct ARMISARegisters {
-        uint32_t id_isar0;
-        uint32_t id_isar1;
-        uint32_t id_isar2;
-        uint32_t id_isar3;
-        uint32_t id_isar4;
-        uint32_t id_isar5;
-        uint32_t id_isar6;
         uint32_t id_mmfr0;
         uint32_t id_mmfr1;
         uint32_t id_mmfr2;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index c8ab8761282a..1489ebb1015e 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -660,13 +660,13 @@ static void aarch64_a57_initfn(Object *obj)
     cpu->isar.id_mmfr1 = 0x40000000;
     cpu->isar.id_mmfr2 = 0x01260000;
     cpu->isar.id_mmfr3 = 0x02102211;
-    cpu->isar.id_isar0 = 0x02101110;
-    cpu->isar.id_isar1 = 0x13112111;
-    cpu->isar.id_isar2 = 0x21232042;
-    cpu->isar.id_isar3 = 0x01112131;
-    cpu->isar.id_isar4 = 0x00011142;
-    cpu->isar.id_isar5 = 0x00011121;
-    cpu->isar.id_isar6 = 0;
+    SET_IDREG(isar, ID_ISAR0, 0x02101110);
+    SET_IDREG(isar, ID_ISAR1, 0x13112111);
+    SET_IDREG(isar, ID_ISAR2, 0x21232042);
+    SET_IDREG(isar, ID_ISAR3, 0x01112131);
+    SET_IDREG(isar, ID_ISAR4, 0x00011142);
+    SET_IDREG(isar, ID_ISAR5, 0x00011121);
+    SET_IDREG(isar, ID_ISAR6, 0);
     SET_IDREG(isar, ID_AA64PFR0, 0x00002222);
     SET_IDREG(isar, ID_AA64DFR0, 0x10305106);
     SET_IDREG(isar, ID_AA64ISAR0, 0x00011120);
@@ -722,13 +722,13 @@ static void aarch64_a53_initfn(Object *obj)
     cpu->isar.id_mmfr1 = 0x40000000;
     cpu->isar.id_mmfr2 = 0x01260000;
     cpu->isar.id_mmfr3 = 0x02102211;
-    cpu->isar.id_isar0 = 0x02101110;
-    cpu->isar.id_isar1 = 0x13112111;
-    cpu->isar.id_isar2 = 0x21232042;
-    cpu->isar.id_isar3 = 0x01112131;
-    cpu->isar.id_isar4 = 0x00011142;
-    cpu->isar.id_isar5 = 0x00011121;
-    cpu->isar.id_isar6 = 0;
+    SET_IDREG(isar, ID_ISAR0, 0x02101110);
+    SET_IDREG(isar, ID_ISAR1, 0x13112111);
+    SET_IDREG(isar, ID_ISAR2, 0x21232042);
+    SET_IDREG(isar, ID_ISAR3, 0x01112131);
+    SET_IDREG(isar, ID_ISAR4, 0x00011142);
+    SET_IDREG(isar, ID_ISAR5, 0x00011121);
+    SET_IDREG(isar, ID_ISAR6, 0);
     SET_IDREG(isar, ID_AA64PFR0, 0x00002222);
     SET_IDREG(isar, ID_AA64DFR0, 0x10305106);
     SET_IDREG(isar, ID_AA64ISAR0, 0x00011120);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 66eda355794a..9dde1db9c078 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7607,32 +7607,32 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa32_tid3,
-              .resetvalue = cpu->isar.id_isar0 },
+              .resetvalue = GET_IDREG(isar, ID_ISAR0)},
             { .name = "ID_ISAR1", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa32_tid3,
-              .resetvalue = cpu->isar.id_isar1 },
+              .resetvalue = GET_IDREG(isar, ID_ISAR1)},
             { .name = "ID_ISAR2", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa32_tid3,
-              .resetvalue = cpu->isar.id_isar2 },
+              .resetvalue = GET_IDREG(isar, ID_ISAR2)},
             { .name = "ID_ISAR3", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa32_tid3,
-              .resetvalue = cpu->isar.id_isar3 },
+              .resetvalue = GET_IDREG(isar, ID_ISAR3) },
             { .name = "ID_ISAR4", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa32_tid3,
-              .resetvalue = cpu->isar.id_isar4 },
+              .resetvalue = GET_IDREG(isar, ID_ISAR4) },
             { .name = "ID_ISAR5", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa32_tid3,
-              .resetvalue = cpu->isar.id_isar5 },
+              .resetvalue = GET_IDREG(isar, ID_ISAR5) },
             { .name = "ID_MMFR4", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 6,
               .access = PL1_R, .type = ARM_CP_CONST,
@@ -7642,7 +7642,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 7,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa32_tid3,
-              .resetvalue = cpu->isar.id_isar6 },
+              .resetvalue = GET_IDREG(isar, ID_ISAR6) },
         };
         define_arm_cp_regs(cpu, v6_idregs);
         define_arm_cp_regs(cpu, v6_cp_reginfo);
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index a73ff0a603bc..ceb7e7bec7a2 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -383,22 +383,15 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
                               ARM64_SYS_REG(3, 0, 0, 1, 6));
         err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr3,
                               ARM64_SYS_REG(3, 0, 0, 1, 7));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar0,
-                              ARM64_SYS_REG(3, 0, 0, 2, 0));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar1,
-                              ARM64_SYS_REG(3, 0, 0, 2, 1));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar2,
-                              ARM64_SYS_REG(3, 0, 0, 2, 2));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar3,
-                              ARM64_SYS_REG(3, 0, 0, 2, 3));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar4,
-                              ARM64_SYS_REG(3, 0, 0, 2, 4));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar5,
-                              ARM64_SYS_REG(3, 0, 0, 2, 5));
+        err |= get_host_cpu_reg(fd, ahcf, ID_ISAR0_EL1_IDX);
+        err |= get_host_cpu_reg(fd, ahcf, ID_ISAR1_EL1_IDX);
+        err |= get_host_cpu_reg(fd, ahcf, ID_ISAR2_EL1_IDX);
+        err |= get_host_cpu_reg(fd, ahcf, ID_ISAR3_EL1_IDX);
+        err |= get_host_cpu_reg(fd, ahcf, ID_ISAR4_EL1_IDX);
+        err |= get_host_cpu_reg(fd, ahcf, ID_ISAR5_EL1_IDX);
+        err |= get_host_cpu_reg(fd, ahcf, ID_ISAR6_EL1_IDX);
         err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr4,
                               ARM64_SYS_REG(3, 0, 0, 2, 6));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar6,
-                              ARM64_SYS_REG(3, 0, 0, 2, 7));
 
         err |= read_sys_reg32(fdarray[2], &ahcf->isar.mvfr0,
                               ARM64_SYS_REG(3, 0, 0, 3, 0));
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index 03acdf83e006..31f9bcc49a13 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -46,6 +46,7 @@ static bool arm_v7m_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 static void cortex_m0_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
+    uint64_t *idregs = cpu->isar.idregs;
     set_feature(&cpu->env, ARM_FEATURE_V6);
     set_feature(&cpu->env, ARM_FEATURE_M);
 
@@ -67,18 +68,19 @@ static void cortex_m0_initfn(Object *obj)
     cpu->isar.id_mmfr1 = 0x00000000;
     cpu->isar.id_mmfr2 = 0x00000000;
     cpu->isar.id_mmfr3 = 0x00000000;
-    cpu->isar.id_isar0 = 0x01141110;
-    cpu->isar.id_isar1 = 0x02111000;
-    cpu->isar.id_isar2 = 0x21112231;
-    cpu->isar.id_isar3 = 0x01111110;
-    cpu->isar.id_isar4 = 0x01310102;
-    cpu->isar.id_isar5 = 0x00000000;
-    cpu->isar.id_isar6 = 0x00000000;
+    SET_IDREG(idregs, ID_ISAR0, 0x01141110);
+    SET_IDREG(idregs, ID_ISAR1, 0x02111000);
+    SET_IDREG(idregs, ID_ISAR2, 0x21112231);
+    SET_IDREG(idregs, ID_ISAR3, 0x01111110);
+    SET_IDREG(idregs, ID_ISAR4, 0x01310102);
+    SET_IDREG(idregs, ID_ISAR5, 0x00000000);
+    SET_IDREG(idregs, ID_ISAR6, 0x00000000);
 }
 
 static void cortex_m3_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
+    uint64_t *idregs = cpu->isar.idregs;
     set_feature(&cpu->env, ARM_FEATURE_V7);
     set_feature(&cpu->env, ARM_FEATURE_M);
     set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
@@ -92,18 +94,19 @@ static void cortex_m3_initfn(Object *obj)
     cpu->isar.id_mmfr1 = 0x00000000;
     cpu->isar.id_mmfr2 = 0x00000000;
     cpu->isar.id_mmfr3 = 0x00000000;
-    cpu->isar.id_isar0 = 0x01141110;
-    cpu->isar.id_isar1 = 0x02111000;
-    cpu->isar.id_isar2 = 0x21112231;
-    cpu->isar.id_isar3 = 0x01111110;
-    cpu->isar.id_isar4 = 0x01310102;
-    cpu->isar.id_isar5 = 0x00000000;
-    cpu->isar.id_isar6 = 0x00000000;
+    SET_IDREG(idregs, ID_ISAR0, 0x01141110);
+    SET_IDREG(idregs, ID_ISAR1, 0x02111000);
+    SET_IDREG(idregs, ID_ISAR2, 0x21112231);
+    SET_IDREG(idregs, ID_ISAR3, 0x01111110);
+    SET_IDREG(idregs, ID_ISAR4, 0x01310102);
+    SET_IDREG(idregs, ID_ISAR5, 0x00000000);
+    SET_IDREG(idregs, ID_ISAR6, 0x00000000);
 }
 
 static void cortex_m4_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
+    uint64_t *idregs = cpu->isar.idregs;
 
     set_feature(&cpu->env, ARM_FEATURE_V7);
     set_feature(&cpu->env, ARM_FEATURE_M);
@@ -122,18 +125,19 @@ static void cortex_m4_initfn(Object *obj)
     cpu->isar.id_mmfr1 = 0x00000000;
     cpu->isar.id_mmfr2 = 0x00000000;
     cpu->isar.id_mmfr3 = 0x00000000;
-    cpu->isar.id_isar0 = 0x01141110;
-    cpu->isar.id_isar1 = 0x02111000;
-    cpu->isar.id_isar2 = 0x21112231;
-    cpu->isar.id_isar3 = 0x01111110;
-    cpu->isar.id_isar4 = 0x01310102;
-    cpu->isar.id_isar5 = 0x00000000;
-    cpu->isar.id_isar6 = 0x00000000;
+    SET_IDREG(idregs, ID_ISAR0, 0x01141110);
+    SET_IDREG(idregs, ID_ISAR1, 0x02111000);
+    SET_IDREG(idregs, ID_ISAR2, 0x21112231);
+    SET_IDREG(idregs, ID_ISAR3, 0x01111110);
+    SET_IDREG(idregs, ID_ISAR4, 0x01310102);
+    SET_IDREG(idregs, ID_ISAR5, 0x00000000);
+    SET_IDREG(idregs, ID_ISAR6, 0x00000000);
 }
 
 static void cortex_m7_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
+    uint64_t *idregs = cpu->isar.idregs;
 
     set_feature(&cpu->env, ARM_FEATURE_V7);
     set_feature(&cpu->env, ARM_FEATURE_M);
@@ -152,18 +156,19 @@ static void cortex_m7_initfn(Object *obj)
     cpu->isar.id_mmfr1 = 0x00000000;
     cpu->isar.id_mmfr2 = 0x01000000;
     cpu->isar.id_mmfr3 = 0x00000000;
-    cpu->isar.id_isar0 = 0x01101110;
-    cpu->isar.id_isar1 = 0x02112000;
-    cpu->isar.id_isar2 = 0x20232231;
-    cpu->isar.id_isar3 = 0x01111131;
-    cpu->isar.id_isar4 = 0x01310132;
-    cpu->isar.id_isar5 = 0x00000000;
-    cpu->isar.id_isar6 = 0x00000000;
+    SET_IDREG(idregs, ID_ISAR0, 0x01101110);
+    SET_IDREG(idregs, ID_ISAR1, 0x02112000);
+    SET_IDREG(idregs, ID_ISAR2, 0x20232231);
+    SET_IDREG(idregs, ID_ISAR3, 0x01111131);
+    SET_IDREG(idregs, ID_ISAR4, 0x01310132);
+    SET_IDREG(idregs, ID_ISAR5, 0x00000000);
+    SET_IDREG(idregs, ID_ISAR6, 0x00000000);
 }
 
 static void cortex_m33_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
+    uint64_t *idregs = cpu->isar.idregs;
 
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_M);
@@ -184,13 +189,13 @@ static void cortex_m33_initfn(Object *obj)
     cpu->isar.id_mmfr1 = 0x00000000;
     cpu->isar.id_mmfr2 = 0x01000000;
     cpu->isar.id_mmfr3 = 0x00000000;
-    cpu->isar.id_isar0 = 0x01101110;
-    cpu->isar.id_isar1 = 0x02212000;
-    cpu->isar.id_isar2 = 0x20232232;
-    cpu->isar.id_isar3 = 0x01111131;
-    cpu->isar.id_isar4 = 0x01310132;
-    cpu->isar.id_isar5 = 0x00000000;
-    cpu->isar.id_isar6 = 0x00000000;
+    SET_IDREG(idregs, ID_ISAR0, 0x01101110);
+    SET_IDREG(idregs, ID_ISAR1, 0x02212000);
+    SET_IDREG(idregs, ID_ISAR2, 0x20232232);
+    SET_IDREG(idregs, ID_ISAR3, 0x01111131);
+    SET_IDREG(idregs, ID_ISAR4, 0x01310132);
+    SET_IDREG(idregs, ID_ISAR5, 0x00000000);
+    SET_IDREG(idregs, ID_ISAR6, 0x00000000);
     cpu->clidr = 0x00000000;
     cpu->ctr = 0x8000c000;
 }
@@ -198,6 +203,7 @@ static void cortex_m33_initfn(Object *obj)
 static void cortex_m55_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
+    uint64_t *idregs = cpu->isar.idregs;
 
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_V8_1M);
@@ -221,13 +227,13 @@ static void cortex_m55_initfn(Object *obj)
     cpu->isar.id_mmfr1 = 0x00000000;
     cpu->isar.id_mmfr2 = 0x01000000;
     cpu->isar.id_mmfr3 = 0x00000011;
-    cpu->isar.id_isar0 = 0x01103110;
-    cpu->isar.id_isar1 = 0x02212000;
-    cpu->isar.id_isar2 = 0x20232232;
-    cpu->isar.id_isar3 = 0x01111131;
-    cpu->isar.id_isar4 = 0x01310132;
-    cpu->isar.id_isar5 = 0x00000000;
-    cpu->isar.id_isar6 = 0x00000000;
+    SET_IDREG(idregs, ID_ISAR0, 0x01103110);
+    SET_IDREG(idregs, ID_ISAR1, 0x02212000);
+    SET_IDREG(idregs, ID_ISAR2, 0x20232232);
+    SET_IDREG(idregs, ID_ISAR3, 0x01111131);
+    SET_IDREG(idregs, ID_ISAR4, 0x01310132);
+    SET_IDREG(idregs, ID_ISAR5, 0x00000000);
+    SET_IDREG(idregs, ID_ISAR6, 0x00000000);
     cpu->clidr = 0x00000000; /* caches not implemented */
     cpu->ctr = 0x8303c003;
 }
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 0f1c5bc87e88..87a0806c0a33 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -23,18 +23,19 @@
 void aa32_max_features(ARMCPU *cpu)
 {
     uint32_t t;
+    ARMISARegisters *isar = &cpu->isar;
 
     /* Add additional features supported by QEMU */
-    t = cpu->isar.id_isar5;
+    t = GET_IDREG(isar, ID_ISAR5);
     t = FIELD_DP32(t, ID_ISAR5, AES, 2);          /* FEAT_PMULL */
     t = FIELD_DP32(t, ID_ISAR5, SHA1, 1);         /* FEAT_SHA1 */
     t = FIELD_DP32(t, ID_ISAR5, SHA2, 1);         /* FEAT_SHA256 */
     t = FIELD_DP32(t, ID_ISAR5, CRC32, 1);
     t = FIELD_DP32(t, ID_ISAR5, RDM, 1);          /* FEAT_RDM */
     t = FIELD_DP32(t, ID_ISAR5, VCMA, 1);         /* FEAT_FCMA */
-    cpu->isar.id_isar5 = t;
+    SET_IDREG(isar, ID_ISAR5, t);
 
-    t = cpu->isar.id_isar6;
+    t = GET_IDREG(isar, ID_ISAR6);
     t = FIELD_DP32(t, ID_ISAR6, JSCVT, 1);        /* FEAT_JSCVT */
     t = FIELD_DP32(t, ID_ISAR6, DP, 1);           /* Feat_DotProd */
     t = FIELD_DP32(t, ID_ISAR6, FHM, 1);          /* FEAT_FHM */
@@ -42,7 +43,7 @@ void aa32_max_features(ARMCPU *cpu)
     t = FIELD_DP32(t, ID_ISAR6, SPECRES, 1);      /* FEAT_SPECRES */
     t = FIELD_DP32(t, ID_ISAR6, BF16, 1);         /* FEAT_AA32BF16 */
     t = FIELD_DP32(t, ID_ISAR6, I8MM, 1);         /* FEAT_AA32I8MM */
-    cpu->isar.id_isar6 = t;
+    SET_IDREG(isar, ID_ISAR6, t);
 
     t = cpu->isar.mvfr1;
     t = FIELD_DP32(t, MVFR1, FPHP, 3);            /* FEAT_FP16 */
@@ -140,7 +141,7 @@ static void arm926_initfn(Object *obj)
      * ARMv5 does not have the ID_ISAR registers, but we can still
      * set the field to indicate Jazelle support within QEMU.
      */
-    cpu->isar.id_isar1 = FIELD_DP32(cpu->isar.id_isar1, ID_ISAR1, JAZELLE, 1);
+    FIELD_DP32_IDREG(&cpu->isar, ID_ISAR1, JAZELLE, 1);
     /*
      * Similarly, we need to set MVFR0 fields to enable vfp and short vector
      * support even though ARMv5 doesn't have this register.
@@ -182,7 +183,7 @@ static void arm1026_initfn(Object *obj)
      * ARMv5 does not have the ID_ISAR registers, but we can still
      * set the field to indicate Jazelle support within QEMU.
      */
-    cpu->isar.id_isar1 = FIELD_DP32(cpu->isar.id_isar1, ID_ISAR1, JAZELLE, 1);
+    FIELD_DP32_IDREG(&cpu->isar, ID_ISAR1, JAZELLE, 1);
     /*
      * Similarly, we need to set MVFR0 fields to enable vfp and short vector
      * support even though ARMv5 doesn't have this register.
@@ -206,6 +207,7 @@ static void arm1026_initfn(Object *obj)
 static void arm1136_r2_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
+    ARMISARegisters *isar = &cpu->isar;
     /*
      * What qemu calls "arm1136_r2" is actually the 1136 r0p2, ie an
      * older core than plain "arm1136". In particular this does not
@@ -233,17 +235,18 @@ static void arm1136_r2_initfn(Object *obj)
     cpu->isar.id_mmfr0 = 0x01130003;
     cpu->isar.id_mmfr1 = 0x10030302;
     cpu->isar.id_mmfr2 = 0x01222110;
-    cpu->isar.id_isar0 = 0x00140011;
-    cpu->isar.id_isar1 = 0x12002111;
-    cpu->isar.id_isar2 = 0x11231111;
-    cpu->isar.id_isar3 = 0x01102131;
-    cpu->isar.id_isar4 = 0x141;
+    SET_IDREG(isar, ID_ISAR0, 0x00140011);
+    SET_IDREG(isar, ID_ISAR1, 0x12002111);
+    SET_IDREG(isar, ID_ISAR2, 0x11231111);
+    SET_IDREG(isar, ID_ISAR3, 0x01102131);
+    SET_IDREG(isar, ID_ISAR4, 0x141);
     cpu->reset_auxcr = 7;
 }
 
 static void arm1136_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
+    ARMISARegisters *isar = &cpu->isar;
 
     cpu->dtb_compatible = "arm,arm1136";
     set_feature(&cpu->env, ARM_FEATURE_V6K);
@@ -264,17 +267,18 @@ static void arm1136_initfn(Object *obj)
     cpu->isar.id_mmfr0 = 0x01130003;
     cpu->isar.id_mmfr1 = 0x10030302;
     cpu->isar.id_mmfr2 = 0x01222110;
-    cpu->isar.id_isar0 = 0x00140011;
-    cpu->isar.id_isar1 = 0x12002111;
-    cpu->isar.id_isar2 = 0x11231111;
-    cpu->isar.id_isar3 = 0x01102131;
-    cpu->isar.id_isar4 = 0x141;
+    SET_IDREG(isar, ID_ISAR0, 0x00140011);
+    SET_IDREG(isar, ID_ISAR1, 0x12002111);
+    SET_IDREG(isar, ID_ISAR2, 0x11231111);
+    SET_IDREG(isar, ID_ISAR3, 0x01102131);
+    SET_IDREG(isar, ID_ISAR4, 0x141);
     cpu->reset_auxcr = 7;
 }
 
 static void arm1176_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
+    ARMISARegisters *isar = &cpu->isar;
 
     cpu->dtb_compatible = "arm,arm1176";
     set_feature(&cpu->env, ARM_FEATURE_V6K);
@@ -296,17 +300,18 @@ static void arm1176_initfn(Object *obj)
     cpu->isar.id_mmfr0 = 0x01130003;
     cpu->isar.id_mmfr1 = 0x10030302;
     cpu->isar.id_mmfr2 = 0x01222100;
-    cpu->isar.id_isar0 = 0x0140011;
-    cpu->isar.id_isar1 = 0x12002111;
-    cpu->isar.id_isar2 = 0x11231121;
-    cpu->isar.id_isar3 = 0x01102131;
-    cpu->isar.id_isar4 = 0x01141;
+    SET_IDREG(isar, ID_ISAR0, 0x0140011);
+    SET_IDREG(isar, ID_ISAR1, 0x12002111);
+    SET_IDREG(isar, ID_ISAR2, 0x11231121);
+    SET_IDREG(isar, ID_ISAR3, 0x01102131);
+    SET_IDREG(isar, ID_ISAR4, 0x01141);
     cpu->reset_auxcr = 7;
 }
 
 static void arm11mpcore_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
+    ARMISARegisters *isar = &cpu->isar;
 
     cpu->dtb_compatible = "arm,arm11mpcore";
     set_feature(&cpu->env, ARM_FEATURE_V6K);
@@ -325,11 +330,11 @@ static void arm11mpcore_initfn(Object *obj)
     cpu->isar.id_mmfr0 = 0x01100103;
     cpu->isar.id_mmfr1 = 0x10020302;
     cpu->isar.id_mmfr2 = 0x01222000;
-    cpu->isar.id_isar0 = 0x00100011;
-    cpu->isar.id_isar1 = 0x12002111;
-    cpu->isar.id_isar2 = 0x11221011;
-    cpu->isar.id_isar3 = 0x01102131;
-    cpu->isar.id_isar4 = 0x141;
+    SET_IDREG(isar, ID_ISAR0, 0x00100011);
+    SET_IDREG(isar, ID_ISAR1, 0x12002111);
+    SET_IDREG(isar, ID_ISAR2, 0x11221011);
+    SET_IDREG(isar, ID_ISAR3, 0x01102131);
+    SET_IDREG(isar, ID_ISAR4, 0x141);
     cpu->reset_auxcr = 1;
 }
 
@@ -343,6 +348,7 @@ static const ARMCPRegInfo cortexa8_cp_reginfo[] = {
 static void cortex_a8_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
+    ARMISARegisters *isar = &cpu->isar;
 
     cpu->dtb_compatible = "arm,cortex-a8";
     set_feature(&cpu->env, ARM_FEATURE_V7);
@@ -365,11 +371,11 @@ static void cortex_a8_initfn(Object *obj)
     cpu->isar.id_mmfr1 = 0x20000000;
     cpu->isar.id_mmfr2 = 0x01202000;
     cpu->isar.id_mmfr3 = 0x11;
-    cpu->isar.id_isar0 = 0x00101111;
-    cpu->isar.id_isar1 = 0x12112111;
-    cpu->isar.id_isar2 = 0x21232031;
-    cpu->isar.id_isar3 = 0x11112131;
-    cpu->isar.id_isar4 = 0x00111142;
+    SET_IDREG(isar, ID_ISAR0, 0x00101111);
+    SET_IDREG(isar, ID_ISAR1, 0x12112111);
+    SET_IDREG(isar, ID_ISAR2, 0x21232031);
+    SET_IDREG(isar, ID_ISAR3, 0x11112131);
+    SET_IDREG(isar, ID_ISAR4, 0x00111142);
     cpu->isar.dbgdidr = 0x15141000;
     cpu->clidr = (1 << 27) | (2 << 24) | 3;
     cpu->ccsidr[0] = 0xe007e01a; /* 16k L1 dcache. */
@@ -412,6 +418,7 @@ static const ARMCPRegInfo cortexa9_cp_reginfo[] = {
 static void cortex_a9_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
+    ARMISARegisters *isar = &cpu->isar;
 
     cpu->dtb_compatible = "arm,cortex-a9";
     set_feature(&cpu->env, ARM_FEATURE_V7);
@@ -440,11 +447,11 @@ static void cortex_a9_initfn(Object *obj)
     cpu->isar.id_mmfr1 = 0x20000000;
     cpu->isar.id_mmfr2 = 0x01230000;
     cpu->isar.id_mmfr3 = 0x00002111;
-    cpu->isar.id_isar0 = 0x00101111;
-    cpu->isar.id_isar1 = 0x13112111;
-    cpu->isar.id_isar2 = 0x21232041;
-    cpu->isar.id_isar3 = 0x11112131;
-    cpu->isar.id_isar4 = 0x00111142;
+    SET_IDREG(isar, ID_ISAR0, 0x00101111);
+    SET_IDREG(isar, ID_ISAR1, 0x13112111);
+    SET_IDREG(isar, ID_ISAR2, 0x21232041);
+    SET_IDREG(isar, ID_ISAR3, 0x11112131);
+    SET_IDREG(isar, ID_ISAR4, 0x00111142);
     cpu->isar.dbgdidr = 0x35141000;
     cpu->clidr = (1 << 27) | (1 << 24) | 3;
     cpu->ccsidr[0] = 0xe00fe019; /* 16k L1 dcache. */
@@ -479,6 +486,7 @@ static const ARMCPRegInfo cortexa15_cp_reginfo[] = {
 static void cortex_a7_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
+    ARMISARegisters *isar = &cpu->isar;
 
     cpu->dtb_compatible = "arm,cortex-a7";
     set_feature(&cpu->env, ARM_FEATURE_V7VE);
@@ -509,11 +517,11 @@ static void cortex_a7_initfn(Object *obj)
      * a7_mpcore_r0p5_trm, page 4-4 gives 0x01101110; but
      * table 4-41 gives 0x02101110, which includes the arm div insns.
      */
-    cpu->isar.id_isar0 = 0x02101110;
-    cpu->isar.id_isar1 = 0x13112111;
-    cpu->isar.id_isar2 = 0x21232041;
-    cpu->isar.id_isar3 = 0x11112131;
-    cpu->isar.id_isar4 = 0x10011142;
+    SET_IDREG(isar, ID_ISAR0, 0x02101110);
+    SET_IDREG(isar, ID_ISAR1, 0x13112111);
+    SET_IDREG(isar, ID_ISAR2, 0x21232041);
+    SET_IDREG(isar, ID_ISAR3, 0x11112131);
+    SET_IDREG(isar, ID_ISAR4, 0x10011142);
     cpu->isar.dbgdidr = 0x3515f005;
     cpu->isar.dbgdevid = 0x01110f13;
     cpu->isar.dbgdevid1 = 0x1;
@@ -528,6 +536,7 @@ static void cortex_a7_initfn(Object *obj)
 static void cortex_a15_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
+    ARMISARegisters *isar = &cpu->isar;
 
     cpu->dtb_compatible = "arm,cortex-a15";
     set_feature(&cpu->env, ARM_FEATURE_V7VE);
@@ -556,11 +565,11 @@ static void cortex_a15_initfn(Object *obj)
     cpu->isar.id_mmfr1 = 0x20000000;
     cpu->isar.id_mmfr2 = 0x01240000;
     cpu->isar.id_mmfr3 = 0x02102211;
-    cpu->isar.id_isar0 = 0x02101110;
-    cpu->isar.id_isar1 = 0x13112111;
-    cpu->isar.id_isar2 = 0x21232041;
-    cpu->isar.id_isar3 = 0x11112131;
-    cpu->isar.id_isar4 = 0x10011142;
+    SET_IDREG(isar, ID_ISAR0, 0x02101110);
+    SET_IDREG(isar, ID_ISAR1, 0x13112111);
+    SET_IDREG(isar, ID_ISAR2, 0x21232041);
+    SET_IDREG(isar, ID_ISAR3, 0x11112131);
+    SET_IDREG(isar, ID_ISAR4, 0x10011142);
     cpu->isar.dbgdidr = 0x3515f021;
     cpu->isar.dbgdevid = 0x01110f13;
     cpu->isar.dbgdevid1 = 0x0;
@@ -585,6 +594,7 @@ static const ARMCPRegInfo cortexr5_cp_reginfo[] = {
 static void cortex_r5_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
+    ARMISARegisters *isar = &cpu->isar;
 
     set_feature(&cpu->env, ARM_FEATURE_V7);
     set_feature(&cpu->env, ARM_FEATURE_V7MP);
@@ -599,13 +609,13 @@ static void cortex_r5_initfn(Object *obj)
     cpu->isar.id_mmfr1 = 0x00000000;
     cpu->isar.id_mmfr2 = 0x01200000;
     cpu->isar.id_mmfr3 = 0x0211;
-    cpu->isar.id_isar0 = 0x02101111;
-    cpu->isar.id_isar1 = 0x13112111;
-    cpu->isar.id_isar2 = 0x21232141;
-    cpu->isar.id_isar3 = 0x01112131;
-    cpu->isar.id_isar4 = 0x0010142;
-    cpu->isar.id_isar5 = 0x0;
-    cpu->isar.id_isar6 = 0x0;
+    SET_IDREG(isar, ID_ISAR0, 0x02101111);
+    SET_IDREG(isar, ID_ISAR1, 0x13112111);
+    SET_IDREG(isar, ID_ISAR2, 0x21232141);
+    SET_IDREG(isar, ID_ISAR3, 0x01112131);
+    SET_IDREG(isar, ID_ISAR4, 0x0010142);
+    SET_IDREG(isar, ID_ISAR5, 0x21232141);
+    SET_IDREG(isar, ID_ISAR6, 0x0);
     cpu->mp_is_up = true;
     cpu->pmsav7_dregion = 16;
     cpu->isar.reset_pmcr_el0 = 0x41151800;
@@ -720,6 +730,7 @@ static const ARMCPRegInfo cortex_r52_cp_reginfo[] = {
 static void cortex_r52_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
+    ARMISARegisters *isar = &cpu->isar;
 
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_EL2);
@@ -746,12 +757,12 @@ static void cortex_r52_initfn(Object *obj)
     cpu->isar.id_mmfr2 = 0x01200000;
     cpu->isar.id_mmfr3 = 0xf0102211;
     cpu->isar.id_mmfr4 = 0x00000010;
-    cpu->isar.id_isar0 = 0x02101110;
-    cpu->isar.id_isar1 = 0x13112111;
-    cpu->isar.id_isar2 = 0x21232142;
-    cpu->isar.id_isar3 = 0x01112131;
-    cpu->isar.id_isar4 = 0x00010142;
-    cpu->isar.id_isar5 = 0x00010001;
+    SET_IDREG(isar, ID_ISAR0, 0x02101110);
+    SET_IDREG(isar, ID_ISAR1, 0x13112111);
+    SET_IDREG(isar, ID_ISAR2, 0x21232142);
+    SET_IDREG(isar, ID_ISAR3, 0x01112131);
+    SET_IDREG(isar, ID_ISAR4, 0x00010142);
+    SET_IDREG(isar, ID_ISAR5, 0x00010001);
     cpu->isar.dbgdidr = 0x77168000;
     cpu->clidr = (1 << 27) | (1 << 24) | 0x3;
     cpu->ccsidr[0] = 0x700fe01a; /* 32KB L1 dcache */
@@ -949,6 +960,7 @@ static void pxa270c5_initfn(Object *obj)
 static void arm_max_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
+    ARMISARegisters *isar = &cpu->isar;
 
     /* aarch64_a57_initfn, advertising none of the aarch64 features */
     cpu->dtb_compatible = "arm,cortex-a57";
@@ -976,13 +988,13 @@ static void arm_max_initfn(Object *obj)
     cpu->isar.id_mmfr1 = 0x40000000;
     cpu->isar.id_mmfr2 = 0x01260000;
     cpu->isar.id_mmfr3 = 0x02102211;
-    cpu->isar.id_isar0 = 0x02101110;
-    cpu->isar.id_isar1 = 0x13112111;
-    cpu->isar.id_isar2 = 0x21232042;
-    cpu->isar.id_isar3 = 0x01112131;
-    cpu->isar.id_isar4 = 0x00011142;
-    cpu->isar.id_isar5 = 0x00011121;
-    cpu->isar.id_isar6 = 0;
+    SET_IDREG(isar, ID_ISAR0, 0x02101110);
+    SET_IDREG(isar, ID_ISAR1, 0x13112111);
+    SET_IDREG(isar, ID_ISAR2, 0x21232042);
+    SET_IDREG(isar, ID_ISAR3, 0x01112131);
+    SET_IDREG(isar, ID_ISAR4, 0x00011142);
+    SET_IDREG(isar, ID_ISAR5, 0x00011121);
+    SET_IDREG(isar, ID_ISAR6, 0);
     cpu->isar.reset_pmcr_el0 = 0x41013000;
     cpu->clidr = 0x0a200023;
     cpu->ccsidr[0] = 0x701fe00a; /* 32KB L1 dcache */
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index cadc1258fc40..ad47279cdd46 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -57,12 +57,12 @@ static void aarch64_a35_initfn(Object *obj)
     cpu->isar.id_mmfr1 = 0x40000000;
     cpu->isar.id_mmfr2 = 0x01260000;
     cpu->isar.id_mmfr3 = 0x02102211;
-    cpu->isar.id_isar0 = 0x02101110;
-    cpu->isar.id_isar1 = 0x13112111;
-    cpu->isar.id_isar2 = 0x21232042;
-    cpu->isar.id_isar3 = 0x01112131;
-    cpu->isar.id_isar4 = 0x00011142;
-    cpu->isar.id_isar5 = 0x00011121;
+    SET_IDREG(isar, ID_ISAR0, 0x02101110);
+    SET_IDREG(isar, ID_ISAR1, 0x13112111);
+    SET_IDREG(isar, ID_ISAR2, 0x21232042);
+    SET_IDREG(isar, ID_ISAR3, 0x01112131);
+    SET_IDREG(isar, ID_ISAR4, 0x00011142);
+    SET_IDREG(isar, ID_ISAR5, 0x00011121);
     SET_IDREG(isar, ID_AA64PFR0, 0x00002222);
     SET_IDREG(isar, ID_AA64PFR1, 0);
     SET_IDREG(isar, ID_AA64DFR0, 0x10305106);
@@ -229,13 +229,13 @@ static void aarch64_a55_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000010ull);
     cpu->id_afr0       = 0x00000000;
     cpu->isar.id_dfr0  = 0x04010088;
-    cpu->isar.id_isar0 = 0x02101110;
-    cpu->isar.id_isar1 = 0x13112111;
-    cpu->isar.id_isar2 = 0x21232042;
-    cpu->isar.id_isar3 = 0x01112131;
-    cpu->isar.id_isar4 = 0x00011142;
-    cpu->isar.id_isar5 = 0x01011121;
-    cpu->isar.id_isar6 = 0x00000010;
+    SET_IDREG(isar, ID_ISAR0, 0x02101110);
+    SET_IDREG(isar, ID_ISAR1, 0x13112111);
+    SET_IDREG(isar, ID_ISAR2, 0x21232042);
+    SET_IDREG(isar, ID_ISAR3, 0x01112131);
+    SET_IDREG(isar, ID_ISAR4, 0x00011142);
+    SET_IDREG(isar, ID_ISAR5, 0x01011121);
+    SET_IDREG(isar, ID_ISAR6, 0x00000010);
     cpu->isar.id_mmfr0 = 0x10201105;
     cpu->isar.id_mmfr1 = 0x40000000;
     cpu->isar.id_mmfr2 = 0x01260000;
@@ -303,12 +303,12 @@ static void aarch64_a72_initfn(Object *obj)
     cpu->isar.id_mmfr1 = 0x40000000;
     cpu->isar.id_mmfr2 = 0x01260000;
     cpu->isar.id_mmfr3 = 0x02102211;
-    cpu->isar.id_isar0 = 0x02101110;
-    cpu->isar.id_isar1 = 0x13112111;
-    cpu->isar.id_isar2 = 0x21232042;
-    cpu->isar.id_isar3 = 0x01112131;
-    cpu->isar.id_isar4 = 0x00011142;
-    cpu->isar.id_isar5 = 0x00011121;
+    SET_IDREG(isar, ID_ISAR0, 0x02101110);
+    SET_IDREG(isar, ID_ISAR1, 0x13112111);
+    SET_IDREG(isar, ID_ISAR2, 0x21232042);
+    SET_IDREG(isar, ID_ISAR3, 0x01112131);
+    SET_IDREG(isar, ID_ISAR4, 0x00011142);
+    SET_IDREG(isar, ID_ISAR5, 0x00011121);
     SET_IDREG(isar, ID_AA64PFR0, 0x00002222);
     SET_IDREG(isar, ID_AA64DFR0, 0x10305106);
     SET_IDREG(isar, ID_AA64ISAR0, 0x00011120);
@@ -362,13 +362,13 @@ static void aarch64_a76_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000010ull);
     cpu->id_afr0       = 0x00000000;
     cpu->isar.id_dfr0  = 0x04010088;
-    cpu->isar.id_isar0 = 0x02101110;
-    cpu->isar.id_isar1 = 0x13112111;
-    cpu->isar.id_isar2 = 0x21232042;
-    cpu->isar.id_isar3 = 0x01112131;
-    cpu->isar.id_isar4 = 0x00010142;
-    cpu->isar.id_isar5 = 0x01011121;
-    cpu->isar.id_isar6 = 0x00000010;
+    SET_IDREG(isar, ID_ISAR0, 0x02101110);
+    SET_IDREG(isar, ID_ISAR1, 0x13112111);
+    SET_IDREG(isar, ID_ISAR2, 0x21232042);
+    SET_IDREG(isar, ID_ISAR3, 0x01112131);
+    SET_IDREG(isar, ID_ISAR4, 0x00010142);
+    SET_IDREG(isar, ID_ISAR5, 0x01011121);
+    SET_IDREG(isar, ID_ISAR6, 0x00000010);
     cpu->isar.id_mmfr0 = 0x10201105;
     cpu->isar.id_mmfr1 = 0x40000000;
     cpu->isar.id_mmfr2 = 0x01260000;
@@ -610,13 +610,13 @@ static void aarch64_neoverse_n1_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000020ull);
     cpu->id_afr0       = 0x00000000;
     cpu->isar.id_dfr0  = 0x04010088;
-    cpu->isar.id_isar0 = 0x02101110;
-    cpu->isar.id_isar1 = 0x13112111;
-    cpu->isar.id_isar2 = 0x21232042;
-    cpu->isar.id_isar3 = 0x01112131;
-    cpu->isar.id_isar4 = 0x00010142;
-    cpu->isar.id_isar5 = 0x01011121;
-    cpu->isar.id_isar6 = 0x00000010;
+    SET_IDREG(isar, ID_ISAR0, 0x02101110);
+    SET_IDREG(isar, ID_ISAR1, 0x13112111);
+    SET_IDREG(isar, ID_ISAR2, 0x21232042);
+    SET_IDREG(isar, ID_ISAR3, 0x01112131);
+    SET_IDREG(isar, ID_ISAR4, 0x00010142);
+    SET_IDREG(isar, ID_ISAR5, 0x01011121);
+    SET_IDREG(isar, ID_ISAR6, 0x00000010);
     cpu->isar.id_mmfr0 = 0x10201105;
     cpu->isar.id_mmfr1 = 0x40000000;
     cpu->isar.id_mmfr2 = 0x01260000;
@@ -689,13 +689,13 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000020ull);
     cpu->id_afr0       = 0x00000000;
     cpu->isar.id_dfr0  = 0x15011099;
-    cpu->isar.id_isar0 = 0x02101110;
-    cpu->isar.id_isar1 = 0x13112111;
-    cpu->isar.id_isar2 = 0x21232042;
-    cpu->isar.id_isar3 = 0x01112131;
-    cpu->isar.id_isar4 = 0x00010142;
-    cpu->isar.id_isar5 = 0x11011121;
-    cpu->isar.id_isar6 = 0x01100111;
+    SET_IDREG(isar, ID_ISAR0, 0x02101110);
+    SET_IDREG(isar, ID_ISAR1, 0x13112111);
+    SET_IDREG(isar, ID_ISAR2, 0x21232042);
+    SET_IDREG(isar, ID_ISAR3, 0x01112131);
+    SET_IDREG(isar, ID_ISAR4, 0x00010142);
+    SET_IDREG(isar, ID_ISAR5, 0x11011121);
+    SET_IDREG(isar, ID_ISAR6, 0x01100111);
     cpu->isar.id_mmfr0 = 0x10201105;
     cpu->isar.id_mmfr1 = 0x40000000;
     cpu->isar.id_mmfr2 = 0x01260000;
@@ -910,14 +910,14 @@ static void aarch64_a710_initfn(Object *obj)
     cpu->isar.id_mmfr1 = 0x40000000;
     cpu->isar.id_mmfr2 = 0x01260000;
     cpu->isar.id_mmfr3 = 0x02122211;
-    cpu->isar.id_isar0 = 0x02101110;
-    cpu->isar.id_isar1 = 0x13112111;
-    cpu->isar.id_isar2 = 0x21232042;
-    cpu->isar.id_isar3 = 0x01112131;
-    cpu->isar.id_isar4 = 0x00010142;
-    cpu->isar.id_isar5 = 0x11011121; /* with Crypto */
+    SET_IDREG(isar, ID_ISAR0, 0x02101110);
+    SET_IDREG(isar, ID_ISAR1, 0x13112111);
+    SET_IDREG(isar, ID_ISAR2, 0x21232042);
+    SET_IDREG(isar, ID_ISAR3, 0x01112131);
+    SET_IDREG(isar, ID_ISAR4, 0x00010142);
+    SET_IDREG(isar, ID_ISAR5, 0x11011121); /* with Crypto */
     cpu->isar.id_mmfr4 = 0x21021110;
-    cpu->isar.id_isar6 = 0x01111111;
+    SET_IDREG(isar, ID_ISAR6, 0x01111111);
     cpu->isar.mvfr0    = 0x10110222;
     cpu->isar.mvfr1    = 0x13211111;
     cpu->isar.mvfr2    = 0x00000043;
@@ -1013,14 +1013,14 @@ static void aarch64_neoverse_n2_initfn(Object *obj)
     cpu->isar.id_mmfr1 = 0x40000000;
     cpu->isar.id_mmfr2 = 0x01260000;
     cpu->isar.id_mmfr3 = 0x02122211;
-    cpu->isar.id_isar0 = 0x02101110;
-    cpu->isar.id_isar1 = 0x13112111;
-    cpu->isar.id_isar2 = 0x21232042;
-    cpu->isar.id_isar3 = 0x01112131;
-    cpu->isar.id_isar4 = 0x00010142;
-    cpu->isar.id_isar5 = 0x11011121; /* with Crypto */
+    SET_IDREG(isar, ID_ISAR0, 0x02101110);
+    SET_IDREG(isar, ID_ISAR1, 0x13112111);
+    SET_IDREG(isar, ID_ISAR2, 0x21232042);
+    SET_IDREG(isar, ID_ISAR3, 0x01112131);
+    SET_IDREG(isar, ID_ISAR4, 0x00010142);
+    SET_IDREG(isar, ID_ISAR5, 0x11011121); /* with Crypto */
     cpu->isar.id_mmfr4 = 0x01021110;
-    cpu->isar.id_isar6 = 0x01111111;
+    SET_IDREG(isar, ID_ISAR6, 0x01111111);
     cpu->isar.mvfr0    = 0x10110222;
     cpu->isar.mvfr1    = 0x13211111;
     cpu->isar.mvfr2    = 0x00000043;
-- 
2.48.1


