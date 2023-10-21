Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8C27D1AFD
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:38:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4eS-0002yf-PW; Sat, 21 Oct 2023 01:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4eG-0002Vv-KA
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:35:46 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4eE-000167-Fk
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:35:44 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-53fbf2c42bfso1122161a12.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866540; x=1698471340; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QfDb+unIm1+7QmjDoXPDwhvDEAwPeBrO/ad5/mnwy80=;
 b=Jue1kPSyyASvH8M5VjSYUFSRSUl46Qa1xwIACu911LdxKdXFZO1utMT95UHmfjIv+M
 uBq5mlcCmyClGqR31LuJ+/njLIL+Uco2pnPVQD2Jh86Lg6UCUYsKFoErt60zcpCI6Fg6
 opvJrZXx9OVQGxOZdwQn3Y1CFApFsMpUufk/47hF9tgF/noL93a7gjBvHk8AnbvYLoVP
 jSkPwVvJhu+mQomwmisB7pWOcHMnt5iRErBjSN1jG9lLQUCjG1KSDcW19ydVeO+YXfkY
 +MxNxlH1zzMD5ysmer5rWVAQHpCuwwFTtCGRbfPdxv0zsBL2RBitjO2S9AqqCSvZOSE6
 YwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866540; x=1698471340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QfDb+unIm1+7QmjDoXPDwhvDEAwPeBrO/ad5/mnwy80=;
 b=GphSHX55PIdKCrKm3VPGwIVWYIrLln/dwYzrZopllYjwlGsq5ysc38/bC6cnHUdTVm
 81VgZUB/1kfsqoPs0rBFkQKGsfH2ljF50srpXnWZ3rvonpkBo6z3QJueeCl8oJ2+GfxK
 JN8xqxBjBZ+JGmjSfzJk2qRaZZ+trMmxtgMABbUPP+Ov1PDHDj+bXQexzqFKEnHy2Zxj
 cqNV+mzVlg8icnpbJUmIpH2nEMT4f3qTeLYUk9QX5rPVcCdtjhP5mjG0RIVPriLLWNah
 HqhaPedV974bYnnHz8m/Kc8hKCX+PLXpFgCLRa7AkxVQy40BaGWvnneaDdosT9UnINd8
 Raog==
X-Gm-Message-State: AOJu0YxwCnXHxDmQCni131HMRyUu8buOuqaKiDfyXNQqQdSqQxDrXKUw
 yptKrvWp7G8uMMOd2VJ0/+naIF7iiAajecwH4tw=
X-Google-Smtp-Source: AGHT+IG/gezyvFvR+bia/kbgqqYpIgXeAIq7VkFi8ZM5WphN3wWc/QU31UWCEOqxgYD4veIhSu+pcQ==
X-Received: by 2002:a05:6a20:3955:b0:151:577:32d1 with SMTP id
 r21-20020a056a20395500b00151057732d1mr4822724pzg.22.1697866539917; 
 Fri, 20 Oct 2023 22:35:39 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h1-20020a62b401000000b00690d255b5a1sm2427978pfn.217.2023.10.20.22.35.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:35:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 48/90] target/sparc: Move simple integer load/store to
 decodetree
Date: Fri, 20 Oct 2023 22:31:16 -0700
Message-Id: <20231021053158.278135-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

Move LDUW, LDUB, LDUH, LDD, LDSW, LDSB, LDSH, LDX,
STW, STB, STH, STD, STX.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  22 +++++
 target/sparc/translate.c  | 196 +++++++++++++++++++++++---------------
 2 files changed, 142 insertions(+), 76 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index bbddae6ce0..edacd2043f 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -231,6 +231,28 @@ RESTORE     10 ..... 111101 ..... . .............          @r_r_ri
 DONE        10 00000 111110 00000 0 0000000000000
 RETRY       10 00001 111110 00000 0 0000000000000
 
+##
+## Major Opcode 11 -- load and store instructions
+##
+
+&r_r_ri_asi rd rs1 rs2_or_imm asi imm:bool
+@r_r_ri_na  .. rd:5  ...... rs1:5 imm:1 rs2_or_imm:s13     &r_r_ri_asi asi=-1
+
+LDUW        11 ..... 000000 ..... . .............          @r_r_ri_na
+LDUB        11 ..... 000001 ..... . .............          @r_r_ri_na
+LDUH        11 ..... 000010 ..... . .............          @r_r_ri_na
+LDD         11 ..... 000011 ..... . .............          @r_r_ri_na
+LDSW        11 ..... 001000 ..... . .............          @r_r_ri_na
+LDSB        11 ..... 001001 ..... . .............          @r_r_ri_na
+LDSH        11 ..... 001010 ..... . .............          @r_r_ri_na
+LDX         11 ..... 001011 ..... . .............          @r_r_ri_na
+
+STW         11 ..... 000100 ..... . .............          @r_r_ri_na
+STB         11 ..... 000101 ..... . .............          @r_r_ri_na
+STH         11 ..... 000110 ..... . .............          @r_r_ri_na
+STD         11 ..... 000111 ..... . .............          @r_r_ri_na
+STX         11 ..... 001110 ..... . .............          @r_r_ri_na
+
 NCP         10 ----- 110110 ----- --------- -----          # v8 CPop1
 NCP         10 ----- 110111 ----- --------- -----          # v8 CPop2
 
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 6f8f279508..af9f58aa53 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4648,6 +4648,117 @@ static bool trans_RETRY(DisasContext *dc, arg_RETRY *a)
     return true;
 }
 
+/*
+ * Major opcode 11 -- load and store instructions
+ */
+
+static TCGv gen_ldst_addr(DisasContext *dc, int rs1, bool imm, int rs2_or_imm)
+{
+    TCGv addr, tmp = NULL;
+
+    /* For simplicity, we under-decoded the rs2 form. */
+    if (!imm && rs2_or_imm & ~0x1f) {
+        return NULL;
+    }
+
+    addr = gen_load_gpr(dc, rs1);
+    if (rs2_or_imm) {
+        tmp = tcg_temp_new();
+        if (imm) {
+            tcg_gen_addi_tl(tmp, addr, rs2_or_imm);
+        } else {
+            tcg_gen_add_tl(tmp, addr, cpu_regs[rs2_or_imm]);
+        }
+        addr = tmp;
+    }
+    if (AM_CHECK(dc)) {
+        if (!tmp) {
+            tmp = tcg_temp_new();
+        }
+        tcg_gen_ext32u_tl(tmp, addr);
+        addr = tmp;
+    }
+    return addr;
+}
+
+static bool do_ld_gpr(DisasContext *dc, arg_r_r_ri_asi *a, MemOp mop)
+{
+    TCGv reg, addr = gen_ldst_addr(dc, a->rs1, a->imm, a->rs2_or_imm);
+    DisasASI da;
+
+    if (addr == NULL) {
+        return false;
+    }
+    da = resolve_asi(dc, a->asi, mop);
+
+    reg = gen_dest_gpr(dc, a->rd);
+    gen_ld_asi0(dc, &da, reg, addr);
+    gen_store_gpr(dc, a->rd, reg);
+    return advance_pc(dc);
+}
+
+TRANS(LDUW, ALL, do_ld_gpr, a, MO_TEUL)
+TRANS(LDUB, ALL, do_ld_gpr, a, MO_UB)
+TRANS(LDUH, ALL, do_ld_gpr, a, MO_TEUW)
+TRANS(LDSB, ALL, do_ld_gpr, a, MO_SB)
+TRANS(LDSH, ALL, do_ld_gpr, a, MO_TESW)
+TRANS(LDSW, 64, do_ld_gpr, a, MO_TESL)
+TRANS(LDX, 64, do_ld_gpr, a, MO_TEUQ)
+
+static bool do_st_gpr(DisasContext *dc, arg_r_r_ri_asi *a, MemOp mop)
+{
+    TCGv reg, addr = gen_ldst_addr(dc, a->rs1, a->imm, a->rs2_or_imm);
+    DisasASI da;
+
+    if (addr == NULL) {
+        return false;
+    }
+    da = resolve_asi(dc, a->asi, mop);
+
+    reg = gen_load_gpr(dc, a->rd);
+    gen_st_asi0(dc, &da, reg, addr);
+    return advance_pc(dc);
+}
+
+TRANS(STW, ALL, do_st_gpr, a, MO_TEUL)
+TRANS(STB, ALL, do_st_gpr, a, MO_UB)
+TRANS(STH, ALL, do_st_gpr, a, MO_TEUW)
+TRANS(STX, 64, do_st_gpr, a, MO_TEUQ)
+
+static bool trans_LDD(DisasContext *dc, arg_r_r_ri_asi *a)
+{
+    TCGv addr;
+    DisasASI da;
+
+    if (a->rd & 1) {
+        return false;
+    }
+    addr = gen_ldst_addr(dc, a->rs1, a->imm, a->rs2_or_imm);
+    if (addr == NULL) {
+        return false;
+    }
+    da = resolve_asi(dc, a->asi, MO_TEUQ);
+    gen_ldda_asi0(dc, &da, addr, a->rd);
+    return advance_pc(dc);
+}
+
+static bool trans_STD(DisasContext *dc, arg_r_r_ri_asi *a)
+{
+    TCGv addr;
+    DisasASI da;
+
+    if (a->rd & 1) {
+        return false;
+    }
+    addr = gen_ldst_addr(dc, a->rs1, a->imm, a->rs2_or_imm);
+    if (addr == NULL) {
+        return false;
+    }
+    da = resolve_asi(dc, a->asi, MO_TEUQ);
+    gen_stda_asi0(dc, &da, addr, a->rd);
+    return advance_pc(dc);
+}
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -5471,47 +5582,15 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
 
                 switch (xop) {
                 case 0x0:       /* ld, V9 lduw, load unsigned word */
-                    gen_address_mask(dc, cpu_addr);
-                    tcg_gen_qemu_ld_tl(cpu_val, cpu_addr,
-                                       dc->mem_idx, MO_TEUL | MO_ALIGN);
-                    break;
                 case 0x1:       /* ldub, load unsigned byte */
-                    gen_address_mask(dc, cpu_addr);
-                    tcg_gen_qemu_ld_tl(cpu_val, cpu_addr,
-                                       dc->mem_idx, MO_UB);
-                    break;
                 case 0x2:       /* lduh, load unsigned halfword */
-                    gen_address_mask(dc, cpu_addr);
-                    tcg_gen_qemu_ld_tl(cpu_val, cpu_addr,
-                                       dc->mem_idx, MO_TEUW | MO_ALIGN);
-                    break;
                 case 0x3:       /* ldd, load double word */
-                    if (rd & 1)
-                        goto illegal_insn;
-                    else {
-                        TCGv_i64 t64;
-
-                        gen_address_mask(dc, cpu_addr);
-                        t64 = tcg_temp_new_i64();
-                        tcg_gen_qemu_ld_i64(t64, cpu_addr,
-                                            dc->mem_idx, MO_TEUQ | MO_ALIGN);
-                        tcg_gen_trunc_i64_tl(cpu_val, t64);
-                        tcg_gen_ext32u_tl(cpu_val, cpu_val);
-                        gen_store_gpr(dc, rd + 1, cpu_val);
-                        tcg_gen_shri_i64(t64, t64, 32);
-                        tcg_gen_trunc_i64_tl(cpu_val, t64);
-                        tcg_gen_ext32u_tl(cpu_val, cpu_val);
-                    }
-                    break;
                 case 0x9:       /* ldsb, load signed byte */
-                    gen_address_mask(dc, cpu_addr);
-                    tcg_gen_qemu_ld_tl(cpu_val, cpu_addr, dc->mem_idx, MO_SB);
-                    break;
                 case 0xa:       /* ldsh, load signed halfword */
-                    gen_address_mask(dc, cpu_addr);
-                    tcg_gen_qemu_ld_tl(cpu_val, cpu_addr,
-                                       dc->mem_idx, MO_TESW | MO_ALIGN);
-                    break;
+                    g_assert_not_reached();  /* in decodetree */
+                case 0x08:      /* V9 ldsw */
+                case 0x0b:      /* V9 ldx */
+                    goto illegal_insn;  /* in decodetree */
                 case 0xd:       /* ldstub */
                     gen_ldstub(dc, cpu_val, cpu_addr, dc->mem_idx);
                     break;
@@ -5553,16 +5632,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     break;
 #endif
 #ifdef TARGET_SPARC64
-                case 0x08: /* V9 ldsw */
-                    gen_address_mask(dc, cpu_addr);
-                    tcg_gen_qemu_ld_tl(cpu_val, cpu_addr,
-                                       dc->mem_idx, MO_TESL | MO_ALIGN);
-                    break;
-                case 0x0b: /* V9 ldx */
-                    gen_address_mask(dc, cpu_addr);
-                    tcg_gen_qemu_ld_tl(cpu_val, cpu_addr,
-                                       dc->mem_idx, MO_TEUQ | MO_ALIGN);
-                    break;
                 case 0x18: /* V9 ldswa */
                     gen_ld_asi(dc, cpu_val, cpu_addr, insn, MO_TESL);
                     break;
@@ -5655,38 +5724,18 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 }
             } else if (xop < 8 || (xop >= 0x14 && xop < 0x18) ||
                        xop == 0xe || xop == 0x1e) {
+#if !defined(CONFIG_USER_ONLY) || defined(TARGET_SPARC64)
                 TCGv cpu_val = gen_load_gpr(dc, rd);
+#endif
 
                 switch (xop) {
                 case 0x4: /* st, store word */
-                    gen_address_mask(dc, cpu_addr);
-                    tcg_gen_qemu_st_tl(cpu_val, cpu_addr,
-                                       dc->mem_idx, MO_TEUL | MO_ALIGN);
-                    break;
                 case 0x5: /* stb, store byte */
-                    gen_address_mask(dc, cpu_addr);
-                    tcg_gen_qemu_st_tl(cpu_val, cpu_addr, dc->mem_idx, MO_UB);
-                    break;
                 case 0x6: /* sth, store halfword */
-                    gen_address_mask(dc, cpu_addr);
-                    tcg_gen_qemu_st_tl(cpu_val, cpu_addr,
-                                       dc->mem_idx, MO_TEUW | MO_ALIGN);
-                    break;
                 case 0x7: /* std, store double word */
-                    if (rd & 1)
-                        goto illegal_insn;
-                    else {
-                        TCGv_i64 t64;
-                        TCGv lo;
-
-                        gen_address_mask(dc, cpu_addr);
-                        lo = gen_load_gpr(dc, rd + 1);
-                        t64 = tcg_temp_new_i64();
-                        tcg_gen_concat_tl_i64(t64, lo, cpu_val);
-                        tcg_gen_qemu_st_i64(t64, cpu_addr,
-                                            dc->mem_idx, MO_TEUQ | MO_ALIGN);
-                    }
-                    break;
+                    g_assert_not_reached();  /* in decodetree */
+                case 0x0e: /* V9 stx */
+                    goto illegal_insn;  /* in decodetree */
 #if !defined(CONFIG_USER_ONLY) || defined(TARGET_SPARC64)
                 case 0x14: /* sta, V9 stwa, store word alternate */
                     gen_st_asi(dc, cpu_val, cpu_addr, insn, MO_TEUL);
@@ -5705,11 +5754,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     break;
 #endif
 #ifdef TARGET_SPARC64
-                case 0x0e: /* V9 stx */
-                    gen_address_mask(dc, cpu_addr);
-                    tcg_gen_qemu_st_tl(cpu_val, cpu_addr,
-                                       dc->mem_idx, MO_TEUQ | MO_ALIGN);
-                    break;
                 case 0x1e: /* V9 stxa */
                     gen_st_asi(dc, cpu_val, cpu_addr, insn, MO_TEUQ);
                     break;
-- 
2.34.1


