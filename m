Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B50907DDBCA
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 05:13:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy2aE-0005zW-Qv; Wed, 01 Nov 2023 00:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qy2a9-0005yC-Uw
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 00:11:54 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qy2a8-0007aQ-7R
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 00:11:53 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3add37de892so3263362b6e.1
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 21:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698811911; x=1699416711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WoN9b5fh20ESPQ7+DOAGdQCWDLjSgxnA1EgnSGB/k3Q=;
 b=yhgo2OxdUXjzPf5e2PfRhbkBnxMSB/rz10xVTrzQPsGY83txcNC04qxBjg1SFYX4W4
 EOy24qjiNLxa5ddKbX7//StYqcY7HEfZo2AxcmkXDUJikf4r0QTTDxCp8dxtrj0fu9sS
 vZHXlKI2er08hmjBhZNOX1xRMCDv7A+yRgxqpF5khh6k6rT/WoZE9dc9f5ulyXgUSq5K
 0qzjUHcNGIeXzAH11H46/isbFhy5wGzmxxVqpbWCQ7DJLddPSfq8gLlFk8QRvUOclpcc
 lT+XBLqrr8tAjXqkwB++nVlISJgdKfkUjxJ9t/OwDOM8JcUzcBKoVHaGoZwJM8b/yH3w
 x3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698811911; x=1699416711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WoN9b5fh20ESPQ7+DOAGdQCWDLjSgxnA1EgnSGB/k3Q=;
 b=lXPcI7hDRUANElgRFJl3Kow83EDXsYmVtmA6QRDg1lbMOynYbHXn1lsdtovnCQ6wGZ
 DKaZKSClm3tDdcSpwE9isQ+GqRquLvod9MsXzf42GM7oBn4Wzf6j+wv9N3r/qEfEWs/3
 82YCPkvlLIa8Iw3PczG2YKMEaAR3JlQN33rLMJ+J4OKbGx7be5rdszbQDO9m6hBYbV8K
 MDPykwV4IAJHEbwU+jkRZ8VYf109jU3pOlm9ChPFrH4BAfbC36Bftob/y/4UiNRt8ybi
 m6IeDviHsbER4KfhHR/H+OvMzHdXC1Rw2OUP3GJtlCUE61j2uzGsCFLQPLXsKCq3xI94
 84YQ==
X-Gm-Message-State: AOJu0YzM2L0PjQj5MqA6WRIDdTQ396eDTyrOd71dR/lj0AvetGDDLndg
 +u5YhFd3TxP3G1bJonqG7ei1A5SOawp5LVJjFhg=
X-Google-Smtp-Source: AGHT+IHFULV7nKnT1fPaDkF0yhYExKT1DJiQ2KB+VATuunCdt3PlpVI0r13oLiHxPTeRO1cirjyKnA==
X-Received: by 2002:a05:6808:209f:b0:3ad:fe8d:dfae with SMTP id
 s31-20020a056808209f00b003adfe8ddfaemr14971479oiw.57.1698811910839; 
 Tue, 31 Oct 2023 21:11:50 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k8-20020aa79728000000b006875df4773fsm359576pfg.163.2023.10.31.21.11.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 21:11:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 20/21] target/sparc: Implement UDIV inline
Date: Tue, 31 Oct 2023 21:11:31 -0700
Message-Id: <20231101041132.174501-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101041132.174501-1-richard.henderson@linaro.org>
References: <20231101041132.174501-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x229.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  3 +-
 target/sparc/translate.c  | 67 +++++++++++++++++++++++++++++++--------
 2 files changed, 56 insertions(+), 14 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 52f54b87cc..2d26404cb2 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -184,7 +184,8 @@ MULScc      10 ..... 100100 ..... . .............          @r_r_ri_cc1
 
 UDIVX       10 ..... 001101 ..... . .............          @r_r_ri
 SDIVX       10 ..... 101101 ..... . .............          @r_r_ri
-UDIV        10 ..... 0.1110 ..... . .............          @r_r_ri_cc
+UDIV        10 ..... 001110 ..... . .............          @r_r_ri
+UDIVcc      10 ..... 011110 ..... . .............          @r_r_ri_cc1
 SDIV        10 ..... 0.1111 ..... . .............          @r_r_ri_cc
 
 TADDcc      10 ..... 100000 ..... . .............          @r_r_ri_cc1
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 95cc4c71f4..4b7d943bae 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -577,18 +577,6 @@ static void gen_op_smul(TCGv dst, TCGv src1, TCGv src2)
     gen_op_multiply(dst, src1, src2, 1);
 }
 
-static void gen_op_udiv(TCGv dst, TCGv src1, TCGv src2)
-{
-#ifdef TARGET_SPARC64
-    gen_helper_udiv(dst, tcg_env, src1, src2);
-    tcg_gen_ext32u_tl(dst, dst);
-#else
-    TCGv_i64 t64 = tcg_temp_new_i64();
-    gen_helper_udiv(t64, tcg_env, src1, src2);
-    tcg_gen_trunc_i64_tl(dst, t64);
-#endif
-}
-
 static void gen_op_sdiv(TCGv dst, TCGv src1, TCGv src2)
 {
 #ifdef TARGET_SPARC64
@@ -3568,7 +3556,7 @@ TRANS(UMUL, MUL, do_logic, a, gen_op_umul, NULL)
 TRANS(SMUL, MUL, do_logic, a, gen_op_smul, NULL)
 TRANS(MULScc, ALL, do_arith, a, NULL, NULL, gen_op_mulscc)
 
-TRANS(UDIV, DIV, do_arith, a, gen_op_udiv, NULL, gen_op_udivcc)
+TRANS(UDIVcc, DIV, do_arith, a, NULL, NULL, gen_op_udivcc)
 TRANS(SDIV, DIV, do_arith, a, gen_op_sdiv, NULL, gen_op_sdivcc)
 
 /* TODO: Should have feature bit -- comes in with UltraSparc T2. */
@@ -3591,6 +3579,59 @@ static bool trans_OR(DisasContext *dc, arg_r_r_ri_cc *a)
     return do_logic(dc, a, tcg_gen_or_tl, tcg_gen_ori_tl);
 }
 
+static bool trans_UDIV(DisasContext *dc, arg_r_r_ri *a)
+{
+    TCGv_i64 t1, t2;
+    TCGv dst;
+
+    if (!avail_DIV(dc)) {
+        return false;
+    }
+    /* For simplicity, we under-decoded the rs2 form. */
+    if (!a->imm && a->rs2_or_imm & ~0x1f) {
+        return false;
+    }
+
+    if (unlikely(a->rs2_or_imm == 0)) {
+        gen_exception(dc, TT_DIV_ZERO);
+        return true;
+    }
+
+    if (a->imm) {
+        t2 = tcg_constant_i64((uint32_t)a->rs2_or_imm);
+    } else {
+        TCGLabel *lab;
+        TCGv_i32 n2;
+
+        finishing_insn(dc);
+        flush_cond(dc);
+
+        n2 = tcg_temp_new_i32();
+        tcg_gen_trunc_tl_i32(n2, cpu_regs[a->rs2_or_imm]);
+
+        lab = delay_exception(dc, TT_DIV_ZERO);
+        tcg_gen_brcondi_i32(TCG_COND_EQ, n2, 0, lab);
+
+        t2 = tcg_temp_new_i64();
+#ifdef TARGET_SPARC64
+        tcg_gen_ext32u_i64(t2, cpu_regs[a->rs2_or_imm]);
+#else
+        tcg_gen_extu_i32_i64(t2, cpu_regs[a->rs2_or_imm]);
+#endif
+    }
+
+    t1 = tcg_temp_new_i64();
+    tcg_gen_concat_tl_i64(t1, gen_load_gpr(dc, a->rs1), cpu_y);
+
+    tcg_gen_divu_i64(t1, t1, t2);
+    tcg_gen_umin_i64(t1, t1, tcg_constant_i64(UINT32_MAX));
+
+    dst = gen_dest_gpr(dc, a->rd);
+    tcg_gen_trunc_i64_tl(dst, t1);
+    gen_store_gpr(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
 static bool trans_UDIVX(DisasContext *dc, arg_r_r_ri *a)
 {
     TCGv dst, src1, src2;
-- 
2.34.1


