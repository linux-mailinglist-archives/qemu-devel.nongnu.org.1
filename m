Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C73A38C71
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Feb 2025 20:32:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk6pm-0002eR-6F; Mon, 17 Feb 2025 14:31:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6p2-0001xC-F5
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:28 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6ow-0008O5-Gb
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:24 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22100006bc8so42906375ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 11:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739820621; x=1740425421; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jSqS9kMTvyRTGLGgXwsTZ3V17qWRY5dQH7PE/q6TsPI=;
 b=PJd+4S7EkQkLxdfLfKdsL35JffUT2hDkDRReAOgmbwIO+jJW0j5cT2mvrc7NrRbyxY
 ziPqUl+BZSgMFXlQA6Vg7CGty/y/fssIUXULhBUE8z/CjM2M50lQiOcRu95KApSyMMp7
 AkNDrRPpEvFeMLKIWNnT+NV4RdACHCvOERklsR/qnKNcHjvqxr1l6XXMqxLaoUCBDqCo
 wxfv7TsJ+/M2VN04D50sMLQ+vOOrbY9DK6ptjYm2uSwHTzxni8WhGvK3rpc96w++djMW
 esoQNmOCJk1ov8bSqPtrSbTq7pRnj5di1dtYTXuz54yDuMHUHut6BNFAom1w058dRi2Q
 nUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739820621; x=1740425421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jSqS9kMTvyRTGLGgXwsTZ3V17qWRY5dQH7PE/q6TsPI=;
 b=QWZ2X3h6zUHeYVdXX7vs4a/aCE6A6s/2i/6odJcnLWuXOfhrmreFwGxol76wy3T7hA
 MfgsPE6Vo8CsIND1ZpGgkLZuf7E16UwyHj6Z/gyLJOfIsLYWjy0HdApKA79DOQRKfJwm
 EEXX4Kt9Fmy4GRym1xYyUMIamXeVAL+ytR9cVuV+mDAsGHa5QVhWrt5VGNsZE+xG7PBM
 FSjn6uQuRp70kMbfJ1YpzuDGLNMBBh0oRZp4Mh6OFx/+Gl7HDYhnUoEw5mTG8npgdjvs
 8QxI2GLpTT+d51glGa8IpiyXTSWN9j2ke1E365A6LITKQ5nj+QL6/CtBP4eTtZ/twZYy
 YwiQ==
X-Gm-Message-State: AOJu0YxoZtevAfkbB2pkhDwclmVOndmi8jT8sYIDrCdnS80OjwzhOevV
 KDr1cAQIsyZ7RDHlaWQ48eZJDMwh9evYvhHbJR0cLM/EaAHGYYG0gcCMi8zf68BfSvMT0FEJuDn
 6
X-Gm-Gg: ASbGncseVwRxMSKqccO1WnH6ATrv3dwCTeLiXIkg/ZiGeX80qdAbXwAe7WTYFc2vJL9
 AUi/lI5md4By0/ATTvnnfExYv9lf7nNiaRd/mtQPZo7pvezUFscHZufUYydlDBiOIHqxbknIQ7g
 Rory03Q2BcVAX2FzJuwICEV5NbtaIMWLnb9fXyYcc2MhVyZhrjirpYtUmi9e0ck89yxr6OEed3q
 /V8XnmVD6lYKNzHrOTOWadjKn+DQ2yn6gXZVjxjFwHo6nCMhnn4CDpG/e54IaqBeHN0psbcqKeI
 Duxtu4uS9Aj1U2SUgb9mZ1Dt0m3mLMUAxs3y1lEnKYXhO+s=
X-Google-Smtp-Source: AGHT+IEBksIDENC1Qd5hXD8KzIMsvKJVkORExFP9Mf9JzNrCHpnx3ogiDTKvv+smSd3HikLzYulGcA==
X-Received: by 2002:a05:6a21:483:b0:1e1:ccf3:a72 with SMTP id
 adf61e73a8af0-1ee8cbc1de0mr19814638637.28.1739820620739; 
 Mon, 17 Feb 2025 11:30:20 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7326a38ff76sm4347164b3a.160.2025.02.17.11.30.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 11:30:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 14/27] include/exec: Use uintptr_t in CPUTLBEntry
Date: Mon, 17 Feb 2025 11:29:55 -0800
Message-ID: <20250217193009.2873875-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217193009.2873875-1-richard.henderson@linaro.org>
References: <20250217193009.2873875-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Since we no longer support 64-bit guests on 32-bit hosts,
we can use a 32-bit type on a 32-bit host.  This shrinks
the size of the structure to 16 bytes on a 32-bit host.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/tlb-common.h | 10 +++++-----
 accel/tcg/cputlb.c        | 21 ++++-----------------
 tcg/arm/tcg-target.c.inc  |  1 -
 tcg/mips/tcg-target.c.inc | 12 +++++-------
 tcg/ppc/tcg-target.c.inc  | 21 +++++----------------
 5 files changed, 19 insertions(+), 46 deletions(-)

diff --git a/include/exec/tlb-common.h b/include/exec/tlb-common.h
index dc5a5faa0b..03b5a8ffc7 100644
--- a/include/exec/tlb-common.h
+++ b/include/exec/tlb-common.h
@@ -19,14 +19,14 @@
 #ifndef EXEC_TLB_COMMON_H
 #define EXEC_TLB_COMMON_H 1
 
-#define CPU_TLB_ENTRY_BITS 5
+#define CPU_TLB_ENTRY_BITS (HOST_LONG_BITS == 32 ? 4 : 5)
 
 /* Minimalized TLB entry for use by TCG fast path. */
 typedef union CPUTLBEntry {
     struct {
-        uint64_t addr_read;
-        uint64_t addr_write;
-        uint64_t addr_code;
+        uintptr_t addr_read;
+        uintptr_t addr_write;
+        uintptr_t addr_code;
         /*
          * Addend to virtual address to get host address.  IO accesses
          * use the corresponding iotlb value.
@@ -37,7 +37,7 @@ typedef union CPUTLBEntry {
      * Padding to get a power of two size, as well as index
      * access to addr_{read,write,code}.
      */
-    uint64_t addr_idx[(1 << CPU_TLB_ENTRY_BITS) / sizeof(uint64_t)];
+    uintptr_t addr_idx[(1 << CPU_TLB_ENTRY_BITS) / sizeof(uintptr_t)];
 } CPUTLBEntry;
 
 QEMU_BUILD_BUG_ON(sizeof(CPUTLBEntry) != (1 << CPU_TLB_ENTRY_BITS));
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 75d075d044..ad158050a1 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -104,22 +104,15 @@ static inline uint64_t tlb_read_idx(const CPUTLBEntry *entry,
 {
     /* Do not rearrange the CPUTLBEntry structure members. */
     QEMU_BUILD_BUG_ON(offsetof(CPUTLBEntry, addr_read) !=
-                      MMU_DATA_LOAD * sizeof(uint64_t));
+                      MMU_DATA_LOAD * sizeof(uintptr_t));
     QEMU_BUILD_BUG_ON(offsetof(CPUTLBEntry, addr_write) !=
-                      MMU_DATA_STORE * sizeof(uint64_t));
+                      MMU_DATA_STORE * sizeof(uintptr_t));
     QEMU_BUILD_BUG_ON(offsetof(CPUTLBEntry, addr_code) !=
-                      MMU_INST_FETCH * sizeof(uint64_t));
+                      MMU_INST_FETCH * sizeof(uintptr_t));
 
-#if TARGET_LONG_BITS == 32
-    /* Use qatomic_read, in case of addr_write; only care about low bits. */
-    const uint32_t *ptr = (uint32_t *)&entry->addr_idx[access_type];
-    ptr += HOST_BIG_ENDIAN;
-    return qatomic_read(ptr);
-#else
-    const uint64_t *ptr = &entry->addr_idx[access_type];
+    const uintptr_t *ptr = &entry->addr_idx[access_type];
     /* ofs might correspond to .addr_write, so use qatomic_read */
     return qatomic_read(ptr);
-#endif
 }
 
 static inline uint64_t tlb_addr_write(const CPUTLBEntry *entry)
@@ -899,14 +892,8 @@ static void tlb_reset_dirty_range_locked(CPUTLBEntry *tlb_entry,
         addr &= TARGET_PAGE_MASK;
         addr += tlb_entry->addend;
         if ((addr - start) < length) {
-#if TARGET_LONG_BITS == 32
-            uint32_t *ptr_write = (uint32_t *)&tlb_entry->addr_write;
-            ptr_write += HOST_BIG_ENDIAN;
-            qatomic_set(ptr_write, *ptr_write | TLB_NOTDIRTY);
-#else
             qatomic_set(&tlb_entry->addr_write,
                         tlb_entry->addr_write | TLB_NOTDIRTY);
-#endif
         }
     }
 }
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 83f6eb6099..cec3d761d4 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1500,7 +1500,6 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
          * Add the tlb_table pointer, creating the CPUTLBEntry address in R1.
          * Load the tlb comparator into R2 and the fast path addend into R1.
          */
-        QEMU_BUILD_BUG_ON(HOST_BIG_ENDIAN);
         if (cmp_off == 0) {
             tcg_out_ld32_rwb(s, COND_AL, TCG_REG_R2, TCG_REG_R1, TCG_REG_R0);
         } else {
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index d744b853cd..14b3cb1eba 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1262,18 +1262,16 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         /* Add the tlb_table pointer, creating the CPUTLBEntry address.  */
         tcg_out_opc_reg(s, ALIAS_PADD, TCG_TMP3, TCG_TMP3, TCG_TMP1);
 
-        if (TCG_TARGET_REG_BITS == 32 || addr_type == TCG_TYPE_I32) {
-            /* Load the (low half) tlb comparator.  */
+        /* Load the tlb comparator.  */
+        if (TCG_TARGET_REG_BITS == 64 && addr_type == TCG_TYPE_I32) {
             tcg_out_ld(s, TCG_TYPE_I32, TCG_TMP0, TCG_TMP3,
                        cmp_off + HOST_BIG_ENDIAN * 4);
         } else {
-            tcg_out_ld(s, TCG_TYPE_I64, TCG_TMP0, TCG_TMP3, cmp_off);
+            tcg_out_ld(s, TCG_TYPE_REG, TCG_TMP0, TCG_TMP3, cmp_off);
         }
 
-        if (TCG_TARGET_REG_BITS == 64 || addr_type == TCG_TYPE_I32) {
-            /* Load the tlb addend for the fast path.  */
-            tcg_out_ld(s, TCG_TYPE_PTR, TCG_TMP3, TCG_TMP3, add_off);
-        }
+        /* Load the tlb addend for the fast path.  */
+        tcg_out_ld(s, TCG_TYPE_PTR, TCG_TMP3, TCG_TMP3, add_off);
 
         /*
          * Mask the page bits, keeping the alignment bits to compare against.
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 2d16807ec7..822925a19b 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2490,27 +2490,16 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         tcg_out32(s, AND | SAB(TCG_REG_TMP1, TCG_REG_TMP1, TCG_REG_R0));
 
         /*
-         * Load the (low part) TLB comparator into TMP2.
+         * Load the TLB comparator into TMP2.
          * For 64-bit host, always load the entire 64-bit slot for simplicity.
          * We will ignore the high bits with tcg_out_cmp(..., addr_type).
          */
-        if (TCG_TARGET_REG_BITS == 64) {
-            if (cmp_off == 0) {
-                tcg_out32(s, LDUX | TAB(TCG_REG_TMP2,
-                                        TCG_REG_TMP1, TCG_REG_TMP2));
-            } else {
-                tcg_out32(s, ADD | TAB(TCG_REG_TMP1,
-                                       TCG_REG_TMP1, TCG_REG_TMP2));
-                tcg_out_ld(s, TCG_TYPE_I64, TCG_REG_TMP2,
-                           TCG_REG_TMP1, cmp_off);
-            }
-        } else if (cmp_off == 0 && !HOST_BIG_ENDIAN) {
-            tcg_out32(s, LWZUX | TAB(TCG_REG_TMP2,
-                                     TCG_REG_TMP1, TCG_REG_TMP2));
+        if (cmp_off == 0) {
+            tcg_out32(s, (TCG_TARGET_REG_BITS == 64 ? LDUX : LWZUX)
+                      | TAB(TCG_REG_TMP2, TCG_REG_TMP1, TCG_REG_TMP2));
         } else {
             tcg_out32(s, ADD | TAB(TCG_REG_TMP1, TCG_REG_TMP1, TCG_REG_TMP2));
-            tcg_out_ld(s, TCG_TYPE_I32, TCG_REG_TMP2, TCG_REG_TMP1,
-                       cmp_off + 4 * HOST_BIG_ENDIAN);
+            tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP2, TCG_REG_TMP1, cmp_off);
         }
 
         /*
-- 
2.43.0


