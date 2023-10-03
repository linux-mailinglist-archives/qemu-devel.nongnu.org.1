Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 479D27B702B
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:44:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjRR-0003Wo-17; Tue, 03 Oct 2023 13:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjRL-0003Ns-Pt
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:44:11 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjRI-0001O1-Td
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:44:11 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1c0ecb9a075so9176845ad.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696355047; x=1696959847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fLvItmIrt15JaLaBIgv2EV2SUjPZVyaPB43Eg76lR6g=;
 b=F/UxaHXZCta1rT7chzZyhqbcOol3hBi4mOK9xCbCE4xECY6LcQZht37vatp+Hd1XaQ
 RANfXsnQYe49t/p5trVxphabNB0dbgCuoqLAoIGUfTcluv19f9aG5Mv0DoZMGK6vGLvl
 wkgva3LQ4Gui0E1FfK/3WejIJMGdqLhMqhZkBqw5kRBCRAg3mVydXjDIwU/Hn5eEJcgq
 yB1vEpn+bUg2cdW5RlZV7CVrFMvw6kozt/CHUk27xBhUFhbbgtwV1MuQmLFvkXq7MZAL
 AUkGg6Ze8s/YtZd6xGS4clyBHe8m4BMEI/a0bQVrw6N5z0lQjzQlka75YbdHuk3iwPZ1
 UT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696355047; x=1696959847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fLvItmIrt15JaLaBIgv2EV2SUjPZVyaPB43Eg76lR6g=;
 b=kIQK7A6N1vIoP8LsPs2drw5vVyOAfLYSg6qlHUv428oM7Lhb2NHz2PJvZnUgzDCuXm
 bMzBuRxZLpezSCUa7YTB61mzYARCYOSIqCIDRZ1C9tHa6CrlvYlm+7GgsUaW1aTAzEmx
 OAzafA2Sng2+rEkxQxqowhfsDu4yBjYLXDjd487pdYjHJG1WGZXPn6oOHzkKU9n8/mnV
 U9uj88aUNR+30385BnodF9TzbJDE9uciNRlDGewpF3MDIvm9MknwgbSAIJXnlIfFwpvk
 s53wqa9PhM1yXCTJB/9p6WcKY/yg2Lc36E+Vx1VVfNtCZKMkvQzGEgCyzByZLBFzDYat
 yP5Q==
X-Gm-Message-State: AOJu0Yzw4TKJ1QI/ueJG9ST49GnclyI5LH4yy78/uYthQcObbrTQnGHV
 6mv+dWCC/H+vLyFAMnnVtsQIGvgc+NIZGQyrTe0=
X-Google-Smtp-Source: AGHT+IHNO/GVywTgAAGeQPjMc8FXVH6WS8AZAhKrYk5D65cChqqNbx/tX+ZzG39mRd8Bm+IS1tuBTQ==
X-Received: by 2002:a17:902:c409:b0:1c5:ea60:85c1 with SMTP id
 k9-20020a170902c40900b001c5ea6085c1mr394129plk.12.1696355047308; 
 Tue, 03 Oct 2023 10:44:07 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jg2-20020a17090326c200b001c32fd9e412sm1876466plb.58.2023.10.03.10.44.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 10:44:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/10] tcg/s390x: Use tcg_use_softmmu
Date: Tue,  3 Oct 2023 10:43:56 -0700
Message-Id: <20231003174356.1602279-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003174356.1602279-1-richard.henderson@linaro.org>
References: <20231003174356.1602279-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
 tcg/s390x/tcg-target.c.inc | 161 ++++++++++++++++++-------------------
 1 file changed, 79 insertions(+), 82 deletions(-)

diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 7552f63a05..c29bc52b3b 100644
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


