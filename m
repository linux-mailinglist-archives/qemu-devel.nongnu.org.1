Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3FB7CEB2F
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 00:27:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtEzk-0008Db-R5; Wed, 18 Oct 2023 18:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEzg-0008Ab-DF
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:24 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEze-0002WL-Gf
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:24 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1c9de3f66e5so47680885ad.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 15:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697667980; x=1698272780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bcjf2eCMU+42vUIozeZGyhF4KpNEtDy+BJZ7xBFSvto=;
 b=SxfDnkQ4o5vXtkd/CBIzOfc6beoWfblF1VLxye5YmK6pCWItufe9Y/hTc/7h9rMJ2G
 BNzL623QbBoDsyYw141N0SjjpG1iApGTuGJ1tqoffTGhvD42OOR9Awn7EDjD6IVtpz+g
 pGnt1W9SdsagWTkILFPASrEz8jTXinqL80oCWxhHVrD52pL5PmYrS63RZSOj9iBJpySX
 kpktS7ITMfHgF0F2FLrG3+MeGP2HL8ONj1EwxdYwUUUfDW69CG6n8hz72d18D6VndW/n
 WkxYYUjzwwIuUrNNmgyFWxrVi0heyUqTjdHYNdpqcp9/o8D91q5zqogveWbRkGkqUUl+
 aQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697667980; x=1698272780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bcjf2eCMU+42vUIozeZGyhF4KpNEtDy+BJZ7xBFSvto=;
 b=xNBkn45K94TW90quU+LTExkjS7pV7HIwP4r7GCneM5shT1BfaOhO2VB4taE3KUCFF8
 P53XyGa0qh+zrGu2nS9KJwWqrCpXpvWgcyBi/M+1eigo/zznc769277IX364pHLvMs+/
 XZgNTZiQ2ijcqet6xg4Hyx+2deDSM6xAxABcGPYQTI/jac74n/tJ6PFZEfV4UmLHEpko
 2cXw4L+memVWYkCMPq3EADHa14A8UTeMr13wgKyrl+4E+FpUIsWsKr5zgPWIFHCKafyZ
 S3VayGK7V4+NKO6VMKTckJbgTFDJ1x++uDSWKhLKK4/LpEArDpYJrSTSucWoC6Xo0/5I
 XV/w==
X-Gm-Message-State: AOJu0YxdFJnHLnHS5jSLiIBxi9CJqjbpEs4Z1ZmGwmj/OWfJb94wIx45
 fZhHDl31F/KiPX3UArpudODpBJuDxORTxQhe0lQ=
X-Google-Smtp-Source: AGHT+IGyN1sIj9/Y9YjU5ZeldzfjUQ5794jmCfXikd8VnxbN5dDwAdWzFhbhzaKsb7D6zPQDc6JN4Q==
X-Received: by 2002:a17:902:e801:b0:1ca:7294:a55a with SMTP id
 u1-20020a170902e80100b001ca7294a55amr722310plg.64.1697667980193; 
 Wed, 18 Oct 2023 15:26:20 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a170902c24d00b001b9d95945afsm431058plg.155.2023.10.18.15.26.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 15:26:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 24/29] tcg/s390x: Use tcg_use_softmmu
Date: Wed, 18 Oct 2023 15:25:52 -0700
Message-Id: <20231018222557.1562065-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018222557.1562065-1-richard.henderson@linaro.org>
References: <20231018222557.1562065-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/s390x/tcg-target.c.inc | 161 ++++++++++++++++++-------------------
 1 file changed, 79 insertions(+), 82 deletions(-)

diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 4ef9ac3d5b..fbee43d3b0 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -46,9 +46,7 @@
 /* A scratch register that may be be used throughout the backend.  */
 #define TCG_TMP0        TCG_REG_R1
 
-#ifndef CONFIG_SOFTMMU
 #define TCG_GUEST_BASE_REG TCG_REG_R13
-#endif
 
 /* All of the following instructions are prefixed with their instruction
    format, and are defined as 8- or 16-bit quantities, even when the two
@@ -1768,94 +1766,95 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     h->aa = atom_and_align_for_opc(s, opc, MO_ATOM_IFALIGN, s_bits == MO_128);
     a_mask = (1 << h->aa.align) - 1;
 
-#ifdef CONFIG_SOFTMMU
-    unsigned s_mask = (1 << s_bits) - 1;
-    int mem_index = get_mmuidx(oi);
-    int fast_off = tlb_mask_table_ofs(s, mem_index);
-    int mask_off = fast_off + offsetof(CPUTLBDescFast, mask);
-    int table_off = fast_off + offsetof(CPUTLBDescFast, table);
-    int ofs, a_off;
-    uint64_t tlb_mask;
+    if (tcg_use_softmmu) {
+        unsigned s_mask = (1 << s_bits) - 1;
+        int mem_index = get_mmuidx(oi);
+        int fast_off = tlb_mask_table_ofs(s, mem_index);
+        int mask_off = fast_off + offsetof(CPUTLBDescFast, mask);
+        int table_off = fast_off + offsetof(CPUTLBDescFast, table);
+        int ofs, a_off;
+        uint64_t tlb_mask;
 
-    ldst = new_ldst_label(s);
-    ldst->is_ld = is_ld;
-    ldst->oi = oi;
-    ldst->addrlo_reg = addr_reg;
-
-    tcg_out_sh64(s, RSY_SRLG, TCG_TMP0, addr_reg, TCG_REG_NONE,
-                 s->page_bits - CPU_TLB_ENTRY_BITS);
-
-    tcg_out_insn(s, RXY, NG, TCG_TMP0, TCG_AREG0, TCG_REG_NONE, mask_off);
-    tcg_out_insn(s, RXY, AG, TCG_TMP0, TCG_AREG0, TCG_REG_NONE, table_off);
-
-    /*
-     * For aligned accesses, we check the first byte and include the alignment
-     * bits within the address.  For unaligned access, we check that we don't
-     * cross pages using the address of the last byte of the access.
-     */
-    a_off = (a_mask >= s_mask ? 0 : s_mask - a_mask);
-    tlb_mask = (uint64_t)s->page_mask | a_mask;
-    if (a_off == 0) {
-        tgen_andi_risbg(s, TCG_REG_R0, addr_reg, tlb_mask);
-    } else {
-        tcg_out_insn(s, RX, LA, TCG_REG_R0, addr_reg, TCG_REG_NONE, a_off);
-        tgen_andi(s, addr_type, TCG_REG_R0, tlb_mask);
-    }
-
-    if (is_ld) {
-        ofs = offsetof(CPUTLBEntry, addr_read);
-    } else {
-        ofs = offsetof(CPUTLBEntry, addr_write);
-    }
-    if (addr_type == TCG_TYPE_I32) {
-        ofs += HOST_BIG_ENDIAN * 4;
-        tcg_out_insn(s, RX, C, TCG_REG_R0, TCG_TMP0, TCG_REG_NONE, ofs);
-    } else {
-        tcg_out_insn(s, RXY, CG, TCG_REG_R0, TCG_TMP0, TCG_REG_NONE, ofs);
-    }
-
-    tcg_out16(s, RI_BRC | (S390_CC_NE << 4));
-    ldst->label_ptr[0] = s->code_ptr++;
-
-    h->index = TCG_TMP0;
-    tcg_out_insn(s, RXY, LG, h->index, TCG_TMP0, TCG_REG_NONE,
-                 offsetof(CPUTLBEntry, addend));
-
-    if (addr_type == TCG_TYPE_I32) {
-        tcg_out_insn(s, RRE, ALGFR, h->index, addr_reg);
-        h->base = TCG_REG_NONE;
-    } else {
-        h->base = addr_reg;
-    }
-    h->disp = 0;
-#else
-    if (a_mask) {
         ldst = new_ldst_label(s);
         ldst->is_ld = is_ld;
         ldst->oi = oi;
         ldst->addrlo_reg = addr_reg;
 
-        /* We are expecting a_bits to max out at 7, much lower than TMLL. */
-        tcg_debug_assert(a_mask <= 0xffff);
-        tcg_out_insn(s, RI, TMLL, addr_reg, a_mask);
+        tcg_out_sh64(s, RSY_SRLG, TCG_TMP0, addr_reg, TCG_REG_NONE,
+                     s->page_bits - CPU_TLB_ENTRY_BITS);
 
-        tcg_out16(s, RI_BRC | (7 << 4)); /* CC in {1,2,3} */
+        tcg_out_insn(s, RXY, NG, TCG_TMP0, TCG_AREG0, TCG_REG_NONE, mask_off);
+        tcg_out_insn(s, RXY, AG, TCG_TMP0, TCG_AREG0, TCG_REG_NONE, table_off);
+
+        /*
+         * For aligned accesses, we check the first byte and include the
+         * alignment bits within the address.  For unaligned access, we
+         * check that we don't cross pages using the address of the last
+         * byte of the access.
+         */
+        a_off = (a_mask >= s_mask ? 0 : s_mask - a_mask);
+        tlb_mask = (uint64_t)s->page_mask | a_mask;
+        if (a_off == 0) {
+            tgen_andi_risbg(s, TCG_REG_R0, addr_reg, tlb_mask);
+        } else {
+            tcg_out_insn(s, RX, LA, TCG_REG_R0, addr_reg, TCG_REG_NONE, a_off);
+            tgen_andi(s, addr_type, TCG_REG_R0, tlb_mask);
+        }
+
+        if (is_ld) {
+            ofs = offsetof(CPUTLBEntry, addr_read);
+        } else {
+            ofs = offsetof(CPUTLBEntry, addr_write);
+        }
+        if (addr_type == TCG_TYPE_I32) {
+            ofs += HOST_BIG_ENDIAN * 4;
+            tcg_out_insn(s, RX, C, TCG_REG_R0, TCG_TMP0, TCG_REG_NONE, ofs);
+        } else {
+            tcg_out_insn(s, RXY, CG, TCG_REG_R0, TCG_TMP0, TCG_REG_NONE, ofs);
+        }
+
+        tcg_out16(s, RI_BRC | (S390_CC_NE << 4));
         ldst->label_ptr[0] = s->code_ptr++;
-    }
 
-    h->base = addr_reg;
-    if (addr_type == TCG_TYPE_I32) {
-        tcg_out_ext32u(s, TCG_TMP0, addr_reg);
-        h->base = TCG_TMP0;
-    }
-    if (guest_base < 0x80000) {
-        h->index = TCG_REG_NONE;
-        h->disp = guest_base;
-    } else {
-        h->index = TCG_GUEST_BASE_REG;
+        h->index = TCG_TMP0;
+        tcg_out_insn(s, RXY, LG, h->index, TCG_TMP0, TCG_REG_NONE,
+                     offsetof(CPUTLBEntry, addend));
+
+        if (addr_type == TCG_TYPE_I32) {
+            tcg_out_insn(s, RRE, ALGFR, h->index, addr_reg);
+            h->base = TCG_REG_NONE;
+        } else {
+            h->base = addr_reg;
+        }
         h->disp = 0;
+    } else {
+        if (a_mask) {
+            ldst = new_ldst_label(s);
+            ldst->is_ld = is_ld;
+            ldst->oi = oi;
+            ldst->addrlo_reg = addr_reg;
+
+            /* We are expecting a_bits to max out at 7, much lower than TMLL. */
+            tcg_debug_assert(a_mask <= 0xffff);
+            tcg_out_insn(s, RI, TMLL, addr_reg, a_mask);
+
+            tcg_out16(s, RI_BRC | (7 << 4)); /* CC in {1,2,3} */
+            ldst->label_ptr[0] = s->code_ptr++;
+        }
+
+        h->base = addr_reg;
+        if (addr_type == TCG_TYPE_I32) {
+            tcg_out_ext32u(s, TCG_TMP0, addr_reg);
+            h->base = TCG_TMP0;
+        }
+        if (guest_base < 0x80000) {
+            h->index = TCG_REG_NONE;
+            h->disp = guest_base;
+        } else {
+            h->index = TCG_GUEST_BASE_REG;
+            h->disp = 0;
+        }
     }
-#endif
 
     return ldst;
 }
@@ -3453,12 +3452,10 @@ static void tcg_target_qemu_prologue(TCGContext *s)
                   TCG_STATIC_CALL_ARGS_SIZE + TCG_TARGET_CALL_STACK_OFFSET,
                   CPU_TEMP_BUF_NLONGS * sizeof(long));
 
-#ifndef CONFIG_SOFTMMU
-    if (guest_base >= 0x80000) {
+    if (!tcg_use_softmmu && guest_base >= 0x80000) {
         tcg_out_movi(s, TCG_TYPE_PTR, TCG_GUEST_BASE_REG, guest_base);
         tcg_regset_set_reg(s->reserved_regs, TCG_GUEST_BASE_REG);
     }
-#endif
 
     tcg_out_mov(s, TCG_TYPE_PTR, TCG_AREG0, tcg_target_call_iarg_regs[0]);
 
-- 
2.34.1


