Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E0A72B2B4
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 18:02:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8NVf-0006Ww-TR; Sun, 11 Jun 2023 12:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q8NUp-0005wO-2x
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 12:00:53 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q8NUi-0000UG-Ux
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 12:00:50 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-30fbf253dc7so244549f8f.0
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 09:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686499242; x=1689091242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OAtg9LQL9ts1JABGS7gXYhJ1xEOgXCbhcvc8lEvcc64=;
 b=s2KjYWFTcGNR/c7MECLf8zO6JcAoo0q1MJblbIhGkm6Qn3fw15l9xudJ3tcDIFQ664
 qpKDnnjUFfCwNFY0UVJ3xV7QtmHR1QwNckvaRxFVbJIs22jMJxLag9ulR5Y85mdM24VK
 r9xjhYVY0v8q5X4B3/KPPuHl50NknDQ7vHDj8foCvW3fhy0cQ2+X5deJOMDaM3s25cWf
 SMoDNYr9r/HXsD51avRlPAgZFrObWCEHRGke5SwwSC7JWaRIOehONjMB5rwFxl9vGhq8
 0qQHRtopE1VqEWMXHVAOX3dB2rMuX+cE3Dyo5vzvsvhBBQ7Xmqbhq7D3aqJN4Ofrvw9v
 5r6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686499242; x=1689091242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OAtg9LQL9ts1JABGS7gXYhJ1xEOgXCbhcvc8lEvcc64=;
 b=DEy7lk3vuMUJ1bX5vNgiShnqD0ZWLDz2QLkEfzvIBo3r/yWhJnStlNDH7yqJfry8us
 JbjqBieyFt4t7KEau3ybhbBDTOjfakMWhbx3iz6MIupKNetLw0k2ifXVHt2lTE7kxpMW
 AHkMNvLHD3s1hu7RjmOF86XnvnfgwYo0OCDdH4WH1DjkoHns05WqBKv0TW3Iel6jLwrM
 i7YjyNIKjZQ31T6d5WqXNMu2EUye3LC5oOjcGX20vIxtHe38/fgr3k9ajf64t9PK30dE
 BHHtslxBCqlCmAMrZlOrbPGbUSsxA75WkuE+9mmJO2Ul/FgTIkNiNtbCquv7jPYv9PXr
 SGlg==
X-Gm-Message-State: AC+VfDztd3C6y7EWQ1d6VqXoGQNtoFmwWelJaey2znovQIdHzYBnTDSy
 sSF5qlwPtzBugDWvnV+SZaFwSg==
X-Google-Smtp-Source: ACHHUZ579ehGWaGF8a7hTfJCJY2t/21Q11umtOYdtiO6lTzDg/PlT9rhluoQpw0OZeRWhnCvbcHRCg==
X-Received: by 2002:a5d:4208:0:b0:30a:e589:68a5 with SMTP id
 n8-20020a5d4208000000b0030ae58968a5mr3496434wrq.29.1686499242180; 
 Sun, 11 Jun 2023 09:00:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m9-20020a056000008900b0030ae499da59sm9923022wrx.111.2023.06.11.09.00.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jun 2023 09:00:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 15/23] target/arm: Convert ld/st reg+imm9 insns to
 decodetree
Date: Sun, 11 Jun 2023 17:00:24 +0100
Message-Id: <20230611160032.274823-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230611160032.274823-1-peter.maydell@linaro.org>
References: <20230611160032.274823-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

Convert the load and store instructions which use a 9-bit
immediate offset to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230602155223.2040685-13-peter.maydell@linaro.org
---
 target/arm/tcg/a64.decode      |  69 +++++++++++
 target/arm/tcg/translate-a64.c | 206 ++++++++++++++-------------------
 2 files changed, 153 insertions(+), 122 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index f5787919931..d55c09684a7 100644
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
index 8b8c9939013..4cabdadde41 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -3040,134 +3040,101 @@ static bool trans_STGP(DisasContext *s, arg_ldstpair *a)
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
+                                 uint64_t offset, bool is_store, MemOp mop)
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
-    MemOp memop;
-    TCGv_i64 clean_addr, dirty_addr;
 
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
-        memop = finalize_memop_asimd(s, size);
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
-        is_signed = !is_store && extract32(opc, 1, 1);
-        is_extended = (size < 3) && extract32(opc, 0, 1);
-        memop = finalize_memop(s, size + is_signed * MO_SIGN);
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
+                                        mop, a->unpriv, memidx);
+}
 
-    memidx = is_unpriv ? get_a64_user_mem_index(s) : get_mem_index(s);
-
-    clean_addr = gen_mte_check1_mmuidx(s, dirty_addr, is_store,
-                                       writeback || rn != 31,
-                                       memop, is_unpriv, memidx);
-
-    if (is_vector) {
-        if (is_store) {
-            do_fp_st(s, rt, clean_addr, memop);
-        } else {
-            do_fp_ld(s, rt, clean_addr, memop);
-        }
-    } else {
-        TCGv_i64 tcg_rt = cpu_reg(s, rt);
-        bool iss_sf = disas_ldst_compute_iss_sf(size, is_signed, opc);
-
-        if (is_store) {
-            do_gpr_st_memidx(s, tcg_rt, clean_addr, memop, memidx,
-                             iss_valid, rt, iss_sf, false);
-        } else {
-            do_gpr_ld_memidx(s, tcg_rt, clean_addr, memop,
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
+    MemOp mop = finalize_memop(s, a->sz + a->sign * MO_SIGN);
+
+    op_addr_ldst_imm_pre(s, a, &clean_addr, &dirty_addr, a->imm, true, mop);
+
+    tcg_rt = cpu_reg(s, a->rt);
+    iss_sf = ldst_iss_sf(a->sz, a->sign, a->ext);
+
+    do_gpr_st_memidx(s, tcg_rt, clean_addr, mop, memidx,
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
+    MemOp mop = finalize_memop(s, a->sz + a->sign * MO_SIGN);
+
+    op_addr_ldst_imm_pre(s, a, &clean_addr, &dirty_addr, a->imm, false, mop);
+
+    tcg_rt = cpu_reg(s, a->rt);
+    iss_sf = ldst_iss_sf(a->sz, a->sign, a->ext);
+
+    do_gpr_ld_memidx(s, tcg_rt, clean_addr, mop,
+                     a->ext, memidx, iss_valid, a->rt, iss_sf, false);
+    op_addr_ldst_imm_post(s, a, dirty_addr, a->imm);
+    return true;
+}
+
+static bool trans_STR_v_i(DisasContext *s, arg_ldst_imm *a)
+{
+    TCGv_i64 clean_addr, dirty_addr;
+    MemOp mop;
+
+    if (!fp_access_check(s)) {
+        return true;
     }
+    mop = finalize_memop_asimd(s, a->sz);
+    op_addr_ldst_imm_pre(s, a, &clean_addr, &dirty_addr, a->imm, true, mop);
+    do_fp_st(s, a->rt, clean_addr, mop);
+    op_addr_ldst_imm_post(s, a, dirty_addr, a->imm);
+    return true;
+}
+
+static bool trans_LDR_v_i(DisasContext *s, arg_ldst_imm *a)
+{
+    TCGv_i64 clean_addr, dirty_addr;
+    MemOp mop;
+
+    if (!fp_access_check(s)) {
+        return true;
+    }
+    mop = finalize_memop_asimd(s, a->sz);
+    op_addr_ldst_imm_pre(s, a, &clean_addr, &dirty_addr, a->imm, false, mop);
+    do_fp_ld(s, a->rt, clean_addr, mop);
+    op_addr_ldst_imm_post(s, a, dirty_addr, a->imm);
+    return true;
 }
 
 /*
@@ -3640,12 +3607,7 @@ static void disas_ldst_reg(DisasContext *s, uint32_t insn)
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


