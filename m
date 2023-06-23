Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEAD73B7DE
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:44:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfxI-0002Hv-Nk; Fri, 23 Jun 2023 08:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfx2-0001Vy-EU
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:44 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfx0-0000fS-KY
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:44 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fa71db4208so6679145e9.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687523501; x=1690115501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ynUFUtXjjp3MQdkYusZ4Ei3zBNQD4GWYtDB3PcOn66Y=;
 b=QRb1I/YMarsOSbD0eA8rVkHArCws6BmunIs1qNqC9wqDpvCsb3wio7xSvhNzemVwL9
 GSGqNwuZRQGGc5OZNfljv/ccTo1VNe8I1Ivxuz9N8kuEUZsAQXNhlDGIiaI+r0UQXKdo
 ee67pVuRl8/jb4Tj2pJa3cY5YpptuK2QA+Sky/bJ4ihf07dcFA7fI5pp8BzIzHNeRCau
 MpByS0AiOnJu7FrolI+OVVXUq3GJjpjMMWTjTCO0PXTXiULT2bSQdnAi2ve1+ZsM0xKJ
 1wv6GUgRxgRORdGlxJFQZr+hVGS5CkoM/2zgIeWGEkbl+8EHddny3GTN8K7F3FCyl9jd
 +/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687523501; x=1690115501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ynUFUtXjjp3MQdkYusZ4Ei3zBNQD4GWYtDB3PcOn66Y=;
 b=OTUVtd9vyo9B7N1IMhRMSgyX9wBvDQvXNMXPUoVuHVmmtX0ORPIHFR3onyZd8G9rK7
 pBFLD56gqTT/ymuEVDBp/4XiChr3G21hh/bIZba4LRaIN37Gq9K33Ny5neY/sQC0XzSv
 /aNTly+uHTXDqYOKMK9RxHUQE3KZjhR7B6MM3JKIT3x7aNEkuTGZrubGmVaE3rt52IaK
 d5UL4MVMnfOA9ymdd/fnjXhj40vdIBBInPTx0GvfJtmucRV1FdouMqwne5gE7c8ghcIK
 CYXn0yjKAs2ElvvVvA1YVjiVrNLfryYQSxcRlebm8j9y28KfXv8HbtpV8btnyLjCpQAT
 WwMg==
X-Gm-Message-State: AC+VfDxG1VKf3RRsuf3Mh3DkKGM6DWiWfn2YFKkhsPPlYYMOfIn7lqoB
 o6Ntl7nB13GBkFy6r8r/82qI13F0orh9Hd3Uqdw=
X-Google-Smtp-Source: ACHHUZ5hv0FcqOiYnjVEEhbSVb+r2HbU3cFJeAKbk/NQWhX+BlwlnDnp3bTOfGt6C9SkFUsDgBVPXw==
X-Received: by 2002:a05:600c:3797:b0:3f8:f749:efae with SMTP id
 o23-20020a05600c379700b003f8f749efaemr3850060wmr.33.1687523500801; 
 Fri, 23 Jun 2023 05:31:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a1c4c07000000b003f819dfa0ddsm2232622wmf.28.2023.06.23.05.31.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:31:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/26] target/arm: Adjust the order of Phys and Stage2 ARMMMUIdx
Date: Fri, 23 Jun 2023 13:31:16 +0100
Message-Id: <20230623123135.1788191-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623123135.1788191-1-peter.maydell@linaro.org>
References: <20230623123135.1788191-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

It will be helpful to have ARMMMUIdx_Phys_* to be in the same
relative order as ARMSecuritySpace enumerators. This requires
the adjustment to the nstable check. While there, check for being
in secure state rather than rely on clearing the low bit making
no change to non-secure state.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230620124418.805717-8-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 12 ++++++------
 target/arm/ptw.c | 12 +++++-------
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 125e53b83fe..b3386197759 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2860,18 +2860,18 @@ typedef enum ARMMMUIdx {
     ARMMMUIdx_E2        = 6 | ARM_MMU_IDX_A,
     ARMMMUIdx_E3        = 7 | ARM_MMU_IDX_A,
 
-    /* TLBs with 1-1 mapping to the physical address spaces. */
-    ARMMMUIdx_Phys_NS   = 8 | ARM_MMU_IDX_A,
-    ARMMMUIdx_Phys_S    = 9 | ARM_MMU_IDX_A,
-
     /*
      * Used for second stage of an S12 page table walk, or for descriptor
      * loads during first stage of an S1 page table walk.  Note that both
      * are in use simultaneously for SecureEL2: the security state for
      * the S2 ptw is selected by the NS bit from the S1 ptw.
      */
-    ARMMMUIdx_Stage2    = 10 | ARM_MMU_IDX_A,
-    ARMMMUIdx_Stage2_S  = 11 | ARM_MMU_IDX_A,
+    ARMMMUIdx_Stage2_S  = 8 | ARM_MMU_IDX_A,
+    ARMMMUIdx_Stage2    = 9 | ARM_MMU_IDX_A,
+
+    /* TLBs with 1-1 mapping to the physical address spaces. */
+    ARMMMUIdx_Phys_S    = 10 | ARM_MMU_IDX_A,
+    ARMMMUIdx_Phys_NS   = 11 | ARM_MMU_IDX_A,
 
     /*
      * These are not allocated TLBs and are used only for AT system
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 37bcb17a9ee..3f3517f70b6 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1449,16 +1449,14 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
     descaddr |= (address >> (stride * (4 - level))) & indexmask;
     descaddr &= ~7ULL;
     nstable = !regime_is_stage2(mmu_idx) && extract32(tableattrs, 4, 1);
-    if (nstable) {
+    if (nstable && ptw->in_secure) {
         /*
          * Stage2_S -> Stage2 or Phys_S -> Phys_NS
-         * Assert that the non-secure idx are even, and relative order.
+         * Assert the relative order of the secure/non-secure indexes.
          */
-        QEMU_BUILD_BUG_ON((ARMMMUIdx_Phys_NS & 1) != 0);
-        QEMU_BUILD_BUG_ON((ARMMMUIdx_Stage2 & 1) != 0);
-        QEMU_BUILD_BUG_ON(ARMMMUIdx_Phys_NS + 1 != ARMMMUIdx_Phys_S);
-        QEMU_BUILD_BUG_ON(ARMMMUIdx_Stage2 + 1 != ARMMMUIdx_Stage2_S);
-        ptw->in_ptw_idx &= ~1;
+        QEMU_BUILD_BUG_ON(ARMMMUIdx_Phys_S + 1 != ARMMMUIdx_Phys_NS);
+        QEMU_BUILD_BUG_ON(ARMMMUIdx_Stage2_S + 1 != ARMMMUIdx_Stage2);
+        ptw->in_ptw_idx += 1;
         ptw->in_secure = false;
     }
     if (!S1_ptw_translate(env, ptw, descaddr, fi)) {
-- 
2.34.1


