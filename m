Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 957AE7CEB57
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 00:33:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtEzj-0008Cc-2F; Wed, 18 Oct 2023 18:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEze-00089V-Oh
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:22 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEzb-0002Vo-Sv
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:22 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1ca72f8ff3aso28056065ad.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 15:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697667978; x=1698272778; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UPfL8PRDqxISdNKDDtEx7VkZ1IZG1ok5c8lkQqcFV18=;
 b=nv45LMkj3nvKFeD/KeVrxDVZ8scU0bT2WnsDSZm3x9AiBkmNHLNTCO1nyTsZr7ofF4
 PCsMHV5In7WPTN7JrPtlpzybQYNtRU8Lsk0eeOOczzbAP3UMDTqJHcOinxCdZsZ/zP9w
 K5q+e8pq4j55HFR2avJjyPpeUUyADDNxaW4rVpduTWhwhg5w7B4zPOIowo69WLGWViOO
 FjYb7acIRpUR43gU4gGoQ2rZW0ZvTA2K39lv+44+w2u71mOaNkHSRv3yF7eYxhZZd1od
 blTpE7bhFChujb8xL3dINd9W5iHPiUKA7MCP70dyUEW+Xg8kHYIL2xX5dAHwwBMW0QgY
 NM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697667978; x=1698272778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UPfL8PRDqxISdNKDDtEx7VkZ1IZG1ok5c8lkQqcFV18=;
 b=ofKaj5MutOgs6Wei/TrknjwJEtP7l44fV0kzwT0/5n+YKPZCQq7Yb9rAN1Hqph6GYX
 ylUvsUrlCi5pBA9ZpTA9TmE17aYcONlG30DoJ0HqtcwbLqOPZP5QpYAVzOUnbvX8SQRv
 5CrM0WQPT2fZmizfESK85jbU+akfniMKy/je4dkFRxHTNEc64ZVqnuzS2P6MAucusre7
 f2cPwVNM9zo3UuGMxJQIrev0jZQR6OC5BWe4p6GlitSxRgdsP1NbIddeqWRNPTDPAXPD
 NTNzFnTk0nWnT8gCcDmuKrdikkkNpMaJt6bzlzzWeebrL3KG/yoMwGMVW8JRWhMjpfQ5
 pb/g==
X-Gm-Message-State: AOJu0YyJVERyKK3LK89316MhH1AppQW+C+FYmCHap0PW/Exz4RMnf/Rd
 SNWQme1TmKqeRy09xe/BlqZfHkzAnLgO9V3Ee7g=
X-Google-Smtp-Source: AGHT+IHPV7SuLyfkXVDkpXji0HSihakDyhhnyzJjtIwHOcXxy+Sp7qxNhqG5xA7mDBHdLwSaZkcMMA==
X-Received: by 2002:a17:902:e5c3:b0:1ca:3e40:beae with SMTP id
 u3-20020a170902e5c300b001ca3e40beaemr742366plf.38.1697667977950; 
 Wed, 18 Oct 2023 15:26:17 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a170902c24d00b001b9d95945afsm431058plg.155.2023.10.18.15.26.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 15:26:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 21/29] tcg/ppc: Use tcg_use_softmmu
Date: Wed, 18 Oct 2023 15:25:49 -0700
Message-Id: <20231018222557.1562065-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018222557.1562065-1-richard.henderson@linaro.org>
References: <20231018222557.1562065-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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


