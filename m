Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 908377B6FF3
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:37:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjEz-0008P5-FI; Tue, 03 Oct 2023 13:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjEj-0008Fx-5X
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:18 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjEe-0007Sb-8m
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:08 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6907e44665bso927424b3a.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696354263; x=1696959063; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6EinnuhWuKtBM4Npa4E/+PX6JKXXIFIG2E4aT0Yd/rA=;
 b=MGuDHYqC0KEmjFdx3Xl8W6bZ60wJSW8j2eDnmVYMSNFcBa/Qw70Yifi76ThoI5UgTS
 fq2NQTa0NqpdSFBy4ay2+Ttxmq7DO6kNN5abi0dQLpj6H1XxTbzyZLVewp7mxq/jBntq
 cJh6aMFuGyCQoO7JXpPSJShHtYnP38vVp10y8yqzyO33oTk5c/OziycMYTKH77US2J2B
 fW/C8hukuJ5yXzugpALUM9tmdHEzXFcWuFgOQNhn5ca2/dkavp4cKETon2PuZ2BxloKx
 w4lGlFY1uih4rFjJ75fGD3EXi9kEffg7Fdv7IEir9D1k8NjZL3jugMIzZsa2Kyrrb9Q2
 jSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696354263; x=1696959063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6EinnuhWuKtBM4Npa4E/+PX6JKXXIFIG2E4aT0Yd/rA=;
 b=J9/Y+WNw7BNHq1mMh0C53iK9cNflzHF6jrxwCiJ5SlEW1M2bprHuDzJI6nwrrLTkmt
 o/dxXeAhd+f3SsG7iuv7MnAONq4OrlG4thIDm6aorh3Pam5P3tKq6+rakQ/K1e8xVH4g
 IVTTykual4zOsFfptqvVUiwRU6lRXe9Y4Ti3wXMuUOAsuY5ac8wh0d9vEFM2rrt2WjOD
 +fC4+5wq9l6oNsE5wp0pzH1WP+9912YOlgFFgPS5Gh6jcVb2QBeKk2Bs0vHCRvlrlp5a
 2Hwn04BsZbkXcH7Zjz76rPKW1cNqEm2f4JoQ+mhjgmHkS3DHYelgbUerFKOLiNzFOKhH
 Z28Q==
X-Gm-Message-State: AOJu0Yy+osK3njgKydiKajHTBXVDdmuTb8+mokvY/rvHgnhBYipXrFzT
 87qnZOqhb7vgY5ncj9dGw0qYRr1FQk3syxWp3rA=
X-Google-Smtp-Source: AGHT+IH7XLDKA7FBTkcYme+rd5JAIoIeAwTar7kbLWJHmrN6RRcsNZiQXgpl/rBoZCt2cJIrQaEH2A==
X-Received: by 2002:a05:6a00:3992:b0:68a:49bc:e0af with SMTP id
 fi18-20020a056a00399200b0068a49bce0afmr273032pfb.1.1696354262812; 
 Tue, 03 Oct 2023 10:31:02 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 n7-20020aa78a47000000b00692c5b1a731sm1620195pfa.186.2023.10.03.10.31.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 10:31:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PULL 08/47] target/arm: Replace TARGET_PAGE_ENTRY_EXTRA
Date: Tue,  3 Oct 2023 10:30:13 -0700
Message-Id: <20231003173052.1601813-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003173052.1601813-1-richard.henderson@linaro.org>
References: <20231003173052.1601813-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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
index 350287852e..46d2ac570f 100644
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
index 2dd7eb3edb..70ac876105 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -137,7 +137,7 @@ static uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
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
index 97f25b4451..6523bfb339 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -13904,7 +13904,7 @@ static bool is_guarded_page(CPUARMState *env, DisasContext *s)
                               false, &host, &full, 0);
     assert(!(flags & TLB_INVALID_MASK));
 
-    return full->guarded;
+    return full->extra.arm.guarded;
 #endif
 }
 
-- 
2.34.1


