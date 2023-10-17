Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B8E7CBAB0
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:14:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdKG-0000Pn-SV; Tue, 17 Oct 2023 02:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdKE-0000Jt-CK
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:06 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdKC-0003tI-BQ
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:06 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c5cd27b1acso44358455ad.2
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523183; x=1698127983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/mTYxiPdr4Iee3Vw86SKy2D5EJuAnTIUSO2hmcgcVG4=;
 b=x/kvGT1G5ngVH/RjLU3yQmK9MHn4WWynOM+dKlj/YlAT4MAESJFvCVAySs0Ql+Mw4O
 RVhrTDCPjhWSnwIJX5VToeAn8nPkaSkEtjGeYBigYjRdRIi4xA3CM2Esd2pC9l2+PtfU
 lHsguG7QscWv5xVG6hS8jK0kf6JVd0gzrIz51c8Qh06rXmuBwR7V/IDB0M0ZnU/vMlGo
 E+LEFWsFKhlC2H2J9FfgVrAM2vG51nKKtDXP9CXdgFhqkTNW7K/xgp9CJwQvAF3VCvpB
 U6V80PdSRJ5FCIk3ovhQnEP1rz32bIvxIb0B+sG1DeUbE+xrr8kpw0lF+ovjVdWNzXVx
 AIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523183; x=1698127983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/mTYxiPdr4Iee3Vw86SKy2D5EJuAnTIUSO2hmcgcVG4=;
 b=C0y6Kpz0hVf+OFtXQRnmOlazsfmIBpfeHZMmNGCuCiQOukGV7f+ykV4dgEfu5H9ti8
 FTrXEo3nGjmrUHRfY0FbsdwVhSwF1lIo3hsqVDCYqA7jYLeksSWv8Sw5tVX07sKArsCH
 Wq0BZMud5UCYrEGmW43H321jzmSe5McVjHfRQ23764iNHU6m2tavhdR/UJ5h+D8OWuEg
 yYtTLOiHp0ClvcJ1erLi1q+vKwmOowTMrptVor9N5XBA5CPevzj1KbuZcMCmu4HGzv+q
 AzUpbpgnXjkbkpfGvEQVZYMJM6z4zCnrvOaHb6DMtfhRpNmWNHZoiTKcoF8uJ53y7PnI
 kmzQ==
X-Gm-Message-State: AOJu0YyjpVg9s30m8GQDT7gAJO0M34MZKxa+8OISDD1vbGCSwgKv+n7n
 dgchboO3oyO1fyWkjfD38Sn74ZsSFNBh3zbqlc4=
X-Google-Smtp-Source: AGHT+IFW2TXKOYtCLiAdu0j+LpsreURVlpcVpC9rRGc7FndEUA7o9x5py0+VXZAELqbBajMNYU/hQQ==
X-Received: by 2002:a17:903:248:b0:1c3:6d97:e89e with SMTP id
 j8-20020a170903024800b001c36d97e89emr1517318plh.58.1697523182790; 
 Mon, 16 Oct 2023 23:13:02 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf4-20020a170903268400b001ca21e05c69sm629150plb.109.2023.10.16.23.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:13:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 20/90] target/sparc: Move Tcc to decodetree
Date: Mon, 16 Oct 2023 23:11:34 -0700
Message-Id: <20231017061244.681584-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
 target/sparc/insns.decode |   2 +
 target/sparc/translate.c  | 143 +++++++++++++++++---------------------
 2 files changed, 66 insertions(+), 79 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index f6f5401b10..4d09c102f1 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -21,3 +21,5 @@ NCP     00 -   ----     111 ----------------------         # CBcc
 SETHI   00 rd:5         100 i:22
 
 CALL    01 i:s30
+
+Tcc     10 0 cond:4 111010 rs1:5 imm:1 cc:1 00000 rs2_or_imm:7
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index b53127ecb7..4a4aab81cd 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -3053,6 +3053,69 @@ static bool trans_SETHI(DisasContext *dc, arg_SETHI *a)
     return advance_pc(dc);
 }
 
+static bool trans_Tcc(DisasContext *dc, arg_Tcc *a)
+{
+    DisasCompare cmp;
+    TCGLabel *lab;
+    TCGv_i32 trap;
+    int mask;
+
+    /* Reject %xcc for sparc32. */
+    if (avail_32(dc) && a->cc) {
+        return false;
+    }
+
+    /* For simplicity, we underdecoded the rs2/imm7 field. */
+    if (!a->imm && (a->rs2_or_imm & ~0x1f)) {
+        return false;
+    }
+
+    /* Trap never.  */
+    if (a->cond == 0) {
+        return advance_pc(dc);
+    }
+
+    mask = ((dc->def->features & CPU_FEATURE_HYPV) && supervisor(dc)
+            ? UA2005_HTRAP_MASK : V8_TRAP_MASK);
+
+    if (a->rs2_or_imm == 0) {
+        a->imm = true;
+    }
+    if (a->rs1 == 0 && a->imm) {
+        trap = tcg_constant_i32((a->rs2_or_imm & mask) + TT_TRAP);
+    } else {
+        TCGv src1 = gen_load_gpr(dc, a->rs1);
+        TCGv sum = tcg_temp_new();
+
+        if (a->imm) {
+            tcg_gen_addi_tl(sum, src1, a->rs2_or_imm);
+        } else {
+            tcg_gen_add_tl(sum, src1, gen_load_gpr(dc, a->rs2_or_imm));
+        }
+
+        trap = tcg_temp_new_i32();
+        tcg_gen_trunc_tl_i32(trap, sum);
+        tcg_gen_andi_i32(trap, trap, mask);
+        tcg_gen_addi_i32(trap, trap, TT_TRAP);
+    }
+
+    /* Trap always.  */
+    if (a->cond == 8) {
+        save_state(dc);
+        gen_helper_raise_exception(tcg_env, trap);
+        dc->base.is_jmp = DISAS_NORETURN;
+        return true;
+    }
+
+    /* Conditional trap.  */
+    flush_cond(dc);
+    lab = delay_exceptionv(dc, trap);
+    gen_compare(&cmp, a->cc, a->cond, dc);
+    tcg_gen_brcond_tl(cmp.cond, cmp.c1, cmp.c2, lab);
+
+    return advance_pc(dc);
+}
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -3083,85 +3146,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


