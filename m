Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 983CA716D69
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 21:21:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44o1-0006E7-Hc; Tue, 30 May 2023 15:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44nt-0005ye-KN
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:14:45 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44nr-0004c2-Sr
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:14:45 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-64d577071a6so5651734b3a.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 12:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685474082; x=1688066082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vdXQUX7VyfIMGOcc2j+k3ArawY+9z3JYFBb7DTwyza4=;
 b=s4rVm/zmwfH/VniMnwEZGCBS4TQp47thGkIjSSmrSDZ68v3Xz28kBFzXhhCulWQ+vH
 04y1yaoNak7SyfgDb5e+ZnozZWbe3C1t54WsWVkjIc3teb52y1AEzZbyvIjDj+ym4tP+
 TrDXHM86V6bAy1/x5awKgf8hAEUkDBuHxnUmoGeS6lFpg8zCd8Kcxk/LK8i7oq7DQ0kb
 //o50Jsb13Mnc2I2H2aIcqbHJaiYQyK/Ae/0QZNtHMMPyLihc0rtrP7l7H3RuXM+jLO8
 BbUV4OdBNaT3AU4/0OZVrj73ng0Z5jfGA+64xBqi7s/Bq6hRoQRAO1iFMdAet00tGfra
 WmoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685474082; x=1688066082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vdXQUX7VyfIMGOcc2j+k3ArawY+9z3JYFBb7DTwyza4=;
 b=OhUE+32dOg/3mRAmL/DuAb/h6DCj7IcmQAy60XedcIrGpQVayM3yAzjWHt91VzzJrK
 jYDsZnI5QXB15scf8AxI7Rc+7pad4mgwkINHz9iEU2Nh6eFO4gON7dQHwv44QiQKRaEf
 A5mpn8tFLrLZdcWe1AhEBrA7e76EQ9RZWvrga1+zmkk2lp1eV6TaLqveoulkXX/VjcOp
 sVbBu1B0Qlp7xmjEm3gOCAik8ayBrLq/MKnizoQziidVDBLUh6Jrqx1MraJ4APurfCkj
 7CBhJvSSaMyMEfGkYOOE1Hd1oj8OScpzn3WjHTbSywnlMuFZNZSU5D0dwB/WCmBzcw4s
 1hKw==
X-Gm-Message-State: AC+VfDwqpS7Rfa8+DNYCv2WrTSq4kMQ7n6tzwnVMxQU/cgK/tbarZ65K
 3Kl/X4GGA6PTxn6nfgTkwV9WWQ5K/j8wvgxctmg=
X-Google-Smtp-Source: ACHHUZ7+cj38KUbGXGK10OUaFrrbmONW+g4/Tl3EDTUnI+bNbfFABcFGNUEEqM72a4LVWMqtne+dCg==
X-Received: by 2002:a05:6a20:1593:b0:10a:cbe6:69ef with SMTP id
 h19-20020a056a20159300b0010acbe669efmr3804423pzj.37.1685474081829; 
 Tue, 30 May 2023 12:14:41 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 10-20020a63104a000000b0051806da5cd6sm8926757pgq.60.2023.05.30.12.14.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 12:14:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 03/20] target/arm: Introduce finalize_memop_{atom,pair}
Date: Tue, 30 May 2023 12:14:21 -0700
Message-Id: <20230530191438.411344-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530191438.411344-1-richard.henderson@linaro.org>
References: <20230530191438.411344-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Let finalize_memop_atom be the new basic function, with
finalize_memop and finalize_memop_pair testing FEAT_LSE2
to apply the appropriate atomicity.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate.h     | 39 +++++++++++++++++++++++++++++-----
 target/arm/tcg/translate-a64.c |  2 ++
 target/arm/tcg/translate.c     |  1 +
 3 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index a9d1f4adc2..9a33076c3d 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -85,6 +85,7 @@ typedef struct DisasContext {
     uint64_t features; /* CPU features bits */
     bool aarch64;
     bool thumb;
+    bool lse2;
     /* Because unallocated encodings generate different exception syndrome
      * information from traps due to FP being disabled, we can't do a single
      * "is fp access disabled" check at a high level in the decode tree.
@@ -552,12 +553,13 @@ static inline TCGv_ptr fpstatus_ptr(ARMFPStatusFlavour flavour)
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
@@ -567,12 +569,39 @@ static inline TCGv_ptr fpstatus_ptr(ARMFPStatusFlavour flavour)
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
index 741a608739..967400ed68 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -14110,6 +14110,8 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     tcg_debug_assert(dc->tbid & 1);
 #endif
 
+    dc->lse2 = dc_isar_feature(aa64_lse2, dc);
+
     /* Single step state. The code-generation logic here is:
      *  SS_ACTIVE == 0:
      *   generate code with no special handling for single-stepping (except
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 7468476724..7a6a8029e5 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -9183,6 +9183,7 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
         dc->sme_trap_nonstreaming =
             EX_TBFLAG_A32(tb_flags, SME_TRAP_NONSTREAMING);
     }
+    dc->lse2 = false; /* applies only to aarch64 */
     dc->cp_regs = cpu->cp_regs;
     dc->features = env->features;
 
-- 
2.34.1


