Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81944AF0186
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Jul 2025 19:15:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWeSe-0005iS-6U; Tue, 01 Jul 2025 13:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSL-0005SG-1s
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:41 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSG-0003PB-8y
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:40 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4537fdec39fso11612605e9.0
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 10:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751389653; x=1751994453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1od2ynLJfhbgnVOPdCimb6scZHHIcZWbgDVxAfEdxP8=;
 b=JjUzzt5kczu8D9caH5KelJ3cv63zob3+dLDTCzX/JbZDO7cpA9mls/+cmfGHdWbTXx
 lWzxZtsvw8rADZbam/CA6EqdI1l4V2w3sA5jIO3/U4+xgjE1HQmulhVrSmmykMgI9iE5
 7HSkpPqOOIPlEzK7VTc+fNJw+IOH5o/diHUHg9naoi4EeNRMmf8IxybN3IWjKKelo2K8
 zZk4nR2qENB+OjVTJpZUr6zAmaOIns9fxca0FYEzx2b6khPX35FKHOrjtp4qHyF4h/fP
 +aLZITZvsAIXS5Brl24pMnby4Hyzw/ajR9B5fmsxstLo2w6vOf9Qe9xQh4zppmAuXu+j
 ksiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751389653; x=1751994453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1od2ynLJfhbgnVOPdCimb6scZHHIcZWbgDVxAfEdxP8=;
 b=W93Ffwd/aKIbSg9nRek9MEbcMRBTuePJbBvKbSuP+HQKOI96eXRo8MpMN/ywTGVebA
 nIq2o4y5fEdDZJL88sz3n/oO124BZ82HSQ/25YWPIYrey6pRwbgJcDk27j2Xe8hZ4Tnc
 BxG9ZEMU33/mRQmY8I/ZYScnXduRK2AkCGEZ+KQG4tLyQz60KUpfH+llgdbOCJhagM4S
 ZTdayhmSWc1MoZnQMry3ma2yVRzfyYZiJedOI2adyfQbEMH3ajJgqp/5l6+8Jkd7vf3L
 0wlbBrICwVB4ast8XeG15PImobc6Yi0Setu4qVGxfxRsvvdbuywQBHKeusmVKWabOfon
 0p0g==
X-Gm-Message-State: AOJu0YxnG6fQ2kOPyJdM9sGkCiKE/puXOjC902e0Bqbrvvq47rDM5o2c
 VBgGiuei728n1a9/qO9UaL9FzzF9jzFU8EnnHFl9hCAIPDG/v00nA7+SOi81EyIjynjYpfsppd3
 gQ0Ts
X-Gm-Gg: ASbGncuQUMgKRiLtqOkcMNKuuAzR3A16FYJZ+mmMwhWFK70Og7h1hBXddmDcOE5KQPN
 7Q0zu15hDht1Mr92YwGol+7r+PoCIA39/me+BR5iQOiOFw7JJ4mKBLSP1ZYoDGJvGnD6sWvCm4j
 8lCM1hkqGql4BgYziTW/tttd5PwMGSgpGjf4Kh8YzizygHc/6tSdc7efVANLU7hv+cH7DicjiSM
 OQXFnXJDRCd2xlSLYbCOgsHlehjApf2Sno4H/yL4cj4m3X2zOKchwJdS1aQszcbQt1cyfeP8PsT
 jAymJZIDPwouGxkNlQmrIS7qtbXQi3YmuMDKpLIY6vhh7MNPUjNhn5MH5L0icQgv/bGC
X-Google-Smtp-Source: AGHT+IFALyVVIqORU6+x/VF4Dt6wSF5XXtyEllepnTGJPh2+D229D9CViCzdWy6yKVo+3yYZDWYuWQ==
X-Received: by 2002:a05:6000:25ca:b0:3a4:ed2f:e82d with SMTP id
 ffacd0b85a97d-3a8f51c1a81mr14587038f8f.22.1751389653050; 
 Tue, 01 Jul 2025 10:07:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80bb28sm13475658f8f.43.2025.07.01.10.07.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 10:07:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/43] arm/cpu: Store id_isar0-7 into the idregs array
Date: Tue,  1 Jul 2025 18:06:46 +0100
Message-ID: <20250701170720.4072660-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701170720.4072660-1-peter.maydell@linaro.org>
References: <20250701170720.4072660-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Sebastian Ott <sebott@redhat.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Message-id: 20250617153931.1330449-9-cohuck@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h |  36 +++++-----
 target/arm/cpu.h          |   7 --
 hw/intc/armv7m_nvic.c     |  12 ++--
 target/arm/cpu.c          |  24 +++----
 target/arm/cpu64.c        |  28 ++++----
 target/arm/helper.c       |  14 ++--
 target/arm/kvm.c          |  21 ++----
 target/arm/tcg/cpu-v7m.c  |  90 +++++++++++++-----------
 target/arm/tcg/cpu32.c    | 144 +++++++++++++++++++++-----------------
 target/arm/tcg/cpu64.c    | 108 ++++++++++++++--------------
 10 files changed, 243 insertions(+), 241 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 051ed7b8847..75a2cc40779 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -46,93 +46,93 @@
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
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 1083ae7623b..353c18e6799 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1050,13 +1050,6 @@ struct ArchCPU {
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
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 83ff74f899f..fdb7f58e367 100644
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
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 400bee84943..cf811e47d99 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2126,10 +2126,10 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 
         FIELD_DP64_IDREG(isar, ID_AA64PFR0, FP, 0xf);
 
-        u = cpu->isar.id_isar6;
+        u = GET_IDREG(isar, ID_ISAR6);
         u = FIELD_DP32(u, ID_ISAR6, JSCVT, 0);
         u = FIELD_DP32(u, ID_ISAR6, BF16, 0);
-        cpu->isar.id_isar6 = u;
+        SET_IDREG(isar, ID_ISAR6, u);
 
         u = cpu->isar.mvfr0;
         u = FIELD_DP32(u, MVFR0, FPSP, 0);
@@ -2181,20 +2181,20 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 
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
@@ -2232,19 +2232,17 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 
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
 
 
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 0f938155d28..6be62c0711b 100644
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
index 39729d3a8d0..7e0b3f164e1 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7830,32 +7830,32 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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
@@ -7865,7 +7865,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 7,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa32_tid3,
-              .resetvalue = cpu->isar.id_isar6 },
+              .resetvalue = GET_IDREG(isar, ID_ISAR6) },
         };
         define_arm_cp_regs(cpu, v6_idregs);
         define_arm_cp_regs(cpu, v6_cp_reginfo);
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 87368558614..eef9481737b 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -346,22 +346,15 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
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
index 8e1a083b911..198c9f3e98c 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -45,6 +45,7 @@ static bool arm_v7m_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 static void cortex_m0_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
+    ARMISARegisters *isar = &cpu->isar;
     set_feature(&cpu->env, ARM_FEATURE_V6);
     set_feature(&cpu->env, ARM_FEATURE_M);
 
@@ -66,18 +67,19 @@ static void cortex_m0_initfn(Object *obj)
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
+    SET_IDREG(isar, ID_ISAR0, 0x01141110);
+    SET_IDREG(isar, ID_ISAR1, 0x02111000);
+    SET_IDREG(isar, ID_ISAR2, 0x21112231);
+    SET_IDREG(isar, ID_ISAR3, 0x01111110);
+    SET_IDREG(isar, ID_ISAR4, 0x01310102);
+    SET_IDREG(isar, ID_ISAR5, 0x00000000);
+    SET_IDREG(isar, ID_ISAR6, 0x00000000);
 }
 
 static void cortex_m3_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
+    ARMISARegisters *isar = &cpu->isar;
     set_feature(&cpu->env, ARM_FEATURE_V7);
     set_feature(&cpu->env, ARM_FEATURE_M);
     set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
@@ -91,18 +93,19 @@ static void cortex_m3_initfn(Object *obj)
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
+    SET_IDREG(isar, ID_ISAR0, 0x01141110);
+    SET_IDREG(isar, ID_ISAR1, 0x02111000);
+    SET_IDREG(isar, ID_ISAR2, 0x21112231);
+    SET_IDREG(isar, ID_ISAR3, 0x01111110);
+    SET_IDREG(isar, ID_ISAR4, 0x01310102);
+    SET_IDREG(isar, ID_ISAR5, 0x00000000);
+    SET_IDREG(isar, ID_ISAR6, 0x00000000);
 }
 
 static void cortex_m4_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
+    ARMISARegisters *isar = &cpu->isar;
 
     set_feature(&cpu->env, ARM_FEATURE_V7);
     set_feature(&cpu->env, ARM_FEATURE_M);
@@ -121,18 +124,19 @@ static void cortex_m4_initfn(Object *obj)
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
+    SET_IDREG(isar, ID_ISAR0, 0x01141110);
+    SET_IDREG(isar, ID_ISAR1, 0x02111000);
+    SET_IDREG(isar, ID_ISAR2, 0x21112231);
+    SET_IDREG(isar, ID_ISAR3, 0x01111110);
+    SET_IDREG(isar, ID_ISAR4, 0x01310102);
+    SET_IDREG(isar, ID_ISAR5, 0x00000000);
+    SET_IDREG(isar, ID_ISAR6, 0x00000000);
 }
 
 static void cortex_m7_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
+    ARMISARegisters *isar = &cpu->isar;
 
     set_feature(&cpu->env, ARM_FEATURE_V7);
     set_feature(&cpu->env, ARM_FEATURE_M);
@@ -151,18 +155,19 @@ static void cortex_m7_initfn(Object *obj)
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
+    SET_IDREG(isar, ID_ISAR0, 0x01101110);
+    SET_IDREG(isar, ID_ISAR1, 0x02112000);
+    SET_IDREG(isar, ID_ISAR2, 0x20232231);
+    SET_IDREG(isar, ID_ISAR3, 0x01111131);
+    SET_IDREG(isar, ID_ISAR4, 0x01310132);
+    SET_IDREG(isar, ID_ISAR5, 0x00000000);
+    SET_IDREG(isar, ID_ISAR6, 0x00000000);
 }
 
 static void cortex_m33_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
+    ARMISARegisters *isar = &cpu->isar;
 
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_M);
@@ -183,13 +188,13 @@ static void cortex_m33_initfn(Object *obj)
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
+    SET_IDREG(isar, ID_ISAR0, 0x01101110);
+    SET_IDREG(isar, ID_ISAR1, 0x02212000);
+    SET_IDREG(isar, ID_ISAR2, 0x20232232);
+    SET_IDREG(isar, ID_ISAR3, 0x01111131);
+    SET_IDREG(isar, ID_ISAR4, 0x01310132);
+    SET_IDREG(isar, ID_ISAR5, 0x00000000);
+    SET_IDREG(isar, ID_ISAR6, 0x00000000);
     cpu->clidr = 0x00000000;
     cpu->ctr = 0x8000c000;
 }
@@ -197,6 +202,7 @@ static void cortex_m33_initfn(Object *obj)
 static void cortex_m55_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
+    ARMISARegisters *isar = &cpu->isar;
 
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_V8_1M);
@@ -220,13 +226,13 @@ static void cortex_m55_initfn(Object *obj)
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
+    SET_IDREG(isar, ID_ISAR0, 0x01103110);
+    SET_IDREG(isar, ID_ISAR1, 0x02212000);
+    SET_IDREG(isar, ID_ISAR2, 0x20232232);
+    SET_IDREG(isar, ID_ISAR3, 0x01111131);
+    SET_IDREG(isar, ID_ISAR4, 0x01310132);
+    SET_IDREG(isar, ID_ISAR5, 0x00000000);
+    SET_IDREG(isar, ID_ISAR6, 0x00000000);
     cpu->clidr = 0x00000000; /* caches not implemented */
     cpu->ctr = 0x8303c003;
 }
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 2c45b7eddda..937a72b12c9 100644
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
+    SET_IDREG(isar, ID_ISAR5, 0x0);
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
index 80a99ab025d..dd4dc8ada56 100644
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
@@ -1012,14 +1012,14 @@ static void aarch64_neoverse_n2_initfn(Object *obj)
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
2.43.0


