Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B11738383
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 14:21:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBwoB-0006pX-5a; Wed, 21 Jun 2023 08:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBwnv-0006eI-W8
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 08:19:21 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBwnt-0000Le-3u
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 08:19:19 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5193c97ecbbso6146418a12.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 05:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687349952; x=1689941952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=opjDePJW5lJazIvQT1fEtG6FPEXvhJQNv9O3cjFs/vU=;
 b=R7+5/dqf94ojA+XX8+u1UJ7DqrvElQbREvyDGlqUJfVCAM+iklLW8CHrmiIIcu521d
 Cxzsevc0P6h2b17Rr2h1PELV0XqGjc6iGqTr4tFMcgjiBVENC/I5FkGLzvyQcMzKhIry
 ATg7bqIT1tLe90sfwfdCx3rhm3+M98AFcrUM7/uWz9F/Swt6YPYIK1pJFpVwuJhThDcR
 wcyyHLMhBm//qJYnAFAR1hC7GS8YhonzbIz8Raa3hcrKj69RgzlJ0sMkAWImXGBtbvoR
 MvpLz3BE/uN12NNjvMjECAqY75Yqt+13dKOmjBS29aNH0cIZWOy44Giy4gvYcdPX4did
 +WjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687349952; x=1689941952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=opjDePJW5lJazIvQT1fEtG6FPEXvhJQNv9O3cjFs/vU=;
 b=lTqu4O7bZ8zA0kmKla6wUIO+Lmpip98d3+S2lJkrIpbFVPCvBfAH7RZIEBefXp2Ipj
 u/NlRhU+gMgst2L1bgf8plNQylOMAt+U077TXQZvLZZfMcERRFIKx9XRReccXYdLkhbh
 Tp4iI/WLVButxtaCsNygimDG1BzcSmlt2Pu8BPOFuR9XjbeTGE7TDMtFshGJQI73mzeu
 wdwWs1Mk94YRXBoacUT773dxomY6eVU/+uQeb3FOWnkjRJ7tTi8mgT0j643Sdhg/fHq5
 pI/3XU62WO3cpDNtwPxyVVuhK/idJhvzANYcyzM52nadI8+5ca2iXrevjslXTwoERb7Q
 6xww==
X-Gm-Message-State: AC+VfDz2EOgbClhACBZYcLPxCzrLqp3o35MxFGydD3bDmIPI4tUb5Xsl
 IQatoWbv1ni/7XNsyGWttv5PAaceVmKrsYr0Y11FsOGw
X-Google-Smtp-Source: ACHHUZ65jTZSqWqUNLk+pOsIqYE2QlAt0NpBVy4as/rKhZCdxN6eletyIN8hcmJreTbdfyNfpA+dxg==
X-Received: by 2002:aa7:d58f:0:b0:51a:3247:399f with SMTP id
 r15-20020aa7d58f000000b0051a3247399fmr9324035edq.4.1687349952488; 
 Wed, 21 Jun 2023 05:19:12 -0700 (PDT)
Received: from stoup.lan ([176.176.128.70]) by smtp.gmail.com with ESMTPSA id
 s6-20020a056402014600b0051bdf152295sm543176edu.76.2023.06.21.05.19.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 05:19:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Idan Horowitz <idan.horowitz@gmail.com>
Subject: [PATCH v2 8/9] target/arm: Do memory type alignment check when
 translation disabled
Date: Wed, 21 Jun 2023 14:19:01 +0200
Message-Id: <20230621121902.1392277-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621121902.1392277-1-richard.henderson@linaro.org>
References: <20230621121902.1392277-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x533.google.com
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

If translation is disabled, the default memory type is Device, which
requires alignment checking.  This is more optimally done early via
the MemOp given to the TCG memory operation.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reported-by: Idan Horowitz <idan.horowitz@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1204
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/hflags.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 616c5fa723..56d7db150a 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -25,6 +25,35 @@ static inline bool fgt_svc(CPUARMState *env, int el)
         FIELD_EX64(env->cp15.fgt_exec[FGTREG_HFGITR], HFGITR_EL2, SVC_EL1);
 }
 
+/* Return true if memory alignment should be enforced. */
+static bool aprofile_require_alignment(CPUARMState *env, int el, uint64_t sctlr)
+{
+#ifdef CONFIG_USER_ONLY
+    return false;
+#else
+    /* Check the alignment enable bit. */
+    if (sctlr & SCTLR_A) {
+        return true;
+    }
+
+    /*
+     * If translation is disabled, then the default memory type is
+     * Device(-nGnRnE) instead of Normal, which requires that alignment
+     * be enforced.  Since this affects all ram, it is most efficient
+     * to handle this during translation.
+     */
+    if (sctlr & SCTLR_M) {
+        /* Translation enabled: memory type in PTE via MAIR_ELx. */
+        return false;
+    }
+    if (el < 2 && (arm_hcr_el2_eff(env) & (HCR_DC | HCR_VM))) {
+        /* Stage 2 translation enabled: memory type in PTE. */
+        return false;
+    }
+    return true;
+#endif
+}
+
 static CPUARMTBFlags rebuild_hflags_common(CPUARMState *env, int fp_el,
                                            ARMMMUIdx mmu_idx,
                                            CPUARMTBFlags flags)
@@ -120,8 +149,9 @@ static CPUARMTBFlags rebuild_hflags_a32(CPUARMState *env, int fp_el,
 {
     CPUARMTBFlags flags = {};
     int el = arm_current_el(env);
+    uint64_t sctlr = arm_sctlr(env, el);
 
-    if (arm_sctlr(env, el) & SCTLR_A) {
+    if (aprofile_require_alignment(env, el, sctlr)) {
         DP_TBFLAG_ANY(flags, ALIGN_MEM, 1);
     }
 
@@ -221,7 +251,7 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
 
     sctlr = regime_sctlr(env, stage1);
 
-    if (sctlr & SCTLR_A) {
+    if (aprofile_require_alignment(env, el, sctlr)) {
         DP_TBFLAG_ANY(flags, ALIGN_MEM, 1);
     }
 
-- 
2.34.1


