Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D38C736C48
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 14:49:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBaiq-0001WX-Lk; Tue, 20 Jun 2023 08:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBain-0001VI-V3
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:44:33 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBaik-0001w7-M1
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:44:33 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4f4b2bc1565so6085718e87.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 05:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687265068; x=1689857068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WJWL093vV/sudKyK+aOjpNFbGT4nrMy+vm7a5Pxrsp0=;
 b=whFhR45r/52C2reBPuQRxndmYiCuwu6GZoh9J4M3zoMlwUBwjWpqbCex3jY4OX0aFT
 sUbddhfnMoMBOAsUQaSKrq0LnYZufSR+SWLO3x1M6t23OIA/5ELv05b/An3bJJ1n26qA
 IeRYNBPbZ5zISA7XeDSSjKmOa0gyOtqAsqlmu3zLhTE6yEcrAk7DzG/E5e1DZMYK/bcr
 uDKFiqHRMWbke7MGVZvohKOjVJJA3RANxIQ1yIqEBrdsnir4Q5b4V973A+jth8j7Vj/M
 pQTXJgD4nWjLEyi+c7DuH7INXKZ2IUWQk/pFwzEFtBsJkT6hvBh4I2T82P7cZQOxJM5V
 GAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687265068; x=1689857068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WJWL093vV/sudKyK+aOjpNFbGT4nrMy+vm7a5Pxrsp0=;
 b=YAO9ZVNH8u4UZGOIZlaGJIjO3OY7CatUUKPcDOlcamnmKEHHeAv1ljkxX8jqoGP1aq
 qYDlJqwGzEE8/pdFHHCjGVq0lT1OwHlEIDzki5nNhypHwHlsevVmZV523GjuUCWS6DTR
 5HHps87Pdaazlf8TljGda0gOiETUymy90PTfzk3QPJ4lT2PtPznucQbNyxm7piQS3G6C
 If+Gu4LMKrzcFx5cgXn3CWgO6i1rPw9ED19W8Nr7LqE4srZkY4aD9Nb09V0lwnoKxLoy
 Lz53f7H56NjFgO6FDmM4gL8OSTwgASPmupzk79ilu3SlBR6lwoge8+vvJvrHIquAPdn3
 CNMg==
X-Gm-Message-State: AC+VfDwM7YUnjovsaxQZFQL8s8JtEtBq6mDA+cFNtd2E5IPCrQOFYyUV
 PgxkA1nYuf5Zjp4FeGaxHeJRb1KpT1//bQ1JId5IFE9l
X-Google-Smtp-Source: ACHHUZ5dDBV8hnY3uGcE+28GPwGxVkzwtAIdwmuIjAsR1N4HeHMMxeGxpjlFW6N/G7vrkZ/UHIl4vg==
X-Received: by 2002:a19:7718:0:b0:4f8:6d54:72f9 with SMTP id
 s24-20020a197718000000b004f86d5472f9mr3514039lfc.61.1687265068007; 
 Tue, 20 Jun 2023 05:44:28 -0700 (PDT)
Received: from stoup.lan ([176.176.183.29]) by smtp.gmail.com with ESMTPSA id
 w9-20020aa7dcc9000000b0051a313a66e8sm1142541edu.45.2023.06.20.05.44.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 05:44:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v5 08/20] target/arm: Introduce ARMMMUIdx_Phys_{Realm,Root}
Date: Tue, 20 Jun 2023 14:44:06 +0200
Message-Id: <20230620124418.805717-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620124418.805717-1-richard.henderson@linaro.org>
References: <20230620124418.805717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

With FEAT_RME, there are four physical address spaces.
For now, just define the symbols, and mention them in
the same spots as the other Phys indexes in ptw.c.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 23 +++++++++++++++++++++--
 target/arm/ptw.c | 10 ++++++++--
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b338619775..590216b855 100644
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
index 3f3517f70b..a742bc1826 100644
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


