Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E73E723E64
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 11:53:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6TJ0-0007qi-0O; Tue, 06 Jun 2023 05:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIn-0007hm-8X
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:33 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIj-0004my-NS
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:32 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3f78a32266bso22052475e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 02:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686044906; x=1688636906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iBsROKbZ2ldPMyBALQrhdveULV++T2Z8yYAPXc19myA=;
 b=a7ZV/0th3N1Gk9HkjEkNkrO+B1KY8GUE8XCBdZnwWC1/HhbDK/pAKKgLKyvAIslO3e
 xn47YUaZrY0KyOLA3TRNl+GRwACM2MOeLVu2xRWEynM1RqpsHISwr2gs9ZnJwECMrgpl
 IX+sV6sTNAqIFjV3uc983D0yNcFMX6Zai/jeXovXAzFyGj9ty2tynXHD/dkRTLVRWlpL
 3hXj9TepjkGUHnrVLewUDRCfJFvI5oxzKcBIeWes6LXBkYdlo22y38+jvSFbhRpJSKdv
 Bwp4EmTMZ1hYOK6G64AYmvlw0sfGf6GyUIdkjqGioGIdFhADts4Ww+DG4yT+JF8xVk96
 qudQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686044906; x=1688636906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iBsROKbZ2ldPMyBALQrhdveULV++T2Z8yYAPXc19myA=;
 b=Sk6wvTkpfq+vIY9nxXtv1n86ZbkuHZ1ykvdrlSjwG424GiMU4YAWXvWEUqCxsZFze6
 8q+gnBz4YeSe6EHzHMK1QQwsurShjlLqlNxQpN27kqLn56z01327ZBocvG9GYoy0gMpa
 j323BzF8dooZLAJ5e5thZGT2XON3HEtpGgaSTSEmtZqpszQsP15Qm0493oZlrEGxSCUs
 ZP6vaJBbSZZqn82FEVNJy7fPryKn2mEhCqAZm2416YdyG5Dymtr9fK+roRV8x5owyG2V
 c7kQ/o9Lf6e03TK2M41x9271KAwY9h4ABa7GqgbZW8TfpKkBB989EUsK1w2knDohNVhp
 pggA==
X-Gm-Message-State: AC+VfDz77OPNnhbpLHyVE21iS3k+uUZEfKXCGx37LRjeJEOu8vAGfROD
 D4iniD01UP05kIwslU/GN/bsKhVEm4TIvt+9qIM=
X-Google-Smtp-Source: ACHHUZ5bxxzBnPq7AU5swjdCbp001IJpYzjsV2ufLN/d5yxESI61sKWmYVNYyefpzyezNWSIVxtFog==
X-Received: by 2002:a05:600c:b49:b0:3f6:128:36a5 with SMTP id
 k9-20020a05600c0b4900b003f6012836a5mr1837924wmr.10.1686044906713; 
 Tue, 06 Jun 2023 02:48:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a5d4b0a000000b0030789698eebsm12134017wrq.89.2023.06.06.02.48.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 02:48:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/42] target/arm: Introduce finalize_memop_{atom,pair}
Date: Tue,  6 Jun 2023 10:47:54 +0100
Message-Id: <20230606094814.3581397-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606094814.3581397-1-peter.maydell@linaro.org>
References: <20230606094814.3581397-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

Let finalize_memop_atom be the new basic function, with
finalize_memop and finalize_memop_pair testing FEAT_LSE2
to apply the appropriate atomicity.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230530191438.411344-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate.h     | 39 +++++++++++++++++++++++++++++-----
 target/arm/tcg/translate-a64.c |  2 ++
 target/arm/tcg/translate.c     |  1 +
 3 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 4d88197715b..c1e57a52ca2 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -90,6 +90,7 @@ typedef struct DisasContext {
     uint64_t features; /* CPU features bits */
     bool aarch64;
     bool thumb;
+    bool lse2;
     /* Because unallocated encodings generate different exception syndrome
      * information from traps due to FP being disabled, we can't do a single
      * "is fp access disabled" check at a high level in the decode tree.
@@ -557,12 +558,13 @@ static inline TCGv_ptr fpstatus_ptr(ARMFPStatusFlavour flavour)
 }
 
 /**
- * finalize_memop:
+ * finalize_memop_atom:
  * @s: DisasContext
  * @opc: size+sign+align of the memory operation
+ * @atom: atomicity of the memory operation
  *
- * Build the complete MemOp for a memory operation, including alignment
- * and endianness.
+ * Build the complete MemOp for a memory operation, including alignment,
+ * endianness, and atomicity.
  *
  * If (op & MO_AMASK) then the operation already contains the required
  * alignment, e.g. for AccType_ATOMIC.  Otherwise, this an optionally
@@ -572,12 +574,39 @@ static inline TCGv_ptr fpstatus_ptr(ARMFPStatusFlavour flavour)
  * and this is applied here.  Note that there is no way to indicate that
  * no alignment should ever be enforced; this must be handled manually.
  */
-static inline MemOp finalize_memop(DisasContext *s, MemOp opc)
+static inline MemOp finalize_memop_atom(DisasContext *s, MemOp opc, MemOp atom)
 {
     if (s->align_mem && !(opc & MO_AMASK)) {
         opc |= MO_ALIGN;
     }
-    return opc | s->be_data;
+    return opc | atom | s->be_data;
+}
+
+/**
+ * finalize_memop:
+ * @s: DisasContext
+ * @opc: size+sign+align of the memory operation
+ *
+ * Like finalize_memop_atom, but with default atomicity.
+ */
+static inline MemOp finalize_memop(DisasContext *s, MemOp opc)
+{
+    MemOp atom = s->lse2 ? MO_ATOM_WITHIN16 : MO_ATOM_IFALIGN;
+    return finalize_memop_atom(s, opc, atom);
+}
+
+/**
+ * finalize_memop_pair:
+ * @s: DisasContext
+ * @opc: size+sign+align of the memory operation
+ *
+ * Like finalize_memop_atom, but with atomicity for a pair.
+ * C.f. Pseudocode for Mem[], operand ispair.
+ */
+static inline MemOp finalize_memop_pair(DisasContext *s, MemOp opc)
+{
+    MemOp atom = s->lse2 ? MO_ATOM_WITHIN16_PAIR : MO_ATOM_IFALIGN_PAIR;
+    return finalize_memop_atom(s, opc, atom);
 }
 
 /**
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index d9800337cf4..1d34c5a7031 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -14098,6 +14098,8 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     tcg_debug_assert(dc->tbid & 1);
 #endif
 
+    dc->lse2 = dc_isar_feature(aa64_lse2, dc);
+
     /* Single step state. The code-generation logic here is:
      *  SS_ACTIVE == 0:
      *   generate code with no special handling for single-stepping (except
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index a68d3c7f6da..13c88ba1b9f 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -9168,6 +9168,7 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
         dc->sme_trap_nonstreaming =
             EX_TBFLAG_A32(tb_flags, SME_TRAP_NONSTREAMING);
     }
+    dc->lse2 = false; /* applies only to aarch64 */
     dc->cp_regs = cpu->cp_regs;
     dc->features = env->features;
 
-- 
2.34.1


