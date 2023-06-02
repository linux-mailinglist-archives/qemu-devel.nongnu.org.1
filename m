Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8967206A0
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 17:55:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q574y-0003GE-VF; Fri, 02 Jun 2023 11:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q574w-0003En-Sh
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 11:52:39 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q574r-0003UF-EG
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 11:52:38 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f606a80d34so21277995e9.0
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 08:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685721152; x=1688313152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0KLmYQ64c8GCMhyYOzgN/W/7tY/GEebqrCmVx7GKA+I=;
 b=XfhbR8R9ojg/R0rn11SNDAuMpVuUc0ccglqFEVFdArSWCIS/EJLrZq1517PeZWWaXP
 lNQ6yzTJMKAKW/siHXEuYvuy2BSv40G7A5qnKjh1eUy5jZfbyLUyPF4ldo8wdqzadPN7
 hxouJOkXVKgvJRV5QRj5htpRqVRxz4bbcaGpHc9WBHj8ohkn4xLkP6H1ey6LDMBk7pcL
 r4X7NmizrRx+DqTlaTiMwNAkBkrlneeDXITDuaaGmr2azAFMzNfsIO4VGGN3VvVzyFrQ
 z6V99NcKQHrt3HR394Oi6lpHe5ycBTIIlEQWMkIQpzUGr7NIEHvwtAH7K0M/RN2gpge9
 zboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685721152; x=1688313152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0KLmYQ64c8GCMhyYOzgN/W/7tY/GEebqrCmVx7GKA+I=;
 b=QmWOjoAuJIDHZn36xL/Mk0yrSeomSl7ha6CMO4O7JCuXoZjPgVdnzrSc4zcwdTE4Cy
 vhin1yPrIJKaajHWWs4W2h7kPFWSsjpSjlVuyeHnnp/qhWQCgKYOFHwC9wdGTNnYKMED
 yGkZrdPaltCPWMkX90P8S/8vtJMTVdUzwOQ+S8HavTSbmy8xGpETAzviJx3i352nFfvT
 fmidxnkps2VvNVu8FA7ytPRUx+fHtey58CL8GCClqFHvpfqti5ugnUxQfzIKJZD4DExP
 8j2fcp6F2pMNHKjTIJnkDsYtl8nAKkSQrkUTmrj3kCm68Mgqtt9yaF5fQnXbtXKdnc2U
 rQEA==
X-Gm-Message-State: AC+VfDxpeHnCFHewh9GFP2uIHp/qS1fGL5NpQcOyRGz+PNTpgYmMNV0b
 txbu2telxw7MywMzPx8Kcy6AixpFSDbT3lYpLjA=
X-Google-Smtp-Source: ACHHUZ4rm+HGTqreIHk9JOOoy+a0jmAB196C7pTdC3QV6i90qUXKsiw3ZBhWJGdEmjMe+A/aMS566Q==
X-Received: by 2002:a7b:ce0d:0:b0:3f6:2ee:698e with SMTP id
 m13-20020a7bce0d000000b003f602ee698emr2047747wmc.7.1685721152034; 
 Fri, 02 Jun 2023 08:52:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v7-20020a05600c214700b003f72a15301csm594952wml.2.2023.06.02.08.52.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 08:52:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 12/20] target/arm: Convert ld/st reg+imm9 insns to decodetree
Date: Fri,  2 Jun 2023 16:52:15 +0100
Message-Id: <20230602155223.2040685-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602155223.2040685-1-peter.maydell@linaro.org>
References: <20230602155223.2040685-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

Convert the load and store instructions which use a 9-bit
immediate offset to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  69 ++++++++++++
 target/arm/tcg/translate-a64.c | 198 +++++++++++++--------------------
 2 files changed, 148 insertions(+), 119 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 0a3850fe8d5..4dfb7bbdc2e 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -326,3 +326,72 @@ LDP_v           10 101 1 011 1 ....... ..... ..... ..... @ldstpair sz=4 sign=0 p
 STGP            01 101 0 001 0 ....... ..... ..... ..... @ldstpair sz=3 sign=0 p=1 w=1
 STGP            01 101 0 010 0 ....... ..... ..... ..... @ldstpair sz=3 sign=0 p=0 w=0
 STGP            01 101 0 011 0 ....... ..... ..... ..... @ldstpair sz=3 sign=0 p=0 w=1
+
+# Load/store register (unscaled immediate)
+&ldst_imm       rt rn imm sz sign w p unpriv ext
+@ldst_imm       .. ... . .. .. . imm:s9 .. rn:5 rt:5 &ldst_imm unpriv=0 p=0 w=0
+@ldst_imm_pre   .. ... . .. .. . imm:s9 .. rn:5 rt:5 &ldst_imm unpriv=0 p=0 w=1
+@ldst_imm_post  .. ... . .. .. . imm:s9 .. rn:5 rt:5 &ldst_imm unpriv=0 p=1 w=1
+@ldst_imm_user  .. ... . .. .. . imm:s9 .. rn:5 rt:5 &ldst_imm unpriv=1 p=0 w=0
+
+STR_i           sz:2 111 0 00 00 0 ......... 00 ..... ..... @ldst_imm sign=0 ext=0
+LDR_i           00 111 0 00 01 0 ......... 00 ..... ..... @ldst_imm sign=0 ext=1 sz=0
+LDR_i           01 111 0 00 01 0 ......... 00 ..... ..... @ldst_imm sign=0 ext=1 sz=1
+LDR_i           10 111 0 00 01 0 ......... 00 ..... ..... @ldst_imm sign=0 ext=1 sz=2
+LDR_i           11 111 0 00 01 0 ......... 00 ..... ..... @ldst_imm sign=0 ext=0 sz=3
+LDR_i           00 111 0 00 10 0 ......... 00 ..... ..... @ldst_imm sign=1 ext=0 sz=0
+LDR_i           01 111 0 00 10 0 ......... 00 ..... ..... @ldst_imm sign=1 ext=0 sz=1
+LDR_i           10 111 0 00 10 0 ......... 00 ..... ..... @ldst_imm sign=1 ext=0 sz=2
+LDR_i           00 111 0 00 11 0 ......... 00 ..... ..... @ldst_imm sign=1 ext=1 sz=0
+LDR_i           01 111 0 00 11 0 ......... 00 ..... ..... @ldst_imm sign=1 ext=1 sz=1
+
+STR_i           sz:2 111 0 00 00 0 ......... 01 ..... ..... @ldst_imm_post sign=0 ext=0
+LDR_i           00 111 0 00 01 0 ......... 01 ..... ..... @ldst_imm_post sign=0 ext=1 sz=0
+LDR_i           01 111 0 00 01 0 ......... 01 ..... ..... @ldst_imm_post sign=0 ext=1 sz=1
+LDR_i           10 111 0 00 01 0 ......... 01 ..... ..... @ldst_imm_post sign=0 ext=1 sz=2
+LDR_i           11 111 0 00 01 0 ......... 01 ..... ..... @ldst_imm_post sign=0 ext=0 sz=3
+LDR_i           00 111 0 00 10 0 ......... 01 ..... ..... @ldst_imm_post sign=1 ext=0 sz=0
+LDR_i           01 111 0 00 10 0 ......... 01 ..... ..... @ldst_imm_post sign=1 ext=0 sz=1
+LDR_i           10 111 0 00 10 0 ......... 01 ..... ..... @ldst_imm_post sign=1 ext=0 sz=2
+LDR_i           00 111 0 00 11 0 ......... 01 ..... ..... @ldst_imm_post sign=1 ext=1 sz=0
+LDR_i           01 111 0 00 11 0 ......... 01 ..... ..... @ldst_imm_post sign=1 ext=1 sz=1
+
+STR_i           sz:2 111 0 00 00 0 ......... 10 ..... ..... @ldst_imm_user sign=0 ext=0
+LDR_i           00 111 0 00 01 0 ......... 10 ..... ..... @ldst_imm_user sign=0 ext=1 sz=0
+LDR_i           01 111 0 00 01 0 ......... 10 ..... ..... @ldst_imm_user sign=0 ext=1 sz=1
+LDR_i           10 111 0 00 01 0 ......... 10 ..... ..... @ldst_imm_user sign=0 ext=1 sz=2
+LDR_i           11 111 0 00 01 0 ......... 10 ..... ..... @ldst_imm_user sign=0 ext=0 sz=3
+LDR_i           00 111 0 00 10 0 ......... 10 ..... ..... @ldst_imm_user sign=1 ext=0 sz=0
+LDR_i           01 111 0 00 10 0 ......... 10 ..... ..... @ldst_imm_user sign=1 ext=0 sz=1
+LDR_i           10 111 0 00 10 0 ......... 10 ..... ..... @ldst_imm_user sign=1 ext=0 sz=2
+LDR_i           00 111 0 00 11 0 ......... 10 ..... ..... @ldst_imm_user sign=1 ext=1 sz=0
+LDR_i           01 111 0 00 11 0 ......... 10 ..... ..... @ldst_imm_user sign=1 ext=1 sz=1
+
+STR_i           sz:2 111 0 00 00 0 ......... 11 ..... ..... @ldst_imm_pre sign=0 ext=0
+LDR_i           00 111 0 00 01 0 ......... 11 ..... ..... @ldst_imm_pre sign=0 ext=1 sz=0
+LDR_i           01 111 0 00 01 0 ......... 11 ..... ..... @ldst_imm_pre sign=0 ext=1 sz=1
+LDR_i           10 111 0 00 01 0 ......... 11 ..... ..... @ldst_imm_pre sign=0 ext=1 sz=2
+LDR_i           11 111 0 00 01 0 ......... 11 ..... ..... @ldst_imm_pre sign=0 ext=0 sz=3
+LDR_i           00 111 0 00 10 0 ......... 11 ..... ..... @ldst_imm_pre sign=1 ext=0 sz=0
+LDR_i           01 111 0 00 10 0 ......... 11 ..... ..... @ldst_imm_pre sign=1 ext=0 sz=1
+LDR_i           10 111 0 00 10 0 ......... 11 ..... ..... @ldst_imm_pre sign=1 ext=0 sz=2
+LDR_i           00 111 0 00 11 0 ......... 11 ..... ..... @ldst_imm_pre sign=1 ext=1 sz=0
+LDR_i           01 111 0 00 11 0 ......... 11 ..... ..... @ldst_imm_pre sign=1 ext=1 sz=1
+
+# PRFM : prefetch memory: a no-op for QEMU
+NOP             11 111 0 00 10 0 --------- 00 ----- -----
+
+STR_v_i         sz:2 111 1 00 00 0 ......... 00 ..... ..... @ldst_imm sign=0 ext=0
+STR_v_i         00 111 1 00 10 0 ......... 00 ..... ..... @ldst_imm sign=0 ext=0 sz=4
+LDR_v_i         sz:2 111 1 00 01 0 ......... 00 ..... ..... @ldst_imm sign=0 ext=0
+LDR_v_i         00 111 1 00 11 0 ......... 00 ..... ..... @ldst_imm sign=0 ext=0 sz=4
+
+STR_v_i         sz:2 111 1 00 00 0 ......... 01 ..... ..... @ldst_imm_post sign=0 ext=0
+STR_v_i         00 111 1 00 10 0 ......... 01 ..... ..... @ldst_imm_post sign=0 ext=0 sz=4
+LDR_v_i         sz:2 111 1 00 01 0 ......... 01 ..... ..... @ldst_imm_post sign=0 ext=0
+LDR_v_i         00 111 1 00 11 0 ......... 01 ..... ..... @ldst_imm_post sign=0 ext=0 sz=4
+
+STR_v_i         sz:2 111 1 00 00 0 ......... 11 ..... ..... @ldst_imm_pre sign=0 ext=0
+STR_v_i         00 111 1 00 10 0 ......... 11 ..... ..... @ldst_imm_pre sign=0 ext=0 sz=4
+LDR_v_i         sz:2 111 1 00 01 0 ......... 11 ..... ..... @ldst_imm_pre sign=0 ext=0
+LDR_v_i         00 111 1 00 11 0 ......... 11 ..... ..... @ldst_imm_pre sign=0 ext=0 sz=4
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index bd591122628..76e3e7b13bf 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2879,131 +2879,96 @@ static bool trans_STGP(DisasContext *s, arg_ldstpair *a)
     return true;
 }
 
-/*
- * Load/store (immediate post-indexed)
- * Load/store (immediate pre-indexed)
- * Load/store (unscaled immediate)
- *
- * 31 30 29   27  26 25 24 23 22 21  20    12 11 10 9    5 4    0
- * +----+-------+---+-----+-----+---+--------+-----+------+------+
- * |size| 1 1 1 | V | 0 0 | opc | 0 |  imm9  | idx |  Rn  |  Rt  |
- * +----+-------+---+-----+-----+---+--------+-----+------+------+
- *
- * idx = 01 -> post-indexed, 11 pre-indexed, 00 unscaled imm. (no writeback)
-         10 -> unprivileged
- * V = 0 -> non-vector
- * size: 00 -> 8 bit, 01 -> 16 bit, 10 -> 32 bit, 11 -> 64bit
- * opc: 00 -> store, 01 -> loadu, 10 -> loads 64, 11 -> loads 32
- */
-static void disas_ldst_reg_imm9(DisasContext *s, uint32_t insn,
-                                int opc,
-                                int size,
-                                int rt,
-                                bool is_vector)
+static void op_addr_ldst_imm_pre(DisasContext *s, arg_ldst_imm *a,
+                                 TCGv_i64 *clean_addr, TCGv_i64 *dirty_addr,
+                                 uint64_t offset, bool is_store)
 {
-    int rn = extract32(insn, 5, 5);
-    int imm9 = sextract32(insn, 12, 9);
-    int idx = extract32(insn, 10, 2);
-    bool is_signed = false;
-    bool is_store = false;
-    bool is_extended = false;
-    bool is_unpriv = (idx == 2);
-    bool iss_valid;
-    bool post_index;
-    bool writeback;
     int memidx;
 
-    TCGv_i64 clean_addr, dirty_addr;
-
-    if (is_vector) {
-        size |= (opc & 2) << 1;
-        if (size > 4 || is_unpriv) {
-            unallocated_encoding(s);
-            return;
-        }
-        is_store = ((opc & 1) == 0);
-        if (!fp_access_check(s)) {
-            return;
-        }
-    } else {
-        if (size == 3 && opc == 2) {
-            /* PRFM - prefetch */
-            if (idx != 0) {
-                unallocated_encoding(s);
-                return;
-            }
-            return;
-        }
-        if (opc == 3 && size > 1) {
-            unallocated_encoding(s);
-            return;
-        }
-        is_store = (opc == 0);
-        is_signed = extract32(opc, 1, 1);
-        is_extended = (size < 3) && extract32(opc, 0, 1);
-    }
-
-    switch (idx) {
-    case 0:
-    case 2:
-        post_index = false;
-        writeback = false;
-        break;
-    case 1:
-        post_index = true;
-        writeback = true;
-        break;
-    case 3:
-        post_index = false;
-        writeback = true;
-        break;
-    default:
-        g_assert_not_reached();
-    }
-
-    iss_valid = !is_vector && !writeback;
-
-    if (rn == 31) {
+    if (a->rn == 31) {
         gen_check_sp_alignment(s);
     }
 
-    dirty_addr = read_cpu_reg_sp(s, rn, 1);
-    if (!post_index) {
-        tcg_gen_addi_i64(dirty_addr, dirty_addr, imm9);
+    *dirty_addr = read_cpu_reg_sp(s, a->rn, 1);
+    if (!a->p) {
+        tcg_gen_addi_i64(*dirty_addr, *dirty_addr, offset);
     }
+    memidx = a->unpriv ? get_a64_user_mem_index(s) : get_mem_index(s);
+    *clean_addr = gen_mte_check1_mmuidx(s, *dirty_addr, is_store,
+                                        a->w || a->rn != 31,
+                                        a->sz, a->unpriv, memidx);
+}
 
-    memidx = is_unpriv ? get_a64_user_mem_index(s) : get_mem_index(s);
-    clean_addr = gen_mte_check1_mmuidx(s, dirty_addr, is_store,
-                                       writeback || rn != 31,
-                                       size, is_unpriv, memidx);
-
-    if (is_vector) {
-        if (is_store) {
-            do_fp_st(s, rt, clean_addr, size);
-        } else {
-            do_fp_ld(s, rt, clean_addr, size);
-        }
-    } else {
-        TCGv_i64 tcg_rt = cpu_reg(s, rt);
-        bool iss_sf = disas_ldst_compute_iss_sf(size, is_signed, opc);
-
-        if (is_store) {
-            do_gpr_st_memidx(s, tcg_rt, clean_addr, size, memidx,
-                             iss_valid, rt, iss_sf, false);
-        } else {
-            do_gpr_ld_memidx(s, tcg_rt, clean_addr, size + is_signed * MO_SIGN,
-                             is_extended, memidx,
-                             iss_valid, rt, iss_sf, false);
+static void op_addr_ldst_imm_post(DisasContext *s, arg_ldst_imm *a,
+                                  TCGv_i64 dirty_addr, uint64_t offset)
+{
+    if (a->w) {
+        if (a->p) {
+            tcg_gen_addi_i64(dirty_addr, dirty_addr, offset);
         }
+        tcg_gen_mov_i64(cpu_reg_sp(s, a->rn), dirty_addr);
     }
+}
 
-    if (writeback) {
-        TCGv_i64 tcg_rn = cpu_reg_sp(s, rn);
-        if (post_index) {
-            tcg_gen_addi_i64(dirty_addr, dirty_addr, imm9);
-        }
-        tcg_gen_mov_i64(tcg_rn, dirty_addr);
+static bool trans_STR_i(DisasContext *s, arg_ldst_imm *a)
+{
+    bool iss_sf, iss_valid = !a->w;
+    TCGv_i64 clean_addr, dirty_addr, tcg_rt;
+    int memidx = a->unpriv ? get_a64_user_mem_index(s) : get_mem_index(s);
+
+    op_addr_ldst_imm_pre(s, a, &clean_addr, &dirty_addr, a->imm, true);
+
+    tcg_rt = cpu_reg(s, a->rt);
+
+    iss_sf = ldst_iss_sf(a->sz, a->sign, a->ext);
+
+    do_gpr_st_memidx(s, tcg_rt, clean_addr, a->sz, memidx,
+                     iss_valid, a->rt, iss_sf, false);
+    op_addr_ldst_imm_post(s, a, dirty_addr, a->imm);
+    return true;
+}
+
+static bool trans_LDR_i(DisasContext *s, arg_ldst_imm *a)
+{
+    bool iss_sf, iss_valid = !a->w;
+    TCGv_i64 clean_addr, dirty_addr, tcg_rt;
+    int memidx = a->unpriv ? get_a64_user_mem_index(s) : get_mem_index(s);
+
+    op_addr_ldst_imm_pre(s, a, &clean_addr, &dirty_addr, a->imm, false);
+
+    tcg_rt = cpu_reg(s, a->rt);
+    iss_sf = ldst_iss_sf(a->sz, a->sign, a->ext);
+
+    do_gpr_ld_memidx(s, tcg_rt, clean_addr, a->sz + a->sign * MO_SIGN,
+                     a->ext, memidx, iss_valid, a->rt, iss_sf, false);
+    op_addr_ldst_imm_post(s, a, dirty_addr, a->imm);
+    return true;
+}
+
+static bool trans_STR_v_i(DisasContext *s, arg_ldst_imm *a)
+{
+    TCGv_i64 clean_addr, dirty_addr;
+
+    if (!fp_access_check(s)) {
+        return true;
     }
+    op_addr_ldst_imm_pre(s, a, &clean_addr, &dirty_addr, a->imm, true);
+    do_fp_st(s, a->rt, clean_addr, a->sz);
+    op_addr_ldst_imm_post(s, a, dirty_addr, a->imm);
+    return true;
+}
+
+static bool trans_LDR_v_i(DisasContext *s, arg_ldst_imm *a)
+{
+    TCGv_i64 clean_addr, dirty_addr;
+
+    if (!fp_access_check(s)) {
+        return true;
+    }
+    op_addr_ldst_imm_pre(s, a, &clean_addr, &dirty_addr, a->imm, false);
+    do_fp_ld(s, a->rt, clean_addr, a->sz);
+    op_addr_ldst_imm_post(s, a, dirty_addr, a->imm);
+    return true;
 }
 
 /*
@@ -3467,12 +3432,7 @@ static void disas_ldst_reg(DisasContext *s, uint32_t insn)
     switch (extract32(insn, 24, 2)) {
     case 0:
         if (extract32(insn, 21, 1) == 0) {
-            /* Load/store register (unscaled immediate)
-             * Load/store immediate pre/post-indexed
-             * Load/store register unprivileged
-             */
-            disas_ldst_reg_imm9(s, insn, opc, size, rt, is_vector);
-            return;
+            break;
         }
         switch (extract32(insn, 10, 2)) {
         case 0:
-- 
2.34.1


