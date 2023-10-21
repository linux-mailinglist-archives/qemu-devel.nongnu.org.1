Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB667D1AED
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:34:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4bI-0007JC-Hm; Sat, 21 Oct 2023 01:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4ax-0007CK-HS
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:20 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4av-0008QI-Nq
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:19 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3b2e22a4004so1095656b6e.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866336; x=1698471136; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EbSPVPuDQiKGoqEnGbeajJk8ZUJL4rxZ/KqPb7KMDCI=;
 b=yp5TqNYgHHvMElL8hN71YSWinOQhDOCiKfkX1emoShmUL7DF07nv/3oN12M5LAJpKe
 cm30cB4cLtL46+4TCdDQLqivUeT1UD9+QN2kS7ifbl/9lVZkWhEEFy8m0VR64Bff/WyX
 8AoZ7IfbyIpLie7Xm6RNt/nDXKkg6SVOxDHMNK39wouMBQNxtkMuh3ZECSvTsH8eHzKd
 e1yPpecld1Huv5ULpkfnNwhR5IbzNk3D8iGen1EK3pRVEWHqVAditu+mpTgNhyjWx35B
 ruAb/6rjcMib5CvCom/QiKkrm1BIVNvx6ACdeLAavT7kZZVYACwFUJKtLriHffyDQ7hk
 42WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866336; x=1698471136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EbSPVPuDQiKGoqEnGbeajJk8ZUJL4rxZ/KqPb7KMDCI=;
 b=Gzk3prX9MoMZ2HKN46Z10GtwxjgYh2jq8N2/bjixQBlzsd+mcz0rltv66bRxGF6eCe
 NgRPGUSjaIQh2XiFd7y+srHE8uwQVAsXsFYGHxCXVC7XjWHUy31p1uSM7Jyz1awN0dL9
 4XMDbNZ9O8E2me/mweQlGqbdv79xH/V/KfdQTzY6FLLGhjvdoXnHQm9gg1MhILA70zyi
 uUSCfJB46hkkdZB9lFXa0QShaZ02p6hyjth08SXrEM5ZVn5wOmlwJsCs4IwDXDadGTZn
 c6/ehbOTl+i8YN9hXZY4NdHO61pPRewK5pttgVXd6CjWfgLQGUA9gP+GG45vL9Ps2MZ+
 mvzQ==
X-Gm-Message-State: AOJu0YwVVjAMs8tTS/o6JOBt0G12PgUwKV0Acq3sfLlDGdtbMCjM0okY
 u+fT5cjcSjaWyeOJSyce/I+vt8Q+pJconvLFUOE=
X-Google-Smtp-Source: AGHT+IG6FpGTyaYcuX+fLE4u4NhhijxcRUAGWnOEo0Dq/YBDYmFf429DnW3oQWofiNpJDv0NYmeUXg==
X-Received: by 2002:a05:6808:219e:b0:3b2:dd7d:fc5e with SMTP id
 be30-20020a056808219e00b003b2dd7dfc5emr4721188oib.10.1697866336638; 
 Fri, 20 Oct 2023 22:32:16 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 f20-20020a056a001ad400b006b2677d3684sm2434831pfv.206.2023.10.20.22.32.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:32:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 20/90] target/sparc: Move Tcc to decodetree
Date: Fri, 20 Oct 2023 22:30:48 -0700
Message-Id: <20231021053158.278135-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
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

Use the new delay_exceptionv function in the implementation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  13 ++++
 target/sparc/translate.c  | 155 +++++++++++++++++++-------------------
 2 files changed, 89 insertions(+), 79 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index f6f5401b10..0517f5591b 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -21,3 +21,16 @@ NCP     00 -   ----     111 ----------------------         # CBcc
 SETHI   00 rd:5         100 i:22
 
 CALL    01 i:s30
+
+Tcc_r       10 0 cond:4 111010 rs1:5 0 cc:1 0000000 rs2:5
+{
+  # For v7, the entire simm13 field is present, but masked to 7 bits.
+  # For v8, [12:7] are reserved.  However, a compatibility note for
+  # the Tcc insn in the v9 manual suggests that the v8 reserved field
+  # was ignored and did not produce traps.
+  Tcc_i_v7  10 0 cond:4 111010 rs1:5 1 ------ i:7
+
+  # For v9, bits [12:11] are cc1 and cc0 (and cc0 must be 0).
+  # Bits [10:8] are reserved and the OSA2011 manual says they must be 0.
+  Tcc_i_v9  10 0 cond:4 111010 rs1:5 1 cc:1 0 000 i:8
+}
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index cdd929282a..b927b212ca 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -3042,6 +3042,81 @@ static bool trans_SETHI(DisasContext *dc, arg_SETHI *a)
     return advance_pc(dc);
 }
 
+static bool do_tcc(DisasContext *dc, int cond, int cc,
+                   int rs1, bool imm, int rs2_or_imm)
+{
+    int mask = ((dc->def->features & CPU_FEATURE_HYPV) && supervisor(dc)
+                ? UA2005_HTRAP_MASK : V8_TRAP_MASK);
+    DisasCompare cmp;
+    TCGLabel *lab;
+    TCGv_i32 trap;
+
+    /* Trap never.  */
+    if (cond == 0) {
+        return advance_pc(dc);
+    }
+
+    /*
+     * Immediate traps are the most common case.  Since this value is
+     * live across the branch, it really pays to evaluate the constant.
+     */
+    if (rs1 == 0 && (imm || rs2_or_imm == 0)) {
+        trap = tcg_constant_i32((rs2_or_imm & mask) + TT_TRAP);
+    } else {
+        trap = tcg_temp_new_i32();
+        tcg_gen_trunc_tl_i32(trap, gen_load_gpr(dc, rs1));
+        if (imm) {
+            tcg_gen_addi_i32(trap, trap, rs2_or_imm);
+        } else {
+            TCGv_i32 t2 = tcg_temp_new_i32();
+            tcg_gen_trunc_tl_i32(t2, gen_load_gpr(dc, rs2_or_imm));
+            tcg_gen_add_i32(trap, trap, t2);
+        }
+        tcg_gen_andi_i32(trap, trap, mask);
+        tcg_gen_addi_i32(trap, trap, TT_TRAP);
+    }
+
+    /* Trap always.  */
+    if (cond == 8) {
+        save_state(dc);
+        gen_helper_raise_exception(tcg_env, trap);
+        dc->base.is_jmp = DISAS_NORETURN;
+        return true;
+    }
+
+    /* Conditional trap.  */
+    flush_cond(dc);
+    lab = delay_exceptionv(dc, trap);
+    gen_compare(&cmp, cc, cond, dc);
+    tcg_gen_brcond_tl(cmp.cond, cmp.c1, cmp.c2, lab);
+
+    return advance_pc(dc);
+}
+
+static bool trans_Tcc_r(DisasContext *dc, arg_Tcc_r *a)
+{
+    if (avail_32(dc) && a->cc) {
+        return false;
+    }
+    return do_tcc(dc, a->cond, a->cc, a->rs1, false, a->rs2);
+}
+
+static bool trans_Tcc_i_v7(DisasContext *dc, arg_Tcc_i_v7 *a)
+{
+    if (avail_64(dc)) {
+        return false;
+    }
+    return do_tcc(dc, a->cond, 0, a->rs1, true, a->i);
+}
+
+static bool trans_Tcc_i_v9(DisasContext *dc, arg_Tcc_i_v9 *a)
+{
+    if (avail_32(dc)) {
+        return false;
+    }
+    return do_tcc(dc, a->cond, a->cc, a->rs1, true, a->i);
+}
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -3072,85 +3147,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
             TCGv cpu_dst = tcg_temp_new();
             TCGv cpu_tmp0;
 
-            if (xop == 0x3a) {  /* generate trap */
-                int cond = GET_FIELD(insn, 3, 6);
-                TCGv_i32 trap;
-                TCGLabel *l1 = NULL;
-                int mask;
-
-                if (cond == 0) {
-                    /* Trap never.  */
-                    break;
-                }
-
-                save_state(dc);
-
-                if (cond != 8) {
-                    /* Conditional trap.  */
-                    DisasCompare cmp;
-#ifdef TARGET_SPARC64
-                    /* V9 icc/xcc */
-                    int cc = GET_FIELD_SP(insn, 11, 12);
-                    if (cc == 0) {
-                        gen_compare(&cmp, 0, cond, dc);
-                    } else if (cc == 2) {
-                        gen_compare(&cmp, 1, cond, dc);
-                    } else {
-                        goto illegal_insn;
-                    }
-#else
-                    gen_compare(&cmp, 0, cond, dc);
-#endif
-                    l1 = gen_new_label();
-                    tcg_gen_brcond_tl(tcg_invert_cond(cmp.cond),
-                                      cmp.c1, cmp.c2, l1);
-                }
-
-                mask = ((dc->def->features & CPU_FEATURE_HYPV) && supervisor(dc)
-                        ? UA2005_HTRAP_MASK : V8_TRAP_MASK);
-
-                /* Don't use the normal temporaries, as they may well have
-                   gone out of scope with the branch above.  While we're
-                   doing that we might as well pre-truncate to 32-bit.  */
-                trap = tcg_temp_new_i32();
-
-                rs1 = GET_FIELD_SP(insn, 14, 18);
-                if (IS_IMM) {
-                    rs2 = GET_FIELD_SP(insn, 0, 7);
-                    if (rs1 == 0) {
-                        tcg_gen_movi_i32(trap, (rs2 & mask) + TT_TRAP);
-                        /* Signal that the trap value is fully constant.  */
-                        mask = 0;
-                    } else {
-                        TCGv t1 = gen_load_gpr(dc, rs1);
-                        tcg_gen_trunc_tl_i32(trap, t1);
-                        tcg_gen_addi_i32(trap, trap, rs2);
-                    }
-                } else {
-                    TCGv t1, t2;
-                    rs2 = GET_FIELD_SP(insn, 0, 4);
-                    t1 = gen_load_gpr(dc, rs1);
-                    t2 = gen_load_gpr(dc, rs2);
-                    tcg_gen_add_tl(t1, t1, t2);
-                    tcg_gen_trunc_tl_i32(trap, t1);
-                }
-                if (mask != 0) {
-                    tcg_gen_andi_i32(trap, trap, mask);
-                    tcg_gen_addi_i32(trap, trap, TT_TRAP);
-                }
-
-                gen_helper_raise_exception(tcg_env, trap);
-
-                if (cond == 8) {
-                    /* An unconditional trap ends the TB.  */
-                    dc->base.is_jmp = DISAS_NORETURN;
-                    goto jmp_insn;
-                } else {
-                    /* A conditional trap falls through to the next insn.  */
-                    gen_set_label(l1);
-                    break;
-                }
-            } else if (xop == 0x28) {
+            if (xop == 0x28) {
                 rs1 = GET_FIELD(insn, 13, 17);
                 switch(rs1) {
                 case 0: /* rdy */
-- 
2.34.1


