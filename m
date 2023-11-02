Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DD47DEA07
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:32:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMXe-0005Vy-Ew; Wed, 01 Nov 2023 21:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXW-0005TN-Eg
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:30 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXS-0001Rc-V3
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:30 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6c0f14d6875so471810b3a.1
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888621; x=1699493421; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dpWvX3bMUy0LLw33Nd4xLQ7viiveU8nGbCNPBx3bpac=;
 b=tmKa3iFqSVXVSpEKssVOC0RXdYvdV/iNtqv3ZAv2Yb3rW5oIWk64+g5Zf30pOdc/dq
 iTufLQdFOKIGC7I+YkI8TgbKzNnDxSTro3ty154Otq67IqYSZZ2Q+iPoLbKnKNYvPbi9
 QtfwzWdWqKZY4fhYRX6g6Fil+qTmqTpQYPAMf1937Isuy3rcOSRlmNF+e1vWxOw+b3vi
 1nBL04dGnSN/OCHPA/918aEzDldqVVJlIhJXx6ANmYX9wpqvJiozf3gEsSUMH/wo2qwq
 88jD8PmiHwFNP8pHN1RYWUCA0EpkYsEv1ywFnObM6WRgu7ltx+NqUYbo4Qmqyo3qzErX
 XcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888621; x=1699493421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dpWvX3bMUy0LLw33Nd4xLQ7viiveU8nGbCNPBx3bpac=;
 b=Th+CoKUeIzUZ9ZbzxYsWXoUspL3gruNqKLjlOMLCergZy4YlkqAxiulmO4ZzI9OVwr
 I4P7kVBAxG5VArA0r+MatNiFIADPpWEpQAvy27R1JdcVuJS2KaMZGxxHoUxa2Uj4J3c0
 iqwtiFyMrrGaf1e4fmVtsc+QLOrPyDWZoY2AcWEwBYA84OxTgwhzeUg62trBGlrEqLqm
 LnTTexSFMUEJ5f+Z5Aoy66iMtr3h9kMDqmzMv1iBzSMdol44/d21Rc2h/hbgcZL6JCYG
 nMwzlpMeKWJOEHqteE3nQrR8NpqdiwJvxcgSUOk38ckXKF3C6OD9+3gx/QrsUa7g9Ayt
 R8rw==
X-Gm-Message-State: AOJu0Yw07MJJ+JUeMJA4W1c/jxs6HPsAmjZmdouTWrKcVz1UCZaRN2lX
 hp4HC+6wXvpr5jRvAGJbOxo284+bBkya5AAUZXM=
X-Google-Smtp-Source: AGHT+IE2VqF0SmP24TuBPChN1Yt6Fl7a0nf1UxItIyyL93w0FpejZOFrinIVfHWD700+qYoRM1G2mQ==
X-Received: by 2002:a05:6a00:84b:b0:69b:5395:59a8 with SMTP id
 q11-20020a056a00084b00b0069b539559a8mr17228805pfk.34.1698888620119; 
 Wed, 01 Nov 2023 18:30:20 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r23-20020aa78457000000b006979f70fdd5sm1784191pfn.219.2023.11.01.18.30.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:30:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 03/88] target/hppa: Use IntervalTreeNode in HPPATLBEntry
Date: Wed,  1 Nov 2023 18:28:51 -0700
Message-Id: <20231102013016.369010-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Replace the va_b and va_b fields with the interval tree node.
The actual interval tree is not yet used.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h        |  5 +++--
 target/hppa/machine.c    |  6 +++---
 target/hppa/mem_helper.c | 31 +++++++++++++++++--------------
 3 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 22edfc955d..84bb6edc60 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -23,6 +23,7 @@
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
 #include "qemu/cpu-float.h"
+#include "qemu/interval-tree.h"
 
 /* PA-RISC 1.x processors have a strong memory model.  */
 /* ??? While we do not yet implement PA-RISC 2.0, those processors have
@@ -175,8 +176,8 @@ typedef int64_t  target_sreg;
 #endif
 
 typedef struct HPPATLBEntry {
-    uint64_t va_b;
-    uint64_t va_e;
+    IntervalTreeNode itree;
+
     target_ureg pa;
     unsigned u : 1;
     unsigned t : 1;
diff --git a/target/hppa/machine.c b/target/hppa/machine.c
index 1d3f9b639d..4535195ca2 100644
--- a/target/hppa/machine.c
+++ b/target/hppa/machine.c
@@ -74,7 +74,7 @@ static int get_tlb(QEMUFile *f, void *opaque, size_t size,
 
     memset(ent, 0, sizeof(*ent));
 
-    ent->va_b = qemu_get_be64(f);
+    ent->itree.start = qemu_get_be64(f);
     ent->pa = qemu_get_betr(f);
     val = qemu_get_be32(f);
 
@@ -88,7 +88,7 @@ static int get_tlb(QEMUFile *f, void *opaque, size_t size,
     ent->d = extract32(val, 28, 1);
     ent->t = extract32(val, 29, 1);
 
-    ent->va_e = ent->va_b + TARGET_PAGE_SIZE - 1;
+    ent->itree.last = ent->itree.start + TARGET_PAGE_SIZE - 1;
     return 0;
 }
 
@@ -110,7 +110,7 @@ static int put_tlb(QEMUFile *f, void *opaque, size_t size,
         val = deposit32(val, 29, 1, ent->t);
     }
 
-    qemu_put_be64(f, ent->va_b);
+    qemu_put_be64(f, ent->itree.start);
     qemu_put_betr(f, ent->pa);
     qemu_put_be32(f, val);
     return 0;
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index a22de81a48..687ae44ed0 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -31,9 +31,10 @@ static HPPATLBEntry *hppa_find_tlb(CPUHPPAState *env, vaddr addr)
 
     for (i = 0; i < ARRAY_SIZE(env->tlb); ++i) {
         HPPATLBEntry *ent = &env->tlb[i];
-        if (ent->va_b <= addr && addr <= ent->va_e) {
+        if (ent->itree.start <= addr && addr <= ent->itree.last) {
             trace_hppa_tlb_find_entry(env, ent + i, ent->entry_valid,
-                                      ent->va_b, ent->va_e, ent->pa);
+                                      ent->itree.start, ent->itree.last,
+                                      ent->pa);
             return ent;
         }
     }
@@ -50,11 +51,12 @@ static void hppa_flush_tlb_ent(CPUHPPAState *env, HPPATLBEntry *ent,
         return;
     }
 
-    trace_hppa_tlb_flush_ent(env, ent, ent->va_b, ent->va_e, ent->pa);
+    trace_hppa_tlb_flush_ent(env, ent, ent->itree.start,
+                             ent->itree.last, ent->pa);
 
-    tlb_flush_range_by_mmuidx(cs, ent->va_b,
-                                ent->va_e - ent->va_b + 1,
-                                HPPA_MMU_FLUSH_MASK, TARGET_LONG_BITS);
+    tlb_flush_range_by_mmuidx(cs, ent->itree.start,
+                              ent->itree.last - ent->itree.start + 1,
+                              HPPA_MMU_FLUSH_MASK, TARGET_LONG_BITS);
 
     /* never clear BTLBs, unless forced to do so. */
     if (ent < &env->tlb[HPPA_BTLB_ENTRIES] && !force_flush_btlb) {
@@ -62,7 +64,7 @@ static void hppa_flush_tlb_ent(CPUHPPAState *env, HPPATLBEntry *ent,
     }
 
     memset(ent, 0, sizeof(*ent));
-    ent->va_b = -1;
+    ent->itree.start = -1;
 }
 
 static HPPATLBEntry *hppa_alloc_tlb_ent(CPUHPPAState *env)
@@ -118,7 +120,7 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
     }
 
     /* We now know the physical address.  */
-    phys = ent->pa + (addr - ent->va_b);
+    phys = ent->pa + (addr - ent->itree.start);
 
     /* Map TLB access_rights field to QEMU protection.  */
     priv = MMU_IDX_TO_PRIV(mmu_idx);
@@ -281,7 +283,7 @@ void HELPER(itlba)(CPUHPPAState *env, target_ulong addr, target_ureg reg)
     /* Zap any old entries covering ADDR; notice empty entries on the way.  */
     for (i = HPPA_BTLB_ENTRIES; i < ARRAY_SIZE(env->tlb); ++i) {
         HPPATLBEntry *ent = &env->tlb[i];
-        if (ent->va_b <= addr && addr <= ent->va_e) {
+        if (ent->itree.start <= addr && addr <= ent->itree.last) {
             if (ent->entry_valid) {
                 hppa_flush_tlb_ent(env, ent, false);
             }
@@ -297,10 +299,11 @@ void HELPER(itlba)(CPUHPPAState *env, target_ulong addr, target_ureg reg)
     }
 
     /* Note that empty->entry_valid == 0 already.  */
-    empty->va_b = addr & TARGET_PAGE_MASK;
-    empty->va_e = empty->va_b + TARGET_PAGE_SIZE - 1;
+    empty->itree.start = addr & TARGET_PAGE_MASK;
+    empty->itree.last = empty->itree.start + TARGET_PAGE_SIZE - 1;
     empty->pa = extract32(reg, 5, 20) << TARGET_PAGE_BITS;
-    trace_hppa_tlb_itlba(env, empty, empty->va_b, empty->va_e, empty->pa);
+    trace_hppa_tlb_itlba(env, empty, empty->itree.start,
+                         empty->itree.last, empty->pa);
 }
 
 static void set_access_bits(CPUHPPAState *env, HPPATLBEntry *ent, target_ureg reg)
@@ -467,8 +470,8 @@ void HELPER(diag_btlb)(CPUHPPAState *env)
             /* force flush of possibly existing BTLB entry */
             hppa_flush_tlb_ent(env, btlb, true);
             /* create new BTLB entry */
-            btlb->va_b = virt_page << TARGET_PAGE_BITS;
-            btlb->va_e = btlb->va_b + len * TARGET_PAGE_SIZE - 1;
+            btlb->itree.start = virt_page << TARGET_PAGE_BITS;
+            btlb->itree.last = btlb->itree.start + len * TARGET_PAGE_SIZE - 1;
             btlb->pa = phys_page << TARGET_PAGE_BITS;
             set_access_bits(env, btlb, env->gr[20]);
             btlb->t = 0;
-- 
2.34.1


