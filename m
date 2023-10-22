Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE1A7D213A
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:02:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRX4-0001r2-Fe; Sun, 22 Oct 2023 02:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRWt-00018H-Ee
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:01:40 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRWp-0001iI-G7
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:01:39 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6bd96cfb99cso1659278b3a.2
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954493; x=1698559293; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NWlKsn/wZN4eT45rH03CDpAb6KA/TazNayvN7ccWLg0=;
 b=VC1V+VVS/jtW5bQPJ3/0nJBvk2XaxnXFX6gZoy5MdYw+d/SsOlQWSVdZdgfd1hkV+y
 UIUY78Pt9tOei8s7nF5MgOTZ0i/cy3C73T5OsjN7eoQjoqw4x6SGldRQhtNsXsNCPCAS
 EQBIvP7/q8HrHOWxe1h7UZzfPg3ZQVwOommNPu4UT55z5IWTWwWci+pBkzP1v6YQDXg3
 8PV4/v44b9z/6U2J0dLwT/k3Cw2wk/gFyj/jRPUA9uK4XwayWzqCOcPtrG+QpeHHmqJe
 koDoKpUVKOf60TC8NE6K24fvyPF+VzoMfntqzH64ZFyvpSJNVXtIoW9VY45ETB0jBcmZ
 UMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954493; x=1698559293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NWlKsn/wZN4eT45rH03CDpAb6KA/TazNayvN7ccWLg0=;
 b=QKnl3HrVt9Pqzt4BtQI6L4y1EMkgz/TFXC51bFVf7GAZ/mikDVzzX4PsN7vfR8c2qw
 q66uhDyMZ0yKKb6F9JKs3rMUzhlMbEkTStft+V4HaKhlo7+aCl1zUaNYv8COS6nFNKT+
 bl4d980XWk74jGwk51Q9e13psNoLrDCzQPNwp4NTXxfM/gOrgrpKZqCG0OQiVxx3jr6Z
 5+xBUcvlUaUBKTOSgiaRn0/J4etbFN6ttKds1MvgOuHQmH15GS9dt55nOqPOjAJyjzDQ
 255LH7HHHXqe2x9tBdS5M4OjhE9TevWeHqzEkDLbEVZ+v2nNCKbNt71kUTF8qEd0EMSo
 C0Zw==
X-Gm-Message-State: AOJu0YzIVwkXGdf6bjLgWxNS90Ysl4dxwvzNnVyer0ojc4oSWXS2+11z
 iZVPWl1PJWBlXdDjIwjV3M/5tLBIEuDdbdpBR0A=
X-Google-Smtp-Source: AGHT+IFSDYGmxob4RgBmPA7jvqJJwmk7QggT3OxZWSfaCHnwLDmUzufvjgKURlI8YUPA35OoAS74Tg==
X-Received: by 2002:a17:90b:3883:b0:27d:669e:5a10 with SMTP id
 mu3-20020a17090b388300b0027d669e5a10mr4059430pjb.13.1697954493055; 
 Sat, 21 Oct 2023 23:01:33 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 je17-20020a170903265100b001c728609574sm3999887plb.6.2023.10.21.23.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:01:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 37/90] target/sparc: Move SLL, SRL, SRA to decodetree
Date: Sat, 21 Oct 2023 22:59:38 -0700
Message-Id: <20231022060031.490251-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  14 +++
 target/sparc/translate.c  | 182 ++++++++++++++++----------------------
 2 files changed, 92 insertions(+), 104 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index b35921aabb..51cddc826d 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -183,6 +183,20 @@ TSUBcc      10 ..... 100001 ..... . .............          @r_r_ri_cc1
 TADDccTV    10 ..... 100010 ..... . .............          @r_r_ri_cc1
 TSUBccTV    10 ..... 100011 ..... . .............          @r_r_ri_cc1
 
+&shiftr     rd rs1 rs2 x:bool
+@shiftr     .. rd:5  ...... rs1:5 . x:1 ....... rs2:5      &shiftr
+
+SLL_r       10 ..... 100101 ..... 0 .   0000000 .....      @shiftr
+SRL_r       10 ..... 100110 ..... 0 .   0000000 .....      @shiftr
+SRA_r       10 ..... 100111 ..... 0 .   0000000 .....      @shiftr
+
+&shifti     rd rs1 i x:bool
+@shifti     .. rd:5  ...... rs1:5 . x:1 ...... i:6         &shifti
+
+SLL_i       10 ..... 100101 ..... 1 .   000000 ......      @shifti
+SRL_i       10 ..... 100110 ..... 1 .   000000 ......      @shifti
+SRA_i       10 ..... 100111 ..... 1 .   000000 ......      @shifti
+
 Tcc_r       10 0 cond:4 111010 rs1:5 0 cc:1 0000000 rs2:5
 {
   # For v7, the entire simm13 field is present, but masked to 7 bits.
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 179f991c5d..3785728e66 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4391,6 +4391,83 @@ static bool trans_MULScc(DisasContext *dc, arg_r_r_ri_cc *a)
     return do_arith(dc, a, CC_OP_ADD, gen_op_mulscc, NULL);
 }
 
+static bool do_shift_r(DisasContext *dc, arg_shiftr *a, bool l, bool u)
+{
+    TCGv dst, src1, src2;
+
+    /* Reject 64-bit shifts for sparc32. */
+    if (avail_32(dc) && a->x) {
+        return false;
+    }
+
+    src2 = tcg_temp_new();
+    tcg_gen_andi_tl(src2, gen_load_gpr(dc, a->rs2), a->x ? 63 : 31);
+    src1 = gen_load_gpr(dc, a->rs1);
+    dst = gen_dest_gpr(dc, a->rd);
+
+    if (l) {
+        tcg_gen_shl_tl(dst, src1, src2);
+        if (!a->x) {
+            tcg_gen_ext32u_tl(dst, dst);
+        }
+    } else if (u) {
+        if (!a->x) {
+            tcg_gen_ext32u_tl(dst, src1);
+            src1 = dst;
+        }
+        tcg_gen_shr_tl(dst, src1, src2);
+    } else {
+        if (!a->x) {
+            tcg_gen_ext32s_tl(dst, src1);
+            src1 = dst;
+        }
+        tcg_gen_sar_tl(dst, src1, src2);
+    }
+    gen_store_gpr(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(SLL_r, ALL, do_shift_r, a, true, true)
+TRANS(SRL_r, ALL, do_shift_r, a, false, true)
+TRANS(SRA_r, ALL, do_shift_r, a, false, false)
+
+static bool do_shift_i(DisasContext *dc, arg_shifti *a, bool l, bool u)
+{
+    TCGv dst, src1;
+
+    /* Reject 64-bit shifts for sparc32. */
+    if (avail_32(dc) && (a->x || a->i >= 32)) {
+        return false;
+    }
+
+    src1 = gen_load_gpr(dc, a->rs1);
+    dst = gen_dest_gpr(dc, a->rd);
+
+    if (avail_32(dc) || a->x) {
+        if (l) {
+            tcg_gen_shli_tl(dst, src1, a->i);
+        } else if (u) {
+            tcg_gen_shri_tl(dst, src1, a->i);
+        } else {
+            tcg_gen_sari_tl(dst, src1, a->i);
+        }
+    } else {
+        if (l) {
+            tcg_gen_deposit_z_tl(dst, src1, a->i, 32 - a->i);
+        } else if (u) {
+            tcg_gen_extract_tl(dst, src1, a->i, 32 - a->i);
+        } else {
+            tcg_gen_sextract_tl(dst, src1, a->i, 32 - a->i);
+        }
+    }
+    gen_store_gpr(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(SLL_i, ALL, do_shift_i, a, true, true)
+TRANS(SRL_i, ALL, do_shift_i, a, false, true)
+TRANS(SRA_i, ALL, do_shift_i, a, false, false)
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -4739,77 +4816,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     default:
                         goto illegal_insn;
                 }
-#ifdef TARGET_SPARC64
-            } else if (xop == 0x25) { /* sll, V9 sllx */
-                cpu_src1 = get_src1(dc, insn);
-                if (IS_IMM) {   /* immediate */
-                    simm = GET_FIELDs(insn, 20, 31);
-                    if (insn & (1 << 12)) {
-                        tcg_gen_shli_i64(cpu_dst, cpu_src1, simm & 0x3f);
-                    } else {
-                        tcg_gen_shli_i64(cpu_dst, cpu_src1, simm & 0x1f);
-                    }
-                } else {                /* register */
-                    rs2 = GET_FIELD(insn, 27, 31);
-                    cpu_src2 = gen_load_gpr(dc, rs2);
-                    cpu_tmp0 = tcg_temp_new();
-                    if (insn & (1 << 12)) {
-                        tcg_gen_andi_i64(cpu_tmp0, cpu_src2, 0x3f);
-                    } else {
-                        tcg_gen_andi_i64(cpu_tmp0, cpu_src2, 0x1f);
-                    }
-                    tcg_gen_shl_i64(cpu_dst, cpu_src1, cpu_tmp0);
-                }
-                gen_store_gpr(dc, rd, cpu_dst);
-            } else if (xop == 0x26) { /* srl, V9 srlx */
-                cpu_src1 = get_src1(dc, insn);
-                if (IS_IMM) {   /* immediate */
-                    simm = GET_FIELDs(insn, 20, 31);
-                    if (insn & (1 << 12)) {
-                        tcg_gen_shri_i64(cpu_dst, cpu_src1, simm & 0x3f);
-                    } else {
-                        tcg_gen_andi_i64(cpu_dst, cpu_src1, 0xffffffffULL);
-                        tcg_gen_shri_i64(cpu_dst, cpu_dst, simm & 0x1f);
-                    }
-                } else {                /* register */
-                    rs2 = GET_FIELD(insn, 27, 31);
-                    cpu_src2 = gen_load_gpr(dc, rs2);
-                    cpu_tmp0 = tcg_temp_new();
-                    if (insn & (1 << 12)) {
-                        tcg_gen_andi_i64(cpu_tmp0, cpu_src2, 0x3f);
-                        tcg_gen_shr_i64(cpu_dst, cpu_src1, cpu_tmp0);
-                    } else {
-                        tcg_gen_andi_i64(cpu_tmp0, cpu_src2, 0x1f);
-                        tcg_gen_andi_i64(cpu_dst, cpu_src1, 0xffffffffULL);
-                        tcg_gen_shr_i64(cpu_dst, cpu_dst, cpu_tmp0);
-                    }
-                }
-                gen_store_gpr(dc, rd, cpu_dst);
-            } else if (xop == 0x27) { /* sra, V9 srax */
-                cpu_src1 = get_src1(dc, insn);
-                if (IS_IMM) {   /* immediate */
-                    simm = GET_FIELDs(insn, 20, 31);
-                    if (insn & (1 << 12)) {
-                        tcg_gen_sari_i64(cpu_dst, cpu_src1, simm & 0x3f);
-                    } else {
-                        tcg_gen_ext32s_i64(cpu_dst, cpu_src1);
-                        tcg_gen_sari_i64(cpu_dst, cpu_dst, simm & 0x1f);
-                    }
-                } else {                /* register */
-                    rs2 = GET_FIELD(insn, 27, 31);
-                    cpu_src2 = gen_load_gpr(dc, rs2);
-                    cpu_tmp0 = tcg_temp_new();
-                    if (insn & (1 << 12)) {
-                        tcg_gen_andi_i64(cpu_tmp0, cpu_src2, 0x3f);
-                        tcg_gen_sar_i64(cpu_dst, cpu_src1, cpu_tmp0);
-                    } else {
-                        tcg_gen_andi_i64(cpu_tmp0, cpu_src2, 0x1f);
-                        tcg_gen_ext32s_i64(cpu_dst, cpu_src1);
-                        tcg_gen_sar_i64(cpu_dst, cpu_dst, cpu_tmp0);
-                    }
-                }
-                gen_store_gpr(dc, rd, cpu_dst);
-#endif
             } else if (xop < 0x36) {
                 if (xop < 0x20) {
                     goto illegal_insn;
@@ -4822,42 +4828,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     case 0x22: /* taddcctv */
                     case 0x23: /* tsubcctv */
                     case 0x24: /* mulscc */
-                        goto illegal_insn;  /* in decodetree */
-#ifndef TARGET_SPARC64
                     case 0x25:  /* sll */
-                        if (IS_IMM) { /* immediate */
-                            simm = GET_FIELDs(insn, 20, 31);
-                            tcg_gen_shli_tl(cpu_dst, cpu_src1, simm & 0x1f);
-                        } else { /* register */
-                            cpu_tmp0 = tcg_temp_new();
-                            tcg_gen_andi_tl(cpu_tmp0, cpu_src2, 0x1f);
-                            tcg_gen_shl_tl(cpu_dst, cpu_src1, cpu_tmp0);
-                        }
-                        gen_store_gpr(dc, rd, cpu_dst);
-                        break;
                     case 0x26:  /* srl */
-                        if (IS_IMM) { /* immediate */
-                            simm = GET_FIELDs(insn, 20, 31);
-                            tcg_gen_shri_tl(cpu_dst, cpu_src1, simm & 0x1f);
-                        } else { /* register */
-                            cpu_tmp0 = tcg_temp_new();
-                            tcg_gen_andi_tl(cpu_tmp0, cpu_src2, 0x1f);
-                            tcg_gen_shr_tl(cpu_dst, cpu_src1, cpu_tmp0);
-                        }
-                        gen_store_gpr(dc, rd, cpu_dst);
-                        break;
                     case 0x27:  /* sra */
-                        if (IS_IMM) { /* immediate */
-                            simm = GET_FIELDs(insn, 20, 31);
-                            tcg_gen_sari_tl(cpu_dst, cpu_src1, simm & 0x1f);
-                        } else { /* register */
-                            cpu_tmp0 = tcg_temp_new();
-                            tcg_gen_andi_tl(cpu_tmp0, cpu_src2, 0x1f);
-                            tcg_gen_sar_tl(cpu_dst, cpu_src1, cpu_tmp0);
-                        }
-                        gen_store_gpr(dc, rd, cpu_dst);
-                        break;
-#endif
+                        goto illegal_insn;  /* in decodetree */
                     case 0x30:
                         goto illegal_insn;  /* WRASR in decodetree */
                     case 0x32:
-- 
2.34.1


