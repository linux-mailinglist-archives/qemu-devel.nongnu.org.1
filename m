Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7195C7D3EC3
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:14:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzRB-0005fz-QK; Mon, 23 Oct 2023 14:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzR4-0005bv-Aj
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:13:55 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzR0-0008Fa-PR
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:13:53 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-692c02adeefso2727381b3a.3
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 11:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698084829; x=1698689629; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UPfL8PRDqxISdNKDDtEx7VkZ1IZG1ok5c8lkQqcFV18=;
 b=fxwrrxhbG8eoYGrDWSp0ObVXQVIQFX2EHfm2PwwwXqiRsIsfZg2qoBvQxdlhLfpn4j
 tDnGcmxnFeLUAAS0QhOvbEkiUIgaewo35bWw6tTA2ZrW/PCzxFPHYuguhLoxpT2BP8/t
 iTJrxAQklao1N2Rzg0PlvGVjgJAq9ojk0BN100GruLwc6YNnHBEdyaLSMAxJAWQYF3VS
 F0l8A4JSDOaexLMZ5hJsFKACo4qtmrlp4EGCvZ09Jw012bzC2cKwNi1bYIxFRwdkWoOy
 6FpA7dUWTnE6oTigkzJZ5hfSU7ZM5N4HB74OH0DJixuqdIrD9GnQLFEwhXq6JWx6IWOs
 IoJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698084829; x=1698689629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UPfL8PRDqxISdNKDDtEx7VkZ1IZG1ok5c8lkQqcFV18=;
 b=Eqm9geA+1FKMhqePbtQzy65Mo1YukkOq5syR2w+K+4aOpE6mDW03RmD6OW/ZeA0WyC
 yKm3EmiUqYvbXsQV2UkNTS1jsnkUJwYD5iD4QTEha0t4C1lAZS3IxNUv9REfBGXihQGx
 /nizj34xwa5bq+2uPYrnPj0bPVkD+lDwsAqGA3l8Mz3a1iFtRZLa0O3IUFSXC7Lab4/N
 3WJR2gTY/QnsOYSFs3miFFw+LnLGNOq4Tr6trb0s2gJOUjixwUe1VJWtL3CpAU7JSvTa
 aJ62HJDNoX3bvo603MInlX7a6RAPg0LZhxwnh+s4CLh8XxsEjN4GHqdXVoi4Kl92O/mW
 VZTg==
X-Gm-Message-State: AOJu0YzgB4nQIa5fYSs3M8bdRiCwdAF3vL5wr4kHqVCtWFdbv8GbSY0C
 qxhdNADfSYOXRShgE8JOSXk7AhZTSI3gP7Cvma8=
X-Google-Smtp-Source: AGHT+IFt7ApQw9OIC7l93hyO2NpME1rbo+sh2uhxJkwMXYcidoyA6U1vq/EVHx0N61zU8Xe4lISfmA==
X-Received: by 2002:a05:6a00:2e8e:b0:666:e1f4:5153 with SMTP id
 fd14-20020a056a002e8e00b00666e1f45153mr8650257pfb.0.1698084829375; 
 Mon, 23 Oct 2023 11:13:49 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v10-20020a65568a000000b005b83bc255fbsm5205137pgs.71.2023.10.23.11.13.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 11:13:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v3 21/38] tcg/ppc: Use tcg_use_softmmu
Date: Mon, 23 Oct 2023 11:13:12 -0700
Message-Id: <20231023181329.171490-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023181329.171490-1-richard.henderson@linaro.org>
References: <20231023181329.171490-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Fix TCG_GUEST_BASE_REG to use 'TCG_REG_R30' instead of '30'.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 284 ++++++++++++++++++++-------------------
 1 file changed, 143 insertions(+), 141 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index c31da4da9d..856c3b18f5 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -107,9 +107,7 @@
 
 #define have_isel  (cpuinfo & CPUINFO_ISEL)
 
-#ifndef CONFIG_SOFTMMU
-#define TCG_GUEST_BASE_REG 30
-#endif
+#define TCG_GUEST_BASE_REG  TCG_REG_R30
 
 #ifdef CONFIG_DEBUG_TCG
 static const char tcg_target_reg_names[TCG_TARGET_NB_REGS][4] = {
@@ -2317,151 +2315,157 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
                                    s_bits == MO_128);
     a_bits = h->aa.align;
 
-#ifdef CONFIG_SOFTMMU
-    int mem_index = get_mmuidx(oi);
-    int cmp_off = is_ld ? offsetof(CPUTLBEntry, addr_read)
-                        : offsetof(CPUTLBEntry, addr_write);
-    int fast_off = tlb_mask_table_ofs(s, mem_index);
-    int mask_off = fast_off + offsetof(CPUTLBDescFast, mask);
-    int table_off = fast_off + offsetof(CPUTLBDescFast, table);
+    if (tcg_use_softmmu) {
+        int mem_index = get_mmuidx(oi);
+        int cmp_off = is_ld ? offsetof(CPUTLBEntry, addr_read)
+                            : offsetof(CPUTLBEntry, addr_write);
+        int fast_off = tlb_mask_table_ofs(s, mem_index);
+        int mask_off = fast_off + offsetof(CPUTLBDescFast, mask);
+        int table_off = fast_off + offsetof(CPUTLBDescFast, table);
 
-    ldst = new_ldst_label(s);
-    ldst->is_ld = is_ld;
-    ldst->oi = oi;
-    ldst->addrlo_reg = addrlo;
-    ldst->addrhi_reg = addrhi;
-
-    /* Load tlb_mask[mmu_idx] and tlb_table[mmu_idx].  */
-    tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_AREG0, mask_off);
-    tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP2, TCG_AREG0, table_off);
-
-    /* Extract the page index, shifted into place for tlb index.  */
-    if (TCG_TARGET_REG_BITS == 32) {
-        tcg_out_shri32(s, TCG_REG_R0, addrlo,
-                       s->page_bits - CPU_TLB_ENTRY_BITS);
-    } else {
-        tcg_out_shri64(s, TCG_REG_R0, addrlo,
-                       s->page_bits - CPU_TLB_ENTRY_BITS);
-    }
-    tcg_out32(s, AND | SAB(TCG_REG_TMP1, TCG_REG_TMP1, TCG_REG_R0));
-
-    /*
-     * Load the (low part) TLB comparator into TMP2.
-     * For 64-bit host, always load the entire 64-bit slot for simplicity.
-     * We will ignore the high bits with tcg_out_cmp(..., addr_type).
-     */
-    if (TCG_TARGET_REG_BITS == 64) {
-        if (cmp_off == 0) {
-            tcg_out32(s, LDUX | TAB(TCG_REG_TMP2, TCG_REG_TMP1, TCG_REG_TMP2));
-        } else {
-            tcg_out32(s, ADD | TAB(TCG_REG_TMP1, TCG_REG_TMP1, TCG_REG_TMP2));
-            tcg_out_ld(s, TCG_TYPE_I64, TCG_REG_TMP2, TCG_REG_TMP1, cmp_off);
-        }
-    } else if (cmp_off == 0 && !HOST_BIG_ENDIAN) {
-        tcg_out32(s, LWZUX | TAB(TCG_REG_TMP2, TCG_REG_TMP1, TCG_REG_TMP2));
-    } else {
-        tcg_out32(s, ADD | TAB(TCG_REG_TMP1, TCG_REG_TMP1, TCG_REG_TMP2));
-        tcg_out_ld(s, TCG_TYPE_I32, TCG_REG_TMP2, TCG_REG_TMP1,
-                   cmp_off + 4 * HOST_BIG_ENDIAN);
-    }
-
-    /*
-     * Load the TLB addend for use on the fast path.
-     * Do this asap to minimize any load use delay.
-     */
-    if (TCG_TARGET_REG_BITS == 64 || addr_type == TCG_TYPE_I32) {
-        tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_REG_TMP1,
-                   offsetof(CPUTLBEntry, addend));
-    }
-
-    /* Clear the non-page, non-alignment bits from the address in R0. */
-    if (TCG_TARGET_REG_BITS == 32) {
-        /*
-         * We don't support unaligned accesses on 32-bits.
-         * Preserve the bottom bits and thus trigger a comparison
-         * failure on unaligned accesses.
-         */
-        if (a_bits < s_bits) {
-            a_bits = s_bits;
-        }
-        tcg_out_rlw(s, RLWINM, TCG_REG_R0, addrlo, 0,
-                    (32 - a_bits) & 31, 31 - s->page_bits);
-    } else {
-        TCGReg t = addrlo;
-
-        /*
-         * If the access is unaligned, we need to make sure we fail if we
-         * cross a page boundary.  The trick is to add the access size-1
-         * to the address before masking the low bits.  That will make the
-         * address overflow to the next page if we cross a page boundary,
-         * which will then force a mismatch of the TLB compare.
-         */
-        if (a_bits < s_bits) {
-            unsigned a_mask = (1 << a_bits) - 1;
-            unsigned s_mask = (1 << s_bits) - 1;
-            tcg_out32(s, ADDI | TAI(TCG_REG_R0, t, s_mask - a_mask));
-            t = TCG_REG_R0;
-        }
-
-        /* Mask the address for the requested alignment.  */
-        if (addr_type == TCG_TYPE_I32) {
-            tcg_out_rlw(s, RLWINM, TCG_REG_R0, t, 0,
-                        (32 - a_bits) & 31, 31 - s->page_bits);
-        } else if (a_bits == 0) {
-            tcg_out_rld(s, RLDICR, TCG_REG_R0, t, 0, 63 - s->page_bits);
-        } else {
-            tcg_out_rld(s, RLDICL, TCG_REG_R0, t,
-                        64 - s->page_bits, s->page_bits - a_bits);
-            tcg_out_rld(s, RLDICL, TCG_REG_R0, TCG_REG_R0, s->page_bits, 0);
-        }
-    }
-
-    if (TCG_TARGET_REG_BITS == 32 && addr_type != TCG_TYPE_I32) {
-        /* Low part comparison into cr7. */
-        tcg_out_cmp(s, TCG_COND_EQ, TCG_REG_R0, TCG_REG_TMP2,
-                    0, 7, TCG_TYPE_I32);
-
-        /* Load the high part TLB comparator into TMP2.  */
-        tcg_out_ld(s, TCG_TYPE_I32, TCG_REG_TMP2, TCG_REG_TMP1,
-                   cmp_off + 4 * !HOST_BIG_ENDIAN);
-
-        /* Load addend, deferred for this case. */
-        tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_REG_TMP1,
-                   offsetof(CPUTLBEntry, addend));
-
-        /* High part comparison into cr6. */
-        tcg_out_cmp(s, TCG_COND_EQ, addrhi, TCG_REG_TMP2, 0, 6, TCG_TYPE_I32);
-
-        /* Combine comparisons into cr7. */
-        tcg_out32(s, CRAND | BT(7, CR_EQ) | BA(6, CR_EQ) | BB(7, CR_EQ));
-    } else {
-        /* Full comparison into cr7. */
-        tcg_out_cmp(s, TCG_COND_EQ, TCG_REG_R0, TCG_REG_TMP2, 0, 7, addr_type);
-    }
-
-    /* Load a pointer into the current opcode w/conditional branch-link. */
-    ldst->label_ptr[0] = s->code_ptr;
-    tcg_out32(s, BC | BI(7, CR_EQ) | BO_COND_FALSE | LK);
-
-    h->base = TCG_REG_TMP1;
-#else
-    if (a_bits) {
         ldst = new_ldst_label(s);
         ldst->is_ld = is_ld;
         ldst->oi = oi;
         ldst->addrlo_reg = addrlo;
         ldst->addrhi_reg = addrhi;
 
-        /* We are expecting a_bits to max out at 7, much lower than ANDI. */
-        tcg_debug_assert(a_bits < 16);
-        tcg_out32(s, ANDI | SAI(addrlo, TCG_REG_R0, (1 << a_bits) - 1));
+        /* Load tlb_mask[mmu_idx] and tlb_table[mmu_idx].  */
+        tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_AREG0, mask_off);
+        tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP2, TCG_AREG0, table_off);
 
+        /* Extract the page index, shifted into place for tlb index.  */
+        if (TCG_TARGET_REG_BITS == 32) {
+            tcg_out_shri32(s, TCG_REG_R0, addrlo,
+                           s->page_bits - CPU_TLB_ENTRY_BITS);
+        } else {
+            tcg_out_shri64(s, TCG_REG_R0, addrlo,
+                           s->page_bits - CPU_TLB_ENTRY_BITS);
+        }
+        tcg_out32(s, AND | SAB(TCG_REG_TMP1, TCG_REG_TMP1, TCG_REG_R0));
+
+        /*
+         * Load the (low part) TLB comparator into TMP2.
+         * For 64-bit host, always load the entire 64-bit slot for simplicity.
+         * We will ignore the high bits with tcg_out_cmp(..., addr_type).
+         */
+        if (TCG_TARGET_REG_BITS == 64) {
+            if (cmp_off == 0) {
+                tcg_out32(s, LDUX | TAB(TCG_REG_TMP2,
+                                        TCG_REG_TMP1, TCG_REG_TMP2));
+            } else {
+                tcg_out32(s, ADD | TAB(TCG_REG_TMP1,
+                                       TCG_REG_TMP1, TCG_REG_TMP2));
+                tcg_out_ld(s, TCG_TYPE_I64, TCG_REG_TMP2,
+                           TCG_REG_TMP1, cmp_off);
+            }
+        } else if (cmp_off == 0 && !HOST_BIG_ENDIAN) {
+            tcg_out32(s, LWZUX | TAB(TCG_REG_TMP2,
+                                     TCG_REG_TMP1, TCG_REG_TMP2));
+        } else {
+            tcg_out32(s, ADD | TAB(TCG_REG_TMP1, TCG_REG_TMP1, TCG_REG_TMP2));
+            tcg_out_ld(s, TCG_TYPE_I32, TCG_REG_TMP2, TCG_REG_TMP1,
+                       cmp_off + 4 * HOST_BIG_ENDIAN);
+        }
+
+        /*
+         * Load the TLB addend for use on the fast path.
+         * Do this asap to minimize any load use delay.
+         */
+        if (TCG_TARGET_REG_BITS == 64 || addr_type == TCG_TYPE_I32) {
+            tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_REG_TMP1,
+                       offsetof(CPUTLBEntry, addend));
+        }
+
+        /* Clear the non-page, non-alignment bits from the address in R0. */
+        if (TCG_TARGET_REG_BITS == 32) {
+            /*
+             * We don't support unaligned accesses on 32-bits.
+             * Preserve the bottom bits and thus trigger a comparison
+             * failure on unaligned accesses.
+             */
+            if (a_bits < s_bits) {
+                a_bits = s_bits;
+            }
+            tcg_out_rlw(s, RLWINM, TCG_REG_R0, addrlo, 0,
+                        (32 - a_bits) & 31, 31 - s->page_bits);
+        } else {
+            TCGReg t = addrlo;
+
+            /*
+             * If the access is unaligned, we need to make sure we fail if we
+             * cross a page boundary.  The trick is to add the access size-1
+             * to the address before masking the low bits.  That will make the
+             * address overflow to the next page if we cross a page boundary,
+             * which will then force a mismatch of the TLB compare.
+             */
+            if (a_bits < s_bits) {
+                unsigned a_mask = (1 << a_bits) - 1;
+                unsigned s_mask = (1 << s_bits) - 1;
+                tcg_out32(s, ADDI | TAI(TCG_REG_R0, t, s_mask - a_mask));
+                t = TCG_REG_R0;
+            }
+
+            /* Mask the address for the requested alignment.  */
+            if (addr_type == TCG_TYPE_I32) {
+                tcg_out_rlw(s, RLWINM, TCG_REG_R0, t, 0,
+                            (32 - a_bits) & 31, 31 - s->page_bits);
+            } else if (a_bits == 0) {
+                tcg_out_rld(s, RLDICR, TCG_REG_R0, t, 0, 63 - s->page_bits);
+            } else {
+                tcg_out_rld(s, RLDICL, TCG_REG_R0, t,
+                            64 - s->page_bits, s->page_bits - a_bits);
+                tcg_out_rld(s, RLDICL, TCG_REG_R0, TCG_REG_R0, s->page_bits, 0);
+            }
+        }
+
+        if (TCG_TARGET_REG_BITS == 32 && addr_type != TCG_TYPE_I32) {
+            /* Low part comparison into cr7. */
+            tcg_out_cmp(s, TCG_COND_EQ, TCG_REG_R0, TCG_REG_TMP2,
+                        0, 7, TCG_TYPE_I32);
+
+            /* Load the high part TLB comparator into TMP2.  */
+            tcg_out_ld(s, TCG_TYPE_I32, TCG_REG_TMP2, TCG_REG_TMP1,
+                       cmp_off + 4 * !HOST_BIG_ENDIAN);
+
+            /* Load addend, deferred for this case. */
+            tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_REG_TMP1,
+                       offsetof(CPUTLBEntry, addend));
+
+            /* High part comparison into cr6. */
+            tcg_out_cmp(s, TCG_COND_EQ, addrhi, TCG_REG_TMP2,
+                        0, 6, TCG_TYPE_I32);
+
+            /* Combine comparisons into cr7. */
+            tcg_out32(s, CRAND | BT(7, CR_EQ) | BA(6, CR_EQ) | BB(7, CR_EQ));
+        } else {
+            /* Full comparison into cr7. */
+            tcg_out_cmp(s, TCG_COND_EQ, TCG_REG_R0, TCG_REG_TMP2,
+                        0, 7, addr_type);
+        }
+
+        /* Load a pointer into the current opcode w/conditional branch-link. */
         ldst->label_ptr[0] = s->code_ptr;
-        tcg_out32(s, BC | BI(0, CR_EQ) | BO_COND_FALSE | LK);
-    }
+        tcg_out32(s, BC | BI(7, CR_EQ) | BO_COND_FALSE | LK);
 
-    h->base = guest_base ? TCG_GUEST_BASE_REG : 0;
-#endif
+        h->base = TCG_REG_TMP1;
+    } else {
+        if (a_bits) {
+            ldst = new_ldst_label(s);
+            ldst->is_ld = is_ld;
+            ldst->oi = oi;
+            ldst->addrlo_reg = addrlo;
+            ldst->addrhi_reg = addrhi;
+
+            /* We are expecting a_bits to max out at 7, much lower than ANDI. */
+            tcg_debug_assert(a_bits < 16);
+            tcg_out32(s, ANDI | SAI(addrlo, TCG_REG_R0, (1 << a_bits) - 1));
+
+            ldst->label_ptr[0] = s->code_ptr;
+            tcg_out32(s, BC | BI(0, CR_EQ) | BO_COND_FALSE | LK);
+        }
+
+        h->base = guest_base ? TCG_GUEST_BASE_REG : 0;
+    }
 
     if (TCG_TARGET_REG_BITS == 64 && addr_type == TCG_TYPE_I32) {
         /* Zero-extend the guest address for use in the host address. */
@@ -2695,12 +2699,10 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     }
     tcg_out_st(s, TCG_TYPE_PTR, TCG_REG_R0, TCG_REG_R1, FRAME_SIZE+LR_OFFSET);
 
-#ifndef CONFIG_SOFTMMU
-    if (guest_base) {
+    if (!tcg_use_softmmu && guest_base) {
         tcg_out_movi_int(s, TCG_TYPE_PTR, TCG_GUEST_BASE_REG, guest_base, true);
         tcg_regset_set_reg(s->reserved_regs, TCG_GUEST_BASE_REG);
     }
-#endif
 
     tcg_out_mov(s, TCG_TYPE_PTR, TCG_AREG0, tcg_target_call_iarg_regs[0]);
     tcg_out32(s, MTSPR | RS(tcg_target_call_iarg_regs[1]) | CTR);
-- 
2.34.1


