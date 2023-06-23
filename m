Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF7373B75A
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:33:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfxA-0001oc-RS; Fri, 23 Jun 2023 08:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfx4-0001WI-4L
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:46 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfx0-0000fU-PC
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:44 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4f6283d0d84so736111e87.1
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687523501; x=1690115501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FCxVtLDLbXBQfcTVdXbOiQnRN9YNEX7Ig4LK4Zi2rBc=;
 b=tWfKtDTdsQfiDqdqGKfsE5nqpXQ/H0GO48g0XG0jufbbptHwI7mHsfcWPlcNkZ54sb
 7czpfPaFfX64GIL+PkiXGyJ8Ch5ZZklAzlob4wlSAL/eGjwmJL1VZSqwc17iI0L3aKt5
 hG8plnSbQuGiOi6hImTcqwepneJR2H4nFXU7eOlpIhiDeVHg5Re8wUqH67xbOsIQi+ns
 ALjVnsnvKwI4TKt8sgz0rPXlhsNF185VjKhhEhVKeZjfE/F0WD8xVMIm0y8RFzygPrVR
 sM06y/Jz9BCu72dkHzWm/fSE7PHt494TqtLZcTuYC8MwiNQVOe/3G8EZV4Daz64imeU6
 EcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687523501; x=1690115501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FCxVtLDLbXBQfcTVdXbOiQnRN9YNEX7Ig4LK4Zi2rBc=;
 b=iSH17OXwGbXc+AGWUYa0VbmbcQuElsxykvaHAqD+6gNW3mw3zB31xlJ+IYcJRdyHgQ
 6/JAq7N78/+zBocj0aFhh4kcn7UC+WyDjblvYIrWWSVhqvB8Fe+T/3rbRcQhnNDGggvI
 b+O7kNjPYUfQMYJiW1xeHJEZmSs+n6pRbZHFVUaImhCkk+tmqDiZPj0Smmj6KCUO9CwS
 r36jZWH29kJDeDOMoPluKPvIQcx9LdJ2RA/pU/hyDZZLnKBPh8z5Y2h3c4CwReVCJFDl
 2/kDtuJcnouf7bV338PliThEf4eoNT1lQ6jjA/RGNqLWARxzGyc9Q1mhgMr3Db+THq+Q
 tKmg==
X-Gm-Message-State: AC+VfDzRhY70Fj9pW80Fts87jaAIJW87YY1JID4pzj+7HpzPuI0FOGdK
 qEnEqqUGWtzOU95I7+XhB3pwldbNRy9o2hfCdlU=
X-Google-Smtp-Source: ACHHUZ5wfzmkCLKEUVeXWBs6gta6Yr/5x+g29/0tO1h1rbzeQoi/dkiyAe87fVU5ByoIjx7pCvZEjw==
X-Received: by 2002:a05:6512:1028:b0:4f7:66bf:b263 with SMTP id
 r8-20020a056512102800b004f766bfb263mr13812188lfr.24.1687523501280; 
 Fri, 23 Jun 2023 05:31:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a1c4c07000000b003f819dfa0ddsm2232622wmf.28.2023.06.23.05.31.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:31:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/26] target/arm: Introduce ARMMMUIdx_Phys_{Realm,Root}
Date: Fri, 23 Jun 2023 13:31:17 +0100
Message-Id: <20230623123135.1788191-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623123135.1788191-1-peter.maydell@linaro.org>
References: <20230623123135.1788191-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12d.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

With FEAT_RME, there are four physical address spaces.
For now, just define the symbols, and mention them in
the same spots as the other Phys indexes in ptw.c.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230620124418.805717-9-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 23 +++++++++++++++++++++--
 target/arm/ptw.c | 10 ++++++++--
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b3386197759..590216b8559 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2870,8 +2870,10 @@ typedef enum ARMMMUIdx {
     ARMMMUIdx_Stage2    = 9 | ARM_MMU_IDX_A,
 
     /* TLBs with 1-1 mapping to the physical address spaces. */
-    ARMMMUIdx_Phys_S    = 10 | ARM_MMU_IDX_A,
-    ARMMMUIdx_Phys_NS   = 11 | ARM_MMU_IDX_A,
+    ARMMMUIdx_Phys_S     = 10 | ARM_MMU_IDX_A,
+    ARMMMUIdx_Phys_NS    = 11 | ARM_MMU_IDX_A,
+    ARMMMUIdx_Phys_Root  = 12 | ARM_MMU_IDX_A,
+    ARMMMUIdx_Phys_Realm = 13 | ARM_MMU_IDX_A,
 
     /*
      * These are not allocated TLBs and are used only for AT system
@@ -2935,6 +2937,23 @@ typedef enum ARMASIdx {
     ARMASIdx_TagS = 3,
 } ARMASIdx;
 
+static inline ARMMMUIdx arm_space_to_phys(ARMSecuritySpace space)
+{
+    /* Assert the relative order of the physical mmu indexes. */
+    QEMU_BUILD_BUG_ON(ARMSS_Secure != 0);
+    QEMU_BUILD_BUG_ON(ARMMMUIdx_Phys_NS != ARMMMUIdx_Phys_S + ARMSS_NonSecure);
+    QEMU_BUILD_BUG_ON(ARMMMUIdx_Phys_Root != ARMMMUIdx_Phys_S + ARMSS_Root);
+    QEMU_BUILD_BUG_ON(ARMMMUIdx_Phys_Realm != ARMMMUIdx_Phys_S + ARMSS_Realm);
+
+    return ARMMMUIdx_Phys_S + space;
+}
+
+static inline ARMSecuritySpace arm_phys_to_space(ARMMMUIdx idx)
+{
+    assert(idx >= ARMMMUIdx_Phys_S && idx <= ARMMMUIdx_Phys_Realm);
+    return idx - ARMMMUIdx_Phys_S;
+}
+
 static inline bool arm_v7m_csselr_razwi(ARMCPU *cpu)
 {
     /* If all the CLIDR.Ctypem bits are 0 there are no caches, and
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 3f3517f70b6..a742bc18263 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -215,8 +215,10 @@ static bool regime_translation_disabled(CPUARMState *env, ARMMMUIdx mmu_idx,
     case ARMMMUIdx_E3:
         break;
 
-    case ARMMMUIdx_Phys_NS:
     case ARMMMUIdx_Phys_S:
+    case ARMMMUIdx_Phys_NS:
+    case ARMMMUIdx_Phys_Root:
+    case ARMMMUIdx_Phys_Realm:
         /* No translation for physical address spaces. */
         return true;
 
@@ -2672,8 +2674,10 @@ static bool get_phys_addr_disabled(CPUARMState *env, target_ulong address,
     switch (mmu_idx) {
     case ARMMMUIdx_Stage2:
     case ARMMMUIdx_Stage2_S:
-    case ARMMMUIdx_Phys_NS:
     case ARMMMUIdx_Phys_S:
+    case ARMMMUIdx_Phys_NS:
+    case ARMMMUIdx_Phys_Root:
+    case ARMMMUIdx_Phys_Realm:
         break;
 
     default:
@@ -2861,6 +2865,8 @@ static bool get_phys_addr_with_struct(CPUARMState *env, S1Translate *ptw,
     switch (mmu_idx) {
     case ARMMMUIdx_Phys_S:
     case ARMMMUIdx_Phys_NS:
+    case ARMMMUIdx_Phys_Root:
+    case ARMMMUIdx_Phys_Realm:
         /* Checking Phys early avoids special casing later vs regime_el. */
         return get_phys_addr_disabled(env, address, access_type, mmu_idx,
                                       is_secure, result, fi);
-- 
2.34.1


