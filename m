Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC3F79F866
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 04:47:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgcLW-0000b3-3w; Wed, 13 Sep 2023 22:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgcLU-0000aV-9S
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:44:44 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgcLP-0000eo-RC
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:44:44 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c3d6d88231so4053805ad.0
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 19:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694659478; x=1695264278; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+eTu7xE2DZYBes3U7Yxgno1qtzEB6OsQoyaVOsiCOP0=;
 b=mK8ZUVrXqETWBMY/yM/bTf/aI8UNLmnCuEd3SL6Kb6karXHhnlfFU5jy/NrnHvGcIc
 DO6w5/J/OkLGSmyUSbTqTTEGwX1b8Dga+Xyv/Prb8mQCeYgtz7FHrgDeYX2N5a9/h9G/
 VFyXJ3VAD/128Oic1C0nY+1zlvuWQeGUQ6XB7BGuN1gGQI5vjdJD6CHC7qgOWW4STrDO
 0AHbTfQod+3kIUZNiYDTcZxzTbzjpNudeUdZ6IrL2lIsFb3axMxsqWbHG8W0qckkgxv/
 o6vemA/uHAsFVmt3H84Fj94mQhxkSsROMq+n+s8aD/vX97LkwAVbAjdkmiE+BqgCQmdV
 8qnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694659478; x=1695264278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+eTu7xE2DZYBes3U7Yxgno1qtzEB6OsQoyaVOsiCOP0=;
 b=EhydLP8SHVjeFZxwTHnieQ+uZhwOFJ6DVJ3Q0th/jrAJiAo3Qkq+VEdPXn4gtkyUlA
 +2ADEXd4xkh0d/sMQchMOoSYwv0K2Qm79j2uNNiUf2wji9Ss2xCPfiA92StBef8WM2Ii
 iWBPhCF7wDvZW1zFUY+1b0nQW2uO0MKET2UkWZnbWxsulsQo37cTfWdy0fZTkpvz40Ee
 MBWgsCJ6Z41fdaCVREtMfqmJFU0gbB0V0CC9/0MHg6C83utKUZiqoSyvhD8E2sCAx6Rm
 Ld6bjzEST9lmS86QP3nEZWPG1I6XFSAT8pwedhz7Mgv+DMk+lj8IB4+/TM6I1jNxESrn
 YwRw==
X-Gm-Message-State: AOJu0YxasYMwzgJDlxXcwyQjDjEjaAQ49KGMn9o1L0/cG+Q9IrA/+tJO
 NZWMhbe/tSkXt9zEq2MQbDA3yAUuNLnBKYVxOk0=
X-Google-Smtp-Source: AGHT+IFC8x1bWNFxDy7nGrDtUJZs35+nBjJW0ty6i44x6QODfFvFMk0azZQU9OIoN1jmEJ+jEXuEzg==
X-Received: by 2002:a17:902:d38d:b0:1c3:f4fa:b1a2 with SMTP id
 e13-20020a170902d38d00b001c3f4fab1a2mr2050187pld.8.1694659478057; 
 Wed, 13 Sep 2023 19:44:38 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 x24-20020a170902b41800b001bbdf32f011sm304336plr.269.2023.09.13.19.44.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 19:44:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng,
	ale@rev.ng,
	philmd@linaro.org
Subject: [PATCH v2 01/24] target/arm: Replace TARGET_PAGE_ENTRY_EXTRA
Date: Wed, 13 Sep 2023 19:44:12 -0700
Message-Id: <20230914024435.1381329-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914024435.1381329-1-richard.henderson@linaro.org>
References: <20230914024435.1381329-1-richard.henderson@linaro.org>
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

From: Anton Johansson <anjo@rev.ng>

TARGET_PAGE_ENTRY_EXTRA is a macro that allows guests to specify additional
fields for caching with the full TLB entry.  This macro is replaced with
a union in CPUTLBEntryFull, thus making CPUTLB target-agnostic at the
cost of slightly inflated CPUTLBEntryFull for non-arm guests.

Note, this is needed to ensure that fields in CPUTLB don't vary in
offset between various targets.

(arm is the only guest actually making use of this feature.)

Signed-off-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20230912153428.17816-2-anjo@rev.ng>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-defs.h        | 18 +++++++++++++++---
 target/arm/cpu-param.h         | 12 ------------
 target/arm/ptw.c               |  4 ++--
 target/arm/tcg/mte_helper.c    |  2 +-
 target/arm/tcg/sve_helper.c    |  2 +-
 target/arm/tcg/tlb_helper.c    |  4 ++--
 target/arm/tcg/translate-a64.c |  2 +-
 7 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index fb4c8d480f..0a600a312b 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -135,9 +135,21 @@ typedef struct CPUTLBEntryFull {
      * This may be used to cache items from the guest cpu
      * page tables for later use by the implementation.
      */
-#ifdef TARGET_PAGE_ENTRY_EXTRA
-    TARGET_PAGE_ENTRY_EXTRA
-#endif
+    union {
+        /*
+         * Cache the attrs and shareability fields from the page table entry.
+         *
+         * For ARMMMUIdx_Stage2*, pte_attrs is the S2 descriptor bits [5:2].
+         * Otherwise, pte_attrs is the same as the MAIR_EL1 8-bit format.
+         * For shareability and guarded, as in the SH and GP fields respectively
+         * of the VMSAv8-64 PTEs.
+         */
+        struct {
+            uint8_t pte_attrs;
+            uint8_t shareability;
+            bool guarded;
+        } arm;
+    } extra;
 } CPUTLBEntryFull;
 #endif /* CONFIG_SOFTMMU */
 
diff --git a/target/arm/cpu-param.h b/target/arm/cpu-param.h
index b3b35f7aa1..f9b462a98f 100644
--- a/target/arm/cpu-param.h
+++ b/target/arm/cpu-param.h
@@ -31,18 +31,6 @@
 # define TARGET_PAGE_BITS_VARY
 # define TARGET_PAGE_BITS_MIN  10
 
-/*
- * Cache the attrs and shareability fields from the page table entry.
- *
- * For ARMMMUIdx_Stage2*, pte_attrs is the S2 descriptor bits [5:2].
- * Otherwise, pte_attrs is the same as the MAIR_EL1 8-bit format.
- * For shareability and guarded, as in the SH and GP fields respectively
- * of the VMSAv8-64 PTEs.
- */
-# define TARGET_PAGE_ENTRY_EXTRA  \
-    uint8_t pte_attrs;            \
-    uint8_t shareability;         \
-    bool guarded;
 #endif
 
 #endif
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index bfbab26b9b..95db9ec4c3 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -579,7 +579,7 @@ static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
         }
         ptw->out_phys = full->phys_addr | (addr & ~TARGET_PAGE_MASK);
         ptw->out_rw = full->prot & PAGE_WRITE;
-        pte_attrs = full->pte_attrs;
+        pte_attrs = full->extra.arm.pte_attrs;
         ptw->out_space = full->attrs.space;
 #else
         g_assert_not_reached();
@@ -2036,7 +2036,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
 
         /* When in aarch64 mode, and BTI is enabled, remember GP in the TLB. */
         if (aarch64 && cpu_isar_feature(aa64_bti, cpu)) {
-            result->f.guarded = extract64(attrs, 50, 1); /* GP */
+            result->f.extra.arm.guarded = extract64(attrs, 50, 1); /* GP */
         }
     }
 
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index b23d11563a..dba21cc4d6 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -124,7 +124,7 @@ static uint8_t *allocation_tag_mem(CPUARMState *env, int ptr_mmu_idx,
     assert(!(flags & TLB_INVALID_MASK));
 
     /* If the virtual page MemAttr != Tagged, access unchecked. */
-    if (full->pte_attrs != 0xf0) {
+    if (full->extra.arm.pte_attrs != 0xf0) {
         return NULL;
     }
 
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 7c103fc9f7..f006d152cc 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -5373,7 +5373,7 @@ bool sve_probe_page(SVEHostPage *info, bool nofault, CPUARMState *env,
     info->tagged = (flags & PAGE_ANON) && (flags & PAGE_MTE);
 #else
     info->attrs = full->attrs;
-    info->tagged = full->pte_attrs == 0xf0;
+    info->tagged = full->extra.arm.pte_attrs == 0xf0;
 #endif
 
     /* Ensure that info->host[] is relative to addr, not addr + mem_off. */
diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index b22b2a4c6e..59bff8b452 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -334,8 +334,8 @@ bool arm_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
             address &= TARGET_PAGE_MASK;
         }
 
-        res.f.pte_attrs = res.cacheattrs.attrs;
-        res.f.shareability = res.cacheattrs.shareability;
+        res.f.extra.arm.pte_attrs = res.cacheattrs.attrs;
+        res.f.extra.arm.shareability = res.cacheattrs.shareability;
 
         tlb_set_page_full(cs, mmu_idx, address, &res.f);
         return true;
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 1b6fbb61e2..07c8f5b53b 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -13775,7 +13775,7 @@ static bool is_guarded_page(CPUARMState *env, DisasContext *s)
                               false, &host, &full, 0);
     assert(!(flags & TLB_INVALID_MASK));
 
-    return full->guarded;
+    return full->extra.arm.guarded;
 #endif
 }
 
-- 
2.34.1


